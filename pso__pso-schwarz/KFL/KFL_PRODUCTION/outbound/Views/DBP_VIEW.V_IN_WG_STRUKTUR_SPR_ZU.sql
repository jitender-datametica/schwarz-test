CREATE OR REPLACE VIEW kfl_production_dbp_view.v_in_wg_struktur_spr_zu AS SELECT in_wg_struktur_id,
 spr_id,
 in_wg_struktur_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.in_wg_struktur_spr_zu;