-- using 1438354025 as a seed to the RNG
-- $ID$
-- TPC-H/TPC-R Potential Part Promotion Query (Q20)
-- Function Query Definition
-- Approved February 1998


select
	s_name,
	s_address
from
	h_supplier,
	h_nation
where
	s_suppkey in (
		select
			ps_suppkey
		from
			h_partsupp
		where
			ps_partkey in (
				select
					p_partkey
				from
					h_part
				where
					p_name like 'purple%'
			)
			and ps_availqty > (
				select
					0.5 * sum(l_quantity)
				from
					h_lineitem
				where
					l_partkey = ps_partkey
					and l_suppkey = ps_suppkey
					and l_shipdate >= date '1993-01-01'
					and l_shipdate < date '1993-01-01' + interval '1' year
			)
	)
	and s_nationkey = n_nationkey
	and n_name = 'RUSSIA'
order by
	s_name;


