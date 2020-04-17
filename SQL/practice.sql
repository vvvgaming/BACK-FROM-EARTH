select hzs.cert_no ID_Number, sum(hns.amount) delay_amount
from
((select u.cert_no ID_Number, sum(t.amount) invest_amount from shanba_deposit.v_users u
inner join shanba_deposit.v_e_accounts e on u.id = e.users.id
inner join yx_data_group.Kstatus m on e.merchant_id = m.merchant
inner join shanba_d
))