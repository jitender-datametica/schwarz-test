CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_mandant_wrg_typ_zu_2 (mandant_id, wrg_id, wrg_typ_id,
wrg_typ_bez) AS SELECT mandant_id,
 wrg_id,
 wrg_typ_id,
 wrg_typ_bez
FROM kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V01;