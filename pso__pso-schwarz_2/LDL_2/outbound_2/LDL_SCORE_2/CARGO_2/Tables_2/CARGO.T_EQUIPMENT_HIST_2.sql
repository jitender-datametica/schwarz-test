CREATE TABLE IF NOT EXISTS ldl_score_cargo.t_equipment_hist_2 (
equipment_rowid STRING(2000),
equipment_lastmoddate TIMESTAMP,
equipment_id_extern BIGNUMERIC(38,5),
equipment_bezeichnung STRING(2000),
equipment_equipmentklasse_code STRING(2000),
equipment_equipmentklasse_bezeichnung STRING(2000),
equipment_zugehoerige_equipments_rowids STRING(2000),
equipment_label STRING(2000),
equipment_sortierreihenfolge BIGNUMERIC(38,5),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);