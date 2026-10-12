CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_geku_kundenfaktor (kundenfaktor_id, markt_fg, fach_fg, td_update,
td_insert) AS SELECT *
FROM kfl_production_dbp_data.l_geku_kundenfaktor;