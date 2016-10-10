package org.cd.weioa.service;

import javax.transaction.Transactional;

import org.cd.weioa.dao.AdminDao;
import org.cd.weioa.entity.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Transactional
public class AdminService {

    @Autowired
    private AdminDao adminDao;

    public String getPassword(String loginname) {
        return this.adminDao.getEntityById(Admin.class, loginname).getPassword();
    }
    
    public String updatePassword(String loginname, String oldPassword, String newPassword) {
        Admin admin = this.adminDao.getEntityById(Admin.class, loginname);
        if(MD5Util.MD5Encode(oldPassword).equals(admin.getPassword())) {
            admin.setPassword(MD5Util.MD5Encode(newPassword));
            this.adminDao.save(admin);
            return "1";
        } else {
            return "0";
        }
    }
}
