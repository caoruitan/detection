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

public class AdminFilter implements Filter {

    @Override
    public void destroy() {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(true);
        String path = httpRequest.getContextPath();
        String basePath = httpRequest.getScheme() + "://" + httpRequest.getServerName() + ":" + httpRequest.getServerPort() + path;
        if(session.getAttribute("adminLogin") == null) {
            httpResponse.sendRedirect(basePath + "/admin/toLogin");
        } else {
            chain.doFilter(httpRequest, response);
        }
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

}
