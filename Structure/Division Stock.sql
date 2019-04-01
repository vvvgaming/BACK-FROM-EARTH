

SELECT
 IFNULL(usx.salerType, '') AS '区域',
  GROUP_CONCAT(t.id) AS '订单编号',
   LEFT(t.serial_code, 32) AS '交易序列号',
  t.customer_id AS '客户编号',
  t.customer_name AS '客户姓名',
  AES_DECRYPT (UNHEX(tu.username),'CXSOKJTSQSAZCVGHGHVDSDCG') AS '手机号'
DATE_FORMAT(tu.create_time, '%Y-%m-%d %h:%i:%s') AS '注册时间'
  (SELECT tb.invest_time FROM jjjr2_product.tb_dealorder tb
WHERE (( tb.product_type = '100' AND tb.status IN ('100', '200')) OR(tb.product_type = '200' AND tb.status IN ('100', '200', '300')) OR(tb.product_type = '300' AND tb.status IN ('200', '400')))
AND tb.customer_id = t.customer_id ORDER BY tb.invest_time ASC LIMIT 1) AS '首投时间'
  t.invest_time AS '投资时间'
  r.saler_code AS '客户经理代码'
  CASE WHEN s.name

 = '000002' THEN '公司' WHEN s.name

 IN ( '000000' '000001') THEN '电销' ELSE s.name END AS '客户经理姓名'
  IFNULL(AES_DECRYPT (UNHEX(s.phone),'CXSOKJTSQSAZCVGHGHVDSDCG'),'') AS '客户经理手机'
IFNULL(usx.C_SalerType,'') AS 'C级代理人代码',
IFNULL(cusx.saler_name,'') AS 'C级代理人姓名',
IFNULL(usx.B_SalerType,'') AS 'B级代理人代码',
IFNULL(busx.saler_name,'') AS 'B级代理人姓名',
IFNULL(usx.A_SalerType,'') AS 'A级代理人代码',
IFNULL(busx.saler_name,'') AS 'A级代理人姓名',

 CASE s.status WHEN '10' THEN '在职' WHEN '20' THEN '离职' ELSE s.status END AS '客户经理状态',
  GROUP_CONCAT(t.product_name) AS '产品名称',
  GROUP_CONCAT(t.freeze_duration) AS '产品期限',
  GROUP_CONCAT(t.freeze_unit) AS '期限单位',
  ROUND(SUM(IFNULL(t.invest_cash, 0)),2) AS '现金投资金额'
  ROUND(SUM(IFNULL(t.invest_cash * t.freeze_duration / 12, 0)),2) AS '现金年化投资金额'
  ROUND(SUM(IFNULL(t.invest_coupon, 0)), 2) AS '投资券金额'
  ROUND(t.add_rate,2) AS '加息券'


 CASE WHEN t.status = '100' THEN '投资中'
 WHEN t.status = '200' THEN '满标'
 WHEN t.status = '300' THEN '赎回' END AS '订单状态',
 IFNULL(u.invest_code,'') AS '推广码',
 IFNULL(u.real_name,'') AS '推广人姓名',
 IFNULL(CONCAT(SUBSTRING(AES_DECRYPT(UNHEX(u.username),'CXSOKJTSQSAZCVGHGHVDSDCG'),1,4),'***',SUBSTRING(AES_DECRYPT(UNHEX(u.username),'CXSOKJTSQSAZCVGHGHVDSDCG'),-4,4)),'') AS '推广人手机号'
FROM
 jjjr2_sns.u_user tu JOIN jjjr2_product.tb_dealorder t ON tu.custom_id = t.customer_id
 LEFT JOIN jjjr2_sns.u_customer_relation r ON t.customer_id = r.custom_id AND t.invest_time >= r.begin_time AND t.invest_time < IFNULL(r.end_time,'9999-99-99')
 LEFT JOIN jjjr2_sns.u_saler s ON s.saler_code = r.saler_code
 LEFT JOIN jjjr2_sns.u_user u ON tu.introducer_id = u.custom_id
 LEFT JOIN jjjr2_sns.u_saler_extend usx ON r.saler_code = usx.saler_code
 LEFT JOIN jjjr2_sns.u_saler_extend cusx ON usx.C_SalerType = cusx.saler_code
 LEFT JOIN jjjr2_sns.u_saler_extend busx ON usx.B_SalerType = busx.saler_code
 LEFT JOIN jjjr2_sns.u_saler_extend ausx ON usx.A_SalerType = ausx.saler_code
WHERE
 t.create_time > '2019-03-07' AND t.create_time < '2019-03-16'
 AND t.invest_cash > 0
 AND t.product_type = '200'
 AND t.status IN ('100', '200','300')
 AND t.freeze_duration = '3'
 AND t.product_name IN ('金奖1号')
 GROUP BY LEFT(t.serial_code,32)
ORDER BY t.id ASC;


--兑付
t.id AS '订单编号',
 LEFT(t.serial_code,32) AS '交易序列号',
t.customer_id AS '客户编号',
t.customer_name AS '客户姓名',
AES_DECRYPT(UNHEX(tu.username),'CXSOKJTSQSAZCVGHGHVDSDCG') AS '手机号',
DATE_FORMAT(tu.create_time, '%Y-%m-%d %H-%s-%s') AS '注册时间',
 (SELECT tb.invest_time FROM jjjr2_product.tb_dealorder tb
WHERE (( tb.product_type = '100' AND tb.status IN('100','200')) OR(tb.product_type = '200' AND tb.status IN ('100', '200', '300')) OR( tb.product_type = '300' AND tb.status IN ('200','400')))
AND tb.customer_id = t.customer_id ORDER BY tb.invest_time ASC LIMIT 1) AS '首投时间',
 r.saler_code AS '客户经理代码',
CASE WHEN s.saler = '000002' THEN '公司' WHEN s.saler_code IN ('000000', '000001') THEN '电销' ELSE s.name END AS '客户经理姓名',
AES_DECRYPT (UNHEX(s.phone),'CXSOKJTSQSAZCVGHGHVDSDCG') AS '客户经理手机',
CASE s.status WHEN '10' THEN '在职' WHEN '20' THEN '离职' ELSE s.name END AS '客户经理状态',
t.product_name AS '产品名称',
t.freeze_duration AS '产品期限',
t.freeze_unit AS '期限单位',
ROUND(IFNULL(t.invest_cash,0),2) AS '现金投资金额',
ROUND(IFNULL(t.invest_cash * t.freeze_duration/12,0),2) AS '现金年化投资金额',
t.invest_time AS '投资时间',
ROUND(t.due_income,2) AS '到期利息',
ROUND((t.invest_amount + t.due_income),2) AS '到期总金额',
t.end_time AS '到期时间',
CASE WHEN t.status = '100' THEN '投资中'
WHEN t.status = '200' THEN '满标'
WHEN t.status = '300' THEN '赎回' END AS '订单状态',
u.invite_code AS '推广码',
u.real_name AS '推广人姓名',
CONCAT(SUBSTRING(AES_DECRYPT(UNHEX(u.username),'CXSOKJTSQSAZCVGHGHVDSDCG'),1,3),'****',SUBSTRING(AES_DECRYPT(UNHEX(u.username),'CXSOKJTSQSAZCVGHGHVDSDCG'),-4,4)) AS '推广人手机'
FROM
jjjr2_sns.u_user tu JOIN jjjr2_product tb.tb_dealorder t ON tu.custom_id = t.customer_id
LEFT JOIN jjjr2_sns.u_customer_relation r ON t.customer_id = r.custom_id
LEFT JOIN jjjr2_sns.u_saler s ON s.saler_code = r.saler_code
LEFT JOIN jjjr2_sns.u_user u ON tu.introducer_id = u.custom_id
WHERE
DATE_FORMAT(t.end_time,'%Y-%m') < '2019-03'
AND t.product_type = '200'
AND t.status IN ('100', '200', '300')
AND r.status = '1'
ORDER BY t.id ASC;

SELECT 
tca.member_id AS '客户编号',
AES_DECRYPT(UNHEX(u.username),'CXSOKJTSQSAZCVGHGHVDSDCG') AS '客户手机',
IFNULL(u.nickname,'') AS '客户昵称',
u.real_name AS '真实姓名',
tca.available_amount AS '账户余额',
FROM 
jjr2_finance.t_cash_account tca,
jjjr2_sns.u_user u 
WHERE tca.member_id = u.custom_id AND tca.available_amount > 1
ORDER BY tca.available_amount DESC;

SELECT
u.custom_id AS '客户编号',
IFNULL(u.real_name,'') AS '姓名',
AES_DECRYPT(UNHEX(u.username),'CXSOKJTSQSAZCVGHGHVDSDCG') AS '手机号',
CASE WHEN LENGTH(AES_DECRYPT(UNHEX(u.identity_card_number),'CXSOKJTSQSAZCVGHGHVDSDCG')) = 15 THEN DATE_FORMAT(SUBSTRING(AES_DECRYPT(UNHEX(u.identity_card_number),'CXSOKJTSQSAZCVGHGHVDSDCG'),7,6),'%y-%m-%d')
WHEN LENGTH(AES_DECRYPT(UNHEX(u.identity_card_number),'CXSOKJTSQSAZCVGHGHVDSDCG')) = 18 THEN DATE_FORMAT(SUBSTRING(AES_DECRYPT(UNHEX(u.identity_card_number),'CXSOKJTSQSAZCVGHGHVDSDCG'),7,8),'%y-%m-%d') ELSE '其他' END '生日',
CASE LENGTH(AES_DECRYPT(UNHEX(u.identity_card_number),'CXSOKJTSQSAZCVGHGHVDSDCG')) WHEN 15 THEN CASE MOD(RIGHT(AES_DECRYPT(UNHEX(u.identity_card_number),'CXSOKJTSQSAZCVGHGHVDSDCG'),1),2) WHEN 0 THEN '女' ELSE '男' END
CASE WHEN SUBSTRING(AES_DECRYPT(UNHEX(u.identity_card_number),'CXSOKJTSQSAZCVGHGHVDSDCG'),1,2) = SUBSTRING(uc.code,1,2) THEN uc.name ELSE '未知' END AS '地域',
DATE_FORMAT(u.create_time,'%y-%m-%d %h:%i:%s') AS '注册时间',
temp.time AS '首投时间',
temp.amt AS '定期持有存量',
ucr.saler_code AS '客户经理代码',
us.name AS '客户经理姓名',
AES_DECRYPT (UNHEX(us.phone),'CXSOKJTSQSAZCVGHGHVDSDCG') AS '客户经理手机',
FROM
jjjr2_sns.u_user u 
LEFT JOIN jjjr2_sns.u_province uc ON LEFT(uc.code,2) = LEFT(AES_DECRYPT(UNHEX(u.identity_card_number),'CXSOKJTSQSAZCVGHGHVDSDCG'),2)
LEFT JOIN jjjr2_sns.u_customer_relation ucr ON u.custom_id = ucr.custom_id AND ucr.status = '1'
LEFT JOIN jjjr2_sns.u_saler us ON ucr.saler_code = us.saler_code
LEFT JOIN
(SELECT tb.customer_id,MIN(tb.invest_time) AS 'time', ROUND(SUM(CASE WHEN tb.product_type = '200' AND tb.status IN('100','200')
THEN tb.invest_amount ELSE 0.00 END),2) AS 'amt'
FROM jjjr2_product.tb_dealorder tb_dealorder
WHERE
(tb.product_type = '200' AND tb.status IN ('100','200','300'))
OR (tb.product_type = '300' AND tb.status IN ('200','400'))
OR(tb.product_type = '100' AND tb.status = '200')
GROUP BY tb.customer_id) temp
ON u.custom_id = temp.customer_id
WHERE
u.status = '1' AND temp.amt > 0;



SELECT 
t.id AS '订单编号',
LEFT(t.serial_code,32) AS '交易序列号',
t.customer_id AS '客户编号',
t.customer_name AS '姓名',
AES_DECRYPT(UNHEX(tu.username),'CXSOKJTSQSAZCVGHGHVDSDCG') AS '手机号',
DATE_FORMAT(tu.create_time,'%Y-%m-%d %H:%i:%s') AS '注册时间',
(SELECT tb.invest_time FROM jjjr2_product.tb.dealorder tb_dealorder
WHERE (( tb.product_type = '100' AND tb.status IN ('100','200')) OR (tb.product_type = '200' AND tb.status IN ('100','200','300')) OR (tb.product_type = '300' AND tb.status IN ('200','400')))
AND tb.customer_id = t.customer_id ORDER BY tb.invest_time ASC LIMIT 1) AS '首投时间',
r.saler_code AS '客户经理代码',
CASE WHEN s.name = '000002' THEN '公司' WHEN s.name IN ('000000','000001') THEN '电销' ELSE s.name END AS '客户经理姓名',
AES_DECRYPT(UNHEX(s.phone),'CXSOKJTSQSAZCVGHGHVDSDCG') AS '客户经理手机',
CASE s.status WHEN '10' THEN '在职' WHEN '20' THEN '离职' ELSE s.status END AS '客户经理状态',
t.product_name AS '产品名称',
ROUND(t.product_rate,6) AS '产品利率',
t.freeze_duration AS '产品期限',
t.freeze_unit AS '期限单位',
ROUND(IFNULL(t.invest_cash,0),2) AS '现金投资金额',
ROUND(IFNULL(t.invest_cash * t.freeze_duration/12,0),2) AS '现金年化投资金额',
ROUND(IFNULL(t.invest_coupon,0),2) AS '投资券金额',
ROUND(t.add_rate,6) AS '加息券',
t.invest_time AS '投资时间',
t.begin_time AS '满标时间',
t.end_time AS '到期时间',
CASE WHEN t.status = '100' THEN '投资中' WHEN t.status = '200' THEN '满标' WHEN t.status = '300' THEN '赎回' END AS '订单状态',
IFNULL(u.invite_code,'') AS '推广码',
IFNULL(u.real_name,'') AS '推广人姓名',
IFNULL(CONCAT(SUBSTRING(AES_DECRYPT(UNHEX(u.username),'CXSOKJTSQSAZCVGHGHVDSDCG'),1,4),'***',SUBSTRING(AES_DECRYPT(UNHEX(u.username),'CXSOKJTSQSAZCVGHGHVDSDCG'),-4,4)),'') AS '推广人手机'
FROM
jjjr2_sns.u_user tu JOIN jjjr2_product.tb_dealorder t ON tu.custom_id = t.customer_id
LEFT JOIN jjjr2_sns.u_customer_relation r ON t.customer_id = r.custom_id AND t.invest_time >= r.begin_time AND t.invest_time < IFNULL(r.end_time,'9999-999-99')
LEFT JOIN jjjr2_sns.u_saler s ON s.saler_code = r.saler_code
LEFT JOIN jjjr2_sns.u_user u ON tu.introducer_id = u.custom_id
WHERE
DATE_FORMAT(t.invest_time,'%Y-%m-%d') >= '2019-03-22'
AND t.customer_id = '000463619'
AND t.invest_cash > 0
AND t.product_type = '200'
AND t.status IN ('100','200'.'300')
ORDER BY t.id ASC;



SELECT
t.invest_order_no AS '订单编号',
t.user_id AS '客户编号',
tu.real_name AS '客户姓名',
tu.mobile AS '手机号',
tu.create_time AS '注册时间',
(SELECT tb.create_time 
FROM 
jjdb.project_invest tb_dealorder
WHERE 
tb.status = '1' AND tb.user_id = t.user_id 
ORDER BY tb.create_time ASC LIMIT 1) AS '首投时间',
s.saler_code AS '客户经理代码',
CASE WHEN s.name = '000002' THEN '公司' WHEN s.name IN ('000000','000001') THEN '电销' ELSE  s.name END AS '客户经理姓名',
AES_DECRYPT(UNHEX(s.phone),'CXSOKJTSQSAZCVGHGHVDSDCG') AS '客户经理手机',
CASE s.status WHEN '10' THEN '在职' WHEN '20' THEN '离职' ELSE s.status END AS '客户经理状态',
pj.project_name AS '产品名称',
ROUND(pj.apr,6) AS '产品利率',
pj.time_limit AS '产品期限',
CASE WHEN pj.time_type = '0' THEN '月' ELSE '天' END AS '期限单位',
ROUND(IFNULL(t.amount,0),2) AS '现金投资金额',
CASE WHEN pj.time_type = 0 THEN ROUND(IFNULL(t.amount * pj.time_limit/12,0),2) ELSE ROUND(IFNULL(t.amount * pj.time_limit/360,0),2) AS '现金年化投资金额',
t.create_time AS '投资时间',
t.interest_date AS '起息日',
t.end_date AS '结束日'
FROM
jjdb.user tu JOIN jjdb.project_invest t ON tu.uuid = t.user_id
LEFT JOIN jjdb.u_customer_relation r ON r.u_mobile = tu.mobile AND r.status = '1'
LEFT JOIN jjdb.u_saler s ON s.saler_code = r.saler_code
LEFT JOIN jjdb.project pj ON pj.uuid = t.project_id
WHERE
DATE_FORMAT(t.create_time,'%Y-%m-%d') >= '2019-03-22'
AND t.status = '1'
ORDER BY invest_order_no ASC;


-- 提现明细
SELCET 
wc.customer_id AS '客户id',
wc.name AS '姓名',
AES_DECRYPT (UNHEX(cc.card_no),'CXSOKJTSQSAZCVGHGHVDSDCG') AS '卡号',
cc.bank_name AS '银行',
cc.brabank_name AS '支行',
wc.amount AS '提现金额',
CASE WHEN wc.channel = '1' THEN '连连'  WHEN wc.channel = '2' THEN '富友' ELSE wc.channel END AS '方式',
wc.create_time AS '提现时间'
FROM
sjzx.t_withdraw_cash wc, jjjr2_partner.t_customer_cards cc
WHERE
cc.customer_id = wc.customer_id
AND wc.create_time >= '2019-03-23 16:00:00';



-- 提现汇总
SELECT
SUM(tmp.提现金额),SUM(CASE WHEN tmp.方式 = '连连' THEN tmp.提现金额 ELSE 0 END) AS '连连',
SUM(CASE WHEN tmp.方式 = '富友' THEN tmp.提现金额 ELSE 0 END) AS '富友'
FROM
(SELECT wc.customer_id AS '客户id',wc.name AS '姓名',AES_DECRYPT(UNHEX(cc.card_no),'CXSOKJTSQSAZCVGHGHVDSDCG') AS '银行卡号',cc.bank_name AS '银行',
cc.brabank_name AS '支行',wc.amount AS '提现金额',CASE WHEN wc.channel = '1' THEN '连连' WHEN wc.channel = '2' THEN '富友' ELSE wc.channel END AS '方式',wc.create_time AS '提现时间'
FROM
sjzx.t_withdraw_cash wc ,jjjr2_partner.t_customer_cards cc
WHERE cc.customer_id = wc.customer_id AND wc.create_time >= '2019-03-25 19:00:00')


-- 注册客户
SELECT 
u.uuid AS 'id',
expa.city AS '城市',
u.real_name AS '姓名',
us.name AS '销售',
u.create_time AS '注册时间'
FROM
jjdb.user u
LEFT JOIN jjdb.u_customer_relation uc ON u.mobile = uc.u_mobile
LEFT JOIN jjdb.u_saler us ON us.saler_code = uc.saler_code AND uc.status = '1'
LEFT JOIN jjjr2_sns.u_saler_expand expa ON expa.saler_code = us.saler_code
WHERE u.create_time >= '2019-03-26'
GROUP BY u.uuid;



-- 有效客户

SELECT 
tmp.mobile, tmp.real_name,us.name AS '销售',expa.city,tmp.amt AS '投资额'
FROM
(SELECT tb.user_id AS 'sustomerID',u.real_name,SUM(tb.amount) AS 'amt',u.mobile
 FROM jjdb.user u,jjdb.project_invest tb
 WHERE tb.user_id = u.uuid
 AND tb.status = '1'
 AND tb.invest_date >= '20190327'
 GROUP BY tb.user_id HAVING SUM(tb.amount) >= 10000
 ) tmp
 LEFT JOIN jjdb.u_customer_relation uc ON uc.u_mobile = tmp.mobile
 LEFT JOIN jjdb.u_saler us ON us.saler_code = uc.saler_code AND us.status = '1'
 LEFT JOIN jjjr2_sns.u_saler_expand expa ON expa.saler_code = us.saler_code
 GROUP BY tmp.mobile;



-- 投资客户
SELECT
t.user_id,
u.real_name,
u.mobile,
us.name AS '销售',
expa.city,
SUM(IFNULL(t.amount,0)) AS 'amt',
CASE WHEN pj.time_type = 0 THEN SUM(IFNULL(t.amount,0)) * pj.time_limit/12 ELSE SUM(IFNULL(t.amount,0)) * pj.time_limit/360 END AS 'year_amt'
FROM
jjdb.project_invest t
LEFT JOIN jjdb.project pj ON pj.uuid = t.project_id
LEFT JOIN jjdb.user u ON t.user_id = u.uuid
LEFT JOIN jjdb.u_customer_relation uc ON uc.u_mobile = u.mobile
LEFT JOIN jjdb.u_saler us ON us.saler_code = uc.saler_code AND uc.status = '1'
LEFT JOIN jjjr2_sns u_saler_expand expa ON expa.saler_code = us.saler_code
WHERE t.status = '1'
AND t.invest_time >= '20190328'
GROUP BY t.user_id; 


-- 新平台投资明细
SELECT
 temp.invest_order_no AS '订单编号',
 temp.user_id AS '客户编号',
 temp.real_name AS '客户姓名',
 CONCAT(SUBSTRING(temp.mobile,1,4),'****',SUBSTRING(temp.mobile,-4,4)) AS '客户手机号',
 temp.zcsj AS '客户注册时间',
 (SELECT tb.create_time FROM jjdb.project_invest tb
 	WHERE tb.status = '1'
 	AND tb.user_id = temp.user_id ORDER BY tb.create_time ASC LIMIT 1) AS '首投时间',
 s.saler_code AS '客户经理代码',
 CASE WHEN s.name = '000002' THEN '公司' WHEN s.name IN ('000000','000001') THEN '电销' ELSE s.name END AS '客户经理姓名',
 AES_DECRYPT(UNHEX(s.phone),'CXSOKJTSQSAZCVGHGHVDSDCG') AS '客户经理手机',
 CASE s.status WHEN '10' THEN '在职' WHEN '20' THEN '离职' ELSE s.status END AS '客户经理状态',
 expa.city AS '直营城市',
 pj.project_name AS '产品名称',
 ROUND(pj.apr,6) AS '产品利率',
 pj.time_limit AS '产品期限',
 CASE WHEN pj.time_type = '0' THEN '月' ELSE '天' END AS '期限单位',
 CASE WHEN pj.repay_style = '1' THEN '等额本息' WHEN pj.repay_style = '2' THEN '一次性还本付息'
 WHEN pj/repay_style = '3' THEN '每月还息到期还本' WHEN pj.repay_style = '4' THEN '等额本金' ELSE '' END AS '还款方式',
 ROUND(IFNULL(temp.amount,0),2) AS '现金投资金额',
 CASE WHEN pj.time_type = 0 THEN ROUND(IFNULL(temp.amount * pj.time_limit/12,0),2) ELSE ROUND(IFNULL(temp.amount * pj.time_limit/360,0),2) END AS '现金年化投资金额',
 temp.create_time AS '投资时间',
 temp.interest_date AS '起息日',
 DATE_FORMAT(pc.repay_time,'%Y-%m-%d') AS '到期时间'
 FROM
 (SELECT tu.mobile,tu.real_name,tu.create_time AS zcsj,t.* FROM jjdb.user tu JOIN jjdb.project_invest t ON tu.uuid = t.user_id) temp
 LEFT JOIN jjdb.u_customer_relation r ON r.u_mobile = temp.mobile AND temp.invest_date >= r.begin_time AND temp.temp.invest_date < IFNULL(r.end_time,'9999-99-99')
 LEFT JOIN jjdb.u_saler s ON s.saler_code = r.saler_code
 LEFT JOIN jjdb.project pj ON pj.uuid = temp.project_id
 LEFT JOIN jjjr2_sns.u_saler_expand expa ON expa.saler_code = r.saler_code
 LEFT JOIN jjdb.project_collection pc ON pc.invest_id = temp.uuid
WHERE DATE_FORMAT(temp.create_time,'%Y-%m-%d') >= '2019-03-29'
AND temp.status = '1'
AND expa.city = '上海'
ORDER BY temp.invest_order_no ASC
LIMIT 100000;

-- 老平台投资明细
SELECT
 t.id AS '订单编号',
 LEFT(t.serial_code,32) AS '交易序列号',
 t.customer_id AS '客户编号',
 t.customer_name AS '客户姓名',
 expa.city AS '城市',
 CONCAT(SUBSTRING(AES_DECRYPT(UNHEX(tu.username),'CXSOKJTSQSAZCVGHGHVDSDCG'),1,4),'***',SUBSTRING(AES_DECRYPT(UNHEX(tu.username),'CXSOKJTSQSAZCVGHGHVDSDCG'),-4,4)) AS '手机号',
 DATE_FORMAT(tu.create_time FROM jjjr2_product.tb_dealorder tb
 	WHERE ((tb.product_type = '100' AND tb.staus IN('100','200')) OR (tb.product_type = '200' AND tb.status IN ('100','200','300')) OR (tb.product_type = '300' AND tb.status IN ('200','400')))
 	AND tb.customer_id = t.customer_id ORDER BY tb.invest_time ASC LIMIT 1) AS '首投时间',
 r.saler_code AS '客户经理代码',
 CASE WHEN s.name = '000002' THEN '公司' WHEN s.name IN ('000000','000001') THEN '电销' ELSE s.name END AS '客户经理',
 










