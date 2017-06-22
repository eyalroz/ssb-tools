start TRANSACTION;

ALTER TABLE date_
ADD PRIMARY KEY(d_datekey);

ALTER TABLE supplier
ADD PRIMARY KEY(s_suppkey);

ALTER TABLE customer 
ADD PRIMARY KEY (c_custkey);

ALTER TABLE part
ADD PRIMARY KEY (p_partkey);

ALTER TABLE lineorder
ADD PRIMARY KEY (lo_orderkey);
ALTER TABLE lineorder
ADD FOREIGN KEY (lo_orderdate) REFERENCES date_ (d_datekey);
ALTER TABLE lineorder
ADD FOREIGN KEY (lo_commitdate) REFERENCES date_ (d_datekey);
ALTER TABLE lineorder
ADD FOREIGN KEY (lo_suppkey) REFERENCES supplier (s_suppkey);
ALTER TABLE lineorder
ADD FOREIGN KEY (lo_custkey) REFERENCES customer (c_custkey);
ALTER TABLE lineorder
ADD FOREIGN KEY (lo_partkey) REFERENCES part (p_partkey);

COMMIT; 
