CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_in_wg_spr_zu_ro AS SELECT mandant_id,
 in_wg_id,
 in_wg_bez,
 in_wg_bez_lang
FROM kfl_production_dbp_view.v_in_wg_spr_zu AS V01
WHERE spr_id = 95;