CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_geku_zusatzinfo_sel_zu_1 (zusatzinfo_id, zusatzinfo_sel_id, td_update,
td_insert) AS SELECT zusatzinfo_id,
 zusatzinfo_sel_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_geku_zusatzinfo_sel_zu_1;