
SELECT
 IFNULL(usx.salerType, '') AS '区域',
  GROUP_CONCAT(t.id) AS '订单编号',