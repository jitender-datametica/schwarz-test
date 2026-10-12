CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ITM_ITEMGROUP_INT_NEW as
    /* 	
    #DescStart# 	
    #$Revision: 6761 $, $LastChangedBy: hwieber $ 	
    #SubjectAreas#: Artikelstamm 	
    #DescEnd# 	
    */	
	
   SELECT	
   t1.itemgroup_int_id,	
   t1.itemgroup_int_remark,	
   t1.itemgroup_int_desc,	
   t1.language_id	
	
   FROM p_lew_core_ac.v_wawi_itm_itemgroup_int_act AS t1	
   INNER JOIN p_lew_mart_msi.v_ref_user_language AS t2	
   ON lower(current_USER) = lower(t2.db_user)	
   AND t2.language_id = t1.language_id;