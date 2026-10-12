CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_beschw_antw_spr_zu_2 AS SELECT beschwerde_antwort_id,
 spr_id,
 beschwerde_antw_bez,
 quelle_spr_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_beschw_antw_spr_zu_2;