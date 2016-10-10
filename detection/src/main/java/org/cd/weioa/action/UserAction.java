package org.cd.weioa.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.cd.weioa.entity.User;
import org.cd.weioa.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("user/")
public class UserAction {

    @Autowired
    private UserService userService;
    
    @RequestMapping("mypage.htm")
    public String deviceList(HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        User userInfo = (User) session.getAttribute("userInfo");
        User user = this.userService.getUserByOpenId(userInfo.getUserOpenId());
        if(user == null) {
            user = new User();
        }
        request.setAttribute("user", user);
        return "user/mypage";
    }
    
    @RequestMapping("toUpdateUser.htm")
    public String toUpdateUser(HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        User userInfo = (User) session.getAttribute("userInfo");
        User user = this.userService.getUserByOpenId(userInfo.getUserOpenId());
        if(user == null) {
            user = new User();
        }
        request.setAttribute("user", user);
        return "user/updateUser";
    }
    
    @RequestMapping("updateUser.htm")
    public String updateUser(HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        User userInfo = (User) session.getAttribute("userInfo");
        String openId = userInfo.getUserOpenId();
        String userName = request.getParameter("userName");
        String userEmail = request.getParameter("userEmail");
        String userPhone = request.getParameter("userPhone");
        this.userService.updateUser(openId, userName, userEmail, userPhone);
        return "redirect:/user/mypage.htm";
    }

}
