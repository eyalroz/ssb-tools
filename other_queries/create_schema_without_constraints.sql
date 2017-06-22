start TRANSACTION;

CREATE TABLE date_ (
     d_datekey          INT,     -- identifier, unique id -- e.g. 19980327 (what we use)
     d_date             STRING,  -- varchar(18), --fixed text, size 18, longest: december 22, 1998
     d_dayofweek        STRING,  -- varchar(8), --fixed text, size 8, sunday, monday, ..., saturday)
     d_month            STRING,  -- varchar(9), --fixed text, size 9: january, ..., december
     d_year             INT,     -- unique value 1992-1998
     d_yearmonthnum     INT,     -- numeric (yyyymm) -- e.g. 199803
     d_yearmonth        STRING,  -- varchar(7), --fixed text, size 7: mar1998 for example
     d_daynuminweek     INT,     -- numeric 1-7
     d_daynuminmonth    INT,     -- numeric 1-31
     d_daynuminyear     INT,     -- numeric 1-366
     d_monthnuminyear   INT,     -- numeric 1-12
     d_weeknuminyear    INT,     -- numeric 1-53
     d_sellingseason    STRING,  -- varchar(12), --text, size 12 (christmas, summer,...)
     d_lastdayinweekfl  INT,     -- 1 bit
     d_lastdayinmonthfl INT,     -- 1 bit
     d_holidayfl        INT,     -- 1 bit
     d_weekdayfl        INT      -- 1 bit
);

CREATE TABLE supplier (
     s_suppkey INT,     -- identifier
     s_name    STRING,  -- varchar(25), --fixed text, size 25: 'supplier'||suppkey
     s_address STRING,  -- varchar(25), --variable text, size 25 (city below)
     s_city    STRING,  -- varchar(10), --fixed text, size 10 (10/nation: nation_prefix||(0-9))
     s_nation  STRING,  -- varchar(15), --fixed text(15) (25 values, longest united kingdom)
     s_region  STRING,  -- varchar(12), --fixed text, size 12 (5 values: longest middle east)
     s_phone   STRING   -- varchar(15) --fixed text, size 15 (many values, format: 43-617-354-1222)
);

CREATE TABLE customer (
     c_custkey    INT,--numeric identifier
     c_name       STRING,     -- varchar(25), --variable text, size 25 'customer'||custkey
     c_address    STRING,     -- varchar(25), --variable text, size 25 (city below)
     c_city       STRING,     -- varchar(10), --fixed text, size 10 (10/nation: nation_prefix||(0-9)
     c_nation     STRING,     -- varchar(15), --fixed text(15) (25 values, longest united kingdom)
     c_region     STRING,     -- varchar(12), --fixed text, size 12 (5 values: longest middle east)
     c_phone      STRING,     -- varchar(15), --fixed text, size 15 (many values, format: 43-617-354-1222)
     c_mktsegment STRING      -- varchar(10) --fixed text, size 10 (longest is automobile)
);

CREATE TABLE part (
     p_partkey   INT,        -- identifier
     p_name      STRING,     -- varchar(22), --variable text, size 22 (not unique per part but never was)
     p_mfgr      STRING,     -- varchar(6), --fixed text, size 6 (mfgr#1-5, card = 5)
     p_category  STRING,     -- varchar(7), --fixed text, size 7 ('mfgr#'||1-5||1-5: card = 25)
     p_brand1    STRING,     -- varchar(9), --fixed text, size 9 (category||1-40: card = 1000)
     p_color     STRING,     -- varchar(11), --variable text, size 11 (card = 94)
     p_type      STRING,     -- varchar(25), --variable text, size 25 (card = 150)
     p_size      INT,        -- numeric 1-50 (card = 50)
     p_container STRING      -- varchar(15) --fixed text(10) (card = 40)
);

CREATE TABLE lineorder (
     lo_orderkey      INT,     -- numeric (int up to sf 300) first 8 of each 32 keys used
     lo_linenumber    INT,     -- numeric 1-7
     lo_custkey       INT,     -- numeric identifier foreign key reference to c_custkey
     lo_partkey       INT,     -- identifier foreign key reference to p_partkey
     lo_suppkey       INT,     -- numeric identifier foreign key reference to s_suppkey
     lo_orderdate     INT,     -- identifier foreign key reference to d_datekey
     lo_orderpriority STRING,  -- varchar(15), --fixed text, size 15 (5 priorities: 1-urgent, etc.)
     lo_shippriority  STRING,  -- varchar(1), --fixed text, size 1
     lo_quantity      INT,     -- numeric 1-50 (for part)
     lo_extendedprice INT,     -- numeric, max about 55,450 (for part)
     lo_ordtotalprice INT,     -- numeric, max about 388,000 (for order)
     lo_discount      INT,     -- numeric 0-10 (for part) -- (represents percent)
     lo_revenue       INT,     -- numeric (for part: (extendedprice*(100-discount))/100)
     lo_supplycost    INT,     -- numeric (for part, cost from supplier, max = ?)
     lo_tax           INT,     -- numeric 0-8 (for part)
     lo_commitdate    INT,     -- foreign key reference to d_datekey
     lo_shipmode      STRING   -- varchar(10) --fixed text, size 10 (modes: reg air, air, etc.)
);

COMMIT; 
