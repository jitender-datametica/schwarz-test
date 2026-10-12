CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_advertise_theme (
nfpo_adv_theme_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_adv_theme_nr STRING(100) NOT NULL,
nfpo_adv_theme_name STRING(100),
nfpo_adv_theme_week_cd STRING(100),
nfpo_adv_theme_alt_nr BIGNUMERIC(38,0),
nfpo_adv_theme_bus_year BIGNUMERIC(38,0),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_adv_theme_sid) NOT ENFORCED
) OPTIONS(description='NFPO advertising themes             CBX: CNT_PROJECT');