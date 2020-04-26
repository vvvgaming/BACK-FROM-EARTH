##part 1
select hzs.身份证 身份证, sum(hzs.投资金额) 暴雷金额 
from 
((select u.cert_no 身份证, sum(t.amount) 投资金额 from shanba_deposit.v_users u
inner join shanba_deposit.v_e_accounts e on u.id = e.user_id
inner join yx_data_group.库中平台状态 m on e.merchant_id = m.平台号
inner join shanba_deposit.transactions t on e.card_no = t.creditor_e_account_no
inner join shanba_deposit.assets a on t.asset_id = a.id
where date(t.created_at) >= 
 if(
	if(m.`清盘时间` > m.存管关闭时间,m.存管关闭时间,m.清盘时间) > m.最后一次还款时间,m.最后一次还款时间,
  if(m.`清盘时间` > m.存管关闭时间,m.存管关闭时间,m.清盘时间)
	)
and m.平台结果='停止运营'
group by 身份证)
union all
(select su.cert_no 身份证, sum(st.amount) 投资金额 from shangrao_deposit.v_users su
inner join shangrao_deposit.v_e_accounts se on su.id = se.user_id
inner join yx_data_group.库中平台状态 sm on se.merchant_id = sm.平台号
inner join shangrao_deposit.transactions st on se.card_no = st.creditor_e_account_no
inner join shangrao_deposit.assets sa on st.asset_id = sa.id
where date(st.created_at) >= 
if(
	if(sm.`清盘时间` > sm.存管关闭时间,sm.存管关闭时间,sm.清盘时间) > sm.最后一次还款时间,sm.最后一次还款时间,
  if(sm.`清盘时间` > sm.存管关闭时间,sm.存管关闭时间,sm.清盘时间)
	)
and sm.平台结果='停止运营'
group by 身份证)
union all
(select xu.cert_no 身份证, sum(xt.amount) 投资金额 from xinan_deposit.v_users xu
inner join xinan_deposit.v_e_accounts xe on xu.id = xe.user_id
inner join yx_data_group.库中平台状态 xm on xe.merchant_id = xm.平台号
inner join xinan_deposit.transactions xt on xe.card_no = xt.creditor_e_account_no
inner join xinan_deposit.assets xa on xt.asset_id = xa.id
where date(xt.created_at) >= 
if(
	if(xm.`清盘时间` > xm.存管关闭时间,xm.存管关闭时间,xm.清盘时间) > xm.最后一次还款时间,xm.最后一次还款时间,
  if(xm.`清盘时间` > xm.存管关闭时间,xm.存管关闭时间,xm.清盘时间)
	)
and xm.平台结果='停止运营'
group by 身份证)) hzs
group by 身份证

##part 2
select u.cert_no 身份证,
