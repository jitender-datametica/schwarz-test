CREATE TABLE IF NOT EXISTS ldl_score_octopus.t_kontraktstrecke_empfangsorte_hist_1 (
parentid STRING(100),
childid STRING(100),
record_id BIGNUMERIC(38,0),
extraction_date DATE,
bic_zmlila STRING(100),
extraction_ts DATETIME,
source_system STRING(100),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);