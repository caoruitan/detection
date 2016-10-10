package org.cd.weioa.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.cd.weioa.entity.User;
import org.cd.weioa.service.UserService;
import org.cd.weioa.weinxin.UserInfo;
import org.cd.weioa.weinxin.WeixinUtil;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;

public class WeixinOauthFilter implements Filter {

    @Override
    public void destroy() {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(true);
        
        boolean isAuth = false;

        /*if(userInfo == null) {
            String path = httpRequest.getContextPath();
            String basePath = httpRequest.getScheme() + "://" + httpRequest.getServerName() + ":" + httpRequest.getServerPort() + path;
            userInfo = new UserInfo();
            userInfo.setOpenId("test");
            userInfo.setNickName("test");
            userInfo.setHeadImgUrl(basePath + "/res/images/edevice/m-user1.png");
            session.setAttribute("userInfo", userInfo);
        }
        chain.doFilter(httpRequest, httpResponse);*/
        User user = (User) session.getAttribute("userInfo");
        if(user != null) {
            isAuth = true;
        } else {
            String paramState = httpRequest.getParameter("state");
            String paramCode = httpRequest.getParameter("code");
            if(paramState != null && paramCode != null && !paramState.equals("") && !paramCode.equals("")) {
                if(paramState.equals("detection")) {
                    UserInfo userInfo = WeixinUtil.getUserInfo(paramCode);
                    WebApplicationContext wac = ContextLoader.getCurrentWebApplicationContext();
                    UserService userService = (UserService) wac.getBean("userService");
                    user = userService.getUserByOpenId(userInfo.getOpenId());
                    if(user == null) {
                        user = new User();
                        user.setUserOpenId(userInfo.getOpenId());
                        user.setWxNickName(userInfo.getNickName());
                        user.setWxSex(userInfo.getSex());
                        user.setWxProvince(userInfo.getProvince());
                        user.setWxCity(userInfo.getCity());
                        user.setWxCountry(userInfo.getCountry());
                        user.setWxHeadImgUrl(userInfo.getHeadImgUrl());
                        user.setWxUnionId(userInfo.getUnionid());
                        userService.addUser(user);
                    }
                    session.setAttribute("userInfo", user);
                    isAuth = true;
                }
            }
        }
        
        if(isAuth) {
            chain.doFilter(httpRequest, httpResponse);
        } else {
            StringBuffer url = httpRequest.getRequestURL();
            if (httpRequest.getQueryString() != null) {
                url.append('?');
                url.append(httpRequest.getQueryString());
            }
            httpResponse.sendRedirect("https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxeb16fda239ff4130&redirect_uri=" + url.toString() + "&response_type=code&scope=snsapi_userinfo&state=detection#wechat_redirect");
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

}
