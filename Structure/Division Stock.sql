

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
 CASE WHEN s.name = '000002' THEN '公司' WHEN s.name IN ('000000','000001') THEN '电销' ELSE s.name END AS '客户经理姓名',
 AES_DECRYPT(UNHEX(s.phone),'CXSOKJTSQSAZCVGHGHVDSDCG') AS '客户经理手机',
 CASE s.status WHEN '10' THEN '在职' WHEN '20' THEN '离职' ELSE s.status END AS '客户经理状态',
 t.product_name AS '产品名称',
 ROUND(t.product_rate,6) AS '产品利率',
 t.freeze_duration AS '产品期限',
 t.freeze_unit AS '期限单位',
 ROUND(IFNULL(t.invest_cash,0),2) AS '现金投资金额',
 ROUND(IFNULL(t.invest_cash * t.freeze_duration/12,0),2) AS '现金年化投资金额',
 ROUND(IFNULL(invest_coupon,0),2) AS '投资券金额',
 ROUND(t.add_rate,6) AS '加息券',
 t.invest_time AS '投资时间',
 t.begin_time AS '满标时间',
 t.end_time AS '到期时间',
 CASE WHEN t.status = '100' THEN '投资中' WHEN t.status = '200' THEN '满标' WHEN t.status = '300' THEN '赎回' END AS '订单状态',
 IFNULL(u.invite_code,'') AS '推广码',
 IFNULL(u.real_name,'') AS '推广人姓名',
 IFNULL(CONCAT(SUBSTRING(AES_DECRYPT(UNHEX(u.username),'CXSOKJTSQSAZCVGHGHVDSDCG'),1,4),'***',SUBSTRING(AES_DECRYPT(UNHEX(u.username),'CXSOKJTSQSAZCVGHGHVDSDCG'),-4,4)),'') AS '推广人手机号'
 FROM
 jjjr2_sns.u_user tu JOIN jjjr2_product.tb_dealorder t ON tu.custom_id = t.customer_id
 LEFT JOIN jjjr2_sns.u_customer_relation r ON t.customer_id = r.custom_id AND t.invest_time >= r.begin_time AND t.invest_time < IFNULL(r.end_time,'9999-99-99')
 LEFT JOIN jjjr2_sns.u_saler s ON s.saler_code = r.saler_code
 LEFT JOIN jjjr2_sns.u_saler_expand expa ON expa.saler_code = r.saler_code
 LEFT JOIN jjjr2_sns.u_saler u ON tu.introducer_id = u.custom_id
WHERE
DATE_FORMAT(t.invest_time,'%Y-%m-%d') >= '2019-04-01'
AND t.product_type = '200'
AND expa.city = '上海'
AND t.status IN ('100','200','300')
ORDER BY t.id ASC
LIMIT 10000;

-- 归属变更
INSERT INTO jjdb.u_customer_relation (
 u_mobile,
 saler_code,
 begin_time,
 end_time,
 status,
 create_time,
 creator,
 update_time,
 updater
 )
VALUES
('13701511158','900061','2019-04-02','9999-99-99','1',NOW(),'钱金芳',NOW(),'钱银芳');

SELECT
temp.date AS '日期',
MAX(CASE temp.description WHEN '注册人数' THEN temp.amt ELSE 0 END) AS '注册人数',
MAX(CASE temp.description WHEN '投资人数' THEN temp.amt ELSE 0 END) AS '投资人数',
MAX(CASE temp.description WHEN '投资人数' THEN temp.amt_1 ELSE 0 END) AS '投资笔数',
MAX(CASE temp.description WHEN '投资人数' THEN temp.amt_2 ELSE 0 END) AS '投资金额'
FROM(
-- 注册人数
SELECT '注册人数' AS 'description', DATE_FORMAT(u.create_time,'%Y-%m-%d') AS 'date',COUNT(u.custom_id) AS 'amt',0 AS 'amt1',0 AS 'amt_2' FROM jjjr2_sns.u_user u, jjjr2_sns.u_customer_relation uc
WHERE u.custom_id = uc.custom_id AND uc.status = '1' AND u.status = '1'
AND uc.saler_code LIKE 'jd%'
AND u.create_time >= '2019-04-04'
GROUP BY DATE_FORMAT(u.create_time,'%Y-%m-%d')

UNION ALL

-- 投资人数
SELECT '投资人数' AS 'description',DATE_FORMAT(t.invest_time,'%Y-%m-%d') AS 'date',
COUNT(DISTINCT t.customer_id) AS 'amt',
COUNT(t.id) AS 'amt_1',
SUM(IFNULL(t.invest_cash,0)) AS 'amt_2'
FROM jjjr2_product.tb_dealorder t,jjjr2_sns.u_customer_relation uc
WHERE t.customer_id = uc.custom_id
AND uc.status = '1'
AND uc.saler_code LIKE 'jd%'
AND t.product_type = '200'
AND t.status IN ('100','200','300')
AND t.invest_time >= '2019-04-04'
GROUP BY DATE_FORMAT(t.invest_time,'%Y-%m-%d'))temp GROUP BY temp.date; 


-- 新平台注册
 SELECT
 u.uuid,
 expa.city,
 u.real_name AS '客户姓名',
 us.name AS '客户经理',
 u.create_time
 FROM
 jjdb.user u
 LEFT JOIN jjdb.u_customer_relation uc ON u.mobile = uc.u_mobile
 LEFT JOIN jjdb.u_saler us ON us.saler_code = uc.saler_code AND uc.status = '1'
 LEFT JOIN jjjr2_sns.u_saler_expand expa ON expa.saler_code = us.saler_code
 WHERE u.create_time >= '2019-04-09'
 GROUP BY u.uuid;



SELECT * FROM jjjr2_product.tb_activity WHERE activity_code = 'fg' AND create_time >= '2019-04-10 00:00:00' AND create_time <= '2019-04-10 22:00:00';


SELECT * FROM jjjr2_product.tb_activity WHERE activity_code = 'ygl' AND create_time >='2019-04-11 00:00:00' AND create_time <='2019-04-11 22:00:00';


SELECT * FROM jjjr2_product.tb_activity WHERE activity_code = 'fg' AND create_time >='2019-04-10 02:00:00' AND create_time <='2019-04-11 02:00:00';


SELECT * FROM jjjr2_product.tb_activity WHERE activity_code = 'kldy' AND create_time >='2019-04-11 03:00:00' AND create_time <='2019-04-12 02:00:00';




SELECT
IFNULL(SUM(invest_amount),0) sumInvestAmt
FROM
jjjr2_product.tb_dealorder
WHERE
create_time >= '2019-04-10 00:00:00'
AND create_time < '2019-04-10 20:00:00'
AND status IN(100,200);



SELECT
t.custom_id,
t.real_name,
AES_DECRYPT(UNHEX(t.username),'CXSOKJTSQSAZCVGHGHVDSDCG')
FROM
jjjr2_sns.u_user t
WHERE
t.custom_id IN('000440311','000013538')
LIMIT 10000;


SELECT
ab.province as '省份',
SUM(ab.amt) as '投资额'
FROM
(SELECT
CASE WHEN LENGTH(AES_DECRYPT(UNHEX(u.identity_card_number),'CXSOKJTSQSAZCVGHGHVDSDCG'))=15 AND MOD(RIGHT(AES_DECRYPT(UNHEX(u.identity_card_number),'CXSOKJTSQSAZCVGHGHVDSDCG'),1),2)=0 THEN '女'
     WHEN LENGTH(AES_DECRYPT(UNHEX(u.identity_card_number),'CXSOKJTSQSAZCVGHGHVDSDCG'))=15 AND MOD(RIGHT(AES_DECRYPT(UNHEX(u.identity_card_number),'CXSOKJTSQSAZCVGHGHVDSDCG'),1),2)=1 THEN '男'
     WHEN LENGTH(AES_DECRYPT(UNHEX(u.identity_card_number),'CXSOKJTSQSAZCVGHGHVDSDCG'))=18 AND MOD(LEFT(RIGHT(AES_DECRYPT(UNHEX(u.identity_card_number),'CXSOKJTSQSAZCVGHGHVDSDCG'),2),1),2)=0 THEN '女'
     WHEN LENGTH(AES_DECRYPT(UNHEX(u.identity_card_number),'CXSOKJTSQSAZCVGHGHVDSDCG'))=18 AND MOD(LEFT(RIGHT(AES_DECRYPT(UNHEX(u.identity_card_number),'CXSOKJTSQSAZCVGHGHVDSDCG'),2),1),2)=1 THEN '男' ELSE '未知' END AS 'level',
     tb.invest_cash AS amt
     FROM jjjr2_product.tb_dealorder tb JOIN jjjr2_sns.u_user u
     ON u.custom_id = tb.customer_id
     WHERE (tb.product_type = '100' AND tb.status IN ('100','200')) OR (tb.product_type = '200' AND tb.status IN ('100','200','300')) OR (tb.product_type = '300' AND tb.status IN('200','400'))) ab
GROUP BY ab.sex


SELECT
ab.level,
SUM(ab.amt),
COUNT(DISTINCT id)
FROM
(SELECT tb.customer_id AS id,
CASE WHEN LENGTH(AES_DECRYPT(UNHEX(u.identity_card_number),'CXSOKJTSQSAZCVGHGHVDSDCG'))=15 THEN CONCAT(SUBSTRING(AES_DECRYPT(UNHEX(u.identity_card_number),'CXSOKJTSQSAZCVGHGHVDSDCG'),7,1),'oh')
     WHEN LENGTH(AES_DECRYPT(UNHEX(u.identity_card_number),'CXSOKJTSQSAZCVGHGHVDSDCG'))=18 THEN CONCAT(SUBSTRING(AES_DECRYPT(UNHEX(u.identity_card_number),'CXSOKJTSQSAZCVGHGHVDSDCG'),9,1),'oh') ELSE '其他' END AS 'level',
     tb.invest_cash AS amt
FROM
jjjr2_product.tb_dealorder tb JOIN jjjr2_sns.u_user u
WHERE (tb.product_type = '100' AND tb.status IN ('100','200')) OR (tb.product_type = '200' AND tb.status IN ('100','200','300')) OR (tb.product_type = '300' AND tb.status IN ('200','400'))) ab
GROUP BY ab.level;


-- 存量客户
SELECT
tca.member_id AS '客户编号',
AES_DECRYPT(UNHEX(u.username),'CXSOKJTSQSAZCVGHGHVDSDCG') AS '手机号',
IFNULL(u.real_name,'') AS '客户姓名',
tca.available_amount AS '账户余额'
FROM
jjjr_finance.t_cash_account tca, jjjr2_sns.u_user u
WHERE tca.member_id = u.custom_id
AND tca.available_amount > 1
ORDER BY tca.available_amount DESC;

-- 充值
t.trade_no AS '交易编号',
tu.custom_id AS '客户编号',
tu.real_name AS '客户姓名',
CONCAT(SUBSTRING(AES_DECRYPT(UNHEX(tu.username),'CXSOKJTSQSAZCVGHGHVDSDCG'),1,4),'***',SUBSTRING(AES_DECRYPT(UNHEX(tu.username),'CXSOKJTSQSAZCVGHGHVDSDCG'),-4,4)) AS '客户手机号',
s.saler_code AS '客户经理代码',
s.name AS '客户经理姓名',
AES_DECRYPT(UNHEX(s.phone),'CXSOKJTSQSAZCVGHGHVDSDCG') AS '客户经理手机号',
ROPUND(t.trans_amount,2) AS '充值金额',
DATE_FORMAT(t.gmt_create,'%Y-%m-%d %H:%i:%s') AS '充值申请时间',
DATE_FORMAT(t.gmt_modify,'%Y-%m-%d %H:%i:%s') AS '充值成功时间',
CASE t.trans_status WHEN '00' THEN '申请中' WHEN '10' THEN '成功' END AS '交易状态'
FROM
jjjr2_sns.u_user tu, jjjr2_paycore.t_transaction t
LEFT JOIN jjjr2_sns.u_customer_relation r ON t.member_id = r.custom_id AND r.status = '1'
LEFT JOIN jjjr2_sns.u_saler s ON s.saler_code = r.saler_code
WHERE t.member_id = tu.custom_id
AND t.trans_type IN ('01','26','FU01','FU26')
AND t.trans_status IN ('00','10')
AND DATE_FORMAT(t.gmt_create,'%Y-%m-%d') = DATE_FORMAT(SUBSTRING(CURRENT_DATE,INTERVAL 1 DAY),'%Y-%m-%d');

-- 提现
SELECT
t.trade_no AS '交易编号',
tu.custom_id AS '客户编号',
tu.real_name AS '客户姓名',
CONCAT(SUBSTRING(AES_DECRYPT(UNHEX(tu.username),'CXSOKJTSQSAZCVGHGHVDSDCG'),1,4),'***',SUBSTRING(AES_DECRYPT(UNHEX(tu.username),'CXSOJTSQSAZCVGHGHVDSDCG'),-4,4)) AS '客户手机号',
s.saler_code AS '客户经理代码',
s.name AS '客户经理姓名',
AES_DECRYPT(UNHEX(s.phone),'CXSOKJTSQSAZCVGHGHVDSDCG') AS '客户经理手机号',
ROUND(t.trans_amount,2) AS '提现金额',
DATE_FORMAT(t.gmt_create,'%Y-%m-%d %H:%i:%s') AS '提现申请时间',
DATE_FORMAT(t.gmt_modify,'%Y-%m-%d %H:%i:%s') AS '提现成功时间',
CASE t.trans_status WHEN '00' THEN '申请中' WHEN '10' THEN '成功' END AS '交易状态'
FROM
jjjr2_sns.u_user tu, jjjr2_paycore.t_transaction t 
LEFT JOIN jjjr2_sns.u_customer_relation r ON member_id = r.custom_id AND r.status = '1'
LEFT JOIN jjjr2_sns.u_saler s ON s.saler_code = r.saler_code
WHERE t.member_id = tu.custom_id
AND t.trans_type IN('03','FY03')
AND t.trans_status IN('00','10')
AND DATE_FORMAT(t.gmt_create,'%Y-%m-%d') = DATE_FORMAT(SUBDATE(CURRENT_DATE,INTERVAL 1 DAY),'%Y-%m-%d');


-- 到期兑付
SELECT
LEFT(t.serial_code) AS '交易序列编号',
t.customer_id AS '客户编号',
  t.`customer_name` AS '客户姓名',
 CONCAT(SUBSTRING(AES_DECRYPT (UNHEX(tu.username),'CXSOKJTSQSAZCVGHGHVDSDCG'),1,4),'***',SUBSTRING(AES_DECRYPT (UNHEX(tu.username),'CXSOKJTSQSAZCVGHGHVDSDCG'),-4,4)) AS '客户手机号',
DATE_FORMAT(tu.`create_time`,'%Y-%m-%d %H:%i:%s') AS '客户注册时间',
  (SELECT tb.invest_time FROM jjjr2_product.`tb_dealorder` tb
WHERE (( tb.product_type = '100' AND tb.status IN ('100','200') ) OR( tb.product_type = '200' AND tb.status IN ('100','200','300'))OR( tb.product_type = '300' AND tb.status IN ('200','400')))
AND tb.customer_id = t.customer_id ORDER BY tb.invest_time ASC LIMIT 1) AS '首投时间',
    r.saler_code AS '客户经理代码' ,
   CASE WHEN s.saler_code = '000002'  THEN '公司' WHEN s.saler_code IN ( '000000','000001')  THEN '电销' ELSE s.`name` END AS '客户经理姓名',
  AES_DECRYPT (UNHEX(s.phone),'CXSOKJTSQSAZCVGHGHVDSDCG') AS '客户经理手机号',
  CASE s.status  WHEN '10' THEN '在职' WHEN '20' THEN '离职' ELSE s.name END AS '客户经理状态',
  t.`product_name` AS '产品名称',
  t.`freeze_duration` AS '产品期限',
  t.`freeze_unit` AS '期限单位',
 ROUND(IFNULL(t.`invest_cash`, 0),2) AS '现金投资金额',
  ROUND( IFNULL(t.`invest_cash`*t.`freeze_duration`/12, 0),2) AS '现金年化投资金额',
  t.`invest_time` AS '投资时间',
  ROUND(t.`due_income`,2) AS '到期利息',
   ROUND((t.invest_amount+t.`due_income`),2) AS '到期总金额',
   t.end_time AS '到期时间',
   CASE WHEN t.`status` = '100' THEN '投资中'
  WHEN t.`status` = '200' THEN '满标' 
  WHEN t.status = '300' THEN '赎回' END AS '订单状态',
  u.invite_code AS '推广码',u.real_name AS '推广人姓名',
  CONCAT(SUBSTRING(AES_DECRYPT (UNHEX(u.username),'CXSOKJTSQSAZCVGHGHVDSDCG'),1,3),'****',SUBSTRING(AES_DECRYPT (UNHEX(u.username),'CXSOKJTSQSAZCVGHGHVDSDCG'),-4,4)) AS '推广人手机号'
FROM
  jjjr2_sns.u_user tu JOIN jjjr2_product.`tb_dealorder` t ON tu.custom_id = t.`customer_id` 
  LEFT JOIN jjjr2_sns.`u_customer_relation` r ON t.`customer_id` = r.`custom_id` 
  LEFT JOIN jjjr2_sns.u_saler s ON s.`saler_code` = r.`saler_code` 
  LEFT JOIN jjjr2_sns.`u_user` u ON tu.introducer_id = u.custom_id  
WHERE 
DATE_FORMAT(t.end_time,'%Y-%m')= DATE_FORMAT(CURRENT_DATE,'%Y-%m')
AND t.`product_type` = '200' 
AND t.`status` IN ('100','200','300')
AND r.status = '1'
ORDER BY t.id ASC;

--金豆昨日投资
SELECT
 t.customer_id AS '客户编号',
 ROUND(SUM(t.invest_time),2) AS '现金总金额',
FROM
 jjjr2_product.tb_dealorder t 
WHERE
t.create_time > SUBDATE(CURRENT(),INTERVAL 1 DAY)
AND t.create_time < CURDATE()
AND ((
  t.product_type = '200'
AND t.status IN ('100','200','300')) OR (t.product_type = '100'
AND t.status = '200') OR (t.product_type = '300'
AND t.status = IN ('200','400')))
GROUP BY t.customer_id
LIMIT 100000;

-- 金豆累计投资
SELECT
 t.customer_id AS '客户编号',
 ROUND(SUM(t.invest_cash),2) AS '现金总金额',
FROM
 jjjr2_product.tb_dealorder t 
WHERE
 t.create_time > SUBDATE(CURDATE(),INTERVAL 1 DAY)
AND t.create_time < CURDATE()
AND((
   t.product_type = '200'
AND t.status IN ('100','200','300') )OR (t.product_type = '100'
AND t.status = '200') OR (t.product_type = '300'
AND t.status IN ('200','400')))
GROUP BY t.customer_id
LIMIT 10000;


--ZY
select * from table
where email in （select distinct email from table ） and rownum=1

SELECT fk.com 月份,fk.dyfkhte 当月放宽合同额,
yd.yddnye 月底当年放款未结清账户贷款余额,
yd.ydlsye 月底全部放款未结清账户贷款余额,
fk.dyxzsdkhs 当月新增首贷客户数,
fk.dydkkhs 当月贷款客户数,
lsdnlj.lsdnall 当年累计客户数,
lslj.lsall 历史累计客户数,
yd.ydlswjq 历史所有未结清账户数,
yd.yd0moreCount 月底逾期0more账户数,
yd.ydhtbjye 累计未结清账户合同本金余额,
yd.yd30morecount 累计30more户数,
yd.yd30more 累计30more账户合同本金余额
 FROM (
SELECT substr(t.grant_loan_date,1,7) mon,SUM(t.loan_amount) dyfkhte,
SUM(CASE WHEN t.xdbz='首贷' THEN 1 ELSE 0 END) dyxzsdkhs,COUNT(1) dydkkhs
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date>='2017-01-01' 
AND t.grant_loan_date<='2017-10-31' 
GROUP BY substr(t.grant_loan_date,1,7)
) fk
LEFT JOIN ( 
SELECT to_char(t.create_date,'yyyy-mm') mon,
SUM(CASE WHEN t.grant_loan_date>='2017-01-01' THEN (t.pay_term-t.paid_term)*t.month_rtn_amount ELSE 0 END) yddnye ,
SUM((t.pay_term-t.paid_term)*t.month_rtn_amount) ydlsye ,
COUNT(1) ydlswjq,
SUM(CASE WHEN t.overdue_day>0 THEN 1 ELSE 0 END) yd0moreCount,
SUM(t.loan_amount-t.paid_capital) ydhtbjye,
SUM(CASE WHEN t.overdue_day>7 THEN 1 ELSE 0 END) yd7morecount,
SUM(CASE WHEN t.overdue_day>7 THEN (t.loan_amount-t.paid_capital) ELSE 0 END) yd7more,
SUM(CASE WHEN t.overdue_day>30 THEN 1 ELSE 0 END) yd30morecount,
SUM(CASE WHEN t.overdue_day>30 THEN (t.loan_amount-t.paid_capital) ELSE 0 END) yd30more,

SUM(CASE WHEN t.overdue_day>7 AND t.grant_loan_date>='2017-01-01' THEN 1 ELSE 0 END) yd7morecountdn,
SUM(CASE WHEN t.overdue_day>7 AND t.grant_loan_date>='2017-01-01' THEN (t.loan_amount-t.paid_capital) ELSE 0 END) yd7moredn,
SUM(CASE WHEN t.overdue_day>30 AND t.grant_loan_date>='2017-01-01' THEN 1 ELSE 0 END) yd30morecountdn,
SUM(CASE WHEN t.overdue_day>30 AND t.grant_loan_date>='2017-01-01' THEN (t.loan_amount-t.paid_capital) ELSE 0 END) yd30moredn
FROM clspuser.crf_p2p_overdue_info_oldjjt t
LEFT JOIN clspuser.oldandjjt_account a ON a.loan_contract_no=t.loan_contract_no
WHERE t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND a.onlinetype='线下' 
AND t.status<>'3'
AND t.create_date IN 
(SELECT last_day(ADD_MONTHS(TO_DATE('2017-01', 'yyyy-MM'), ROWNUM - 1)) FROM DUAL CONNECT BY ROWNUM <=months_between(to_date('2017-10', 'yyyy-MM'),to_date('2017-01', 'yyyy-MM')) + 1)
GROUP BY t.create_date
) yd ON yd.mon=fk.mon
LEFT JOIN (
SELECT ls.mon,COUNT(1) lsall FROM (
SELECT DISTINCT '2017-01' mon,t.Id_Card
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date<='2017-01-31' 
UNION ALL
SELECT DISTINCT '2017-02' mon,t.Id_Card
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date<='2017-02-28' 
UNION ALL
SELECT DISTINCT '2017-03' mon,t.Id_Card
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date<='2017-03-31' 
UNION ALL
SELECT DISTINCT '2017-04' mon,t.Id_Card
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date<='2017-04-31' 

UNION ALL
SELECT DISTINCT '2017-05' mon,t.Id_Card
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date<='2017-05-31' 
UNION ALL
SELECT DISTINCT '2017-06' mon,t.Id_Card
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date<='2017-06-31' 
UNION ALL
SELECT DISTINCT '2017-07' mon,t.Id_Card
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date<='2017-07-31' 
UNION ALL
SELECT DISTINCT '2017-08' mon,t.Id_Card
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date<='2017-08-31' 
UNION ALL
SELECT DISTINCT '2017-09' mon,t.Id_Card
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date<='2017-09-31' 
UNION ALL
SELECT DISTINCT '2017-10' mon,t.Id_Card
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date<='2017-10-31' 
) ls
GROUP BY ls.mon
) lslj ON lslj.mon=fk.mon

----dn
LEFT JOIN (
SELECT lsdn.mon,COUNT(1) lsdnall FROM (
SELECT DISTINCT '2017-01' mon,t.Id_Card
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date>='2017-01-01'
AND t.grant_loan_date<='2017-01-31' 
UNION ALL
SELECT DISTINCT '2017-02' mon,t.Id_Card
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date>='2017-01-01'
AND t.grant_loan_date<='2017-02-28' 
UNION ALL
SELECT DISTINCT '2017-03' mon,t.Id_Card
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date>='2017-01-01'
AND t.grant_loan_date<='2017-03-31' 
UNION ALL
SELECT DISTINCT '2017-04' mon,t.Id_Card
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date>='2017-01-01'
AND t.grant_loan_date<='2017-04-31' 

UNION ALL
SELECT DISTINCT '2017-05' mon,t.Id_Card
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date>='2017-01-01'
AND t.grant_loan_date<='2017-05-31' 
UNION ALL
SELECT DISTINCT '2017-06' mon,t.Id_Card
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date>='2017-01-01'
AND t.grant_loan_date<='2017-06-31' 
UNION ALL
SELECT DISTINCT '2017-07' mon,t.Id_Card
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date>='2017-01-01'
AND t.grant_loan_date<='2017-07-31' 
UNION ALL
SELECT DISTINCT '2017-08' mon,t.Id_Card
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date>='2017-01-01'
AND t.grant_loan_date<='2017-08-31' 
UNION ALL
SELECT DISTINCT '2017-09' mon,t.Id_Card
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date>='2017-01-01'
AND t.grant_loan_date<='2017-09-31' 
UNION ALL
SELECT DISTINCT '2017-10' mon,t.Id_Card
 FROM clspuser.oldandjjt_account t
WHERE t.onlinetype='线下' 
AND t.area_no IN ( SELECT o.Org_Desc FROM cffg_loan.Sys_Org o WHERE o.area_code_ IN ('C','X','L','Y','G'))
AND t.grant_loan_date>='2017-01-01'
AND t.grant_loan_date<='2017-10-31' 
) lsdn
GROUP BY lsdn.mon
) lsdnlj ON lsdnlj.mon=fk.mon
ORDER BY 1

-- practice
SELECT * FROM Customers WHERE NOT (Country='Germany' OR Country='USA')
SELECT * FROM Customers WHERE NOT Country='Germany' AND NOT Country='USA'

SELECT * FROM Customers ORDER BY Country DESC;
SELECT * FROM Customers ORDER BY Country, CustomerName;
SELECT * FROM Customers ORDER BY Country ASC, CustomerName DESC;

CREATE SCHEMA  Jack Ma with DBPROPERTIES(
  LOCATION = 'oss://bucket名/目录名/',
  catalog = 'oss'
);

CREATE EXTERNAL TABLE BABA(
  ordernumber BIGINT
  brand STRING
)
ROW FORMAT DELIMITED FILEDS TERMINATED BY ','
STORED AS TEXT

