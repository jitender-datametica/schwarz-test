CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm.mv_art_gruppe_spr_zu_1 AS (SELECT T0.art_attribut_id AS
  art_gruppe_id,
  TRIM(T1.art_attribut_bez) AS art_gruppe_bez
 FROM kfl_production_dbp_view.v_art_gruppe_attribut_zu_1 AS T0
  LEFT JOIN kfl_production_dbp_view.v_art_attribut_spr_zu_1 AS T1_1 ON T0.art_attribut_id = T1.art_attribut_id
 WHERE T0.art_gruppe_id = 'FL001'
 GROUP BY art_gruppe_id,
  T1.art_attribut_bez
 UNION DISTINCT
 SELECT '-' AS art_gruppe_id,
  '-/nicht gepflegt / not maintained' AS art_gruppe_bez)
UNION DISTINCT
SELECT '-1' AS art_gruppe_id,
 'Alle Artikelgruppen' AS art_gruppe_bez;