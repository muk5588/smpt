package QandA.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import QandA.dto.QandACategory;
import QandA.dto.Criteria;
import QandA.dto.PageMaker;
import QandA.dto.ReplyQandaVO;
import QandA.dto.SearchCriteria;
import QandA.dto.QandaVO;
import QandA.service.QandAReplyService;
import QandA.service.QandAService;
import user.dto.User;

@Controller
@RequestMapping("/QandA")
public class QandAController {

    @Inject
    private QandAService qandaservice;

    @Inject
    private QandAReplyService qandareplyservice;

    private static final Logger log = LoggerFactory.getLogger(QandAController.class);

    // 여행이야기 리스트 보기
    @GetMapping("/list")
    public void boardListGET(Model model, @ModelAttribute("scri") SearchCriteria scri, HttpSession session) throws Exception {
        log.info("검색 기능");

        // 정렬 기준을 받아서 설정
        String sortType = scri.getSortType();
        model.addAttribute("sortType", sortType);

        List<QandaVO> list = qandaservice.list(scri);
        model.addAttribute("list", list);

        // 추천 수 표시 추가
        for (QandaVO story : list) {
            story.setRecommendCount(qandaservice.getRecommendCount(story.getBoardNo()));
        }

        // 로그인 상태 확인 및 사용자 정보 추가
        Integer isLoginInteger = (Integer) session.getAttribute("isLogin");
        Boolean isLogin = isLoginInteger != null && isLoginInteger > 0;
        User dto1 = (User) session.getAttribute("dto1");
        if (isLogin != null && isLogin && dto1 != null) {
            model.addAttribute("isLogin", true);
            model.addAttribute("dto1", dto1);
        } else {
            model.addAttribute("isLogin", false);
        }

        PageMaker pageMaker = new PageMaker();
        pageMaker.setCri(scri);
        pageMaker.setTotalCount(qandaservice.countSearch(scri));
        model.addAttribute("pageMaker", pageMaker);

        log.info("게시판 목록 페이지 들어감");
    }

    @RequestMapping(value = "/create", method = RequestMethod.GET)
    public String getCreate(Model model) throws Exception {
        log.info("게시판 작성페이지 들어가기 성공함");

        // 게시판 분류 목록 조회
        List<QandACategory> categoryList = qandaservice.getCategoryList();
        model.addAttribute("categoryList", categoryList);

        return "/qanda/create";
    }

    @RequestMapping(value = "/create", method = RequestMethod.POST)
    public String postWrite(QandaVO vo, @RequestParam("uploadFiles") List<MultipartFile> uploadFiles,
                            HttpServletRequest request) throws Exception {
        String uploadsDir = "/resources/uploads/";
        String realPathToUploads = request.getSession().getServletContext().getRealPath(uploadsDir);

        File uploadPath = new File(realPathToUploads);
        if (!uploadPath.exists()) {
            uploadPath.mkdirs();
        }

        StringBuilder imagePaths = new StringBuilder();

        for (MultipartFile file : uploadFiles) {
            if (!file.isEmpty()) {
                String originalFileName = file.getOriginalFilename();
                String uuid = UUID.randomUUID().toString();
                String saveFileName = uuid + "_" + originalFileName;
                File saveFile = new File(uploadPath, saveFileName);

                file.transferTo(saveFile);

                if (imagePaths.length() > 0) {
                    imagePaths.append(",");
                }
                imagePaths.append(request.getContextPath()).append(uploadsDir).append(saveFileName);
            }
        }

        vo.setImagePath(imagePaths.toString());
        qandaservice.create(vo);

        return "redirect:/qanda/list";
    }

    @RequestMapping(value = "/detail", method = RequestMethod.GET)
    public void getDetail(@RequestParam("boardNo") int boardNo, Model model, HttpSession session) throws Exception {
        // 로그인 상태 확인 및 사용자 정보 추가
        Integer isLoginInteger = (Integer) session.getAttribute("isLogin");
        Boolean isLogin = isLoginInteger != null && isLoginInteger > 0;
        User dto1 = (User) session.getAttribute("dto1");
        if (isLogin != null && isLogin && dto1 != null) {
            model.addAttribute("isLogin", true);
            model.addAttribute("dto1", dto1);
        } else {
            model.addAttribute("isLogin", false);
        }

        // 조회수 증가
        qandaservice.incrementViewCount(boardNo);

        QandaVO vo = qandaservice.detail(boardNo);
        model.addAttribute("detail", vo);

        // 추천 수 표시 추가
        model.addAttribute("recommendCount", qandaservice.getRecommendCount(boardNo));

        // 조회수 표시 추가
        model.addAttribute("viewCount", vo.getBoardview());

        // 댓글 표시
        List<ReplyQandaVO> reply = qandaservice.replyList(boardNo);
        model.addAttribute("reply", reply);
    }

    @RequestMapping(value = "/update", method = RequestMethod.GET)
    public String getUpdate(@RequestParam("boardNo") int boardNo, Model model, HttpSession session) throws Exception {
        User currentUser = (User) session.getAttribute("dto1");
        QandaVO vo = qandaservice.detail(boardNo);

        if (currentUser == null || currentUser.getUserno() != vo.getUserno()) {
            return "redirect:/story/detail?boardNo=" + boardNo; // 권한이 없으면 게시글 상세 페이지로 리디렉션
        }

        model.addAttribute("detail", vo);
        return "/qanda/update";
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    public String postUpdate(QandaVO vo, HttpSession session) throws Exception {
        User currentUser = (User) session.getAttribute("dto1");

        if (currentUser == null || currentUser.getUserno() != vo.getUserno()) {
            return "redirect:/qanda/detail?boardNo=" + vo.getBoardNo(); // 권한이 없으면 게시글 상세 페이지로 리디렉션
        }

        qandaservice.update(vo);
        return "redirect:/qanda/detail?boardNo=" + vo.getBoardNo(); // 수정 완료 후 상세 페이지로 리디렉션
    }

    @RequestMapping(value = "/delete", method = RequestMethod.GET)
    public String getDelete(@RequestParam("boardNo") int boardNo) throws Exception {
        // 컨트롤러에서 삭제 요청을 처리할 때, 예외 처리를 추가하여 삭제 도중 오류가 발생할 경우를 대비
        try {
            qandaservice.delete(boardNo);
        } catch (Exception e) {
            log.error("Error deleting story", e);
            // 에러 메시지를 추가하고 에러 페이지로 리디렉션할 수 있습니다.
            return "redirect:/error";
        }
        return "redirect:/qanda/list";
    }

    // 추천수 증가 post
    @RequestMapping(value = "/recommend", method = RequestMethod.POST)
    public String recommend(@RequestParam("boardNo") int boardNo, HttpSession session, Model model) throws Exception {
        User currentUser = (User) session.getAttribute("dto1");
        if (currentUser != null) {
            boolean hasRecommended = qandaservice.incrementRecommendCount(boardNo, currentUser.getUserno());
            if (!hasRecommended) {
                return "redirect:/story/detail?boardNo=" + boardNo + "&alreadyRecommended=true";
            }
        }
        return "redirect:/qanda/detail?boardNo=" + boardNo;
    }
}
