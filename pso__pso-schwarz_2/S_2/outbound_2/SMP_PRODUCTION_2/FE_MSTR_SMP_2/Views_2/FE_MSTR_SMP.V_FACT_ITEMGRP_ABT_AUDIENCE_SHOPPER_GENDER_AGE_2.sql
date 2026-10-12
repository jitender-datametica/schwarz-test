CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_itemgrp_abt_audience_shopper_gender_age_2 AS WITH
 SHOPPERS_BY_GENDER AS (SELECT DISTINCT A15.itemgrp_abt,
   FCT.country_id,
   FCT.division_id,
   FCT.shopper_id,
   DA.descr_audience_id
  FROM smp_production_core_rel.t_smp_attributed_sales_2 AS FCT
   INNER JOIN smp_production_core_rel.t_map_shopper_descr_audience_2 AS DA ON FCT.country_id = DA.country_id AND FCT.division_id
        = DA.division_id AND FCT.shopper_id = DA.shopper_id AND LEFT(DA.descr_audience_id, 3) = 'GEN'
   INNER JOIN smp_production_fe_mstr_smp.v_dim_item_2 AS A12 ON FCT.country_id = A12.country_id AND FCT.division_id = A12
      .division_id AND FCT.gtin_id = A12.gtin_id
   INNER JOIN smp_production_fe_mstr_smp.v_rel_wg_itemfamily_owg_2 AS A13 ON A12.country_id = A13.country_id AND A12.division_id
       = A13.division_id AND A12.taxonomy_id = COALESCE(A13.wg, A13.familygrp_owg)
   INNER JOIN smp_production_fe_mstr_smp.v_rel_itemgrp_wg_familygroup_owg_2 AS A14 ON A13.country_id = A14.country_id AND
      A13.division_id = A14.division_id AND A13.familygrp_owg = A14.familygrp_owg
   INNER JOIN smp_production_fe_mstr_smp.v_rel_itemgrp_abt_subitemgrp_hwg_2 AS A15 ON A14.country_id = A15.country_id AND
      A14.division_id = A15.division_id AND A14.subitemgrp_hwg = A15.subitemgrp_hwg
  WHERE FCT.event_tmsp BETWEEN CAST(DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY) AS DATETIME) AND (CAST(CURRENT_DATE AS DATETIME)
     )), CNT_ITEMGRP_ABT AS (SELECT country_id,
   division_id,
   itemgrp_abt,
   COUNT(DISTINCT shopper_id) AS cnt_shopper_itemgrp_abt
  FROM SHOPPERS_BY_GENDER
  GROUP BY country_id,
   division_id,
   itemgrp_abt) (SELECT SBG.itemgrp_abt,
   SBG.country_id,
   SBG.division_id,
   SBG.descr_audience_id AS gender,
   DA0.descr_audience_id AS age,
   t9.cnt_shopper_itemgrp_abt,
   COUNT(SBG.shopper_id) AS cnt_shopper
  FROM SHOPPERS_BY_GENDER AS SBG
   INNER JOIN smp_production_core_rel.t_map_shopper_descr_audience_2 AS DA0 ON SBG.country_id = DA0.country_id AND SBG.division_id
        = DA0.division_id AND SBG.shopper_id = DA0.shopper_id AND LEFT(DA0.descr_audience_id, 3) = 'AGE'
   INNER JOIN CNT_ITEMGRP_ABT AS t9 ON SBG.country_id = t9.country_id AND SBG.division_id = t9.division_id AND SBG.itemgrp_abt
      = t9.itemgrp_abt
  GROUP BY SBG.itemgrp_abt,
   SBG.country_id,
   SBG.division_id,
   gender,
   age,
   t9.cnt_shopper_itemgrp_abt);