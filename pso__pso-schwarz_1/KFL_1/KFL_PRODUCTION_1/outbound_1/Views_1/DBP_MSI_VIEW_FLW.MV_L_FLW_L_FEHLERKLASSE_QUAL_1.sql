CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_l_fehlerklasse_qual_1 (mandant_id, fehlerklasse_id,
fehlerklasse_kennzahl, fehlerklasse_kennzahl_ber, fehlerklasse) AS SELECT mandant_id,
 fehlerklasse_id,
 fehlerklasse_kennzahl,
  CASE
  WHEN fehlerklasse_kennzahl = 1
  THEN 0
  ELSE fehlerklasse_kennzahl
  END AS fehlerklasse_kennzahl_ber,
  100 - CASE
   WHEN fehlerklasse_kennzahl = 1
   THEN 0
   ELSE fehlerklasse_kennzahl
   END AS fehlerklasse
FROM kfl_production_dbp_view.v_flw_l_fehlerklasse_1 AS V01;