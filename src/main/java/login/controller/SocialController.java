package login.controller;

import com.google.gson.JsonObject;
import login.service.SocialService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;

@Controller
@RequestMapping("/login")
public class SocialController {
	private Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired SocialService socialService;
	
//    @Autowired
//    private NaverLoginVO naverLoginVO;
    private String apiResult = null;
//    @Autowired
//    private void setnaverLoginVO(NaverLoginVO naverLoginVO) {
//        this.naverLoginVO = naverLoginVO;
//    }
//    @RequestMapping(value = "/naverLogin", method = { RequestMethod.GET, RequestMethod.POST })
//    public String login(Model model, HttpSession session) {
//
//        /* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginVO클래스의 getAuthorizationUrl메소드 호출 */
//        String naverAuthUrl = naverLoginVO.getAuthorizationUrl(session);
//
//        //https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
//        //redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
//        System.out.println("네이버:" + naverAuthUrl);
//
//        //네이버 
//        model.addAttribute("url", naverAuthUrl);
//
//        /* 생성한 인증 URL을 View로 전달 */
//        return "login/naverlogin";
//    }
//
//    //네이버 로그인 성공시 callback호출 메소드
//    @RequestMapping(value = "/login/navercallback", method = { RequestMethod.GET, RequestMethod.POST })
//    public String callback(Model model, @RequestParam(value = "code") String code, @RequestParam(value = "state") String state, HttpSession session)
//            throws IOException {
//        System.out.println("여기는 callback");
//        OAuth2AccessToken oauthToken;
//        oauthToken = naverLoginVO.getAccessToken(session, code, state);
//        //로그인 사용자 정보를 읽어온다.
//        apiResult = naverLoginVO.getUserProfile(oauthToken);
//        model.addAttribute("result", apiResult);
//
//        /* 네이버 로그인 성공 페이지 View 호출 */
//        return "login/naverSuccess";
//    }

	@RequestMapping("/naver/login")
	public ModelAndView main(HttpSession session, Model model) {
		String state = socialService.getstate();
		
		String apiURL = socialService.getApiURL(state);
		
	    session.setAttribute("state", state);
	    logger.info("state~~~ {}",state);
	    logger.info("apiu~~~ {}",apiURL);
	    
	    model.addAttribute("apiURL", apiURL);
	    return new ModelAndView("redirect:"+apiURL);
	}
	
	@RequestMapping("/naver/callback")
	public String callback(HttpServletRequest request, HttpServletResponse response
			) {
		    String code = request.getParameter("code");
		    String state = request.getParameter("state");
		    logger.debug("code : {} ", request.getParameter("code"));
		    logger.debug("state : {} ", request.getParameter("state"));
		    
		    String apiURL = socialService.getApiURL(code,state);
		    logger.debug("apiURL : {} ", apiURL);
		    
		    JsonObject token = socialService.getToken(apiURL);
//		    logger.debug("-----------------error : {} ----------------", token.get("error"));
//		    logger.debug("error_description : {} ", token.get("error_description"));
//		    logger.debug("expires_in : {} ", token.get("expires_in"));
//		    logger.debug("access_token : {} ", token.get("access_token"));
//		    logger.debug("refresh_token : {} ", token.get("refresh_token"));
//		    logger.debug("-------------------token_type : {} ----------------", token.get("token_type"));
		    
		    HashMap<String, Object> info = socialService.getUserInfo(token);
		    
		    return "login/naver/success";
	}

	@RequestMapping("/naver/naver/logoutCallback")
	public void naverLogout() {
		
	}
}
