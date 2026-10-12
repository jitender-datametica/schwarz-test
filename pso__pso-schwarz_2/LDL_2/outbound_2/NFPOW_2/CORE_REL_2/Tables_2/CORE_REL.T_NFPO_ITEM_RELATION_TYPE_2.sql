CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_relation_type_2 (
nfpo_item_rel_type_cd STRING(100) NOT NULL,
nfpo_item_rel_type_name STRING(100) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_rel_type_cd) NOT ENFORCED
)
OPTIONS(description='Item_2 relation type             Reference data:             item_2 relation types in the NFPO item_2 planning and creation system:              PRED1: Predecessor 1             PRED2: Predecessor 2             REF_PRED: Reference Predecessor             REF_MKT: Reference Item_2 in other market');