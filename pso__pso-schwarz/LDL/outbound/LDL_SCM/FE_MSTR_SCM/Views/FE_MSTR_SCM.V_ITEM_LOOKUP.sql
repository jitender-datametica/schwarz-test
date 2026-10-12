CREATE OR REPLACE VIEW ldl_scm_fe_mstr_scm.v_item_lookup (client_id OPTIONS(description='Identification of country'),
country_iso_cd OPTIONS(description='Abbreviation of country'), nan OPTIONS(description='national article number'), ian
OPTIONS(description='International article number'), artikel_bezeichnung
OPTIONS(description='description of article name'), zielreichweite OPTIONS(description='target delivery time')) AS WITH
 ALL_IAN_DEMAND AS (SELECT DISTINCT COU.client_id,
   D.land AS country_cd,
   D.ian,
   D.artikel_bezeichnung
  FROM ldl_scm_core.t_demand_ordr_recvd_weekly AS D
   INNER JOIN ldl_scm_core_rel.t_client AS COU ON D.land = COU.country_cd) (SELECT *
  FROM (SELECT aid.client_id,
      aid.country_cd,
      IFNULL(ITM.orig_item_nr, - 1) AS nan,
      aid.ian,
      aid.artikel_bezeichnung,
      IFNULL(SUB.tgt_delivery_time_week_cnt, 0) AS zielreichweite
     FROM ALL_IAN_DEMAND AS aid
      LEFT JOIN ldl_scm_core_rel.t_item AS ITM ON aid.client_id = ITM.client_id AND aid.ian = IFNULL(ITM.src_orig_item_nr_int
         , ITM.orig_item_nr_int)
      LEFT JOIN ldl_scm_core_rel.t_subitemgroup_delivery_time_target AS SUB ON ITM.subitemgrp_cd = SUB.subitemgrp_cd
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY aid.client_id, CAST(aid.ian AS STRING) ORDER BY nan IS NULL DESC, nan DESC
           )) = 1
     UNION DISTINCT
     SELECT ITM.client_id,
      ITM.country_iso_cd,
      ITM.orig_item_nr AS nan,
      IFNULL(ITM.src_orig_item_nr_int, ITM.orig_item_nr_int) AS ian,
      IFNULL(ITM.item_descr, ITM.item_name) AS artikel_bezeichnung,
      IFNULL(SDT.tgt_delivery_time_week_cnt, 0) AS zielreichweite
     FROM ldl_scm_core_rel.t_item AS ITM
      LEFT JOIN ldl_scm_core_rel.t_subitemgroup_delivery_time_target AS SDT ON ITM.subitemgrp_cd = SDT.subitemgrp_cd
     WHERE (ITM.case_size > 0 AND ITM.client_id NOT IN (33) AND ITM.subitemgrp_cd IS NOT NULL OR ITM.client_id = 33)
      AND NOT EXISTS (SELECT 1
       FROM ALL_IAN_DEMAND
       WHERE CONCAT(client_id, ian) = CONCAT(ITM.client_id, IFNULL(ITM.src_orig_item_nr_int, ITM.orig_item_nr_int)))
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(ITM.client_id AS STRING), ian, CAST(nan AS STRING) ORDER BY
           artikel_bezeichnung IS NULL, artikel_bezeichnung, ITM.dwh_updated_tmsp IS NULL DESC, ITM.dwh_updated_tmsp
           DESC)) = 1));