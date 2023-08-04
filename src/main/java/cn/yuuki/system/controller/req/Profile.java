package cn.yuuki.system.controller.req;

import lombok.Data;

@Data
public class Profile {


    private Long userId;

    private String mobile;

    private String email;

    private String erpCode;


}
