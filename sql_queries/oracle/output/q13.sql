-- using 1438354023 as a seed to the RNG
-- $ID$
-- TPC-H/TPC-R Customer Distribution Query (Q13)
-- Functional Query Definition
-- Approved February 1998


select
	c_count,
	count(*) as custdist
from
	(
		select
			c_custkey,
			count(o_orderkey) c_count
		from
			h_customer left outer join h_order on
				c_custkey = o_custkey
				and o_comment not like '%pending%deposits%'
		group by
			c_custkey
	) c_orders
group by
	c_count
order by
	custdist desc,
	c_count desc;


