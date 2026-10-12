CREATE OR REPLACE VIEW smp_production_fe_mstr_smp.v_fact_familygrp_owg_audience_shopper_categories_2 AS WITH
 SHOPPERS_BY_AUDIENCE AS (SELECT DISTINCT A14.familygrp_owg,
   FCT.country_id,
   FCT.division_id,
   FCT.shopper_id,
   DA.descr_audience_id
  FROM smp_production_core_rel.t_smp_attributed_sales_2 AS FCT
   INNER JOIN smp_production_core_rel.t_map_shopper_descr_audience_2 AS DA ON FCT.country_id = DA.country_id AND FCT.division_id
        = DA.division_id AND FCT.shopper_id = DA.shopper_id AND LEFT(DA.descr_audience_id, 3) NOT IN ('GEN', 'AGE',
      'VIE', 'ZIP')
   INNER JOIN smp_production_fe_mstr_smp.v_dim_item_2 AS A12 ON FCT.country_id = A12.country_id AND FCT.division_id = A12
      .division_id AND FCT.gtin_id = A12.gtin_id
   INNER JOIN smp_production_fe_mstr_smp.v_rel_wg_itemfamily_owg_2 AS A13 ON A12.country_id = A13.country_id AND A12.division_id
       = A13.division_id AND A12.taxonomy_id = COALESCE(A13.wg, A13.familygrp_owg)
   INNER JOIN smp_production_fe_mstr_smp.v_rel_itemgrp_wg_familygroup_owg_2 AS A14 ON A13.country_id = A14.country_id AND
      A13.division_id = A14.division_id AND A13.familygrp_owg = A14.familygrp_owg
  WHERE FCT.event_tmsp BETWEEN CAST(DATE_SUB(CURRENT_DATE, INTERVAL 90 DAY) AS DATETIME) AND (CAST(CURRENT_DATE AS DATETIME)
     )), CNT_FAMILYGRP_OWG AS (SELECT country_id,
   division_id,
   familygrp_owg,
   COUNT(DISTINCT shopper_id) AS cnt_shopper_familygrp_owg
  FROM SHOPPERS_BY_AUDIENCE
  GROUP BY country_id,
   division_id,
   familygrp_owg) (SELECT SBA.familygrp_owg,
   SBA.country_id,
   SBA.division_id,
   DA0.descr_audience_id,
   t9.cnt_shopper_familygrp_owg,
   COUNT(DISTINCT SBA.shopper_id) AS cnt_shopper
  FROM SHOPPERS_BY_AUDIENCE AS SBA
   INNER JOIN smp_production_core_rel.t_map_shopper_descr_audience_2 AS DA0 ON SBA.country_id = DA0.country_id AND SBA.division_id
       = DA0.division_id AND SBA.shopper_id = DA0.shopper_id
   INNER JOIN CNT_FAMILYGRP_OWG AS t9 ON SBA.country_id = t9.country_id AND SBA.division_id = t9.division_id AND SBA.familygrp_owg
       = t9.familygrp_owg AND LEFT(DA0.descr_audience_id, 3) NOT IN ('GEN', 'AGE', 'VIE', 'ZIP')
  GROUP BY SBA.familygrp_owg,
   SBA.country_id,
   SBA.division_id,
   DA0.descr_audience_id,
   t9.cnt_shopper_familygrp_owg);