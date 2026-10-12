CREATE TABLE IF NOT EXISTS ldl_score_octopus.t_verkehrstraeger_hist_1 (
id STRING(200),
rowid STRING(200),
idextern BIGNUMERIC(38,5),
bezeichnung STRING(200),
crglatestlasttransactionnumber BIGNUMERIC(38,5),
crglastmoddate STRING(200),
crglatestlastmoddate STRING(200),
record_id BIGNUMERIC(38,5),
extraction_date DATE,
bic_zmlila STRING(1000),
extraction_ts DATETIME,
source_system STRING(1000),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);