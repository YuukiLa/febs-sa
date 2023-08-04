package cn.yuuki.system.service;

import com.baomidou.mybatisplus.extension.service.IService;
import cn.yuuki.system.entity.system.TradeLog;

/**
 * @author MrBird
 */
public interface ITradeLogService extends IService<TradeLog> {

    /**
     * 打包并派送
     *
     * @param tradeLog 交易日志
     */
    void packageAndSend(TradeLog tradeLog);
}
