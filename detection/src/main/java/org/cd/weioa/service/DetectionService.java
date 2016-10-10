package org.cd.weioa.service;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collection;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.transaction.Transactional;

import org.cd.weioa.dao.DeviceCalendarDao;
import org.cd.weioa.dao.DeviceCalendarOrderDao;
import org.cd.weioa.dao.DeviceDao;
import org.cd.weioa.dao.DeviceScheduleDao;
import org.cd.weioa.entity.DateSchedule;
import org.cd.weioa.entity.Device;
import org.cd.weioa.entity.DeviceCalendar;
import org.cd.weioa.entity.DeviceCalendarOrder;
import org.cd.weioa.entity.DeviceSchedule;
import org.cd.weioa.entity.MySchedule;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Transactional
public class DetectionService {

    @Autowired
    private DeviceDao deviceDao;
    
    @Autowired
    private DeviceCalendarDao deviceCalendarDao;
    
    @Autowired
    private DeviceScheduleDao deviceScheduleDao;
    
    @Autowired
    private DeviceCalendarOrderDao deviceCalendarOrderDao;
    
    public Device getDeviceById(String deviceId) {
        return this.deviceDao.getEntityById(Device.class, deviceId);
    }
    
    public List<Device> deviceList() {
        return deviceDao.deviceList();
    }
    
    @SuppressWarnings("deprecation")
    public Map<Date, Long> calendarMap(String deviceId) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Map<Date, Long> calendarMap = new LinkedHashMap<Date, Long>();
        
        List<Date> afterDate = new ArrayList<Date>();
        for(int i = 1; i <= 30; i ++) {
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DATE, i);
            afterDate.add(cal.getTime());
        }
        
        Date startDate = afterDate.get(0);
        for(int i = 0; i < startDate.getDay() - 1; i ++) {
            Calendar cal = Calendar.getInstance();
            cal.add(Calendar.DATE, -i);
            afterDate.add(0, cal.getTime());
        }
        
        Long scheduleCount = this.deviceScheduleDao.getCountSchedulePerDay(deviceId);
        Calendar end = Calendar.getInstance();
        end.add(Calendar.DATE, 30);
        Date endDate = end.getTime();
        List<Object[]> calendars = deviceCalendarDao.getUsedCalendarCount(deviceId, sdf.format(startDate), sdf.format(endDate));
        Map<String, Long> usedCalendarMap = new LinkedHashMap<String, Long>();
        for(Object[] objs : calendars) {
            usedCalendarMap.put(objs[0].toString(), Long.parseLong(objs[1].toString()));
        }
        
        for(Date date : afterDate) {
            if(date.getTime() < startDate.getTime()) {
                calendarMap.put(date, -1l);
                continue;
            }
            Long count = scheduleCount;
            Long usedCount = usedCalendarMap.get(sdf.format(date));
            if(usedCount != null) {
                count = scheduleCount - usedCount;
            }
            calendarMap.put(date, count);
        }
        
        return calendarMap;
    }
    
    public Map<String, Boolean> scheduleList(String deviceId, String calendarDate) {
        List<DeviceSchedule> scheduleList = this.deviceScheduleDao.getScheduleList(deviceId);
        List<DeviceCalendar> calendarList = this.deviceCalendarDao.getUsedCalendarList(deviceId, calendarDate);
        List<String> calendarIds = new ArrayList<String>();
        for(DeviceCalendar calendar : calendarList) {
            calendarIds.add(calendar.getScheduleId());
        }
        
        Map<String, Boolean> scheduleMap = new LinkedHashMap<String, Boolean>();
        for(DeviceSchedule schedule : scheduleList) {
            if(calendarIds.contains(schedule.getScheduleId())) {
                scheduleMap.put(schedule.getScheduleTime(), false);
            } else {
                scheduleMap.put(schedule.getScheduleTime(), true);
            }
        }
        return scheduleMap;
    }
    
    public void makeAnAppointment(String deviceId, String calendarDate, String[] calendarTimes, String creator) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date date = null;
        try {
            date = sdf.parse(calendarDate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        
        List<DeviceSchedule> scheduleList = this.deviceScheduleDao.getScheduleListByTimes(deviceId, calendarTimes);
        List<String> scheduleIds = new ArrayList<String>();
        for(DeviceSchedule schedule : scheduleList) {
            scheduleIds.add(schedule.getScheduleId());
        }
        
        Long usedCount = this.deviceCalendarDao.getCountOfCalendar(deviceId, date, scheduleIds);
        if(usedCount > 0) {
            throw new Exception();
        }
        
        DeviceCalendarOrder order = new DeviceCalendarOrder();
        order.setDeviceId(deviceId);
        order.setOrderDate(date);
        order.setCreator(creator);
        order.setCreateTime(new Date());
        this.deviceCalendarOrderDao.save(order);
        
        for(DeviceSchedule schedule : scheduleList) {
            DeviceCalendar calendar = new DeviceCalendar();
            calendar.setOrderId(order.getOrderId());
            calendar.setDeviceId(deviceId);
            calendar.setCalendarDate(date);
            calendar.setScheduleId(schedule.getScheduleId());
            this.deviceCalendarDao.save(calendar);
        }
    }
    
    public Collection<MySchedule> mySchedule(String userId) throws ParseException {
        List<Object[]> myScheduleList = this.deviceCalendarOrderDao.mySchedule(userId);
        Map<String, MySchedule> mySchedules = new LinkedHashMap<String, MySchedule>();
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        for(Object[] obj : myScheduleList) {
            MySchedule schedule = mySchedules.get(obj[3].toString());
            if(schedule == null) {
                schedule = new MySchedule();
                schedule.setOrderId(obj[3].toString());
                schedule.setDeviceId(obj[4].toString());
                schedule.setOrderDate(sdf.parse(obj[5].toString()));
                schedule.setDeviceName(obj[6].toString());
                schedule.setDeviceModel(obj[7].toString());
                schedule.setDeviceImageUrl(obj[8].toString());
                List<String> times = new ArrayList<String>();
                times.add(obj[2].toString());
                schedule.setCalendarTimes(times);
                mySchedules.put(obj[3].toString(), schedule);
            } else {
                schedule.getCalendarTimes().add(obj[2].toString());
            }
        }
        return mySchedules.values();
    }
    
    public List<DateSchedule> deviceScheduleOfDate(String deviceId, String date) {
        List<Object[]> schedules = this.deviceCalendarOrderDao.deviceScheduleOfDate(deviceId, date);
        List<DateSchedule> dataSchedule = new ArrayList<DateSchedule>();
        for(Object[] obj : schedules) {
            DateSchedule sch = new DateSchedule();
            sch.setScheduleTime(obj[0].toString());
            sch.setScheduleId(obj[5].toString());
            if(obj[6] != null) {
                sch.setOrderId(obj[6].toString());
            }
            if(obj[1] != null) {
                sch.setCalendarId(obj[1].toString());
            }
            if(obj[2] != null) {
                sch.setUserName(obj[2].toString());
            }
            if(obj[3] != null) {
                sch.setUserEmail(obj[3].toString());
            }
            if(obj[4] != null) {
                sch.setUserPhone(obj[4].toString());
            }
            dataSchedule.add(sch);
        }
        return dataSchedule;
    }
    
    public void makeAppointOfAdmin(String deviceId, String scheduleId, String date) throws ParseException {
        DeviceCalendar calendar = new DeviceCalendar();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        calendar.setCalendarDate(sdf.parse(date));
        calendar.setDeviceId(deviceId);
        calendar.setScheduleId(scheduleId);
        this.deviceCalendarDao.save(calendar);
    }

}
