CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_geku.mv_l_geku_kundenfaktor_2 (kundenfaktor_id, markt_fg, fach_fg) AS
SELECT kundenfaktor_id,
 markt_fg,
 fach_fg
FROM kfl_production_dbp_view.v_l_geku_kundenfaktor_2;