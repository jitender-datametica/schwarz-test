CREATE OR REPLACE TABLE kfl_production_dbp_msi_view_flw_materialized.mv_l_in_art_wup_status_2 (
mandant_id INTEGER,
in_art_id INTEGER,
werk_id INTEGER,
dme_einh_id STRING(3) COLLATE 'und:ci',
tiergattung_id INTEGER,
beschaffungsart_id STRING(1) COLLATE 'und:ci',
zerlege_gruppe_id INTEGER,
loesch_id STRING(2) COLLATE 'und:ci',
dat_von_loesch_id DATE,
indentifikation_fg INTEGER,
tierkategorie_id INTEGER,
herkunftsnachweis_fg INTEGER,
herkunft_id INTEGER,
hackfleischpruef_fg INTEGER,
toleranz_unter_prozent NUMERIC(29,2),
toleranz_ueber_prozent NUMERIC(29,2)
);