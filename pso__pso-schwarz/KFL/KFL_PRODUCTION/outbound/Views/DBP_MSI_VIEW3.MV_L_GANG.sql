CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_l_gang AS SELECT DISTINCT mandant_id,
 nb_id,
 wup_id,
 lagernummer_id,
  CASE
  WHEN SUBSTR(lagerplatz_id, 4, 1) = '-'
  THEN LEFT(lagerplatz_id, 3)
  ELSE 'kein Gang'
  END AS gang_id
FROM kfl_production_dbp_view.v_l_lagerplatz
WHERE dat_bis = DATE '9999-12-31';