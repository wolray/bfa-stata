clear
// set more off ò��ֻ�ڴ������������
cd d:\sync\stata\homework

//1-1
forvalues i=2011/2013 { //���ڴ��������ֵ��ļ�������forvalues
insheet using `i'.csv,clear
drop v13
rename (v*) (code name date high low close vol change turnover value pe pb)
gen year=`i' //��ݰ����ָ�ʽ����
save `i',replace
}
append using 2011 2012
sort date //append֮����2013-2011-2012��˳�򣬿���sortһ��
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
bysort year (date): egen mvalue=mean(value) //��date�������򵫲��������
gen ifvalue=(value>mvalue) //��������1������������0
label define ifvalue 0 "smaller" 1 "bigger"
label values ifvalue ifvalue //�����ǩ���ͱ�����һ�£��ü�
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

rename (prc*) (prc1 prc2 prc3 prc4)			//����������
gen year=year(date)
gen month=month(date)
gen ym=ym(year,month)					//�����·ݱ�־ ym
bysort ym (date): gen num=ym if _n==_N			//���ÿһ���µ׵������ num
//ym����������������������·ݴ��룬�������ڴ���һЩ���������

forvalues i=1/4 {
sort date
gen return`i'=prc`i'[_n]/prc`i'[_n-1]-1			//1������������������������ return
sort num                                        	//2����ÿ���µ��µ������ŵ���ǰ����������
gen end`i'=prc`i'[_n]/prc`i'[_n-1] if num!=.		//3�����µ����������������� end
bysort ym (date): egen m_return`i'=sum(end`i')		//4��������� m_return
replace m_return`i'=. if ym==ym[1]			//ȱʧֵ��Ӻ���Ϊ0��������Ҫ��0�滻Ϊȱʧֵ
//������xxx[#]����ʾ��#�й۲�ֵ
}

keep date prc* *return*					//ɾ����ʱ����
save 2-1, replace

//2-2
use dprc, clear

rename (prc*) (prc1 prc2 prc3 prc4)
gen year=year(date)
gen month=month(date)
gen ym=ym(year,month)
bysort ym (date): gen num=ym if _n==_N

reshape long prc, i(date) j(id)				//wide��תΪlong��
sort id date
bysort id (date): gen return=prc[_n]/prc[_n-1]
bysort id (num): gen end=prc[_n]/prc[_n-1] if num!=.
bysort id ym (date): egen m_return=sum(end)
replace m_return=. if ym=ym[1]				//��0�滻Ϊȱʧֵ
order id date
keep id date prc return					//ɾ����ʱ����
save 2-2, replace
