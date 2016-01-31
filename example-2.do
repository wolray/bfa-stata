clear
// set more off 貌似只在窗口输入才有用
cd d:\sync\stata\homework

//1-1
forvalues i=2011/2013 { //对于带规律数字的文件建议用forvalues
insheet using `i'.csv,clear
drop v13
rename (v*) (code name date high low close vol change turnover value pe pb)
gen year=`i' //年份按数字格式生成
save `i',replace
}
append using 2011 2012
sort date //append之后是2013-2011-2012的顺序，可以sort一下
save s1, replace

//1-2
import excel ipodate, firstrow clear
rename (*) (code date)
drop if substr(code,-2,2)=="SZ"
save s2, replace

//1-3
use s1, clear
merge m:1 code using s2
drop if _merge!=3
drop _merge
save s3, replace

//1-4
use s3,clear
encode code,gen(code2)
bysort year (date): egen mvalue=mean(value) //对date进行排序但不参与分组
gen ifvalue=(value>mvalue) //成立返回1，不成立返回0
label define ifvalue 0 "smaller" 1 "bigger"
label values ifvalue ifvalue //建议标签名和变量名一致，好记
bysort year (date): egen mpe=mean(pe)
gen ifpe=(pe>mpe)
label define ifpe 0 "lower" 1 "higher"
label values ifpe ifpe
save s4, replace

//1-5
use s4, clear
bysort year (date): tabstat pe, stat(mean semean)
tabulate ifvalue ifpe

//1-6
use s4, clear
bysort code2 year: egen yvalue=mean(value)
duplicates drop yvalue,force
keep code2 year yvalue
save s6, replace

//1-7
use s6, clear
reshape wide yvalue, i(code2) j(year)
ttest yvalue2013==yvalue2011
save s7, replace


//2-1
use dprc, clear

rename (prc*) (prc1 prc2 prc3 prc4)			//变量重命名
gen year=year(date)
gen month=month(date)
gen ym=ym(year,month)					//生成月份标志 ym
bysort ym (date): gen num=ym if _n==_N			//标记每一个月底的总序号 num
//ym这个函数可以生成连续的月份代码，这样便于处理一些跨年的数据

forvalues i=1/4 {
sort date
gen return`i'=prc`i'[_n]/prc`i'[_n-1]-1			//1、按日期排序生成日收益率 return
sort num                                        	//2、把每个月的月底依次排到最前，便于运算
gen end`i'=prc`i'[_n]/prc`i'[_n-1] if num!=.		//3、按月底排序生成月收益率 end
bysort ym (date): egen m_return`i'=sum(end`i')		//4、按月填充 m_return
replace m_return`i'=. if ym==ym[1]			//缺失值相加后会变为0，这里需要将0替换为缺失值
//可以用xxx[#]来表示第#行观测值
}

keep date prc* *return*					//删除临时变量
save 2-1, replace

//2-2
use dprc, clear

rename (prc*) (prc1 prc2 prc3 prc4)
gen year=year(date)
gen month=month(date)
gen ym=ym(year,month)
bysort ym (date): gen num=ym if _n==_N

reshape long prc, i(date) j(id)				//wide型转为long型
sort id date
bysort id (date): gen return=prc[_n]/prc[_n-1]
bysort id (num): gen end=prc[_n]/prc[_n-1] if num!=.
bysort id ym (date): egen m_return=sum(end)
replace m_return=. if ym=ym[1]				//将0替换为缺失值
order id date
keep id date prc return					//删除临时变量
save 2-2, replace
