/* TPC-H/TPC-R Minimum Cost Supplier Query (Q2) */


select
	s_acctbal,
	s_name,
	n_name,
	p_partkey,
	p_mfgr,
	s_address,
	s_phone,
	s_comment
from
	h_part,
	h_supplier,
	h_partsupp,
	h_nation,
	h_region
where
	p_partkey = ps_partkey
	and s_suppkey = ps_suppkey
	and p_size = 39
	and p_type like '%NICKEL'
	and s_nationkey = n_nationkey
	and n_regionkey = r_regionkey
	and r_name = 'MIDDLE EAST'
	and ps_supplycost = (
		select
			min(ps_supplycost)
		from
			h_partsupp,
			h_supplier,
			h_nation,
			h_region
		where
			p_partkey = ps_partkey
			and s_suppkey = ps_suppkey
			and s_nationkey = n_nationkey
			and n_regionkey = r_regionkey
			and r_name = 'MIDDLE EAST'
	)
order by
	s_acctbal desc,
	n_name,
	s_name,
	p_partkey;

	
	