CREATE OR REPLACE TABLE kfl_production_dbp_msi_view3_materialized.tbl_mv_verrechfall_kosten_dl_agg_2 (
mandant_id INTEGER,
wrg_id STRING(3) COLLATE 'und:ci',
wrg_typ_id INTEGER,
verrechfall_id INTEGER,
verrechfall_kostenart_id STRING(10) COLLATE 'und:ci',
betrag_kosten_erster NUMERIC(29,2),
betrag_kosten_letzter NUMERIC(29,2)
);