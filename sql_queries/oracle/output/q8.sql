-- using 1438372631 as a seed to the RNG
/* TPC-H/TPC-R National Market Share Query (Q8) */


select
	o_year,
	sum(case
		when nation = 'JAPAN' then volume
		else 0
	end) / sum(volume) as mkt_share
from
	(
		select
			extract(year from o_orderdate) as o_year,
			l_extendedprice * (1 - l_discount) as volume,
			n2.n_name as nation
		from
			h_part,
			h_supplier,
			h_lineitem,
			h_order,
			h_customer,
			h_nation n1,
			h_nation n2,
			h_region
		where
			p_partkey = l_partkey
			and s_suppkey = l_suppkey
			and l_orderkey = o_orderkey
			and o_custkey = c_custkey
			and c_nationkey = n1.n_nationkey
			and n1.n_regionkey = r_regionkey
			and r_name = 'ASIA'
			and s_nationkey = n2.n_nationkey
			and o_orderdate between date '1995-01-01' and date '1996-12-31'
			and p_type = 'PROMO PLATED NICKEL'
	) all_nations
group by
	o_year
order by
	o_year;

	
	