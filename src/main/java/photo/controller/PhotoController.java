package photo.controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import photo.dto.Photo;
import photo.service.face.PhotoService;
import util.Paging;

@Controller
@RequestMapping("/photo")
public class PhotoController {
    
    private final Logger logger = LoggerFactory.getLogger(getClass());
    
    private static final String UPLOAD_DIR = "C:\\Users\\eun99\\Downloads\\project\\src\\main\\webapp\\resources\\img\\upload";
    
    @Autowired
    private HttpSession session; // HttpSession 주입

    
    @Autowired 
    private PhotoService photoService;

    @RequestMapping("/list")
    public String list(@RequestParam(defaultValue = "0") int curPage, Model model) {
        Paging paging = photoService.getPaging(curPage);
        logger.info("{}", paging);

        List<Photo> list = photoService.list(paging);
        logger.info("{}", paging);

        model.addAttribute("paging", paging);
        model.addAttribute("list", list);

        return "photo/list";
    }

    // 사진 업로드 폼
    @GetMapping("/write")
    public String writeForm() {
        return "photo/upload";
    }

    // 사진 업로드 처리
    @PostMapping("/upload")
    public String uploadPhoto(@RequestParam("photoFile") MultipartFile file, @RequestParam("content") String content,@RequestParam("title") String title, HttpSession session, Model model) {
        if (file.isEmpty()) {
            model.addAttribute("message", "업로드할 파일을 선택해주세요");
            return "redirect:/photo/uploadStatus";
        }

        try {
            String originalFilename = file.getOriginalFilename();
            String uniqueFilename = UUID.randomUUID().toString() + "_" + originalFilename;
            Path path = Paths.get(UPLOAD_DIR, uniqueFilename);
            Files.write(path, file.getBytes());

            String nickname = (String) session.getAttribute("nickname");

            
            // 사진 객체 생성 및 저장
            Photo photo = new Photo();
            photo.setFilename(uniqueFilename);
            photo.setContent(content);
            photo.setTitle(title);
            photo.setNickname(nickname);
            photoService.save(photo);

            model.addAttribute("message", "파일 업로드 성공");
            return "redirect:/photo/list";
        } catch (IOException e) {
            logger.error("파일 업로드 실패", e);
            model.addAttribute("message", "파일 업로드 실패");
            return "photo/uploadStatus";
        }
    }
    
    @GetMapping("/view")
    public String view(@RequestParam("photoNo") int photoNo, Model model) {
        // 해당 photono에 대한 게시물 정보를 불러와서 model에 추가
        Photo photo = photoService.view(photoNo);
        model.addAttribute("photo", photo);
        
        return "photo/view"; // view.jsp로 이동
    }
    
    @GetMapping("/fix")
    public String fixForm(@RequestParam("photoNo") int photoNo, Model model) {
        Photo photo = photoService.findByPhotoNo(photoNo);
        model.addAttribute("photo", photo);
        return "photo/fix";
    }

    // 사진 수정 처리
    @PostMapping("/fix")
    public String fix(@RequestParam("photoNo") int photoNo,
                      @RequestParam("title") String title,
                      @RequestParam("content") String content,
                      @RequestParam("photoFile") MultipartFile file,
                      Model model) {
        Photo photo = photoService.view(photoNo);

        photo.setTitle(title);
        photo.setContent(content);

        if (!file.isEmpty()) {
            try {
                String originalFilename = file.getOriginalFilename();
                String uniqueFilename = UUID.randomUUID().toString() + "_" + originalFilename;
                Path path = Paths.get(UPLOAD_DIR, uniqueFilename);
                Files.write(path, file.getBytes());
                photo.setFilename(uniqueFilename);
            } catch (IOException e) {
                logger.error("파일 업로드 실패", e);
                model.addAttribute("message", "파일 업로드 실패");
                return "photo/fix";
            }
        }

        photoService.update(photo);

        return "redirect:/photo/view?photoNo=" + photoNo;
    }
    
    @GetMapping("/delete")
    public String delete(@RequestParam("photoNo")int photono) {
    	photoService.delete(photono);
        return "redirect:/photo/list";
    	
    }
    
}