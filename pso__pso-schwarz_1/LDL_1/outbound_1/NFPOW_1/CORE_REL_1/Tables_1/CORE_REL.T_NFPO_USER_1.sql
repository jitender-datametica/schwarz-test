CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_user_1 (
nfpo_user_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_user_acct_name STRING(100) NOT NULL,
nfpo_user_version_nr BIGNUMERIC(38,0) NOT NULL,
nfpo_user_abbr_name STRING(100),
nfpo_user_first_name STRING(100),
nfpo_user_last_name STRING(100),
nfpo_user_email_addr_txt STRING(1000),
sso_name STRING(100) COLLATE 'und:ci',
nfpo_user_note_txt STRING(1000),
nfpo_user_mgr_abbr_name STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_user_sid) NOT ENFORCED
) OPTIONS(description='NFPO user, mainly covering the role buyer             CBX: CNT_USER, CTM_USER');