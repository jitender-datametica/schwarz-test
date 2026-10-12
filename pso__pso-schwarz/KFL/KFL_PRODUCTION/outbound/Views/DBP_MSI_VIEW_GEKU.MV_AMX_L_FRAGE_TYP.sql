CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_amx_l_frage_typ (frage_typ_id, amx_system_id, frage_typ_bez)
AS SELECT frage_typ_id,
 amx_system_id,
 frage_typ_bez
FROM kfl_production_dbp_view.v_amx_l_frage_typ;