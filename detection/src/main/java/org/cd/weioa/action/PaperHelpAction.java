package org.cd.weioa.action;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("paperhelp/")
public class PaperHelpAction {

    @RequestMapping("building.htm")
    public String deviceList(HttpServletRequest request) {
        return "paperhelp/building";
    }

}
