/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_dig_client_nfpo_organization_2
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:39:33
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_dig_client_nfpo_organization_2 (
ldl_dig_client_cd STRING(100) NOT NULL OPTIONS(description='Client code in the Lidl Digital DWH.'),
nfpo_org_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Surrogate key internal organization.            LDL: P_LEW_CORE.T_INTERNAL_ORGANISATION.INT_ORG_SID'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_dig_client_cd) NOT ENFORCED
) OPTIONS(description='Lidl Digital Web Shops to NFPO Organizations.');