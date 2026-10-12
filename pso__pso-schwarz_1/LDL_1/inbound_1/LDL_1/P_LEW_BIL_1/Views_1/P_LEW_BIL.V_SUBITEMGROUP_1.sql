CREATE OR REPLACE view P_LEW_BIL.V_SUBITEMGROUP_1 as
   SELECT	
     sig.client_id,	
   sig.sub_item_grp_sid,	
   sig.src_subitemgrp_cd,	
   sig.src_subitemgrp_id,	
   sig.sub_item_grp_name,	
   sigh.item_grp_int_sid,	
   sig_lidl.sub_item_grp_descr AS subitemgroup_desc_lidl_short,	
   sig_default.sub_item_grp_descr AS subitemgroup_desc_default_short,	
   sig_lidl.sub_item_grp_descr AS subitemgroup_desc_lidl,	
   sig_default.sub_item_grp_descr AS subitemgroup_desc_default,	
   sigh.deleted_fg,	
   sig_default.lang_cd AS lang_cd_default,	
   sig_lidl.lang_sid AS lang_sid_lidl,	
   1 AS active_fg -- Subitemgroup ist nicht historisiert -> immer aktiv	
  FROM p_lew_core_ac.v_subitemgroup_hist_1 AS sigh	
   INNER JOIN p_lew_core_ac.v_subitemgroup_1 sig	
   ON sig.client_id = sigh.client_id	
   AND sig.sub_item_grp_sid = sigh.sub_item_grp_sid	
   AND Current_Date BETWEEN sigh.dwh_valid_from AND sigh.dwh_valid_to	
   INNER JOIN p_lew_core_ac.v_country_1 AS lidlctry	
   ON sig.client_id = lidlctry.country_sid	
   LEFT OUTER JOIN p_lew_core_ac.v_subitemgroup_descr_1 AS sig_default	
   ON sig_default.client_id = lidlctry.country_sid	
   AND sig_default.lang_sid=lidlctry.lang_sid	
   AND sig_default.sub_item_grp_sid = sigh.sub_item_grp_sid	
   LEFT OUTER JOIN p_lew_core_ac.v_subitemgroup_descr_1 AS sig_lidl	
   ON  sig_lidl.sub_item_grp_sid  = sig.sub_item_grp_sid	
   AND  sig_lidl.lang_sid=2	
   AND  sig_lidl.client_id = sig.client_id	
;