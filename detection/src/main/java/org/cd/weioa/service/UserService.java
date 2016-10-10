package org.cd.weioa.service;

import javax.transaction.Transactional;

import org.cd.weioa.dao.UserDao;
import org.cd.weioa.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
@Transactional
public class UserService {

    @Autowired
    private UserDao userDao;

    public User getUserByOpenId(String openId) {
        return this.userDao.getUserByOpenId(openId);
    }
    
    public void updateUser(String openId, String userName, String userEmail, String userPhone) {
        User user = this.getUserByOpenId(openId);
        if(user == null) {
            user = new User();
            user.setUserOpenId(openId);
            user.setUserName(userName);
            user.setUserEmail(userEmail);
            user.setUserPhone(userPhone);
            this.userDao.save(user);
        } else {
            user.setUserOpenId(openId);
            user.setUserName(userName);
            user.setUserEmail(userEmail);
            user.setUserPhone(userPhone);
            this.userDao.update(user);
        }
    }
    
    public void addUser(User user) {
        this.userDao.save(user);
    }
}
