CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_SUBITEMGROUPS
AS
   SELECT
      c.country_iso_cd
     ,a.subitemgroup_id
     ,a.mainitemgroup_id
     ,b.subitemgroup_sortterm
     ,a.itemgroup_int_id
     ,b.subitemgroup_desc
     ,b.subitemgroup_short_desc
     ,b.language_id
   FROM p_lew_core_ac.v_wawi_itm_subitemgroup AS a
   INNER JOIN p_lew_core_ac.v_wawi_itm_subitemgroup_desc AS b
   ON a.client_id = b.client_id
   AND a.subitemgroup_id = b.subitemgroup_id
   AND a.dat_rec_end = b.dat_rec_end
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_country AS cc
   ON a.client_id = cc.client_id
   INNER JOIN p_lew_core_ac.v_wawi_ref_country AS c
   ON cc.country_id = c.country_id
   INNER JOIN p_lew_core_ac.v_client_migration_per AS mig
   ON mig.client_id = a.client_id
   WHERE CURRENT_DATE BETWEEN a.dat_rec_start AND a.dat_rec_end
       AND a.subitemgroup_id > 0
       AND a.itemgroup_int_id > 0
       AND (    CURRENT_DATE < mig.migration_dat_valid_from
             OR CURRENT_DATE > mig.migration_dat_valid_to
           )
;