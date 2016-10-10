package org.cd.weioa.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.cd.weioa.service.AdminService;
import org.cd.weioa.service.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("admin")
public class AdminAction {

    @Autowired
    private AdminService adminService;
    
    @RequestMapping("toLogin")
    public String toLogin(HttpServletRequest request) {
        String error = request.getParameter("error");
        request.setAttribute("error", error);
        return "admin/login";
    }
    
    @RequestMapping("login")
    public String login(HttpServletRequest request) {
        String loginname = request.getParameter("loginname");
        String password = request.getParameter("password");
        String md5Password = this.adminService.getPassword(loginname);
        if(MD5Util.MD5Encode(password).equals(md5Password)) {
            HttpSession session = request.getSession(true);
            session.setAttribute("adminLogin", loginname);
            return "redirect:/admin/index.do";
        } else {
            return "redirect:/admin/toLogin?error=true";
        }
    }
    
    @RequestMapping("logout")
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        session.removeAttribute("adminLogin");
        return "redirect:/admin/toLogin";
    }
    
    @RequestMapping("index.do")
    public String index(HttpServletRequest request) {
        return "admin/index";
    }
    
    @RequestMapping("toUpdatePassword.do")
    public String toUpdatePassword(HttpServletRequest request) {
        String error = request.getParameter("error");
        request.setAttribute("error", error);
        return "admin/updatePassword";
    }
    
    @RequestMapping("updatePassword.do")
    public String updatePassword(HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        String loginname = session.getAttribute("adminLogin").toString();
        String oldPassword = request.getParameter("password");
        String newPassword = request.getParameter("password1");
        String result = this.adminService.updatePassword(loginname, oldPassword, newPassword);
        if(result.equals("0")) {
            return "redirect:/admin/toUpdatePassword.do?error=true";
        } else {
            return "redirect:/admin/index.do";
        }
    }
}
