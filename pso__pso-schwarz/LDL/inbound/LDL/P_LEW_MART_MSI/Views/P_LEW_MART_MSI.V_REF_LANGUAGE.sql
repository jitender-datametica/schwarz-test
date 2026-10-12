CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_LANGUAGE as
   /* 	
   #DescStart# 	
   #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
   #SubjectAreas#: Language_views 	
   #DescEnd# 	
   */	
	
   SELECT	
   l.language_id,	
   l.language_desc,	
   l.language_iso_cd	
    FROM p_lew_core_ac.v_wawi_ref_language l	
   INNER JOIN p_lew_mart_msi.t_msi_ref_user_language rul	
   ON l.language_id = rul.language_id	
   AND current_USER = rul.db_user;