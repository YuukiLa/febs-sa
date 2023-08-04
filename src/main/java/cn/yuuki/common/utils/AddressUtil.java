package cn.yuuki.common.utils;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.lionsoul.ip2region.xdb.Searcher;
import org.springframework.core.io.ClassPathResource;

import java.io.IOException;
import java.io.InputStream;

/**
 * 根据 IP获取地址
 *
 * @author MrBird
 */
@Slf4j
public class AddressUtil {

    private static byte[] cBuff;

    static {
        String dbPath = "ip2region/ip2region.xdb";

        // 1、从 dbPath 加载整个 xdb 到内存。
        try {
            InputStream resourceAsStream = new ClassPathResource(dbPath).getInputStream();
            cBuff = IOUtils.toByteArray(resourceAsStream);
        } catch (Exception e) {
            System.out.printf("failed to load content from `%s`: %s\n", dbPath, e);
        }
    }

    public static String getCityInfo(String ip) {

        Searcher searcher = null;
        try {
            // 1、创建 searcher 对象
            searcher = Searcher.newWithBuffer(cBuff);
            // 2、查询
            String region = searcher.search(ip);
            // 备注：并发使用，每个线程需要创建一个独立的 searcher 对象单独使用。
            return region;
        } catch (Exception e) {
            log.warn("获取地址信息异常,{}", e.getMessage());
            return StringUtils.EMPTY;
        } finally {
            if (searcher != null) {
                try {
                    searcher.close();
                } catch (IOException e) {
                    log.error("ip2region searcher close error", e);
                }
            }
        }
    }
}