

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
IFNULL(cusx.)