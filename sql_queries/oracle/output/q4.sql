/* TPC-H/TPC-R Order Priority Checking Query (Q4) */

select
	o_orderpriority,
	count(*) as order_count
from
	h_order
where
	o_orderdate >= date '1995-03-01'
	and o_orderdate < date '1995-03-01' + interval '3' month
	and exists (
		select
			*
		from
			h_lineitem
		where
			l_orderkey = o_orderkey
			and l_commitdate < l_receiptdate
	)
group by
	o_orderpriority
order by
	o_orderpriority;

	
	