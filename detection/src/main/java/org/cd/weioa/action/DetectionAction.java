package org.cd.weioa.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.cd.weioa.entity.Device;
import org.cd.weioa.entity.MySchedule;
import org.cd.weioa.entity.User;
import org.cd.weioa.service.DetectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("device/")
public class DetectionAction {

    @Autowired
    private DetectionService detectionService;
    
    @RequestMapping("deviceList.htm")
    public String deviceList(HttpServletRequest request) {
        List<Device> deviceList = this.detectionService.deviceList();
        request.setAttribute("deviceList", deviceList);
        return "device/deviceList";
    }
    
    @RequestMapping("deviceDetail.htm")
    public String deviceDetail(HttpServletRequest request) {
        String deviceId = request.getParameter("deviceId");
        Device device = this.detectionService.getDeviceById(deviceId);
        Map<Date, Long> calendarMap = this.detectionService.calendarMap(deviceId);
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        List<Map<String, Long>> table = new ArrayList<Map<String, Long>>();
        int k = 1;
        for(Map.Entry<Date, Long> entry : calendarMap.entrySet()) {
            Map<String, Long> row;
            if(k == 1) {
                row = new LinkedHashMap<String, Long>();
                table.add(row);
            } else {
                row = table.get(table.size() - 1);
            }
            row.put(sdf.format(entry.getKey()), entry.getValue());
            k++;
            if(k == 8) {
                k = 1;
            }
        }
        
        request.setAttribute("device", device);
        request.setAttribute("table", table);
        return "device/deviceDetail";
    }
    
    @RequestMapping("toMakeAnAppointment.htm")
    public String toMakeAnAppointment(HttpServletRequest request) {
        String deviceId = request.getParameter("deviceId");
        String calendarDate = request.getParameter("calendarDate");
        Map<String, Boolean> scheduleMap = this.detectionService.scheduleList(deviceId, calendarDate);
        request.setAttribute("scheduleMap", scheduleMap);
        request.setAttribute("calendarDate", calendarDate);
        request.setAttribute("deviceId", deviceId);
        return "device/makeAnAppointment";
    }

    @RequestMapping("makeAnAppointment.htm")
    public String makeAnAppointment(HttpServletRequest request) {
        HttpSession session = request.getSession(true);
        User userInfo = (User) session.getAttribute("userInfo");
        String deviceId = request.getParameter("deviceId");
        String calendarDate = request.getParameter("calendarDate");
        String[] calendarTimes = request.getParameter("calendarTime").split(",");
        try {
            this.detectionService.makeAnAppointment(deviceId, calendarDate, calendarTimes, userInfo.getUserOpenId());
        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/device/faild.htm";
        }
        return "redirect:/device/success.htm";
    }
    
    @RequestMapping("success.htm")
    public String success(HttpServletRequest request) {
        return "/device/success";
    }
    
    @RequestMapping("faild.htm")
    public String faild(HttpServletRequest request) {
        return "/device/faild";
    }
    
    @RequestMapping("mySchedule.htm")
    public String mySchedule(HttpServletRequest request) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        HttpSession session = request.getSession(true);
        User userInfo = (User) session.getAttribute("userInfo");
        Collection<MySchedule> schedules = this.detectionService.mySchedule(userInfo.getUserOpenId());
        request.setAttribute("schedules", schedules);
        request.setAttribute("today", sdf.parse(sdf.format(new Date())));
        return "/device/mySchedule";
    }

}
