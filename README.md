# �������

## �˵���

* File �ļ�����

* Edit �ı�����+�������

* Data ���ݲ���

* Graphics ͼ�����

* Statistics ͳ�Ʒ���

* User ��֪�������õ�

* Window �����л�(Ctrl-1/2/3/4/5�л�������)

* Help û��

## ������

* Viewer �����ĵ�(��Ҫ)����ݼ�F1

* Do-file Editor Do�ļ��༭��(��Ҫ)

* Data Editor ��дģʽ/ֻ��ģʽ(��Ҫ)

* Variables Manager ����������

## ����

| ����           | ����                           |
|----------------|--------------------------------|
| Review window  | ��ʾ������ʷ��¼�������ظ����� |
| Results window | �������н��                   |
| Command window | �������봰��(���޵��м�����) |
| Variables      | �ڴ��б�������                 |
| Properties     | ѡ��ĳ������������������     |

## �Ƽ�����

### ��ɫ����

�����ÿ�������ʾ���ĵ�����(Ĭ�����������Ļ���ʾ����)

	RightClick->Preferences->Result Colors->Color Scheme

### ��������

| window | Style       | Size | Device |
|------------------|-------------|------|--------|
| Review Window    | Courier New |    9 | laptop |
| Results Window   | Courier New |   11 | laptop |
| Command Window   | Courier New |   11 | laptop |
| Variables Window | Courier New |    9 | laptop |

### ��ʼ������

### ������������

Ĭ�Ϲ���·������

	cd d:/my-stata-directory

### ���÷�ʽ

�ڰ�װ·����(ͨ��ΪC:/Program Files/Stata13/)����һ��do�ļ�

	Profiles.do

�ļ���д���������������Stataʱ����Զ����г�ʼ���ű�

## ��ݼ�

### ������ȫ�ֿ�ݼ�

���ļ�(open-file)

	Ctrl-0

�򿪰����ĵ�

	F1
	help
	h

��������

	F2
	describle
	d

����

	F7
	save

����.dta�ļ�

	F8
	use

### do�ļ��༭���ڿ�ݼ�

���д���(��ѡ�в��ִ���������ѡ�в���)

	Ctrl-r

ѡ�е�ǰ��

	Ctrl-l

������ת��

	Ctrl-g

����/����/����/ճ��

	Ctrl-s/x/c/v

# ���ݴ���
## 1 �����﷨����������

### �����﷨

### �����ʽ

	[prefix] command [varlist] [=exp] [if exp] [in range] [,options]

* [xxx]������б�����ݱ�ʾ��������������ʡ��
* [,options]�����options�Ǵ�ָ����ͬ��options���Ե��ӣ���"command ,option1 option2"��options֮�䲻�ö��ŷָ�
* ����Ӵֱ�ʾ�������µ��»��߱�ʾ���Լ�д
* ��ɫ���ֱ�ʾ�˴��г�����

### ע��

β��ע��

	//your-comment-here

����ע��

	/#your-comment-here#/

### ��������

#### ��������

ָ����ǰ����·��

	cd

��ʾ�������ֱ�Ӹ���ѧ����

	display [exp]

��������

	describe [varname1 varname2]

�г������۲�ֵ

	list [varname1 varname2]

�г������ĳ���ͳ����

	summarize [varname1 varname2]

�г�������Ƶ�α�

	tabulate varlist

��ʾ��ǰĿ¼�µ��ļ�

	dir

����ڴ棬������ı���

	clear

�˳�stata

	exit

#### ϵͳ����

��������ڴ�/�ر�more

    set more off/on

�趨�۲�ֵ����

    set obs [number]

�趨��������(����)

    set maxvar [number]

#### ��Ҫϵͳ����

��ǰ�۲�ֵ������

	_n

�����������

	_N

��ѧ����

	_pi

#### �ع�ģ���������

���ģ�͹���֮��õ���ϵ��

	_b[varname]

���ģ�͹����ĳ���

	_cons (_b[_cons])

���ģ�͹����ı�׼���

	_se[varname]

## 2 �ļ�����

### �����ļ����ͽ���

| �����ļ����� | ����                         |
|--------------|------------------------------|
| .dta         | stata��׼�ļ����洢������Ϣ  |
| .cvs         | ���ŷָ����ļ������ڵ��뵼�� |
| .xls         | excel�ļ������ڵ��뵼��      |

### �ļ���������

#### .dta�ļ�

���� ([,clear] ��ʾ�������ݸ��ǵ�ǰ�ڴ�)

	use filename [,clear]
	use [varlist] [if] [in] using filename [,clear]

���� ([,replace] ��ʾ�������ݸ���ԭ�ļ�)

	save [filename] [,replace]

#### .csv�ļ�

����

	import delimited [using] filename [,options]
	import delimited [varlist] using filename [,options]
	[,varnames(#|nonames)]

����

	export delimited [using] filename [if] [in] [,options]
	export delimited [varlist] using filename [if] [in] [,options]

#### EXCEL�ļ�

�����﷨ͬcsvһ��

	import/export excel
	[,firstrow]

#### �Ϻõ�ʾ���ļ�

�����ļ�

	sysuse auto

���ݳ����ʽת��

	webuse reshape1
	webuse reshape2

## 3 ���ݼ�����

### ���ݼ��ϲ�

����ϲ�

	merge varlist using filename [,options]
	merge 1:1 varlist using filename [,options]
	merge m:1 varlist using filename [,options]

����ϲ�

	append using filename [filename] [,options]

### �����ʽת��

��ת�ɿ�

	reshape wide varname, i(i) j(j) [string]

��ת�ɳ�

	reshape long stub, i(i) j(j) [string]

### �ظ����ݴ���

�㱨�ظ�����

	duplicates report [varlist] [if] [in]

ɾ����ȫ��ͬ���ظ���

	duplicates drop [if] [in]

ɾ��ָ�������е��ظ���

	duplicates drop varlist [if] [in], force

## 4 �������۲�ֵ����

### ��������д


* var* ��var��ͷ�����б���

* *var ��var��β�����б���

* my*var ��my��ͷ��var��β�����б���

* my~var ��my��ͷ��var��β��һ������

* my?var ��my��ͷ��var��β���м�ֻ��һ���ַ������б���

* vara-varb ��vara��varb�Լ��м�����б��������������ҵ�˳��

### ��������

	order var1 var2

* ��var1 var2 �ֱ��ᵽ��һ�ڶ���λ�ã������������ο���

#### �۲�ֵ����

	sort varlist
	gsort [-|+]varname1 [-|+]varname2

### ɾ������

drop ɾ��ָ������

	drop varlist
	drop if exp
	drop in range

keep ����ָ������(��ɾ���������)����drop�﷨��ͬ

### �����±���

��������

	generate [type] newvar =exp [if] [in]

ǿ������

	egen [type] newvar =function(arguments) [if] [in]

����egen����

	egen newvar=sum(varname)
	egen newvar=group(varname)

### ����������

	rename oldname newname
	rename (oldname1 oldname2) (newname1 newname2)

### ��ʽת��(����ת�ַ�)

	destring varlist [,generate|replace]

### ��ʽת��(�ַ�ת����)

	tostring varlist [,generate|replace]

### �������ַ����ַ�����ת��

	encode varname [if] [in] , generate(newvar) [label(name) noextend]
	decode varname [if] [in] , generate(newvar) [maxlength(#)]

### ȱʧֵת��

	mvencode varlist [if] [in], mv(#|mvc=# [\ mvc=#...] [\ else=#]) [override]
	mvdecode varlist [if] [in], mv(numlist | numlist=mvc [\ numlist=mvc...])

### ����������ת��������

	recode(var, value1, value2, ��,)
	recode(var, value1, value2, ��,)

### �ӱ�ǩ

�����ӱ�ǩ

	label variable varname ["label"]

�۲�ֵ�ӱ�ǩ

	lable define labelname #1 "label1" #2 "label2" ...
	label values varlist labelname

�鿴��ǰ����ı�ǩ

	label list

���ƣ�ɾ���������Ѷ���ı�ǩ

	label copy/drop labelanme
	label save

## 5 ʱ���ʽ����

### ��غ���

������ȡ

	date(varname,"YMD")

���¼�����ȡ

	year(date)
	month(date)
	quarter(date)
	week(date)

��ʾ��ʽת��

	format date %td
	format date %tdCCYY/NN/DD
	format date %tdDD-YY-CCYY

### ����1

2016-01-01

2016-1-1

01Jan2016

1Jan2016

2016��1��1��

	1)
	gen newvar=date(varname,"YMD")
	gen yearid=year(newvar)

	2)
	substr()
	destring
	if

### ����2

20160101

	1)
	gen year=substr(varname,1,4)
	destring yearid=yearid,replace

	2)
	destring varname,replace
	gen year=int(varname/10000)

## 6 ѭ�����

### forvalues

��������

	forvalues i=1/10 {          //1,2,3...,10

�Ȳ�����

	forvalues i=1(2)10 {   //1,3,5,7,9

### foreach

foreach in

	foreach i in var1 var2 var3 {

foreach of varlist

	foreach i of varlist var1 var2 var3
	foreach i of varlist var1-var3
	foreach i of varlist v*

foreach of newlist

	foreach i of newlist new1 new2 new3 {
		gen `i'=exp
	}

foreach of numlist

	foreach i of numlist 1/4 5(3)11 22 {

## 7 ���ദ��&ѭ������
### ���ദ����Ӧlong��ʽ������

	bysort varname1 [(varname2)]: exp

### ѭ��������Ӧwide��ʽ������

	foreach varlist { exp }

# �κ�ϰ��һ

There are three CSV files, namely 2011, 2012 and 2013, containing all A-share stocks in Shanghai Stock Exchange. Each file gives stock id, stock name, date, highest price, lowest price, close price, trading volume, price change, turnover, market value, PE ratio and PB ratio in daily frequency.

Another excel file is IPODATE, containing stock id and the IPO date for each stock in Shanghai Stock Exchange and Shenzhen Stock Exchange.

## 1)

Please import the three CSV files to STATA data files, rename all variables to appropriate names and combine them to one dataset with marking the source of resulting observations.

	HINTS: foreach/forvalues, insheet, rename, append

## 2)

Please import the IPODATE excel file to STATA data file with renaming appropriate variable names and deleting the stocks of Shenzhen Stock Exchange.

	HINTS: import excel, substr

## 3)

Please merge the two STATA data files and only keep matched observations.

	HINTS: merge

## 4)

Please turning variable of stock id into an ordinal variable beginning with 1. And please generate a new variable with values of big or small representing bigger or smaller than the average of market value of all stocks year by year. Similarly, please generate a new variable with values of high or low representing higher or lower than the average of PE ratio of all stocks year by year. You may have more than one way to achieve this data processing.

	HINTS: encode, by, egen, mean, autocode

## 5)

Please use the dataset obtained from 4) to make a table showing the summary statistics (including mean and standard error) of PE ratio by categorical variable of market value in each year. And please make another table of frequencies about categorical variables of market value and PE ratio within three years. Do you see some patterns about the two variables of market value and PE ratio?

	HINTS: tabstat, tabulate

## 6)

Please use the dataset obtained from 4) and keep the variables of date, year (marks of the source of resulting observations in 1)), market value and the ordinal variable of stock id. Please change this dataset with daily frequency to a yearly dataset by taking the average of market value year by year for each stock. (Hints: by, egen, mean, duplicates drop)

	HINTS: by, egen, mean, duplicates, drop

## 7)

Please use the dataset obtained from 6) and reshape it into a wide form with the three new variables of market value specified by year. Please compare the market values of each stock in 2013 and them in 2011 and see whether there is a significantly increasing pattern of market value in A-share stocks of Shanghai Stock Exchange from 2011 to 2013. (Hints: reshape, ttest)

	HINTS: reshape, ttest

# �κ�ϰ���

## 1)

ʹ�� dprc ���ݣ� ��ʹ���κκϲ����ݼ��������� dprc �����������������ʣ��ĸ����������������ʣ� ʹ�ñ���ĩ���һ�����̼۳�������ĩ���һ�����̼ۣ� �ĸ���������������������Ҫ���ڱ�������ֵ��һ����

## 2)

�� dprc ����ת���� long ��ʽ������ 1���� ��ʱ��������Ϊһ����������������Ϊһ����
����

	HINTS: forvalues / foreach, bysort, _n / _N, _n==_N, sort, gen, sum()
