~/src/mine/ssb-tools/benchmark_queries ~/src/mine/ssb-tools
-- All SSB (Star-Schema Benchmark) queries:
-------------------------------------------

-- Query 01
select sum(lo_extendedprice*lo_discount) as revenue from lineorder, date_ where lo_orderdate = d_datekey and d_year = 1993 and lo_discount between 1 and 3 and lo_quantity < 25; 

-- Query 02
select sum(lo_extendedprice*lo_discount) as revenue from lineorder, date_ where lo_orderdate = d_datekey and d_yearmonthnum = 199401 and lo_discount between 4 and 6 and lo_quantity between 26 and 35; 

-- Query 03
select sum(lo_extendedprice*lo_discount) as revenue from lineorder, date_ where lo_orderdate = d_datekey and d_weeknuminyear = 6 and d_year = 1994 and lo_discount between 5 and 7 and lo_quantity between 36 and 40; 

-- Query 04
select sum(lo_revenue), d_year, p_brand1 from lineorder, date_, part, supplier where lo_orderdate = d_datekey and lo_partkey = p_partkey and lo_suppkey = s_suppkey and p_category = 'MFGR#12' -- OK to add p_mfgr = ’MFGR#1’ and s_region = 'AMERICA' group by d_year, p_brand1 order by d_year, p_brand1; 

-- Query 05
select sum(lo_revenue), d_year, p_brand1 from lineorder, date_, part, supplier where lo_orderdate = d_datekey and lo_partkey = p_partkey and lo_suppkey = s_suppkey -- OK to add p_mfgr=’MFGR#2’ -- OK to add p_category=’MFGR#22’ and p_brand1 between 'MFGR#2221' and 'MFGR#2228' and s_region = 'ASIA' group by d_year, p_brand1 order by d_year, p_brand1; 

-- Query 06
select sum(lo_revenue), d_year, p_brand1 from lineorder, date_, part, supplier where lo_orderdate = d_datekey and lo_partkey = p_partkey and lo_suppkey = s_suppkey -- OK to add p_mfgr=’MFGR#2’ -- OK to add p_category=’MFGR#22’ and p_brand1 = 'MFGR#2221' and s_region = 'EUROPE' group by d_year, p_brand1 order by d_year, p_brand1; 

-- Query 07
select c_nation, s_nation, d_year, sum(lo_revenue) as revenue from customer, lineorder, supplier, date_ where lo_custkey = c_custkey and lo_suppkey = s_suppkey and lo_orderdate = d_datekey and c_region = 'ASIA' and s_region = 'ASIA' and d_year >= 1992 and d_year <= 1997 group by c_nation, s_nation, d_year order by d_year asc, revenue desc; 

-- Query 08
select c_city, s_city, d_year, sum(lo_revenue) as revenue from customer, lineorder, supplier, date_ where lo_custkey = c_custkey and lo_suppkey = s_suppkey and lo_orderdate = d_datekey and c_nation = 'UNITED STATES' and s_nation = 'UNITED STATES' and d_year >= 1992 and d_year <= 1997 group by c_city, s_city, d_year order by d_year asc, revenue desc; 

-- Query 09
select c_city, s_city, d_year, sum(lo_revenue) as revenue from customer, lineorder, supplier, date_ where lo_custkey = c_custkey and lo_suppkey = s_suppkey and lo_orderdate = d_datekey and c_nation = 'UNITED KINGDOM' and (c_city='UNITED KI1' or c_city='UNITED KI5') and (s_city='UNITED KI1' or s_city='UNITED KI5') and s_nation = 'UNITED KINGDOM' and d_year >= 1992 and d_year <= 1997 group by c_city, s_city, d_year order by d_year asc, revenue desc; 

-- Query 10
select c_city, s_city, d_year, sum(lo_revenue) as revenue from customer, lineorder, supplier, date_ where lo_custkey = c_custkey and lo_suppkey = s_suppkey and lo_orderdate = d_datekey and c_nation = 'UNITED KINGDOM' and (c_city='UNITED KI1' or c_city='UNITED KI5') and (s_city='UNITED KI1' or s_city='UNITED KI5') and s_nation = 'UNITED KINGDOM' and d_yearmonth = 'Dec1997' group by c_city, s_city, d_year order by d_year asc, revenue desc; 

-- Query 11
select d_year, c_nation, sum(lo_revenue-lo_supplycost) as profit1 from date_, customer, supplier, part, lineorder where lo_custkey = c_custkey and lo_suppkey = s_suppkey and lo_partkey = p_partkey and lo_orderdate = d_datekey and c_region = 'AMERICA' and s_region = 'AMERICA' and (p_mfgr = 'MFGR#1' or p_mfgr = 'MFGR#2') group by d_year, c_nation order by d_year, c_nation; 

-- Query 12
select d_year, s_nation, p_category, sum(lo_revenue-lo_supplycost) as profit1 from date_, customer, supplier, part, lineorder where lo_custkey = c_custkey and lo_suppkey = s_suppkey and lo_partkey = p_partkey and lo_orderdate = d_datekey and c_region = 'AMERICA' and s_region = 'AMERICA' and (d_year = 1997 or d_year = 1998) and (p_mfgr = 'MFGR#1' or p_mfgr = 'MFGR#2') group by d_year, s_nation, p_category order by d_year, s_nation, p_category; 

-- Query 13
select d_year, s_city, p_brand1, sum(lo_revenue-lo_supplycost) as profit1 from date_, customer, supplier, part, lineorder where lo_custkey = c_custkey and lo_suppkey = s_suppkey and lo_partkey = p_partkey and lo_orderdate = d_datekey and c_region = 'AMERICA' and s_nation = 'UNITED STATES' and (d_year = 1997 or d_year = 1998) and p_category = 'MFGR#14' group by d_year, s_city, p_brand1 order by d_year, s_city, p_brand1; 

