CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ios_materialized.mv_projekt_fg (
mandant_id INTEGER,
projekt_id STRING(32) COLLATE 'und:ci',
projekt_nr STRING(30) COLLATE 'und:ci',
eingang_vorplan_fg INTEGER,
eingang_fs_vp_fg INTEGER,
eingang_auftrag_fg INTEGER,
projekt_uebergabe_fg INTEGER,
datum_teil_oeffentl_fg INTEGER,
projekt_abgeschl_fg INTEGER,
ist_aufnahme_technik_fg INTEGER,
pflege_stammdaten_sap_fg INTEGER,
apl_nat_fg INTEGER,
int_apl_fg INTEGER,
bapl_fg INTEGER
);