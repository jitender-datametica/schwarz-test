CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_amx_frage_katalog_monat_1 (amx_frage_katalog_id, kmr_quelle_id,
kjmo, wert) AS SELECT V01.amx_frage_katalog_id,
 1 AS kmr_quelle_id,
 V02.kjmo,
 1 AS wert
FROM kfl_production_dbp_view.v_amx_frage_katalog_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_monat_1 AS V02 ON TRUE
WHERE V02.akt_gj BETWEEN - 1 AND 0
 AND V01.amx_system_id = 1;