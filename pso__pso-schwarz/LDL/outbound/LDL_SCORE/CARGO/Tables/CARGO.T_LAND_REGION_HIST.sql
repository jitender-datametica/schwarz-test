CREATE TABLE IF NOT EXISTS ldl_score_cargo.t_land_region_hist (
region_bezeichnung STRING(250),
region_rowid STRING(250),
region_lastmoddate TIMESTAMP,
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);