/* TPC-H/TPC-R Suppliers Who Kept Orders Waiting Query (Q21) */
:x
:o
select
	s_name,
	count(*) as numwait
from
	h_supplier,
	h_lineitem l1,
	h_order,
	h_nation
where
	s_suppkey = l1.l_suppkey
	and o_orderkey = l1.l_orderkey
	and o_orderstatus = 'F'
	and l1.l_receiptdate > l1.l_commitdate
	and exists (
		select
			*
		from
			h_lineitem l2
		where
			l2.l_orderkey = l1.l_orderkey
			and l2.l_suppkey <> l1.l_suppkey
	)
	and not exists (
		select
			*
		from
			h_lineitem l3
		where
			l3.l_orderkey = l1.l_orderkey
			and l3.l_suppkey <> l1.l_suppkey
			and l3.l_receiptdate > l3.l_commitdate
	)
	and s_nationkey = n_nationkey
	and n_name = ':1'
group by
	s_name
order by
	numwait desc,
	s_name;


