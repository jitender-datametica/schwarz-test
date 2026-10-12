CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_pillar_2 (
nfpo_pillar_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key, identifier of the pillar in CBX, alternative item_2 grouping, groups item_2 family groups            CBX:Item_2/ldlPillar            ESB:cbxItem/pillar'),
nfpo_pillar_name STRING(100) NOT NULL
OPTIONS(description='namne for the identifier of the pillar in CBX, alternative item_2 grouping, groups item_2 family groups            CBX:Item_2/ldlPillar            ESB:cbxItem/pillar'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_pillar_sid) NOT ENFORCED
) OPTIONS(description='NFPO alternative item_2 grouping             CBX: CNT_ITEM.LDL_PILLAR');