CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_paletten_kontrolle_gewicht_2 (mandant_id, lagernummer_id, wup_id,
nb_id, handling_unit_id, handling_unit_id_traeger, status_id, gewicht_ist, gewicht_soll, gewicht_abweichung) AS SELECT
 mandant_id,
 lagernummer_id,
 wup_id,
 nb_id,
 handling_unit_id,
 handling_unit_id_traeger,
 status_id,
 gewicht_ist,
 gewicht_soll,
  CASE
  WHEN CAST(gewicht_ist AS NUMERIC) > 0.00000
  THEN ABS(CAST(gewicht_ist AS NUMERIC) - CAST(gewicht_soll AS NUMERIC)) / CAST(gewicht_soll AS NUMERIC)
  ELSE NULL
  END AS gewicht_abweichung
FROM kfl_production_dbp_view.v_paletten_kontrolle_gewicht_2 AS V01;