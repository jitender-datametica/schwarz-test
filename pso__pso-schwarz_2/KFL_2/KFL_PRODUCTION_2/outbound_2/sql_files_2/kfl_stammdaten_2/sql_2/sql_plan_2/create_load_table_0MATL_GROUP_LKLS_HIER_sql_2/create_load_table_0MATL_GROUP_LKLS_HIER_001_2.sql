DROP TABLE IF EXISTS dbp_etl.ret_wghier_2;


CREATE TABLE IF NOT EXISTS dbp_etl.ret_wghier_2 (
    id STRING(10) COLLATE 'und:ci',
    node_type STRING(20) COLLATE 'und:ci',
    node STRING(50) COLLATE 'und:ci',
    parent_id STRING(10) COLLATE 'und:ci',
    child_id STRING(10) COLLATE 'und:ci',
    sibling_id STRING(10) COLLATE 'und:ci',
    name1 STRING(50) COLLATE 'und:ci',
    mandant_id INTEGER,
    td_insert TIMESTAMP
);
