CREATE OR REPLACE VIEW kfl_production_dbp_view.v_fw_wk_discount_spr_zu_2 AS SELECT mandant_id,
 fw_wk_discount_id,
 wg_id,
 arthiertyp_id,
 spr_id,
 fw_wk_discount_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.fw_wk_discount_spr_zu_2;