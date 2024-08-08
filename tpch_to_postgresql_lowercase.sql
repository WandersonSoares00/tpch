CREATE DATABASE tpch WITH ENCODING 'UTF8' LC_COLLATE='C' LC_CTYPE='C' TEMPLATE template0;

\c tpch;

CREATE TABLE nation  ( 
    n_nationkey INTEGER primary key,
    n_name       CHAR(25) NOT NULL,
    n_regionkey  INTEGER NOT NULL,
    n_comment    VARCHAR(152)
);

CREATE TABLE region  ( 
    r_regionkey INTEGER primary key,
    r_name       CHAR(25) NOT NULL,
    r_comment    VARCHAR(152)
);

CREATE TABLE part  ( 
    p_partkey INTEGER primary key,
    p_name        VARCHAR(55) NOT NULL,
    p_mfgr        CHAR(25) NOT NULL,
    p_brand       CHAR(10) NOT NULL,
    p_type        VARCHAR(25) NOT NULL,
    p_size        INTEGER NOT NULL,
    p_container   CHAR(10) NOT NULL,
    p_retailprice DECIMAL(15,2) NOT NULL,
    p_comment     VARCHAR(23) NOT NULL
);

CREATE TABLE supplier  ( 
    s_suppkey INTEGER primary key,
    s_name        CHAR(25) NOT NULL,
    s_address     VARCHAR(40) NOT NULL,
    s_nationkey   INTEGER NOT NULL,
    s_phone       CHAR(15) NOT NULL,
    s_acctbal     DECIMAL(15,2) NOT NULL,
    s_comment     VARCHAR(101) NOT NULL
);

CREATE TABLE partsupp  ( 
    ps_partkey INTEGER NOT NULL,
    ps_suppkey     INTEGER NOT NULL,
    ps_availqty    INTEGER NOT NULL,
    ps_supplycost  DECIMAL(15,2)  NOT NULL,
    ps_comment     VARCHAR(199) NOT NULL, 
    primary key (ps_partkey, ps_suppkey)
);

CREATE TABLE customer  ( 
    c_custkey INTEGER primary key,
    c_name        VARCHAR(25) NOT NULL,
    c_address     VARCHAR(40) NOT NULL,
    c_nationkey   INTEGER NOT NULL,
    c_phone       CHAR(15) NOT NULL,
    c_acctbal     DECIMAL(15,2)   NOT NULL,
    c_mktsegment  CHAR(10) NOT NULL,
    c_comment     VARCHAR(117) NOT NULL
);

CREATE TABLE orders  ( 
    o_orderkey INTEGER primary key,
    o_custkey        INTEGER NOT NULL,
    o_orderstatus    CHAR(1) NOT NULL,
    o_totalprice     DECIMAL(15,2) NOT NULL,
    o_orderdate      DATE NOT NULL,
    o_orderpriority  CHAR(15) NOT NULL,
    o_clerk          CHAR(15) NOT NULL,
    o_shippriority   INTEGER NOT NULL,
    o_comment        VARCHAR(79) NOT NULL
);

CREATE TABLE lineitem ( 
    l_orderkey INTEGER NOT NULL,
    l_partkey     INTEGER NOT NULL,
    l_suppkey     INTEGER NOT NULL,
    l_linenumber  INTEGER NOT NULL,
    l_quantity    DECIMAL(15,2) NOT NULL,
    l_extendedprice  DECIMAL(15,2) NOT NULL,
    l_discount    DECIMAL(15,2) NOT NULL,
    l_tax         DECIMAL(15,2) NOT NULL,
    l_returnflag  CHAR(1) NOT NULL,
    l_linestatus  CHAR(1) NOT NULL,
    l_shipdate    DATE NOT NULL,
    l_commitdate  DATE NOT NULL,
    l_receiptdate DATE NOT NULL,
    l_shipinstruct CHAR(25) NOT NULL,
    l_shipmode     CHAR(10) NOT NULL,
    l_comment      VARCHAR(44) NOT NULL,
    primary key(l_orderkey, l_linenumber)
);

COPY nation (n_nationkey, n_name, n_regionkey, n_comment) 
FROM 'PATH/nation.tbl'
DELIMITER '|' 
CSV;

COPY region (r_regionkey, r_name, r_comment) 
FROM 'PATH/region.tbl'
DELIMITER '|' 
CSV;

COPY part (p_partkey, p_name, p_mfgr, p_brand, p_type, p_size, p_container, p_retailprice, p_comment) 
FROM 'PATH/part.tbl'
DELIMITER '|' 
CSV;

COPY supplier (s_suppkey, s_name, s_address, s_nationkey, s_phone, s_acctbal, s_comment) 
FROM 'PATH/supplier.tbl'
DELIMITER '|' 
CSV;

COPY partsupp (ps_partkey, ps_suppkey, ps_availqty, ps_supplycost, ps_comment) 
FROM 'PATH/partsupp.tbl' 
DELIMITER '|'
CSV;

COPY customer (c_custkey, c_name, c_address, c_nationkey, c_phone, c_acctbal, c_mktsegment, c_comment) 
FROM 'PATH/customer.tbl'
DELIMITER '|' 
CSV;

COPY orders (o_orderkey, o_custkey, o_orderstatus, o_totalprice, o_orderdate, o_orderpriority, o_clerk, o_shippriority, o_comment) 
FROM 'PATH/orders.tbl'
DELIMITER '|' 
CSV;

COPY lineitem (l_orderkey, l_partkey, l_suppkey, l_linenumber, l_quantity, l_extendedprice, l_discount, l_tax, l_returnflag, l_linestatus, l_shipdate, l_commitdate, l_receiptdate, l_shipinstruct, l_shipmode, l_comment) 
FROM 'PATH/lineitem.tbl'
DELIMITER '|' 
CSV;

ALTER TABLE region ADD PRIMARY KEY (r_regionkey);
ALTER TABLE nation ADD PRIMARY KEY (n_nationkey);
ALTER TABLE nation ADD FOREIGN KEY (n_regionkey) REFERENCES region(r_regionkey);
ALTER TABLE part   ADD PRIMARY KEY (p_partkey);
ALTER TABLE supplier ADD PRIMARY KEY (s_suppkey);
ALTER TABLE supplier ADD FOREIGN KEY (s_nationkey) REFERENCES nation(n_nationkey);
ALTER TABLE partsupp ADD PRIMARY KEY (ps_partkey, ps_suppkey);
ALTER TABLE customer ADD PRIMARY KEY (c_custkey);
ALTER TABLE customer ADD FOREIGN KEY (c_nationkey) REFERENCES nation(n_nationkey);
ALTER TABLE lineitem ADD PRIMARY KEY (l_orderkey, l_linenumber);
ALTER TABLE partsupp ADD FOREIGN KEY (ps_suppkey) REFERENCES supplier(s_suppkey);
ALTER TABLE partsupp ADD FOREIGN KEY (ps_partkey) REFERENCES part(p_partkey);
ALTER TABLE orders ADD FOREIGN KEY (o_custkey) REFERENCES customer(c_custkey);
ALTER TABLE lineitem ADD FOREIGN KEY (l_orderkey) REFERENCES orders(o_orderkey);
ALTER TABLE lineitem ADD FOREIGN KEY (l_partkey, l_suppkey) REFERENCES partsupp(ps_partkey, ps_suppkey);

