CREATE OR REPLACE VIEW kfl_production_dbp_view.v_geku_zusatzinfo_sel_spr_zu_2 (zusatzinfo_sel_id, spr_id,
zusatzinfo_sel_bez, quelle_spr_id, td_update, td_insert) AS SELECT zusatzinfo_sel_id,
 spr_id,
 zusatzinfo_sel_bez,
 quelle_spr_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.geku_zusatzinfo_sel_spr_zu_2;