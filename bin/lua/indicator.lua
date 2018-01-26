--����ģ��
--[[
module indicator  
--]]
--��ͬ������
--[[
local M = {};
local indicator = ...;
_G[indicator] = M;
package.loaded[indicator] = M    -- ��ģ�����뵽package.loaded�У���ֹ��μ���  
setfenv(1,M)                     -- ��ģ�������Ϊ�����Ļ�������ʹ��ģ���е����в���������ģ����еģ��������庯����ֱ�Ӷ�����ģ�����  
--]]

--[[
--�ű�����ʵ�ִ�ӡһ��table
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


--��־����
LOGLEVEL_DEBUG = 0; --����
LOGLEVEL_INFO = 1; --��Ϣ
LOGLEVEL_WARN = 2; --����
LOGLEVEL_ERROR = 3; --����

--ָ������
INDICATOR_TYPE_MAIN = 0; --��ͼָ��
INDICATOR_TYPE_SECOND = 1; --��ͼָ��
INDICATOR_TYPE_POOL = 2; --����/��ָ��

--ָ��������
INDEX_LINE = 0; --ָ����
INDEX_CALC = 1; --��������

--���߷�ʽ
DRAW_LINE = 0; --����
DRAW_SECTION = 1; --����
DRAW_STICK = 2; --��״��
DRAW_HISTOGRAM = 3; --��״ͼ
DRAW_HISTOGRAM2 = 4; --����ָ���������״ͼ

--��������
LINE_SOLID = 0; --ʵ��
LINE_DASH = 1; --����
LINE_DOT = 2; --����
LINE_DASHDOT = 3; --�۵���
LINE_DASHDOTDOT = 4; --˫�۵���

--�۸�����
PRICE_CLOSE=0; --���̼�
PRICE_OPEN=1; --���̼�
PRICE_HIGH=2; --��߼�
PRICE_LOW=3; --��ͼ�
PRICE_MEDIAN=4; --�м�ֵ����+�ͣ�/2
PRICE_TYPICAL=5; --���ͼ۸񣨸�+��+���̼ۣ�/3
PRICE_WEIGHTED=6; --ƽ���۸񣨸�+��+���̼۸�+���̼۸�/4
PRICE_VOLUME=7; --�ɽ���
PRICE_AMOUNT=8; --�ɽ���
PRICE_TICKVOLUME=9; --������
PRICE_AVPRICE=10; --ƽ���ۣ��ɽ���/�ɽ�����


--����
PERIOD_TICK = 0 --��ϸ
PERIOD_1SEC = 1 --1��
PERIOD_5SEC = 5 --5��
PERIOD_1MIN = 60 --����
PERIOD_5MIN = 60*5 --5����
PERIOD_15MIN = 60*15 --15����
PERIOD_30MIN = 60*30 --30����
PERIOD_HOUR = 60*60 --ʱ
PERIOD_4HOUR = 60*60*4 --4Сʱ
PERIOD_DAY = 60*60*24 --��
PERIOD_WEEK = 60*60*24*7 --��
PERIOD_MONTH = 60*60*24*30 --��
PERIOD_SEASON = 60*60*24*90 --��
PERIOD_YEAR = 60*60*24*365 --��

--�����ֶ�
INDICATOR_FIELD_0 = 0; --��
INDICATOR_FIELD_DATE = 1; --����
INDICATOR_FIELD_TIME = 2; --ʱ��
INDICATOR_FIELD_CLOSE = 3; --���̼�
INDICATOR_FIELD_OPEN = 4; --���̼�
INDICATOR_FIELD_HIGH = 5; --��߼�
INDICATOR_FIELD_LOW = 6; --��ͼ�
INDICATOR_FIELD_NOW = 7; --���¼�
INDICATOR_FIELD_VOLUME = 8; --�ɽ���
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
INDICATOR_FIELD_ASK_PRICE_10 = 48; -- ��ʮ��		��(Ԫ)/��
INDICATOR_FIELD_ASK_PRICE_9 = 49; -- ���ż�		��(Ԫ)/��
INDICATOR_FIELD_ASK_PRICE_8 = 50; -- ���˼�		��(Ԫ)/��
INDICATOR_FIELD_ASK_PRICE_7 = 51; -- ���߼�		��(Ԫ)/��
INDICATOR_FIELD_ASK_PRICE_6 = 52; -- ������		��(Ԫ)/��
INDICATOR_FIELD_ASK_PRICE_5 = 53; -- �����		��(Ԫ)/��
INDICATOR_FIELD_ASK_PRICE_4 = 54; -- ���ļ�		��(Ԫ)/��
INDICATOR_FIELD_ASK_PRICE_3 = 55; -- ������		��(Ԫ)/��
INDICATOR_FIELD_ASK_PRICE_2 = 56; -- ������		��(Ԫ)/��
INDICATOR_FIELD_ASK_PRICE_1 = 57; -- ��һ�ۣ�ͬ������IDF_ASK_PRICE
INDICATOR_FIELD_BID_PRICE_1 = 58; -- ��һ�ۣ�ͬ�����IDF_BID_PRICE
INDICATOR_FIELD_BID_PRICE_2 = 59; -- �����		��(Ԫ)/��
INDICATOR_FIELD_BID_PRICE_3 = 60; -- ������		��(Ԫ)/��
INDICATOR_FIELD_BID_PRICE_4 = 61; -- ���ļ�		��(Ԫ)/��
INDICATOR_FIELD_BID_PRICE_5 = 62; -- �����		��(Ԫ)/��
INDICATOR_FIELD_BID_PRICE_6 = 63; -- ������		��(Ԫ)/��
INDICATOR_FIELD_BID_PRICE_7 = 64; -- ���߼�		��(Ԫ)/��
INDICATOR_FIELD_BID_PRICE_8 = 65; -- ��˼�		��(Ԫ)/��
INDICATOR_FIELD_BID_PRICE_9 = 66; -- ��ż�		��(Ԫ)/��
INDICATOR_FIELD_BID_PRICE_10 = 67; -- ��ʮ��		��(Ԫ)/��
INDICATOR_FIELD_ASK_VOLUME_10 = 68; -- ��ʮ��		��(�ɡ��š���)
INDICATOR_FIELD_ASK_VOLUME_9 = 69; -- ������		��(�ɡ��š���)
INDICATOR_FIELD_ASK_VOLUME_8 = 70; -- ������		��(�ɡ��š���)
INDICATOR_FIELD_ASK_VOLUME_7 = 71; -- ������		��(�ɡ��š���)
INDICATOR_FIELD_ASK_VOLUME_6 = 72; -- ������		��(�ɡ��š���)
INDICATOR_FIELD_ASK_VOLUME_5 = 73; -- ������		��(�ɡ��š���)
INDICATOR_FIELD_ASK_VOLUME_4 = 74; -- ������		��(�ɡ��š���)
INDICATOR_FIELD_ASK_VOLUME_3 = 75; -- ������		��(�ɡ��š���)
INDICATOR_FIELD_ASK_VOLUME_2 = 76; -- ������		��(�ɡ��š���)
INDICATOR_FIELD_ASK_VOLUME_1 = 77; -- ��һ��		��(�ɡ��š���)
INDICATOR_FIELD_BID_VOLUME_1 = 78; -- ��һ��		��(�ɡ��š���)
INDICATOR_FIELD_BID_VOLUME_2 = 79; -- �����		��(�ɡ��š���)
INDICATOR_FIELD_BID_VOLUME_3 = 80; -- ������		��(�ɡ��š���)
INDICATOR_FIELD_BID_VOLUME_4 = 81; -- ������		��(�ɡ��š���)
INDICATOR_FIELD_BID_VOLUME_5 = 82; -- ������		��(�ɡ��š���)
INDICATOR_FIELD_BID_VOLUME_6 = 83; -- ������		��(�ɡ��š���)
INDICATOR_FIELD_BID_VOLUME_7 = 84; -- ������		��(�ɡ��š���)
INDICATOR_FIELD_BID_VOLUME_8 = 85; -- �����		��(�ɡ��š���)
INDICATOR_FIELD_BID_VOLUME_9 = 86; -- �����		��(�ɡ��š���)
INDICATOR_FIELD_BID_VOLUME_10 = 87; -- ��ʮ�� 		��(�ɡ��š���)
	
--MA����
MODE_SMA=0; --���ƶ�ƽ���� (SMA)��Simple Moving Average
MODE_EMA=1; --ָ���ƶ�ƽ���� (EMA)��Exponential MA
MODE_SMMA=2; --ͨ���ƶ�ƽ���� (SMMA)��Smoothed MA
MODE_LWMA=3; --����Ȩ���ƶ�ƽ���� (LWMA)��Linear Weighted MA
MODE_DMA=4; --��̬�ƶ�ƽ���� Dynamic Moving Average


--�����б�����
MODE_ORDERS=1 --ί��
MODE_HISTORY_ORDERS=2 --��ʷί��
MODE_TRADES=3 --�ɽ�
MODE_HISTORY_TRADES=4 --��ʷ�ɽ�
MODE_POSITION=5 --�ֲ�

--ί�з�ʽ
OP_NONE	= 0;
OP_BUY = 1;	--Buy operation
OP_SELL	= 2;	--Sell operation
OP_BUYLIMIT	= 3;	--Buy limit pending order
OP_SELLLIMIT = 4;	--Sell limit pending order
OP_BUYSTOP = 5;	--Buy stop pending order
OP_SELLSTOP	= 6;	--Sell stop pending order


--ָ�꺯��˵��
--����ָ�꣬���ڶ���ָ�����ͣ�ָ��/���ԣ����Ƿ���ָ�꣬���������ָ���ߵ�
--iSet(table)
--������ָ��󣬸���ָ�����ͣ�����Ҫ����ָ����Ӧ������
--������OnInit������OnInitֻ�ڵ�һ�γ�ʼ��ָ���ʱ�����һ�Σ����治�ٵ��ã��������������һ�����㲢����ָ���ָ���ߣ���Ȼ�������ָ��ܼ���ȫ���Բ���ʵ��OnInit����iSet�͹���
--function OnInit() {}
--Ȼ����OnFilter��ֻ������ָ���ǲ���ָ�꣨INDICATOR_TYPE_POOL��������Ҫ��ӦOnFilter����OnFilter��������Ӻ�ɾ����Ĵ��룬����ϵͳ�ڼ�⵽��Ĵ��������ͽ��׷����κα仯��ʱ�򣬾ͻᴥ������ָ��ļ���
--function OnFilter() {}
--�����Ǽ��㺯��OnCalculate��OnCalculate�����ڱ�Ĵ��������ͽ��׷����κα仯��ʱ�򣬶��ᴥ�����㣬�������ڼ��㺯����ʵʱ����ָ��ֵ��״̬������ѯ�˻��ͳֲ֡�ί����Ϣ�Լ������������׵�
--function OnCalculate(count,calculated) { return(count); }

--������������ϵͳΪ���ṩ��ָ����غ��������ֺ������������ָ��ָ�����Ļ������ǻ�ȡָ��ָ������ݣ�ָ����һ�������һ��������������ѡ�񲻴����������ǻ�ȡ�����õ�ǰָ������
--�����������
--iSetInput(name,value)
--����ָ������
--iSetIndexName(index,name)
--����ָ��������
--iSetIndexType(index,type)
--����ָ����С��λ��
--iSetIndexDigits(index,digits)
--����ָ����ƫ��
--iSetIndexShift(index,shift)
--����ָ���߻��߿�ʼλ��
--iSetIndexBegin(index,begin)
--����ָ���߻��߷�ʽ
--iSetIndexDraw(index,draw)
--����ָ��������
--iSetIndexLine(index,line)
--����ָ���߹���ָ����
--iSetIndexNext(index,next)
--����ָ����offsetλ�õ�ֵ
--iSetIndexValue(index,offset,value)
--����ָ����ӱ�Ĵ��뵽���Գ�
--iAddPool(object)
--����ָ��Ӳ��Գ��Ƴ���Ĵ���
--iRemovePool(object)
--��ȡָ����������ַ���
--iGetInput(name)
--��ȡָ���������ֵ
--iGetInputValue(name)
--��ȡָ��ָ����offsetλ�õ�ֵ
--iGetIndexValue(index,offset)
--��ȡָ�굱ǰ���offsetλ�õļ۸�
--iGetPriceValue(price,offset)
--��ȡָ�굱ǰ���offsetλ�õ�����
--iGetPriceDate(offset)
--��ȡָ�굱ǰ���offsetλ�õ�ʱ��
--iGetPriceTime(offset)
--��ȡָ�굱ǰ���offsetλ�õĲ�������
--iGetFinanceValue(finance,offset)
--��ȡָ�굱ǰ��Ŀ����ֶ�ֵ
--iGetFieldValue(field)
--����λ�õķ���λ��
--iReversePos(pos)
--�ж�ָ����û�м����
--iIsCalculate(handle)
--��������ָ�꣬����ͨ�������������ϵͳָ��������Զ����ָ��
--iRef(name,object,period,...)
--�ͷ�ָ�꣬���������ʹ�ø�ָ��Ļ��������ͷ�����Ĭ������£�������Ҫ�����ͷţ�ϵͳ���Զ���������
--iRelease(handle)
--ϵͳָ��MA
--iMA(object, period, ma_period, ma_shift, ma_method, applied_price)
--ϵͳָ��iStochastic
--iStochastic(object, period, Kperiod, Dperiod, slowing, ma_method, sto_price)
--ϵͳ�㷨MA
--iMAIndexOnPrice(index, period, method, price, handle)
--iMAIndexOnLine(index, period, method, line, handle)
--�ź��ж�
--iIsCross(src, dst, offset, handle)
--����ָ���ж�
--iIsTrade
--�Ƿ�ɽ����ж�
--iIsTradeable
--��ȡ��ǰ��¼�˻���
--iUsersTotal()
--ѡ������˻�
--iUserSelectByIndex(index)
--iUserSelectByName(name)
--���ݱ�Ĵ���ѡ����ʵĽ����˻�
--iUserSelectBySymbol(symbol)
--��ȡ�˻���Ϣ
--iUserFieldValue(field)
--iUserFieldString(field)
--��ȡ�˻��˺�
--iUserAccount()
--��ȡ�˻����׻���
--iUserMoneySymbol()
--��ȡ�˻����ʲ�
--iUserMoneyTotal()
--��ȡ�˻������ʽ�
--iUserMoneyAvailable()
--��ȡ�˻������ʽ�
--iUserMoneyFreeze()
--��ȡ�˻���ȡ�ʽ�
--iUserMoneyFree()
--��ȡ�˻������
--iUserMoneyIn()
--��ȡ�˻�������
--iUserMoneyOut()
--����ί�ж���
--iOrderSend(object, cmd, volume, price, slippage, stoploss, takeprofit, comment, magic, date, time)
--�޸�ί�ж���
--iOrderModify(price,stoploss,takeprofit,expiration)
--����ƽ��
--iOrderClose(lots,price,slippage)
--���򿪲�
--iOrderCloseBy(opposite)
--ɾ��ί�ж���
--iOrderDelete()
--ѡ������Ķ����б�
--iOrdersSelect(pool)
--��ȡ�����б�����
--iOrdersTotal()
--ѡ������Ķ���
--iOrderSelectByIndex(index)
--iOrderSelectByTicketA(ticket)
--iOrderSelectByMagic(magic)
--��ȡ��������
--iOrderType()
--��ȡ�������
--iOrderTicket()
--��ȡ������Ĵ���
--iOrderSymbol()
--��ȡ�������ּ�
--iOrderOpenPrice()
--��ȡ����ƽ�ּ�
--iOrderClosePrice()
--��ȡ��������ʱ��
--iOrderOpenTime()
--��ȡ����ƽ��ʱ��
--iOrderCloseTime()
--��ȡ������Ч��
--iOrderExpiration()
--��ȡ������С
--iOrderLots()
--��ȡ��������
--iOrderProfit()
--��ȡ����ֹӯ��
--iOrderTakeProfit()
--��ȡ����ֹ���
--iOrderStopLoss()
--��ȡ����Ӷ��
--iOrderCommission()
--��ȡ����ħ����
--iOrderMagicNumber()
--��ȡ����˵��ע��
--iOrderComment()
--��ȡ���������ֶ�
--iOrderFieldString(field)

--����iSet���õ������������������������һ�����ʹ��

--����ָ��/���ԣ�ϵͳ�����ó��õĿ������ݣ�����:
--Object ��Ĵ���
--Period ����
--Date ����
--Time ʱ��

--���ڽ���ָ��/���ԣ�ϵͳ�����ó��õĿ������ݣ�����:
--Close ���̼�
--Open ���̼�
--High ��߼�
--Low ��ͼ�
--Now ���¼�
--Volume �ɽ���
--Amount �ɽ���
--BidPrice ί���
--AskPrice ί����
--BidVolume ί����
--AskVolume ί����
--AvgPrice ����
--AvgVolume ����
--UpperPrice ��ͣ��
--LowerPrice ��ͣ��

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