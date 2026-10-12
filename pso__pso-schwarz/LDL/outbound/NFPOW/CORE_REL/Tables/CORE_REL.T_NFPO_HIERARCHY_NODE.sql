CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_hierarchy_node (
nfpo_hier_node_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_hier_name STRING(100) NOT NULL,
nfpo_hier_node_path_nr STRING(100) NOT NULL,
nfpo_hier_node_cd STRING(100) NOT NULL,
nfpo_hier_node_name STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_hier_node_sid) NOT ENFORCED
) OPTIONS(description='NFPO product hierarchy             CBX: derived from CNT_ITEM');