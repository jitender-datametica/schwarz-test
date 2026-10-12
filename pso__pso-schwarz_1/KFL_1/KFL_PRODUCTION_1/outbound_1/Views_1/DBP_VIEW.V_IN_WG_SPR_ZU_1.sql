CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_wg_spr_zu_1 AS SELECT mandant_id,
 in_wg_id,
 spr_id,
 in_wg_bez,
 in_wg_bez_lang,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_wg_spr_zu_1;