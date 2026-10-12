CREATE OR REPLACE VIEW kfl_production_dbp_view.v_fw_wk_national_spr_zu_1 AS SELECT fw_wk_national_id,
 mandant_id,
 wg_id,
 arthiertyp_id,
 spr_id,
 fw_wk_national_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.fw_wk_national_spr_zu_1;