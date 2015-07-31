-- using 1438372630 as a seed to the RNG
/* TPC-H/TPC-R Forecasting Revenue Change Query (Q6) */


select
	sum(l_extendedprice * l_discount) as revenue
from
	h_lineitem
where
	l_shipdate >= date '1994-01-01'
	and l_shipdate < date '1994-01-01' + interval '1' year
	and l_discount between 0.03 - 0.01 and 0.03 + 0.01
	and l_quantity < 25;

	
	