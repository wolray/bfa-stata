//dofile׼��
cd X:\XXX\XXX					//��д��ĳ���·��
set more off
//ѡ���ض�һ�л���д��룬Ctrl+D ���ֻ������ѡ�в���
//����ÿ�����ӷ֡���ʾ����׼�����͡��������������֣�����׼���Ĵ������м��ɣ�����ϸ��



//��һ���ַ�������1
clear
set obs 1						//�趨1�й۲�ֵ
gen date_str="2015-4-27"		//�ַ�������1

//����Ϊ��ʾ����׼��������Ϊ����
gen date=date(date_str,"YMD")	//ת��������������
format %td date 				//��ʾΪ���������ո�ʽ
gen year=year(date)				//������ָ��
gen month=month(date)			//���ɵ�����ָ�꣬1-12
gen ym=ym(year, month)			//�����ܵ���ָ�꣬�ɿ��������ָ��



//�������ַ�������2
clear
set obs 1		
gen date_str="20150427"			//�ַ�������2

//����Ϊ��ʾ����׼��������Ϊ����
gen year=substr(date,1,4)		//��ȡ���, ����date���Դ���date_str
gen month=substr(date,5,2)		//��ȡ�·ݣ�2��ʾ�ַ�������Ϊ2
gen day=substr(date,-2,2)		//��ȡ������-2��ʾ�����ڶ����ַ�
foreach i in year month day {	//ѭ�������ַ�ת������
destring `i', replace
}



//�������������
clear
set obs 730
gen date_str="2014-1-1"
gen date=date(date_str,"YMD")
replace date=date[_n]+_n-1		//���ɼ��Ϊ1�죬2014-2015�������������
format %td date
gen year=year(date)
gen month=month(date)
gen ym=ym(year, month)
drop *str year month			//ɾ����ʱ����
forvalues i=1/3 {
gen price`i'=rnormal(`i'+6,2)	//���ɷ���(i+6,2)��̬�ֲ����������price
}
reshape long price, i(ym date) j(id)
								//wideת��Ϊlong, �����±���id
sort id date					//�۲�ֵ����
order id date ym				//������������		

//����Ϊ��ʾ����׼��������Ϊ����
bysort id (date): gen daily_return=price[_n]/price[_n-1]-1
								//���������date��()��ʾֻ�������򣬲��������
bysort id ym (date): gen end=ym if _n==_N
								//ͨ��һ����ʱ��������µ�end
bysort id (end): gen month_return=price[_n]/price[_n-1]-1 if end!=.
								//��������������������ʣ�bysort���µ���������ǰ
drop end
sort id (date)



//���ദ���Ӧlong��ʽ��ѭ�������Ӧwide��ʽ�������ѡ��Ϳ�������ʽ�͸���ϲ����
//�������֣���merge, regress��statsby�Ļ����÷�������յ��ݵ����ݴ����佲��
//����Ȥ�Ļ������˽�һ��egenָ�generate�ļ�ǿ�棬�ô��ܶ�
//�������鿴help�ĵ����󲿷ֶ��ɽ��
	//������˾��ϰٶ�



//����һЩ���ݴ�����
	//rename (*) (name1 name2 name3 name4 name5 ...) ����ʵ����������������
	//��Stata��װĿ¼�·���һ�� profile.do��stata������ʱ���Զ�����
		//�˾ٿ����ÿ������ʱ�ظ�������cd/set more off/�ȳ���ָ��
	//ѭ����������Ա�����Ҳ����Թ۲�ֵʹ�ã����磺
clear
set obs 18
gen v1=_n
tostring v1, gen(v2)
forvalues i=1/`=_N' {			//`=_N'�൱��ѭ���е�һ��������������ﲻ��ֱ��ʹ��_N
replace v2="obs`i'" in `i'
}
gen v3="this is an example"
gen v4=substr(v3,1,_n)
gen v5=substr(v4,_n,1)
forvalues i=1/`=_N' {
replace v3="`=v4[`i']' | `=v5[`i']'" in `i'
								//ͬ������v2����v3��ʱ��Ҫʹ�þ������`=v2[`i']'
}
//���˽�Ĺ۲�ֵѭ�������ڴ����漰�ַ�ת�������⣬���ַ�����һ����_n�Ϳ���
//����һ��Ӧ���ǿɽ�һ�������Ĺ۲�ֵ��Ϊ��ǩ������һ���������������ӱ�ǩ
	//��ش����help label
//Ҳ��ʵ�ֶ���ַ��ͱ����ĺϲ�



//����
//by WEN_Lei, BFA Stata Training Promgram
