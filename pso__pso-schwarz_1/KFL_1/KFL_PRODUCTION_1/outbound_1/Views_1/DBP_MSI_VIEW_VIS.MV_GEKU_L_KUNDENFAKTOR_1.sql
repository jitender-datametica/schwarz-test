CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_geku_l_kundenfaktor_1 (kundenfaktor_id, markt_fg, fach_fg) AS
SELECT kundenfaktor_id,
 CAST(CASE
   WHEN markt_fg = 1
   THEN 'links00.gif'
   ELSE 'leer.gif'
   END AS STRING) AS zentrale_fg,
 CAST(CASE
   WHEN fach_fg = 1
   THEN 'rechts00.gif'
   ELSE 'leer.gif'
   END AS STRING) AS filiale_fg
FROM kfl_production_dbp_view.v_l_geku_kundenfaktor_1;