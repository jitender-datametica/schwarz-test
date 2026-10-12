CREATE TABLE IF NOT EXISTS ldl_score_cargo.t_logistiktyp_hist_1 (
logistiktyp_rowid STRING(2000),
logistiktyp_lastmoddate TIMESTAMP,
logistiktyp_id_extern BIGNUMERIC(38,5),
logistiktyp_code STRING(2000),
logistiktyp_sortierung BIGNUMERIC(38,5),
logistiktyp_bezeichnung STRING(2000),
logistiktyp_unterer_temperaturbereich BIGNUMERIC(38,5),
logistiktyp_oberer_temperaturbereich BIGNUMERIC(38,5),
logistiktyp_abrechnungsrelevant BIGNUMERIC(38,0),
logistiktyp_temperiert BIGNUMERIC(38,0),
source_extraction_tmsp ARRAY < STRING >,
tech_valid_from TIMESTAMP NOT NULL,
tech_valid_to TIMESTAMP NOT NULL,
snflk_insert_tmsp TIMESTAMP NOT NULL,
snflk_update_tmsp TIMESTAMP NOT NULL
);