CREATE TABLE IF NOT EXISTS ldl_score_cargo.t_land_hist (
land_iso2 STRING(250),
land_kfz STRING(250),
land_region_rowid STRING(250),
land_bezeichnung STRING(250),
land_row_id STRING(250),
land_waehrung_iso STRING(250),
land_waehrung_bezeichnung STRING(250),
land_lastmoddate TIMESTAMP,
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);