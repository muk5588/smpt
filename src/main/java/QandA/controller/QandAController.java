package QandA.controller;

import QandA.dto.QandA;
import QandA.dto.QandAComment;
import QandA.dto.QandARecommendation;
import QandA.service.QandAService;
import user.dto.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/qanda")
public class QandAController {

    private final QandAService qandAService;

    @Autowired
    public QandAController(QandAService qandAService) {
        this.qandAService = qandAService;
    }

    @GetMapping("/qandalist")
    public String qandaList(@RequestParam(defaultValue = "latest") String sort, Model model, HttpSession session) {
        User user = (User) session.getAttribute("dto");
        model.addAttribute("user", user);

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("sort", sort);

        List<QandA> qandas = qandAService.getAllSelectQandAs(paramMap);
        model.addAttribute("qandas", qandas);
        model.addAttribute("sort", sort);

        return "qanda/qandalist";
    }


    @GetMapping("/detail/{seq}")
    public String qandaDetails(@PathVariable("seq") int seq, Model model) {
        qandAService.increaseViews(seq);

        QandA qanda = qandAService.getQandAById(seq);
        if (qanda == null) {
            return "redirect:/qanda/qandalist";
        }

        List<QandAComment> commentList = qandAService.getCommentsByQandAId(seq);

        model.addAttribute("qanda", qanda);
        model.addAttribute("commentList", commentList);
        return "qanda/qandaDetail";
    }

    @PostMapping("/addComment")
    public String addComment(@RequestParam int qandaId, @RequestParam String content, HttpSession session) {
        User user = (User) session.getAttribute("dto");
        if (user == null || user.getUserid() == null) {
            return "redirect:/login";
        }
        QandAComment comment = new QandAComment();
        comment.setQandaId(qandaId);
        comment.setUserno(user.getUserno());
        comment.setContent(content);
        qandAService.addComment(comment);
        return "redirect:/qanda/detail/" + qandaId;
    }

    // 댓글 삭제
    @PostMapping("/deleteComment/{commentId}")
    public String deleteComment(@PathVariable int commentId, @RequestParam int qandaId, HttpSession session) {
        User user = (User) session.getAttribute("dto");
        if (user == null || user.getUserid() == null) {
            return "redirect:/login";
        }
        qandAService.deleteComment(commentId);
        return "redirect:/qanda/detail/" + qandaId;
    }
    
    @GetMapping("/qandaForm")
    public String showCreateForm(Model model, HttpSession session) {
        User user = (User) session.getAttribute("dto");
        if (user == null || user.getUserid() == null) {
            return "redirect:/login";
        }
        model.addAttribute("qanda", new QandA());
        return "qanda/qandaForm";
    }
    
    @GetMapping("/create")
    public String showCreateForm(Model model) {
        model.addAttribute("qanda", new QandA());
        return "qanda/qandaForm";
    }

    @PostMapping("/create")
    public String createQandA(@ModelAttribute("qanda") QandA qanda,
                              @RequestParam(value="imageFile", required=false) MultipartFile imageFile,
                              @RequestParam(value="attachmentFile", required=false) MultipartFile attachmentFile,
                              HttpSession session, RedirectAttributes redirectAttributes) {

        User user = (User) session.getAttribute("dto");
        if (user == null || user.getUserid() == null) {
            return "redirect:/login";
        }
        if (qanda.getTitle().isEmpty() || qanda.getContent().isEmpty()) {
            redirectAttributes.addFlashAttribute("message", "제목과 내용을 입력하세요.");
            return "redirect:/qanda/create";
        }
        qanda.setUserno(user.getUserno());

        // 파일 업로드 경로 설정
        String uploadDir = "C:/path/to/upload/directory"; // 실제 업로드 디렉토리 경로로 수정 필요

        // 업로드 디렉토리 생성
        File uploadDirFile = new File(uploadDir);
        if (!uploadDirFile.exists()) {
            uploadDirFile.mkdirs();
        }

        // 이미지 파일 저장
        if (imageFile != null && !imageFile.isEmpty()) {
            String imageFileName = System.currentTimeMillis() + "_" + imageFile.getOriginalFilename();
            try {
                File imageDest = new File(uploadDir, imageFileName);
                imageFile.transferTo(imageDest);
                qanda.setImagePath("/uploads/" + imageFileName); // 웹에서 접근 가능한 경로 설정
            } catch (IOException e) {
                e.printStackTrace();
                redirectAttributes.addFlashAttribute("message", "이미지 파일 업로드에 실패했습니다.");
                return "redirect:/qanda/create";
            }
        }

        // 첨부파일 저장
        if (attachmentFile != null && !attachmentFile.isEmpty()) {
            String attachmentFileName = System.currentTimeMillis() + "_" + attachmentFile.getOriginalFilename();
            try {
                File attachmentDest = new File(uploadDir, attachmentFileName);
                attachmentFile.transferTo(attachmentDest);
                qanda.setAttachmentPath("/uploads/" + attachmentFileName); // 웹에서 접근 가능한 경로 설정
            } catch (IOException e) {
                e.printStackTrace();
                redirectAttributes.addFlashAttribute("message", "첨부파일 업로드에 실패했습니다.");
                return "redirect:/qanda/create";
            }
        }

        qandAService.addQandA(qanda);
        return "redirect:/qanda/qandalist";
    }

    @PostMapping("/uploadImage")
    @ResponseBody
    public Map<String, Object> uploadImage(@RequestParam("file") MultipartFile file) {
        Map<String, Object> response = new HashMap<>();
        String[] allowedTypes = {"image/png", "image/jpeg", "image/gif"};
        boolean isValidType = Arrays.asList(allowedTypes).contains(file.getContentType());

        if (!isValidType) {
            response.put("uploaded", false);
            response.put("error", Collections.singletonMap("message", "지원되지 않는 형식입니다"));
            return response;
        }

        if (!file.isEmpty()) {
            try {
                String originalFilename = file.getOriginalFilename();
                String fileName = System.currentTimeMillis() + "_" + originalFilename;
                Path uploadPath = Paths.get("uploads");

                if (!Files.exists(uploadPath)) {
                    Files.createDirectories(uploadPath);
                }

                file.transferTo(uploadPath.resolve(fileName).toFile());

                response.put("uploaded", true);
                response.put("url", "/uploads/" + fileName);
            } catch (IOException e) {
                response.put("uploaded", false);
                response.put("error", Collections.singletonMap("message", e.getMessage()));
            }
        } else {
            response.put("uploaded", false);
            response.put("error", Collections.singletonMap("message", "파일이 비어 있습니다"));
        }

        return response;
    }

    @GetMapping("/edit/{seq}")
    public String editQandA(@PathVariable("seq") int seq, Model model) {
        QandA qanda = qandAService.getQandAById(seq);
        if (qanda == null) {
            return "redirect:/qanda/qandalist";
        }
        model.addAttribute("qanda", qanda);
        return "qanda/qandaUpdateForm"; // 수정 페이지로 이동
    }

    @PostMapping("/update/{seq}")
    public String updateQandA(@PathVariable int seq, @ModelAttribute("qanda") QandA qanda, HttpSession session) {
        User user = (User) session.getAttribute("dto");
        if (user == null || user.getUserid() == null) {
            return "redirect:/login";
        }
        qanda.setSeq(seq);
        qandAService.updateQandA(qanda);
        return "redirect:/qanda/qandalist";
    }

    @PostMapping("/delete/{seq}")
    public String deleteQandA(@PathVariable int seq, HttpSession session) {
        User user = (User) session.getAttribute("dto");
        if (user == null || user.getUserid() == null) {
            return "redirect:/login";
        }
        qandAService.deleteQandA(seq);
        return "redirect:/qanda/qandalist";
    }
    
    
    @PostMapping("/increaseLikes/{seq}")
    @ResponseBody
    public Map<String, Object> increaseLikes(@PathVariable int seq, HttpSession session) {
        User user = (User) session.getAttribute("dto");
        Map<String, Object> result = new HashMap<>();

        if (user == null) {
            result.put("success", false);
            result.put("message", "로그인이 필요합니다.");
            return result;
        }

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userno", user.getUserno());
        paramMap.put("seq", seq);

        boolean alreadyRecommended = qandAService.checkUserRecommendation(paramMap);
        if (alreadyRecommended) {
            result.put("success", false);
            result.put("message", "이미 추천한 게시물입니다.");
        } else {
            qandAService.addUserRecommendation(user.getUserno(), seq);
            qandAService.increaseLikes(seq);
            result.put("success", true);
        }

        return result;
    }

}
