-- using 1438354024 as a seed to the RNG
-- $ID$
-- TPC-H/TPC-R Large Volume Customer Query (Q18)
-- Function Query Definition
-- Approved February 1998


select
	c_name,
	c_custkey,
	o_orderkey,
	o_orderdate,
	o_totalprice,
	sum(l_quantity)
from
	h_customer,
	h_order,
	h_lineitem
where
	o_orderkey in (
		select
			l_orderkey
		from
			h_lineitem
		group by
			l_orderkey having
				sum(l_quantity) > 312
	)
	and c_custkey = o_custkey
	and o_orderkey = l_orderkey
group by
	c_name,
	c_custkey,
	o_orderkey,
	o_orderdate,
	o_totalprice
order by
	o_totalprice desc,
	o_orderdate;

