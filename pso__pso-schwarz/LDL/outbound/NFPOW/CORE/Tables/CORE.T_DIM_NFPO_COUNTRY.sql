/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_country
   generated from Powerdesigner on Montag, 31. Juli 2023 15:56:30
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_nfpo_country (
nfpo_country_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_country_cd STRING(100) NOT NULL,
nfpo_country_name STRING(100) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_country_sid) NOT ENFORCED
)
OPTIONS(description='List of political countries used by NFPO.             CBX: CNT_CODELIST, code list "COUNTRY"             LDL: P_LEW_CORE.T_COUNTRY_POLITICAL             CORE_REL: T_NFPO_COUNTRY');