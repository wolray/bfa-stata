//ϰ��һ�ο����루���ԣ�������

cd C:\Users\Delia\Desktop\STATA\Homework1\homework
set more off

//1)
forvalues i=2011/2013{
insheet using `i'.csv, clear
rename (v1 v2 v3 v4 v5 v6 v7 v8 v9 v10 v11 v12) (stockid stockname date highest lowest close volume pricechange turnover marketvalue PE PB)
drop v13
gen year=`i'
save `i'.dta, replace //��dta�ļ��Ĳ������üӺ�׺��
}
append using 2011 2012 2013
//��Ҫע�⣬֮ǰ�����ļ����ڴ����Ѿ�������2013�����ݣ�����append�ظ���
save data1.dta, replace

//2)
import excel ipodate.xls, clear firstrow //ָ����excel�����ٸ���׺��
rename (A B) (stockid  ipodate)
gen market=substr(stockid, -2, 2)
keep if market=="SH"
save data2.dta, replace

//3)
use data1.dta, clear
merge m:1 stockid using data2.dta
drop if _merge==2 //����Ӧ���� _merge!=3

//4)
encode stockid, gen(id)
bysort year: egen meanmv=mean(marketvalue)
//���ｨ���� bysort year (date)����ȫ����б�Ҫ��date��һ������
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


//ϰ����ο����루���ԣ������⣩
//2-1
use dprc.dta,clear
gen month=month(date)
gen year=year(date)

foreach i of numlist 0 4/6{
gen dyield60000`i'=prc60000`i'[_n]/prc60000`i'[_n-1]-1
bysort year month: gen temp60000`i'=exp(sum(ln(dyield60000`i'+1)))-1
//stata��û�����˺����������ö�����ӵķ�ʽ������Ǹ��ð취
bysort year month: gen myield60000`i'=temp60000`i' if _n==_N
drop temp60000`i'
//������ֱ���� bysort year month: replace temp60000`i'=. if _n!=_N�ͺ�
//������һ��bug�ǣ��˷����ᱣ����һ���µ���������
//Ҳ���ǵ�һ�����µ�����³��������ʣ�����һ����������ݣ���Ҫ��취�����
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
