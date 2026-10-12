CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_geku_kundenfaktor_2 AS SELECT kundenfaktor_id,
 markt_fg,
 fach_fg,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_geku_kundenfaktor_2;