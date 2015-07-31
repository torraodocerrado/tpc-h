-- using 1438354024 as a seed to the RNG
-- $ID$
-- TPC-H/TPC-R Parts/Supplier Relationship Query (Q16)
-- Functional Query Definition
-- Approved February 1998


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
	and p_brand <> 'Brand#21'
	and p_type not like 'STANDARD POLISHED%'
	and p_size in (16, 17, 22, 2, 4, 48, 33, 37)
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


