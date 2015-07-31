-- using 1438354026 as a seed to the RNG
-- $ID$
-- TPC-H/TPC-R Global Sales Opportunity Query (Q22)
-- Functional Query Definition
-- Approved February 1998


select
	cntrycode,
	count(*) as numcust,
	sum(c_acctbal) as totacctbal
from
	(
		select
			SUBSTR(c_phone ,1 , 2) as cntrycode,
			c_acctbal
		from
			h_customer
		where
			SUBSTR(c_phone , 1, 2) in
				('21', '14', '26', '27', '32', '17', '30')
			and c_acctbal > (
				select
					avg(c_acctbal)
				from
					h_customer
				where
					c_acctbal > 0.00
					and SUBSTR(c_phone , 1, 2) in
						('21', '14', '26', '27', '32', '17', '30')
			)
			and not exists (
				select
					*
				from
					h_order
				where
					o_custkey = c_custkey
			)
	) custsale
group by
	cntrycode
order by
	cntrycode;

	

