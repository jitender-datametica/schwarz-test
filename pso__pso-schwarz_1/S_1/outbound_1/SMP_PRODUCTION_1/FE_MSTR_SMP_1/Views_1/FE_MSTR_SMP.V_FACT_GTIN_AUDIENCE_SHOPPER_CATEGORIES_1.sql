CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_gtin_audience_shopper_categories_1 AS WITH SHOPPERS_BY_AUDIENCE
 AS (SELECT DISTINCT FCT.gtin_id,
   FCT.country_id,
   FCT.division_id,
   FCT.shopper_id,
   DA.descr_audience_id
  FROM smp_production_core_rel.t_smp_attributed_sales_1 AS FCT
   INNER JOIN smp_production_core_rel.t_map_shopper_descr_audience_1 AS DA ON FCT.country_id = DA.country_id AND FCT.division_id
        = DA.division_id AND FCT.shopper_id = DA.shopper_id AND LEFT(DA.descr_audience_id, 3) NOT IN ('GEN', 'AGE',
      'VIE', 'ZIP')
  WHERE FCT.event_tmsp BETWEEN CAST(DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY) AS DATETIME) AND (CAST(CURRENT_DATE AS DATETIME)
     )), CNT_GTIN AS (SELECT country_id,
   division_id,
   gtin_id,
   COUNT(DISTINCT shopper_id) AS cnt_shopper_gtin
  FROM SHOPPERS_BY_AUDIENCE
  GROUP BY country_id,
   division_id,
   gtin_id) (SELECT SBA.gtin_id,
   SBA.country_id,
   SBA.division_id,
   DA0.descr_audience_id,
   t9.cnt_shopper_gtin,
   COUNT(DISTINCT SBA.shopper_id) AS cnt_shopper
  FROM SHOPPERS_BY_AUDIENCE AS SBA
   INNER JOIN smp_production_core_rel.t_map_shopper_descr_audience_1 AS DA0 ON SBA.country_id = DA0.country_id AND SBA.division_id
       = DA0.division_id AND SBA.shopper_id = DA0.shopper_id
   INNER JOIN CNT_GTIN AS t9 ON SBA.country_id = t9.country_id AND SBA.division_id = t9.division_id AND SBA.gtin_id = t9
      .gtin_id AND LEFT(DA0.descr_audience_id, 3) NOT IN ('GEN', 'AGE', 'VIE', 'ZIP')
  GROUP BY SBA.gtin_id,
   SBA.country_id,
   SBA.division_id,
   DA0.descr_audience_id,
   t9.cnt_shopper_gtin);