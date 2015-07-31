-- using 1438372630 as a seed to the RNG
/* TPC-H/TPC-R Local Supplier Volume Query (Q5) */


select
	n_name,
	sum(l_extendedprice * (1 - l_discount)) as revenue
from
	h_customer,
	h_order,
	h_lineitem,
	h_supplier,
	h_nation,
	h_region
where
	c_custkey = o_custkey
	and l_orderkey = o_orderkey
	and l_suppkey = s_suppkey
	and c_nationkey = s_nationkey
	and s_nationkey = n_nationkey
	and n_regionkey = r_regionkey
	and r_name = 'EUROPE'
	and o_orderdate >= date '1994-01-01'
	and o_orderdate < date '1994-01-01' + interval '1' year
group by
	n_name
order by
	revenue desc;

