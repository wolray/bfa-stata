# 软件界面

## 菜单栏

* File 文件操作

* Edit 文本操作+软件设置

* Data 数据操作

* Graphics 图表操作

* Statistics 统计分析

* User 不知道干嘛用的

* Window 窗口切换(Ctrl-1/2/3/4/5切换各窗口)

* Help 没用

## 工具栏

* Viewer 帮助文档(重要)，快捷键F1

* Do-file Editor Do文件编辑器(重要)

* Data Editor 读写模式/只读模式(重要)

* Variables Manager 变量管理器

## 窗口

| 窗口           | 功能                           |
|----------------|--------------------------------|
| Review window  | 显示命令历史记录，并可重复调用 |
| Results window | 命令运行结果                   |
| Command window | 命令输入窗口(仅限单行简单命令) |
| Variables      | 内存中变量概览                 |
| Properties     | 选中某具体变量后的性质描述     |

## 推荐设置

### 颜色主题

需设置可正常显示中文的主题(默认主题下中文会显示乱码)

	RightClick->Preferences->Result Colors->Color Scheme

### 字体设置

| window | Style       | Size | Device |
|------------------|-------------|------|--------|
| Review Window    | Courier New |    9 | laptop |
| Results Window   | Courier New |   11 | laptop |
| Command Window   | Courier New |   11 | laptop |
| Variables Window | Courier New |    9 | laptop |

### 初始化设置

### 建议设置内容

默认工作路径，如

	cd d:/my-stata-directory

### 设置方式

在安装路径内(通常为C:/Program Files/Stata13/)放置一个do文件

	Profiles.do

文件内写上相关命令，如此启动Stata时便可自动运行初始化脚本

## 快捷键

### 主窗口全局快捷键

打开文件(open-file)

	Ctrl-0

打开帮助文档

	F1
	help
	h

表述变量

	F2
	describle
	d

保存

	F7
	save

导入.dta文件

	F8
	use

### do文件编辑器内快捷键

运行代码(若选中部分代码则运行选中部分)

	Ctrl-r

选中当前行

	Ctrl-l

快速跳转行

	Ctrl-g

保存/剪切/复制/粘贴

	Ctrl-s/x/c/v

# 数据处理
## 1 基本语法及常用命令

### 基本语法

### 命令格式

	[prefix] command [varlist] [=exp] [if exp] [in range] [,options]

* [xxx]括号中斜体内容表示附加命令，可视情况省略
* [,options]这里的options是代指，不同的options可以叠加，如"command ,option1 option2"，options之间不用逗号分隔
* 命令加粗表示，命令下的下划线表示可以简写
* 蓝色文字表示此处有超链接

### 注释

尾部注释

	//your-comment-here

行内注释

	/#your-comment-here#/

### 常用命令

#### 窗口命令

指定当前工作路径

	cd

显示结果，可直接跟数学函数

	display [exp]

描述变量

	describe [varname1 varname2]

列出变量观测值

	list [varname1 varname2]

列出变量的常见统计量

	summarize [varname1 varname2]

列出变量的频次表

	tabulate varlist

显示当前目录下的文件

	dir

清除内存，即储存的变量

	clear

退出stata

	exit

#### 系统参数

在输出窗口打开/关闭more

    set more off/on

设定观测值行数

    set obs [number]

设定最大变量数(列数)

    set maxvar [number]

#### 重要系统变量

当前观测值所在行

	_n

变量最大行数

	_N

数学常数

	_pi

#### 回归模型输出变量

最近模型估算之后得到的系数

	_b[varname]

最近模型估算后的常数

	_cons (_b[_cons])

最近模型估算后的标准误差

	_se[varname]

## 2 文件操作

### 常用文件类型介绍

| 常用文件类型 | 描述                         |
|--------------|------------------------------|
| .dta         | stata标准文件，存储变量信息  |
| .cvs         | 逗号分隔符文件，用于导入导出 |
| .xls         | excel文件，用于导入导出      |

### 文件操作命令

#### .dta文件

导入 ([,clear] 表示导入内容覆盖当前内存)

	use filename [,clear]
	use [varlist] [if] [in] using filename [,clear]

导出 ([,replace] 表示保存内容覆盖原文件)

	save [filename] [,replace]

#### .csv文件

导入

	insheet using filename.csv [,options]
	outsheet using filename.csv [varlist] using filename [,options]

导出

	export delimited [using] filename [if] [in] [,options]
	export delimited [varlist] using filename [if] [in] [,options]

#### EXCEL文件

基本语法同csv一样

	import/export excel
	[,firstrow]

#### 较好的示例文件

常用文件

	sysuse auto

数据长宽格式转换

	webuse reshape1
	webuse reshape2

## 3 数据集处理

### 数据集合并

横向合并

	merge varlist using filename [,options]
	merge 1:1 varlist using filename [,options]
	merge m:1 varlist using filename [,options]

纵向合并

	append using filename [filename] [,options]

### 长宽格式转换

长转成宽

	reshape wide varname, i(i) j(j) [string]

宽转成长

	reshape long stub, i(i) j(j) [string]

### 重复数据处理

汇报重复数据

	duplicates report [varlist] [if] [in]

删除完全相同的重复行

	duplicates drop [if] [in]

删除指定变量中的重复行

	duplicates drop varlist [if] [in], force

## 4 变量及观测值处理

### 变量名缩写


* var* 以var开头的所有变量

* *var 以var结尾的所有变量

* my*var 以my开头以var结尾的所有变量

* my~var 以my开头以var结尾的一个变量

* my?var 以my开头以var结尾，中间只有一个字符的所有变量

* vara-varb 从vara到varb以及中间的所有变量，按从左往右的顺序

### 变量排序

	order var1 var2

* 将var1 var2 分别提到第一第二的位置，其他变量依次靠后

#### 观测值排序

	sort varlist
	gsort [-|+]varname1 [-|+]varname2

### 删除变量

drop 删除指定变量

	drop varlist
	drop if exp
	drop in range

keep 保留指定变量(即删除其余变量)，与drop语法相同

### 生成新变量

基本命令

	generate [type] newvar =exp [if] [in]

强化命令

	egen [type] newvar =function(arguments) [if] [in]

常用egen函数

	egen newvar=sum(varname)
	egen newvar=group(varname)

### 变量重命名

	rename oldname newname
	rename (oldname1 oldname2) (newname1 newname2)

### 格式转换(数字转字符)

	destring varlist [,generate|replace]

### 格式转换(字符转数字)

	tostring varlist [,generate|replace]

### 非数字字符的字符变量转换

	encode varname [if] [in] , generate(newvar) [label(name) noextend]
	decode varname [if] [in] , generate(newvar) [maxlength(#)]

### 缺失值转换

	mvencode varlist [if] [in], mv(#|mvc=# [\ mvc=#...] [\ else=#]) [override]
	mvdecode varlist [if] [in], mv(numlist | numlist=mvc [\ numlist=mvc...])

### 非连续变量转连续变量

	recode(var, value1, value2, …,)
	recode(var, value1, value2, …,)

### 加标签

变量加标签

	label variable varname ["label"]

观测值加标签

	lable define labelname #1 "label1" #2 "label2" ...
	label values varlist labelname

查看当前定义的标签

	label list

复制，删除，保存已定义的标签

	label copy/drop labelanme
	label save

## 5 时间格式处理

### 相关函数

日期提取

	date(varname,"YMD")

年月季周提取

	year(date)
	month(date)
	quarter(date)
	week(date)

显示格式转换

	format date %td
	format date %tdCCYY/NN/DD
	format date %tdDD-YY-CCYY

### 类型1

2016-01-01

2016-1-1

01Jan2016

1Jan2016

2016年1月1日

	1)
	gen newvar=date(varname,"YMD")
	gen yearid=year(newvar)

	2)
	substr()
	destring
	if

### 类型2

20160101

	1)
	gen year=substr(varname,1,4)
	destring yearid=yearid,replace

	2)
	destring varname,replace
	gen year=int(varname/10000)

## 6 循环语句

### forvalues

连续数列

	forvalues i=1/10 {          //1,2,3...,10

等差数列

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

## 7 分类处理&循环处理
### 分类处理，对应long格式的数据

	bysort varname1 [(varname2)]: exp

### 循环处理，对应wide格式的数据

	foreach varlist { exp }

# 课后习题一

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

	HINTS: encode, by, egen, mean

## 5)

Please use the dataset obtained from 4) to make a table showing the summary statistics (including mean and standard error) of PE ratio by categorical variable of market value in each year. And please make another table of frequencies about categorical variables of market value and PE ratio within three years. Do you see some patterns about the two variables of market value and PE ratio?

	HINTS: tabstat, tabulate

## 6)

Please use the dataset obtained from 4) and keep the variables of date, year (marks of the source of resulting observations in 1)), market value and the ordinal variable of stock id. Please change this dataset with daily frequency to a yearly dataset by taking the average of market value year by year for each stock.

	HINTS: by, egen, mean, duplicates, drop

## 7)

Please use the dataset obtained from 6) and reshape it into a wide form with the three new variables of market value specified by year. Please compare the market values of each stock in 2013 and them in 2011 and see whether there is a significantly increasing pattern of market value in A-share stocks of Shanghai Stock Exchange from 2011 to 2013.

	HINTS: reshape, ttest

# 课后习题二

## 1)

使用 dprc 数据， 不使用任何合并数据集方法，在 dprc 数据中生成日收益率（四个变量）、月收益率（ 使用本月末最后一天收盘价除以上月末最后一天收盘价， 四个变量），其中月收益率要求在本月内数值都一样。

## 2)

将 dprc 数据转换成 long 格式，重做 1）， 此时日收益率为一个变量，月收益率为一个变
量。

	HINTS: forvalues / foreach, bysort, _n / _N, _n==_N, sort, gen, sum()
