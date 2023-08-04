package cn.yuuki.system.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import cn.yuuki.system.entity.system.TradeLog;
import cn.yuuki.system.mapper.TradeLogMapper;
import cn.yuuki.system.service.ITradeLogService;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.concurrent.ConcurrentHashMap;

/**
 * @author MrBird
 */
@Slf4j
@Service("tradeLogService")
public class TradeLogServiceImpl extends ServiceImpl<TradeLogMapper, TradeLog> implements ITradeLogService {

    ConcurrentHashMap<String, Long> hashMap = new ConcurrentHashMap<>();

    @Override
    public void packageAndSend(TradeLog tradeLog) {
        TradeLog tl = new TradeLog();
        tl.setGoodsId(tradeLog.getGoodsId());
        tl.setGoodsName(tradeLog.getGoodsName());
        tl.setStatus("打包完毕，开始物流配送！");
        tl.setCreateTime(new Date());

        this.save(tl);
        log.info("商品ID为{}，名称为{}的商品打包完毕，开始物流配送", tradeLog.getGoodsId(), tradeLog.getGoodsName());

    }

}
