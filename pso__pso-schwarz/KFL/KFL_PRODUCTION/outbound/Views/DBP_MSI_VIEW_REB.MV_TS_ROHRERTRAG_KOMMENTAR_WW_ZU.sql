CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_ts_rohrertrag_kommentar_ww_zu (mandant_id, kjwo_ww, kommentar
) AS SELECT mandant_id,
 kjwo_ww,
 kommentar
FROM kfl_production_dbp_msi_view_reb.ts_rohertrag_kommentar_ww_zu AS V01;