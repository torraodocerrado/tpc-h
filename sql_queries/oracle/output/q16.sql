-- using 1438372634 as a seed to the RNG
/* TPC-H/TPC-R Parts/Supplier Relationship Query (Q16) */


select
	p_brand,
	p_type,
	p_size,
	count(distinct ps_suppkey) as supplier_cnt
from
	h_partsupp,
	h_part
where
	p_partkey = ps_partkey
	and p_brand <> 'Brand#22'
	and p_type not like 'MEDIUM BRUSHED%'
	and p_size in (13, 38, 14, 11, 36, 10, 39, 3)
	and ps_suppkey not in (
		select
			s_suppkey
		from
			h_supplier
		where
			s_comment like '%Customer%Complaints%'
	)
group by
	p_brand,
	p_type,
	p_size
order by
	supplier_cnt desc,
	p_brand,
	p_type,
	p_size;


