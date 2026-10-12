CREATE OR REPLACE VIEW kfl_production_dbp_view.v_fw_we_artikel_spr_zu AS SELECT mandant_id,
 fw_we_artikel_id,
 wg_id,
 arthiertyp_id,
 spr_id,
 fw_we_artikel_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.fw_we_artikel_spr_zu;