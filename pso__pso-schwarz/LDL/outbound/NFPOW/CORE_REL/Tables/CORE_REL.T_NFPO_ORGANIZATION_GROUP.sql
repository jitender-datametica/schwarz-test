CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_organization_group (
nfpo_org_grp_id BIGNUMERIC(38,0) NOT NULL,
nfpo_org_grp_cd STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_org_grp_id) NOT ENFORCED
) OPTIONS(description='$Revision: 0000 $ Client block. Groups clients with common logistics.');