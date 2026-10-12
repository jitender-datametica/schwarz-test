CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_brand_abschnitt_1 (mandant_id, lagernummer_id,
brand_abschnitt_id) AS (SELECT mandant_id,
  lagernummer_id,
  brand_abschnitt_id
 FROM kfl_production_dbp_view.v_brand_abschnitt_spr_zu_1 AS V01
 GROUP BY brand_abschnitt_id,
  mandant_id,
  lagernummer_id
 UNION DISTINCT
 SELECT mandant_id,
  lagernummer_id,
  '-1' AS brand_abschnitt_id
 FROM kfl_production_dbp_view.v_brand_abschnitt_spr_zu_1 AS V01
 GROUP BY V01.brand_abschnitt_id,
  mandant_id,
  lagernummer_id)
UNION DISTINCT
SELECT mandant_id,
 lagernummer_id,
 '  ' AS brand_abschnitt_id
FROM kfl_production_dbp_view.v_brand_abschnitt_spr_zu_1 AS V01
GROUP BY V01.brand_abschnitt_id,
 mandant_id,
 lagernummer_id;