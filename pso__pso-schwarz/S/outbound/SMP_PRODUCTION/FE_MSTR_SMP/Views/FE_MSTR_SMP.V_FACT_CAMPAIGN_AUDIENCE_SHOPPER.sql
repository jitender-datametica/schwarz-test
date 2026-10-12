/* ,MAX(CASE WHEN da.descr_audience_type_id = 'AGE' THEN da.descr_audience_type_id ELSE NULL END) AS age
    ,MAX(CASE WHEN da.descr_audience_type_id = 'AGE' THEN da.descr_audience_id ELSE NULL END) AS age_id
    ,MAX(CASE WHEN da.descr_audience_type_id = 'AGE' THEN da.descr_audience_name ELSE NULL END) AS age_name
    ,MAX(CASE WHEN da.descr_audience_type_id = 'GENDER' THEN da.descr_audience_type_id ELSE NULL END) AS gender
    ,MAX(CASE WHEN da.descr_audience_type_id = 'GENDER' THEN da.descr_audience_id ELSE NULL END) AS gender_id
    ,MAX(CASE WHEN da.descr_audience_type_id = 'GENDER' THEN da.descr_audience_name ELSE NULL END) AS gender_name */
CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_campaign_audience_shopper AS WITH GOPA1 AS (SELECT DISTINCT DIM
   .campaign_id,
   FCT.country_id,
   FCT.division_id,
   SHOPPER.shopper_id
  FROM smp_production_core.t_fact_sales_store_supplier_shopper_gtin_day AS FCT
   INNER JOIN smp_production_core_rel.t_campaign_gtin AS C_GTIN ON FCT.country_id = C_GTIN.country_id AND FCT.division_id
       = C_GTIN.division_id AND FCT.gtin_id = C_GTIN.gtin_id
   INNER JOIN smp_production_core.t_dim_campaign AS DIM ON FCT.country_id = DIM.country_id AND FCT.division_id = DIM.division_id
         AND FCT.gtin_id = C_GTIN.gtin_id AND FCT.day_dt <= DIM.campaign_end_dt AND FCT.day_dt >= DIM.campaign_start_dt
   INNER JOIN smp_production_eval.tmp_shopper_special_behaviour AS SHOPPER ON FCT.country_id = SHOPPER.country_id AND
      FCT.division_id = SHOPPER.division_id AND FCT.shopper_id_ref = SHOPPER.shopper_id_ref
  WHERE FCT.day_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY) AND (CURRENT_DATE)
   AND FCT.shopper_id_ref IS NOT NULL), CNT_CAMPAIGN AS (SELECT country_id,
   division_id,
   campaign_id,
   COUNT(DISTINCT shopper_id) AS cnt_shopper_campaign
  FROM GOPA1
  GROUP BY country_id,
   division_id,
   campaign_id) (SELECT t2.country_id,
   t2.division_id,
   t2.campaign_id,
   MSDA.descr_audience_id,
   t10.cnt_shopper_campaign,
   COUNT(DISTINCT t2.shopper_id) AS cnt_shopper
  FROM smp_production_core_rel.t_map_shopper_descr_audience AS MSDA
   INNER JOIN GOPA1 AS t2 ON MSDA.country_id = t2.country_id AND MSDA.division_id = t2.division_id AND MSDA.shopper_id =
     t2.shopper_id
   INNER JOIN CNT_CAMPAIGN AS t10 ON t2.country_id = t10.country_id AND t2.division_id = t10.division_id AND t2.campaign_id
      = t10.campaign_id
   INNER JOIN smp_production_core_rel.t_descr_audience AS DA ON MSDA.division_id = DA.division_id AND MSDA.country_id =
       DA.country_id AND MSDA.descr_audience_id = DA.descr_audience_id AND DA.descr_audience_type_id IN ('BUYING BEHAVIOUR'
      , 'AGE', 'GENDER')
  GROUP BY t2.campaign_id,
   t2.country_id,
   t2.division_id,
   MSDA.descr_audience_id,
   t10.cnt_shopper_campaign);