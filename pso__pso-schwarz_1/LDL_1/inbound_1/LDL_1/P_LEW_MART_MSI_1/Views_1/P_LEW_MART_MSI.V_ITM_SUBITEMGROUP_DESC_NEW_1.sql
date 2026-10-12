CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_SUBITEMGROUP_DESC_NEW_1 AS
   /* 	
   #DescStart# 	
   #$Revision: 6761 $, $LastChangedBy: hwieber $ 	
   #SubjectAreas#: Artikelstamm 	
   #DescEnd# 	
   */	
   SELECT	
   b.subitemgroup_id	
   ,b.subitemgroup_desc
   ,b.subitemgroup_short_desc	
    FROM p_lew_core_ac.v_wawi_itm_subitemgroup_desc_act_1 AS b	
   INNER JOIN p_lew_mart_msi.v_ref_user_language_1 AS lg	
   ON LOWER(current_USER)  = LOWER(lg.db_user)	
   AND  b.language_id = lg.language_id	
;