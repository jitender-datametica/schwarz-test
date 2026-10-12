CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_frage_katalog_typ_zu_2 (amx_frage_katalog_id, amx_system_id
, kmr_quelle_id, frage_typ_id) AS SELECT amx_frage_katalog_id,
 amx_system_id,
 1 AS kmr_quelle_id,
 frage_typ_id
FROM kfl_production_dbp_view.v_amx_frage_katalog_typ_zu_2;