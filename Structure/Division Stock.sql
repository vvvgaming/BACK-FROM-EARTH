

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
 IFNULL(CONCAT(SUB))