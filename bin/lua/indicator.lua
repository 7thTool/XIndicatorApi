--定义模块
--[[
module indicator  
--]]
--等同于以下
--[[
local M = {};
local indicator = ...;
_G[indicator] = M;
package.loaded[indicator] = M    -- 将模块表加入到package.loaded中，防止多次加载  
setfenv(1,M)                     -- 将模块表设置为函数的环境表，这使得模块中的所有操作是以在模块表中的，这样定义函数就直接定义在模块表中  
--]]

--[[
--脚本函数实现打印一个table
function print_table(t, n)
    if "table" ~= type(t) then
        return 0;
    end
    n = n or 0;
    local str_space = "";
    for i = 1, n do
        str_space = str_space.."  ";
    end
    print(str_space.."{");
    for k, v in pairs(t) do
        local str_k_v = str_space.."  ["..tostring(k).."] = ";
        if "table" == type(v) then
            print(str_k_v);
            print_table(v, n + 1);
        else
            str_k_v = str_k_v..tostring(v);
            print(str_k_v);
        end
    end
    print(str_space.."}");
end
--]]


--日志类型
LOGLEVEL_DEBUG = 0; --调试
LOGLEVEL_INFO = 1; --信息
LOGLEVEL_WARN = 2; --警告
LOGLEVEL_ERROR = 3; --错误

--指标类型
INDICATOR_TYPE_MAIN = 0; --主图指标
INDICATOR_TYPE_SECOND = 1; --幅图指标
INDICATOR_TYPE_POOL = 2; --策略/池指标

--指标线类型
INDEX_LINE = 0; --指标线
INDEX_CALC = 1; --辅助计算

--画线方式
DRAW_LINE = 0; --画线
DRAW_SECTION = 1; --线条
DRAW_STICK = 2; --柱状线
DRAW_HISTOGRAM = 3; --柱状图
DRAW_HISTOGRAM2 = 4; --两个指标命令的柱状图

--画线类型
LINE_SOLID = 0; --实线
LINE_DASH = 1; --折线
LINE_DOT = 2; --虚线
LINE_DASHDOT = 3; --折点线
LINE_DASHDOTDOT = 4; --双折点线

--价格类型
PRICE_CLOSE=0; --收盘价
PRICE_OPEN=1; --开盘价
PRICE_HIGH=2; --最高价
PRICE_LOW=3; --最低价
PRICE_MEDIAN=4; --中间值（高+低）/2
PRICE_TYPICAL=5; --典型价格（高+低+收盘价）/3
PRICE_WEIGHTED=6; --平均价格（高+低+收盘价格+开盘价格）/4
PRICE_VOLUME=7; --成交额
PRICE_AMOUNT=8; --成交量
PRICE_TICKVOLUME=9; --跳动量
PRICE_AVPRICE=10; --平均价（成交额/成交量）


--周期
PERIOD_TICK = 0 --明细
PERIOD_1SEC = 1 --1秒
PERIOD_5SEC = 5 --5秒
PERIOD_1MIN = 60 --分钟
PERIOD_5MIN = 60*5 --5分钟
PERIOD_15MIN = 60*15 --15分钟
PERIOD_30MIN = 60*30 --30分钟
PERIOD_HOUR = 60*60 --时
PERIOD_4HOUR = 60*60*4 --4小时
PERIOD_DAY = 60*60*24 --日
PERIOD_WEEK = 60*60*24*7 --周
PERIOD_MONTH = 60*60*24*30 --月
PERIOD_SEASON = 60*60*24*90 --季
PERIOD_YEAR = 60*60*24*365 --年

--快照字段
INDICATOR_FIELD_0 = 0; --无
INDICATOR_FIELD_DATE = 1; --日期
INDICATOR_FIELD_TIME = 2; --时间
INDICATOR_FIELD_CLOSE = 3; --收盘价
INDICATOR_FIELD_OPEN = 4; --开盘价
INDICATOR_FIELD_HIGH = 5; --最高价
INDICATOR_FIELD_LOW = 6; --最低价
INDICATOR_FIELD_NOW = 7; --最新价
INDICATOR_FIELD_VOLUME = 8; --成交量
INDICATOR_FIELD_LAST_VOLUME = 9; --5-9
INDICATOR_FIELD_AMOUNT = 10;
INDICATOR_FIELD_AVERAGE_PRICE = 11;
INDICATOR_FIELD_DELTA = 12;
INDICATOR_FIELD_RANGE_PERCENT = 13;
INDICATOR_FIELD_DELTA_PERCENT = 14; --10-14
INDICATOR_FIELD_WEIBI = 15;
INDICATOR_FIELD_BID_ASK_VOLUME_DIFF = 16;
INDICATOR_FIELD_VOLUME_RATIO = 17;
INDICATOR_FIELD_BID_VOLUME = 18;
INDICATOR_FIELD_ASK_VOLUME = 19; --15-19
INDICATOR_FIELD_BID_PRICE = 20;
INDICATOR_FIELD_ASK_PRICE = 21;
INDICATOR_FIELD_SOLD_VOLUME = 22;
INDICATOR_FIELD_BOUGHT_VOLUME = 23;
INDICATOR_FIELD_RECENT_DELTA_PERCENT = 24;  --20-24
INDICATOR_FIELD_TURNOVER_RATE = 25;
INDICATOR_FIELD_AVERAGE_VOLUME = 26;
INDICATOR_FIELD_PRICE_EARNING_RATIO = 27;
INDICATOR_FIELD_POSITION = 28;
INDICATOR_FIELD_INTEREST = 29;  --25-29
INDICATOR_FIELD_FULL_PRICE = 30;
INDICATOR_FIELD_BARGAIN = 31;
INDICATOR_FIELD_AVERAGE_BARGAIN_VOLUME = 32;
INDICATOR_FIELD_CEILING_PRICE = 33;
INDICATOR_FIELD_FLOOR_PRICE = 34; --30-34
INDICATOR_FIELD_TOTAL_VALUE = 35;
INDICATOR_FIELD_CURRENT_VALUE = 36;
INDICATOR_FIELD_PRICE_BOOK_VALUE_RATIO = 37;
INDICATOR_FIELD_PREV_POSITION = 38;
INDICATOR_FIELD_PREV_SETTLEMENT = 39; --35-39
INDICATOR_FIELD_SETTLEMENT = 40;
INDICATOR_FIELD_LAST_DELTA_POSITION = 41;
INDICATOR_FIELD_DELTA_POSITION = 42;
INDICATOR_FIELD_LAST_OPEN_CLOSE_POSITION = 43;
INDICATOR_FIELD_RISE_COUNT = 44; --40-44
INDICATOR_FIELD_DROP_COUNT = 45;
INDICATOR_FIELD_EQUAL_COUNT = 46; --45-46
INDICATOR_FIELD_DIGITS = 47;
INDICATOR_FIELD_ASK_PRICE_10 = 48; -- 卖十价		是(元)/是
INDICATOR_FIELD_ASK_PRICE_9 = 49; -- 卖九价		是(元)/是
INDICATOR_FIELD_ASK_PRICE_8 = 50; -- 卖八价		是(元)/是
INDICATOR_FIELD_ASK_PRICE_7 = 51; -- 卖七价		是(元)/是
INDICATOR_FIELD_ASK_PRICE_6 = 52; -- 卖六价		是(元)/是
INDICATOR_FIELD_ASK_PRICE_5 = 53; -- 卖五价		是(元)/是
INDICATOR_FIELD_ASK_PRICE_4 = 54; -- 卖四价		是(元)/是
INDICATOR_FIELD_ASK_PRICE_3 = 55; -- 卖三价		是(元)/是
INDICATOR_FIELD_ASK_PRICE_2 = 56; -- 卖二价		是(元)/是
INDICATOR_FIELD_ASK_PRICE_1 = 57; -- 卖一价，同卖出价IDF_ASK_PRICE
INDICATOR_FIELD_BID_PRICE_1 = 58; -- 买一价，同买入价IDF_BID_PRICE
INDICATOR_FIELD_BID_PRICE_2 = 59; -- 买二价		是(元)/是
INDICATOR_FIELD_BID_PRICE_3 = 60; -- 买三价		是(元)/是
INDICATOR_FIELD_BID_PRICE_4 = 61; -- 买四价		是(元)/是
INDICATOR_FIELD_BID_PRICE_5 = 62; -- 买五价		是(元)/是
INDICATOR_FIELD_BID_PRICE_6 = 63; -- 买六价		是(元)/是
INDICATOR_FIELD_BID_PRICE_7 = 64; -- 买七价		是(元)/是
INDICATOR_FIELD_BID_PRICE_8 = 65; -- 买八价		是(元)/是
INDICATOR_FIELD_BID_PRICE_9 = 66; -- 买九价		是(元)/是
INDICATOR_FIELD_BID_PRICE_10 = 67; -- 买十价		是(元)/是
INDICATOR_FIELD_ASK_VOLUME_10 = 68; -- 卖十量		是(股、张、份)
INDICATOR_FIELD_ASK_VOLUME_9 = 69; -- 卖九量		是(股、张、份)
INDICATOR_FIELD_ASK_VOLUME_8 = 70; -- 卖八量		是(股、张、份)
INDICATOR_FIELD_ASK_VOLUME_7 = 71; -- 卖七量		是(股、张、份)
INDICATOR_FIELD_ASK_VOLUME_6 = 72; -- 卖六量		是(股、张、份)
INDICATOR_FIELD_ASK_VOLUME_5 = 73; -- 卖五量		是(股、张、份)
INDICATOR_FIELD_ASK_VOLUME_4 = 74; -- 卖四量		是(股、张、份)
INDICATOR_FIELD_ASK_VOLUME_3 = 75; -- 卖三量		是(股、张、份)
INDICATOR_FIELD_ASK_VOLUME_2 = 76; -- 卖二量		是(股、张、份)
INDICATOR_FIELD_ASK_VOLUME_1 = 77; -- 卖一量		是(股、张、份)
INDICATOR_FIELD_BID_VOLUME_1 = 78; -- 买一量		是(股、张、份)
INDICATOR_FIELD_BID_VOLUME_2 = 79; -- 买二量		是(股、张、份)
INDICATOR_FIELD_BID_VOLUME_3 = 80; -- 买三量		是(股、张、份)
INDICATOR_FIELD_BID_VOLUME_4 = 81; -- 买四量		是(股、张、份)
INDICATOR_FIELD_BID_VOLUME_5 = 82; -- 买五量		是(股、张、份)
INDICATOR_FIELD_BID_VOLUME_6 = 83; -- 买六量		是(股、张、份)
INDICATOR_FIELD_BID_VOLUME_7 = 84; -- 买七量		是(股、张、份)
INDICATOR_FIELD_BID_VOLUME_8 = 85; -- 买八量		是(股、张、份)
INDICATOR_FIELD_BID_VOLUME_9 = 86; -- 买九量		是(股、张、份)
INDICATOR_FIELD_BID_VOLUME_10 = 87; -- 买十量 		是(股、张、份)
	
--MA方法
MODE_SMA=0; --简单移动平均线 (SMA)：Simple Moving Average
MODE_EMA=1; --指数移动平均线 (EMA)：Exponential MA
MODE_SMMA=2; --通畅移动平均线 (SMMA)：Smoothed MA
MODE_LWMA=3; --线性权数移动平均线 (LWMA)：Linear Weighted MA
MODE_DMA=4; --动态移动平均线 Dynamic Moving Average


--订单列表类型
MODE_ORDERS=1 --委托
MODE_HISTORY_ORDERS=2 --历史委托
MODE_TRADES=3 --成交
MODE_HISTORY_TRADES=4 --历史成交
MODE_POSITION=5 --持仓

--委托方式
OP_NONE	= 0;
OP_BUY = 1;	--Buy operation
OP_SELL	= 2;	--Sell operation
OP_BUYLIMIT	= 3;	--Buy limit pending order
OP_SELLLIMIT = 4;	--Sell limit pending order
OP_BUYSTOP = 5;	--Buy stop pending order
OP_SELLSTOP	= 6;	--Sell stop pending order


--指标函数说明
--设置指标，用于定义指标类型（指标/策略），是否交易指标，输入参数，指标线等
--iSet(table)
--定义完指标后，根据指标类型，您需要处理指标响应函数，
--首先是OnInit函数，OnInit只在第一次初始化指标的时候调用一次，后面不再调用，您可以在这里进一步计算并定义指标和指标线，当然如果您的指标很简单完全可以不用实现OnInit，用iSet就够了
--function OnInit() {}
--然后是OnFilter，只有您的指标是策略指标（INDICATOR_TYPE_POOL），才需要响应OnFilter，在OnFilter您可以添加和删除标的代码，这样系统在检测到标的代码的行情和交易发生任何变化的时候，就会触发策略指标的计算
--function OnFilter() {}
--最后就是计算函数OnCalculate，OnCalculate函数在标的代码的行情和交易发生任何变化的时候，都会触发计算，您可以在计算函数里实时更新指标值和状态，并查询账户和持仓、委托信息以及触发买卖交易等
--function OnCalculate(count,calculated) { return(count); }

--接下来将介绍系统为您提供的指标相关函数，部分函数如果您传入指定指标句柄的话，就是获取指定指标的数据，指标句柄一般是最后一个参数，您可以选择不传，这样就是获取和设置当前指标数据
--设置输入参数
--iSetInput(name,value)
--设置指标线名
--iSetIndexName(index,name)
--设置指标线类型
--iSetIndexType(index,type)
--设置指标线小数位数
--iSetIndexDigits(index,digits)
--设置指标线偏移
--iSetIndexShift(index,shift)
--设置指标线画线开始位置
--iSetIndexBegin(index,begin)
--设置指标线画线方式
--iSetIndexDraw(index,draw)
--设置指标线线型
--iSetIndexLine(index,line)
--设置指标线关联指标线
--iSetIndexNext(index,next)
--设置指标线offset位置的值
--iSetIndexValue(index,offset,value)
--策略指标添加标的代码到策略池
--iAddPool(object)
--策略指标从策略池移除标的代码
--iRemovePool(object)
--获取指标输入参数字符串
--iGetInput(name)
--获取指标输入参数值
--iGetInputValue(name)
--获取指标指标线offset位置的值
--iGetIndexValue(index,offset)
--获取指标当前标的offset位置的价格
--iGetPriceValue(price,offset)
--获取指标当前标的offset位置的日期
--iGetPriceDate(offset)
--获取指标当前标的offset位置的时间
--iGetPriceTime(offset)
--获取指标当前标的offset位置的财务数据
--iGetFinanceValue(finance,offset)
--获取指标当前标的快照字段值
--iGetFieldValue(field)
--计算位置的反向位置
--iReversePos(pos)
--判断指标有没有计算过
--iIsCalculate(handle)
--引用其他指标，可以通过这个函数引用系统指标或者您自定义的指标
--iRef(name,object,period,...)
--释放指标，如果您不再使用该指标的话，可以释放它。默认情况下，您不需要考虑释放，系统会自动帮您处理
--iRelease(handle)
--系统指标MA
--iMA(object, period, ma_period, ma_shift, ma_method, applied_price)
--系统指标iStochastic
--iStochastic(object, period, Kperiod, Dperiod, slowing, ma_method, sto_price)
--系统算法MA
--iMAIndexOnPrice(index, period, method, price, handle)
--iMAIndexOnLine(index, period, method, line, handle)
--信号判断
--iIsCross(src, dst, offset, handle)
--交易指标判断
--iIsTrade
--是否可交易判断
--iIsTradeable
--获取当前登录账户数
--iUsersTotal()
--选择操作账户
--iUserSelectByIndex(index)
--iUserSelectByName(name)
--根据标的代码选择合适的交易账户
--iUserSelectBySymbol(symbol)
--获取账户信息
--iUserFieldValue(field)
--iUserFieldString(field)
--获取账户账号
--iUserAccount()
--获取账户交易货币
--iUserMoneySymbol()
--获取账户总资产
--iUserMoneyTotal()
--获取账户可用资金
--iUserMoneyAvailable()
--获取账户冻结资金
--iUserMoneyFreeze()
--获取账户可取资金
--iUserMoneyFree()
--获取账户入金金额
--iUserMoneyIn()
--获取账户出金金额
--iUserMoneyOut()
--发出委托订单
--iOrderSend(object, cmd, volume, price, slippage, stoploss, takeprofit, comment, magic, date, time)
--修改委托订单
--iOrderModify(price,stoploss,takeprofit,expiration)
--卖出平仓
--iOrderClose(lots,price,slippage)
--反向开仓
--iOrderCloseBy(opposite)
--删除委托订单
--iOrderDelete()
--选择操作的订单列表
--iOrdersSelect(pool)
--获取订单列表订单数
--iOrdersTotal()
--选择操作的订单
--iOrderSelectByIndex(index)
--iOrderSelectByTicketA(ticket)
--iOrderSelectByMagic(magic)
--获取订单类型
--iOrderType()
--获取订单编号
--iOrderTicket()
--获取订单标的代码
--iOrderSymbol()
--获取订单开仓价
--iOrderOpenPrice()
--获取订单平仓价
--iOrderClosePrice()
--获取订单开仓时间
--iOrderOpenTime()
--获取订单平仓时间
--iOrderCloseTime()
--获取订单有效期
--iOrderExpiration()
--获取订单大小
--iOrderLots()
--获取订单利润
--iOrderProfit()
--获取订单止盈价
--iOrderTakeProfit()
--获取订单止损价
--iOrderStopLoss()
--获取订单佣金
--iOrderCommission()
--获取订单魔术字
--iOrderMagicNumber()
--获取订单说明注释
--iOrderComment()
--获取订单其他字段
--iOrderFieldString(field)

--对于iSet设置的输入参数，可以像其他变量一样随便使用

--对于指标/策略，系统会内置常用的快照数据，如下:
--Object 标的代码
--Period 周期
--Date 日期
--Time 时间

--对于交易指标/策略，系统会内置常用的快照数据，如下:
--Close 收盘价
--Open 开盘价
--High 最高价
--Low 最低价
--Now 最新价
--Volume 成交量
--Amount 成交额
--BidPrice 委买价
--AskPrice 委卖价
--BidVolume 委买量
--AskVolume 委卖量
--AvgPrice 均价
--AvgVolume 均量
--UpperPrice 涨停价
--LowerPrice 跌停价

function OnPreFilter()
	--init filter data
	return 1;
end

function OnPreCalculate(count,calculated)
	if(count<=0) 
		then
 				return(0);
 		end
 		
	--print(DATE,TIME,"CLOSE="..CLOSE,"OPEN="..OPEN,"HIGH="..HIGH,"LOW="..LOW,"MEDIAN="..MEDIAN,"TYPICAL="..TYPICAL,"WEIGHTED="..WEIGHTED,"VOLUME="..VOLUME,"AMOUNT="..AMOUNT,"TICKVOLUME="..TICKVOLUME,"AVPRICE="..AVPRICE);
	
	return 1;
end

--[[
function M.start()
    print("start");
end

function M.stop()
    print("stop");
end

return M;
--]]