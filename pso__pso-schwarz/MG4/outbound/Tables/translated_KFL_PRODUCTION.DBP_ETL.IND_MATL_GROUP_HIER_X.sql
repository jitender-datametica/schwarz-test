CREATE OR REPLACE TABLE kfl_production_dbp_etl.ind_matl_group_hier_x (
knoten_id STRING(8) COLLATE 'und:ci',
knotentyp STRING(30) COLLATE 'und:ci',
knoten STRING(33) COLLATE 'und:ci',
vaterknoten_id STRING(8) COLLATE 'und:ci',
kindknoten_id STRING(8) COLLATE 'und:ci',
sibling_knoten_id STRING(8) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);