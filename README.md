# XIndicatorApi

XIndicatorApi分为XPlatfromApi和XIndicatorApi
* XPlatformApi提供了加载启动XIndicator系统的Api以及和XIndicator系统交互的Api接口
* XIndicatorApi提供了访问行情指标/策略数据和交易接口的Api以及用户自定义行情交易Api接口等

## 快速集成XIndicatorApi可以参考下面几步：

首先，定义XPlatformApi的交互Spi对象

```c/c++
class CPlatformSpi 
	: public XPlatformSpi
{
public:
	virtual int OnRun(bool bJoin)
	{
		printf("CPlatformSpi::OnRun\n");
		XPlatformApi::GetInstance()->CreateThread("MyMACD");
		return __super::OnRun(bJoin);
	}

	virtual int OnRunThread()
	{
		printf("CPlatformSpi::OnRunThread\n");
		return __super::OnRunThread();
	}
};
```

然后，调用XPlatformApi加载XIndicator系统
```c/c++
  XPlatformApi* pApi = XPlatformApi::GetInstance();
	if(pApi) {
		pApi->RegisterSpi(&g_Platform);
		pApi->Init(szAppNameA,szAppPathA,szAppDataA);
		pApi->Login("","");
		pApi->Run();
		pApi->Term();
	}
```

最后，当需要退出XIndicator系统时
```c/c++
	if(XPlatformApi::IsInstanced()) {
		XPlatformApi::GetInstance()->PostQuit();
	}

	DWORD dwRet = ::WaitForSingleObject(hThread, INFINITE);
	if (dwRet == WAIT_TIMEOUT || dwRet == WAIT_FAILED) {
		::TerminateThread(hThread, -1);
	}
	::CloseHandle(hThread);
	hThread = NULL;

	if (XPlatformApi::IsInstanced()) {
		XPlatformApi::ReleaseInstance();
	}
```

## XIndicatorApi提供了访问行情指标/策略数据和交易接口的Api以及用户自定义行情交易Api接口：

XIndicatorSpi
```c/c++
class XINDICATOR_API XIndicatorSpi
{
public:
	//Global
	virtual void OnLog(INDICATOR_LOG_LEVEL level, const char* str) {}

	virtual void OnInit() {}
	virtual void OnTerm() {}

	//Data
	virtual void OnUpdateHisData(const char* symbol) {}
	virtual void OnUpdateFinanceData(const char* symbol) {}
	virtual void OnUpdateFieldData(const char* symbol) {}
	virtual void OnUpdateOrderData() {}
	
	//Calc
	virtual void OnTest(iHandle handle) {}
	virtual void OnCalc(iHandle handle) {}
};

class XINDICATOR_API XIndicatorQuoteProvider
{
public:
	//Symbol
	virtual int OnSymbolsFind(const char* key, unsigned int flags) { return 0; }
	virtual int OnSymbolsTotal(const char* market) { return 0; }
	virtual const char* OnSymbolSelect(int index, char* str, int len) { return str; }

	//Calc Data
	virtual voidptr OnRefCalcData(const char* symbol, int period, unsigned int flags = REF_CALCDATA_DEFAULT) { return 0; }
	virtual void OnReleaseCalcData(voidptr dataptr) {}
	virtual const char* OnGetSymbol(voidptr dataptr, char* str, int len) { return str; }
	virtual int OnGetPeriod(voidptr dataptr) { return 0; }
	virtual int OnGetPriceCount(voidptr dataptr) { return 0; }
	virtual unsigned int OnGetPriceDate(voidptr dataptr, int offset) { return 0; }
	virtual unsigned int OnGetPriceTime(voidptr dataptr, int offset) { return 0; }
	virtual double OnGetPriceValue(voidptr dataptr, int price, int offset) { return 0.; }
	virtual double OnGetFinanceValue(voidptr dataptr, int finance, int offset) { return 0.; }
	virtual double OnGetFieldValue(voidptr dataptr, INDICATOR_FIELD field) { return 0.; }
};

class XINDICATOR_API XIndicatorTradeProvider
{
public:
	//User
	virtual int OnUsersTotal() { return 0; }
	virtual int OnUserSelectReset() { return -1; }
	virtual int OnUserSelectByIndex(int index) { return -1; }
	virtual int OnUserSelectByName(const char* name) { return -1; }
	virtual int OnUserSelectByObject(const char* symbol) { return -1; }
	virtual double OnGetUserFieldValue(const char* field) { return 0.; }
	virtual const char* OnGetUserFieldString(const char* field, char* str, int len) { return str; }

	//Trade
	virtual int OnOrderSend(const char* symbol, int cmd, double volume, double price
		, int slippage, double stoploss, double takeprofit
		, const char* comment, int magic) { return -1; }
	virtual int OnOrdersSelect(int pool) { return -1; }
	virtual int OnOrdersTotal() { return 0; }
	virtual int OnOrderSelectReset() { return -1; }
	virtual int OnOrderSelectByIndex(int index) { return -1; }
	virtual int OnOrderSelectByTicket(const char* ticket) { return -1; }
	virtual int OnOrderSelectByMagic(int magic) { return -1; }

	virtual int OnOrderClose(double lots, double price, int slippage) { return -1; }
	virtual int OnOrderCloseBy(int opposite) { return -1; }
	virtual int OnOrderDelete() { return -1; }
	virtual int OnOrderModify(double price,double stoploss,double takeprofit,unsigned long expiration) { return -1; }

	virtual double OnGetOrderFieldValue(const char* field) { return 0.; }
	virtual const char* OnGetOrderFieldString(const char* field, char* str, int len) { return str; }

	virtual int OnGetOrderType() { return OP_NONE; }
	virtual const char* OnGetOrderTicket(char* str, int len) { return str; }

	virtual const char* OnGetOrderSymbol(char* str, int len) { return str; }

	virtual double OnGetOrderOpenPrice() { return EMPTY_VALUE; }
	virtual double OnGetOrderClosePrice() { return EMPTY_VALUE; }

	virtual unsigned int OnGetOrderOpenTime(unsigned long* date) { return 0; }
	virtual unsigned int OnGetOrderCloseTime(unsigned long* date) { return 0; }
	virtual unsigned int OnGetOrderExpiration(unsigned long* date) { return 0; }

	virtual double OnGetOrderLots() { return 0.; }
	virtual double OnGetOrderProfit() { return 0.; }
	virtual double OnGetOrderTakeProfit() { return 0.; }
	virtual double OnGetOrderStopLoss() { return 0.; }
	virtual double OnGetOrderCommission() { return 0.; }
	virtual int OnGetOrderMagicNumber() { return 0; }
	virtual const char* OnGetOrderComment(char* str, int len) { return str; }
};
```

XIndicatorApi
```c/c++
class XINDICATOR_API XIndicatorApi
{
public:
	static XIndicatorApi* GetInstance();
	static XIndicatorApi* GetInstanceA(const char* workdir, const char* datadir);
	static XIndicatorApi* GetInstanceW(const wchar_t* workdir, const wchar_t* datadir);
	static void ReleaseInstance();

public:
	///初始化
	///@remark 初始化运行环境,只有调用后,接口才开始工作
	//virtual void Init() = 0;
	//virtual void Term() = 0;

	/**
    * @brief 注册回调接口
    * @param[in] pSpi 派生自回调接口类的实例
    * @return 无
    */
	virtual void RegisterSpi(XIndicatorSpi *pSpi) = 0;
	/**
    * @brief 注册行情回调接口
    * @param[in] pProvider 派生自行情回调接口类的实例
    * @return 无
    */
	virtual void RegisterQuoteProvider(XIndicatorQuoteProvider *pProvider) = 0;
	/**
    * @brief 注册交易回调接口
    * @param[in] pProvider 派生自交易回调接口类的实例
    * @return 无
    */
	virtual void RegisterTradeProvider(XIndicatorTradeProvider *pProvider) = 0;

	/**
    * @brief 处理接口，需要接口使用者不停调用，这样指标系统方能正常工作
    * @return 无
    */
	virtual void Handle() = 0;

	/**
    * @brief 更新历史数据接口，
	*
	* 如果接口使用者自己提供行情数据，即RegisterQuoteProvider了，就需要每次历史数据变化时调用此接口
    * @return 无
    */
	virtual void UpdateHisData(const char* symbol) = 0;

	/**
    * @brief 更新财务数据接口，
	*
	* 如果接口使用者自己提供行情数据，即RegisterQuoteProvider了，就需要每次财务数据变化时调用此接口
    * @return 无
    */
	virtual void UpdateFinanceData(const char* symbol) = 0;

	/**
    * @brief 更新实时快照数据接口，
	*
	* 如果接口使用者自己提供行情数据，即RegisterQuoteProvider了，就需要每次实时快照数据变化时调用此接口
    * @return 无
    */
	virtual void UpdateFieldData(const char* symbol) = 0;

	/**
    * @brief 更新交易数据接口，
	*
	* 如果接口使用者自己提供交易接口和数据，即RegisterTradeProvider了，就需要每次交易数据变化时调用此接口
    * @return 无
    */
	virtual void UpdateOrderData() = 0;

protected:
	virtual ~XIndicatorApi() {};
};
```

更多细节请参考示例项目。
