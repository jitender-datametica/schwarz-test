CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_family_group_1 (
nfpo_item_fam_grp_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_item_fam_grp_nr STRING(100),
nfpo_item_fam_grp_name STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_fam_grp_sid) NOT ENFORCED
) OPTIONS(description='$Revision: 0000 $. FAMG; 2. Ebene der Artikelhierarchie. Direkt oberhalb des Artikels;');