/* TPC-H/TPC-R Large Volume Customer Query (Q18) */
:x
:o
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
				sum(l_quantity) > :1
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


