CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_ios_materialized.mv_bvv_gik_2 (
mandant_id INTEGER,
rpm_hierarchie_id STRING(32) COLLATE 'und:ci',
testmarkt_fg INTEGER,
projekt_id STRING(32) COLLATE 'und:ci',
projekt_nr STRING(30) COLLATE 'und:ci',
psp_id INTEGER,
psp_id_char STRING(30) COLLATE 'und:ci',
psp_end_nr INTEGER,
ausblend INTEGER,
gesamt_investitions_kosten NUMERIC(29,4),
wrg_id STRING(12) COLLATE 'und:ci',
wrg_typ_id INTEGER,
faktor NUMERIC(29,5),
kurs_2 NUMERIC(29,5)
);