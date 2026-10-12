CREATE OR REPLACE VIEW kfl_production_dbp_view.v_bv_quelle_spr_zu AS SELECT mandant_id,
 spr_id,
 bv_quelle_id,
 bv_quelle_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.bv_quelle_spr_zu;