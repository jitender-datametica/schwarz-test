CREATE OR REPLACE VIEW kfl_production_dbp_view.v_fw_saison_spr_zu_1 AS SELECT fw_saison_id,
 mandant_id,
 wg_id,
 arthiertyp_id,
 spr_id,
 fw_saison_bez,
 td_insert,
 td_update
FROM kfl_production_dbp_data.fw_saison_spr_zu_1;