package cn.yuuki.system.service;

import java.util.Map;

public interface ILoginService {

    Map<String,Object> login(String username,String password) throws Exception;

    void logout();


}
