
SELECT
 IFNULL(usx.salerType, '') AS '区域',
  GROUP_CONCAT(t.id) AS '订单编号',
   LEFT(t.serial_code, 32) AS '交易序列号',
  t.customer_id AS '客户编号',
  t.customer_name AS '客户姓名',
  AES_DECRYPT (UNHEX(tu.username),'CX') AS '手机号'