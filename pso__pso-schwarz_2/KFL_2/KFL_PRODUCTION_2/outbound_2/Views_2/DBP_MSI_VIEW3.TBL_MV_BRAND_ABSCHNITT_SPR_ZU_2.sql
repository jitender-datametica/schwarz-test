CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.tbl_mv_brand_abschnitt_spr_zu_2 (brand_abschnitt_id, mandant_id,
lagernummer_id, spr_id, brand_abschnitt_bez) AS (SELECT brand_abschnitt_id,
  mandant_id,
  lagernummer_id,
  spr_id,
  brand_abschnitt_bez
 FROM kfl_production_dbp_view.v_brand_abschnitt_spr_zu_2 AS V01
 UNION DISTINCT
 SELECT '-1' AS brand_abschnitt_id,
  mandant_id,
  lagernummer_id,
  spr_id,
  'system generated' AS brand_abschnitt_bez
 FROM kfl_production_dbp_view.v_brand_abschnitt_spr_zu_2 AS V01
 GROUP BY V01.brand_abschnitt_id,
  mandant_id,
  lagernummer_id,
  spr_id)
UNION DISTINCT
SELECT '  ' AS brand_abschnitt_id,
 mandant_id,
 lagernummer_id,
 spr_id,
 'system generated' AS brand_abschnitt_bez
FROM kfl_production_dbp_view.v_brand_abschnitt_spr_zu_2 AS V01
GROUP BY V01.brand_abschnitt_id,
 mandant_id,
 lagernummer_id,
 spr_id;