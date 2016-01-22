//dofile准备
cd X:\XXX\XXX					//填写你的常用路径
set more off
//选中特定一行或多行代码，Ctrl+D 便可只运行所选中部分
//下面每个例子分“演示数据准备”和“操作”两个部分，数据准备的代码运行即可，不必细究



//例一，字符型日期1
clear
set obs 1						//设定1行观测值
gen date_str="2015-4-27"		//字符型日期1

//以上为演示数据准备，以下为操作
gen date=date(date_str,"YMD")	//转换成数字型日期
format %td date 				//显示为常见年月日格式
gen year=year(date)				//生成年指标
gen month=month(date)			//生成当年月指标，1-12
gen ym=ym(year, month)			//生成总的月指标，可跨年的连续指标



//例二，字符型日期2
clear
set obs 1		
gen date_str="20150427"			//字符型日期2

//以上为演示数据准备，以下为操作
gen year=substr(date,1,4)		//提取年份, 这里date可以代表date_str
gen month=substr(date,5,2)		//提取月份，2表示字符串长度为2
gen day=substr(date,-2,2)		//提取天数，-2表示倒数第二个字符
foreach i in year month day {	//循环，将字符转成数字
destring `i', replace
}



//例三，分类操作
clear
set obs 730
gen date_str="2014-1-1"
gen date=date(date_str,"YMD")
replace date=date[_n]+_n-1		//生成间隔为1天，2014-2015两年的日期数据
format %td date
gen year=year(date)
gen month=month(date)
gen ym=ym(year, month)
drop *str year month			//删除临时变量
forvalues i=1/3 {
gen price`i'=rnormal(`i'+6,2)	//生成服从(i+6,2)正态分布的随机变量price
}
reshape long price, i(ym date) j(id)
								//wide转换为long, 生成新变量id
sort id date					//观测值排序
order id date ym				//变量左右排序		

//以上为演示数据准备，以下为操作
bysort id (date): gen daily_return=price[_n]/price[_n-1]-1
								//分组操作，date的()表示只参与排序，不参与分组
bysort id ym (date): gen end=ym if _n==_N
								//通过一个临时变量标记月底end
bysort id (end): gen month_return=price[_n]/price[_n-1]-1 if end!=.
								//分组操作，生成月收益率，bysort将月底排在了最前
drop end
sort id (date)



//分类处理对应long格式，循环处理对应wide格式，具体的选择就看数据形式和个人喜好了
//其他部分，如merge, regress及statsby的基本用法，请参照导演的数据处理补充讲义
//有兴趣的话，可了解一下egen指令，generate的加强版，用处很多
//有问题多查看help文档，大部分都可解决
	//解决不了就上百度



//另附上一些数据处理技巧
	//rename (*) (name1 name2 name3 name4 name5 ...) 可以实现批量重命名变量
	//在Stata安装目录下放置一个 profile.do，stata在启动时会自动运行
		//此举可免除每次启动时重复输入如cd/set more off/等常用指令
	//循环不仅仅针对变量，也可针对观测值使用，例如：
clear
set obs 18
gen v1=_n
tostring v1, gen(v2)
forvalues i=1/`=_N' {			//`=_N'相当于循环中的一个局域变量，这里不能直接使用_N
replace v2="obs`i'" in `i'
}
gen v3="this is an example"
gen v4=substr(v3,1,_n)
gen v5=substr(v4,_n,1)
forvalues i=1/`=_N' {
replace v3="`=v4[`i']' | `=v5[`i']'" in `i'
								//同理，引用v2（及v3）时需要使用局域变量`=v2[`i']'
}
//我了解的观测值循环多用于处理涉及字符转换的问题，非字符问题一般用_n就可以
//它的一个应用是可将一个变量的观测值作为标签贴给另一个变量，即批量加标签
	//相关代码见help label
//也可实现多个字符型变量的合并



//以上
//by WEN_Lei, BFA Stata Training Promgram
