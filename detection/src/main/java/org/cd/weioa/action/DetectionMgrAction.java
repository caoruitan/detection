package org.cd.weioa.action;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.cd.weioa.entity.DateSchedule;
import org.cd.weioa.entity.Device;
import org.cd.weioa.service.DetectionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("devicemgr/")
public class DetectionMgrAction {

    @Autowired
    private DetectionService detectionService;
    
    @RequestMapping("deviceList.do")
    public String deviceList(HttpServletRequest request) {
        List<Device> deviceList = this.detectionService.deviceList();
        request.setAttribute("deviceList", deviceList);
        return "devicemgr/deviceList";
    }
    
    @RequestMapping("deviceDetail.do")
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
        return "devicemgr/deviceDetail";
    }
    
    @RequestMapping("dateSchedule.do")
    public String toMakeAnAppointment(HttpServletRequest request) {
        String deviceId = request.getParameter("deviceId");
        String calendarDate = request.getParameter("calendarDate");
        List<DateSchedule> schedules = this.detectionService.deviceScheduleOfDate(deviceId, calendarDate);
        request.setAttribute("schedules", schedules);
        request.setAttribute("deviceId", deviceId);
        request.setAttribute("calendarDate", calendarDate);
        return "devicemgr/dateSchedule";
    }

    @RequestMapping("makeAppoint.do")
    public String makeAppoint(HttpServletRequest request) throws ParseException {
        String deviceId = request.getParameter("deviceId");
        String calendarDate = request.getParameter("calendarDate");
        String scheduleId = request.getParameter("scheduleId");
        this.detectionService.makeAppointOfAdmin(deviceId, scheduleId, calendarDate);
        return "redirect:/devicemgr/dateSchedule.do?deviceId=" + deviceId + "&calendarDate=" + calendarDate;
    }

}
