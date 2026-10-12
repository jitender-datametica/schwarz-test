CREATE OR REPLACE VIEW dbp_msi_view_reb.mv_ts_rohrertrag_kommentar_ww_zu_2 (mandant_id, kjwo_ww, kommentar) AS SELECT
 mandant_id,
 kjwo_ww,
 kommentar
FROM dbp_msi_view_reb.ts_rohertrag_kommentar_ww_zu_2 AS v01;