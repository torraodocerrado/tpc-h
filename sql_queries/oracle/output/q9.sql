-- using 1438372631 as a seed to the RNG
/* TPC-H/TPC-R Product Type Profit Measure Query (Q9) */


select
	nation,
	o_year,
	sum(amount) as sum_profit
from
	(
		select
			n_name as nation,
			extract(year from o_orderdate) as o_year,
			l_extendedprice * (1 - l_discount) - ps_supplycost * l_quantity as amount
		from
			h_part,
			h_supplier,
			h_lineitem,
			h_partsupp,
			h_order,
			h_nation
		where
			s_suppkey = l_suppkey
			and ps_suppkey = l_suppkey
			and ps_partkey = l_partkey
			and p_partkey = l_partkey
			and o_orderkey = l_orderkey
			and s_nationkey = n_nationkey
			and p_name like '%steel%'
	) profit
group by
	nation,
	o_year
order by
	nation,
	o_year desc;

	

