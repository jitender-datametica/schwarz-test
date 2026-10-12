CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_gtin_audience_shopper_gender_age AS WITH SHOPPERS_BY_GENDER AS
  (SELECT DISTINCT FCT.gtin_id,
   FCT.country_id,
   FCT.division_id,
   FCT.shopper_id,
   DA.descr_audience_id
  FROM smp_production_core_rel.t_smp_attributed_sales AS FCT
   INNER JOIN smp_production_core_rel.t_map_shopper_descr_audience AS DA ON FCT.country_id = DA.country_id AND FCT.division_id
        = DA.division_id AND FCT.shopper_id = DA.shopper_id AND LEFT(DA.descr_audience_id, 3) = 'GEN'
  WHERE FCT.event_tmsp BETWEEN CAST(DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY) AS DATETIME) AND (CAST(CURRENT_DATE AS DATETIME)
     )), CNT_GTIN AS (SELECT country_id,
   division_id,
   gtin_id,
   COUNT(DISTINCT shopper_id) AS cnt_shopper_gtin
  FROM SHOPPERS_BY_GENDER
  GROUP BY country_id,
   division_id,
   gtin_id) (SELECT SBG.gtin_id,
   SBG.country_id,
   SBG.division_id,
   SBG.descr_audience_id AS gender,
   DA0.descr_audience_id AS age,
   t9.cnt_shopper_gtin,
   COUNT(SBG.shopper_id) AS cnt_shopper
  FROM SHOPPERS_BY_GENDER AS SBG
   INNER JOIN smp_production_core_rel.t_map_shopper_descr_audience AS DA0 ON SBG.country_id = DA0.country_id AND SBG.division_id
        = DA0.division_id AND SBG.shopper_id = DA0.shopper_id AND LEFT(DA0.descr_audience_id, 3) = 'AGE'
   INNER JOIN CNT_GTIN AS t9 ON SBG.country_id = t9.country_id AND SBG.division_id = t9.division_id AND SBG.gtin_id = t9
     .gtin_id
  GROUP BY SBG.gtin_id,
   SBG.country_id,
   SBG.division_id,
   gender,
   age,
   t9.cnt_shopper_gtin);