-- using 1438372632 as a seed to the RNG
/* TPC-H/TPC-R Important Stock Identification Query (Q11) */


select
	ps_partkey,
	sum(ps_supplycost * ps_availqty) as value
from
	h_partsupp,
	h_supplier,
	h_nation
where
	ps_suppkey = s_suppkey
	and s_nationkey = n_nationkey
	and n_name = 'EGYPT'
group by
	ps_partkey having
		sum(ps_supplycost * ps_availqty) > (
			select
				sum(ps_supplycost * ps_availqty) * 0.0001000000
			from
				h_partsupp,
				h_supplier,
				h_nation
			where
				ps_suppkey = s_suppkey
				and s_nationkey = n_nationkey
				and n_name = 'EGYPT'
		)
order by
	value desc;

	

