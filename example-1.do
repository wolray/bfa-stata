//习题一参考代码（来自：王晨竹）

cd C:\Users\Delia\Desktop\STATA\Homework1\homework
set more off

//1)
forvalues i=2011/2013{
insheet using `i'.csv, clear
rename (v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12) (stockid stockname date highest lowest close volume pricechange turnover marketvalue PE PB)
drop v13
gen year=`i'
save `i'.dta, replace //对dta文件的操作不用加后缀名
}
append using 2011 2012 2013
//需要注意，之前导入文件后内存里已经包含了2013的数据，这里append重复了
save data1.dta, replace

//2)
import excel ipodate.xls, clear firstrow //指定了excel后不用再跟后缀名
rename (A B) (stockid  ipodate)
gen market=substr(stockid, -2, 2)
keep if market=="SH"
save data2.dta, replace

//3)
use data1.dta, clear
merge m:1 stockid using data2.dta
drop if _merge==2 //这里应该是 _merge!=3

//4)
encode stockid, gen(id)
bysort year: egen meanmv=mean(marketvalue)
//这里建议用 bysort year (date)，安全起见有必要对date做一下排序
gen size="big" if marketvalue>meanmv
replace size="small" if marketvalue<meanmv
bysort year: egen meanpe=mean(PE)
gen _pe="high" if PE>meanpe
replace _pe="low" if PE<meanpe

//5)
bysort year: tabstat PE ,by(size) stat(mean semean max min sd)
bysort year: tabstat marketvalue ,by(_pe) stat(mean semean max min sd)
bysort year: tabulate _pe size

//6)
keep date year marketvalue id
bysort year id: egen _mv=mean(marketvalue)
duplicates report _mv
duplicates drop _mv, force

//7)
keep _mv year id
reshape wide _mv, i(id) j(year)
ttest _mv2013==_mv2011


//习题二参考代码（来自：林正衡）
//2-1
use dprc.dta,clear
gen month=month(date)
gen year=year(date)

foreach i of numlist 0 4/6{
gen dyield60000`i'=prc60000`i'[_n]/prc60000`i'[_n-1]-1
bysort year month: gen temp60000`i'=exp(sum(ln(dyield60000`i'+1)))-1
//stata里没有连乘函数，这里用对数相加的方式来替代是个好办法
bysort year month: gen myield60000`i'=temp60000`i' if _n==_N
drop temp60000`i'
//这两行直接用 bysort year month: replace temp60000`i'=. if _n!=_N就好
//这里有一个bug是，此方法会保留第一个月的月收益率
//也就是第一个月月底相对月初的收益率，这是一个错误的数据，需要想办法清除掉
//gen ym=ym(year,month)
//sort ym
//replace myield60000`i'=. if ym==ym[1]
}

drop month year
save dprc_1.dta,replace

//2-2
use dprc.dta,clear
reshape long prc, i(date) j(code)
gen month=month(date)
gen year=year(date)
sort code date
bysort code: gen dyield=prc[_n]/prc[_n-1]-1
bysort code year month: gen temp=exp(sum(ln(dyield+1)))-1
bysort code year month: gen myield=temp if _n==_N
sort code date
drop temp month year
save dprc_2.dta,replace
