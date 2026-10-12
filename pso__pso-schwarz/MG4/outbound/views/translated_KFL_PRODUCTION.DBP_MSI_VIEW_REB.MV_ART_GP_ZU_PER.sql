CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_art_gp_zu_per (art_id, gp_id, mandant_id, aktuell_fg) AS
SELECT art_id,
 gp_id,
 mandant_id,
  CASE
  WHEN dat_bis = DATE '9999-12-31'
  THEN 'a'
  ELSE 'h'
  END AS aktuell_fg
FROM kfl_production_dbp_view.v_art_gp_zu_per
WHERE mandant_id = 1
QUALIFY (SUM(1) OVER (PARTITION BY art_id, gp_id, mandant_id ORDER BY dat_bis IS NULL, dat_bis ROWS BETWEEN
    UNBOUNDED PRECEDING AND CURRENT ROW)) = 1;