
\i tpch_to_postgresql_lowercase.sql

CREATE VIEW revenue15 AS
SELECT
    l_suppkey AS supplier_no,
    SUM(l_extendedprice * (1 - l_discount)) AS total_revenue
FROM
    lineitem
WHERE
    l_shipdate >= DATE '1996-01-01'
    AND l_shipdate < DATE '1996-01-01' + INTERVAL '3 months'
GROUP BY
    l_suppkey;

