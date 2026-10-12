CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.pcon_abwesenh_logik_fg_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
abwesenheit_id STRING(4) COLLATE 'und:ci' NOT NULL,
kjmo_bis BIGNUMERIC(38,0) NOT NULL,
kjmo_von BIGNUMERIC(38,0) NOT NULL,
logik_kz STRING(40) COLLATE 'und:ci' DEFAULT '-1' NOT NULL,
langzeit_abwesend_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
pflege_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
beschaeftigungs_verbot_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
krankheit_unfall_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
sonstige_abwesenheit_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
freigestellt_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
mutterschutz_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
elternzeit_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);