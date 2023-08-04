package cn.yuuki.common.domain.constant;

/**
 * FEBS系统常量类
 *
 * @author MrBird
 */
public interface FebsConstant {

    /**
     * 排序规则：降序
     */
    String ORDER_DESC = "descending";
    /**
     * 排序规则：升序
     */
    String ORDER_ASC = "ascending";


    /**
     * 用户缓存的前缀
     */
    String USER_CACHE_VALUE = "febs:user:";

    /**
     * 用户权限缓存前缀
     */
    String USER_PERMISSION_CACHE_VALUE = "febs:permission:";

    /**
     * 允许下载的文件类型，根据需求自己添加（小写）
     */
    String[] VALID_FILE_TYPE = {"xlsx", "zip"};

    /**
     * 验证码 key前缀
     */
    String CODE_PREFIX = "febs.captcha.";

    /**
     * 异步线程池名称
     */
    String ASYNC_POOL = "febsAsyncThreadPool";



    /**
     * Java默认临时目录
     */
    String JAVA_TEMP_DIR = "java.io.tmpdir";
    /**
     * utf-8
     */
    String UTF8 = "utf-8";
    /**
     * 注册用户角色ID
     */
    Long REGISTER_ROLE_ID = 2L;

    String LOCALHOST = "localhost";
    String LOCALHOST_IP = "127.0.0.1";

}
