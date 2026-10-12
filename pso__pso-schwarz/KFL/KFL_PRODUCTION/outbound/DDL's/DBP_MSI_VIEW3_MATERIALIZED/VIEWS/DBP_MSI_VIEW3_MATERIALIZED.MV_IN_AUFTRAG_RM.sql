CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3_materialized.mv_in_auftrag_rm (mandant_id, auftrag_id,
co_leistungsart_id, storno_fg, storno_zaehler, dat_buch) AS SELECT DISTINCT mandant_id,
 auftrag_id,
 co_leistungsart_id,
 storno_fg,
 storno_zaehler,
 dat_buch
FROM kfl_production_dbp_view.v_in_auftrag_rm;