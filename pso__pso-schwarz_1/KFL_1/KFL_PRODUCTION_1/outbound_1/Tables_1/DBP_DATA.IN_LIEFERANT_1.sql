CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_lieferant_1 (
in_lief_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
lief_name_1 STRING(40) COLLATE 'und:ci' NOT NULL,
lief_name_2 STRING(40) COLLATE 'und:ci' NOT NULL,
gp_ort STRING(40) COLLATE 'und:ci' NOT NULL,
gp_plz STRING(10) COLLATE 'und:ci' NOT NULL,
in_lief_nr STRING(10) COLLATE 'und:ci' NOT NULL,
mandant_id_werk BIGNUMERIC(38,0) NOT NULL,
system_id BIGNUMERIC(38,0) NOT NULL,
loesch_fg BIGNUMERIC(38,0) NOT NULL,
in_lief_id_int BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
subkategorie_1_id BIGNUMERIC(38,0),
konzern_id BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
werk_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL,
bis_relevant_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);