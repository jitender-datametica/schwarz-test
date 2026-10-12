CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_organization_ldl_client (
nfpo_org_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='surrogate key internal organisation'),
nfpo_org_type_cd STRING(100) NOT NULL
OPTIONS(description='type code of the internal organisation (defined by the data modeler)'),
ldl_client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Surrogate Key CLIENT'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_org_sid, ldl_client_id) NOT ENFORCED
)
OPTIONS(description='This table contains the relationship between internal organisations and erp system based clients. this relationship can be 1:n, m:1 or m:n, depending on the organisation type');