CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_SUBITEMGROUP_NEW_2 as
         /* 	
         #DescStart# 	
         #$Revision: 6761 $, $LastChangedBy: hwieber $ 	
         #SubjectAreas#: Artikelstamm 	
         #DescEnd# 	
         */	
         SELECT	
         subitemgroup_id,	
         mainitemgroup_id,	
         itemgroup_int_id,	
         statisticgroup_id	
          FROM p_lew_core_ac.v_wawi_itm_subitemgroup_act_2	
;