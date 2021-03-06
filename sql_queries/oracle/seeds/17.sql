/* TPC-H/TPC-R Small-Quantity-Order Revenue Query (Q17) */
:x
:o
select
	sum(l_extendedprice) / 7.0 as avg_yearly
from
	h_lineitem,
	h_part
where
	p_partkey = l_partkey
	and p_brand = ':1'
	and p_container = ':2'
	and l_quantity < (
		select
			0.2 * avg(l_quantity)
		from
			h_lineitem
		where
			l_partkey = p_partkey
	);


