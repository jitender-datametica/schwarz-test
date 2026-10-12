CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_campaign_audience_shopper_bkp_2 AS WITH GOPA1 AS (SELECT DISTINCT
   C_GTIN.gtin_id,
   DIM.campaign_id,
   FCT.country_id,
   FCT.division_id,
   SHOPPER.shopper_id
  FROM smp_production_core.t_fact_sales_store_supplier_shopper_gtin_day_2 AS FCT
   INNER JOIN smp_production_core_rel.t_campaign_gtin_2 AS C_GTIN ON FCT.country_id = C_GTIN.country_id AND FCT.division_id
       = C_GTIN.division_id AND FCT.gtin_id = C_GTIN.gtin_id
   INNER JOIN smp_production_core.t_dim_campaign_2 AS DIM ON FCT.country_id = DIM.country_id AND FCT.division_id = DIM.division_id
         AND FCT.gtin_id = C_GTIN.gtin_id AND FCT.day_dt <= DIM.campaign_end_dt AND FCT.day_dt >= DIM.campaign_start_dt
   INNER JOIN smp_production_eval.tmp_shopper_special_behaviour_2 AS SHOPPER_2 ON FCT.country_id = SHOPPER.country_id AND
      FCT.division_id = SHOPPER.division_id AND FCT.shopper_id_ref = SHOPPER.shopper_id_ref
  WHERE FCT.day_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY) AND (CURRENT_DATE)) (-- ADDITIONAL CNT NOT AGGREGATED BY AUDIENCE

  SELECT t2.country_id,
   t2.division_id,
   t2.campaign_id,
   DA.descr_audience_id,
    (SELECT COUNT(DISTINCT shopper_id)
    FROM GOPA1) AS cnt_shopper_campaign,
   COUNT(DISTINCT t2.shopper_id) AS cnt_shopper
  FROM smp_production_core_rel.t_map_shopper_descr_audience_2 AS DA
   INNER JOIN GOPA1 AS t2 ON DA.country_id = t2.country_id AND DA.division_id = t2.division_id AND DA.shopper_id = t2.shopper_id
     
  GROUP BY t2.campaign_id,
   DA.descr_audience_id,
   t2.country_id,
   t2.division_id);