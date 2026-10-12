CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_LP_LANGUAGE as
   /* 	
   #DescStart# 	
   #$Revision: 6699 $, $LastChangedBy: hwieber $ 	
   #SubjectAreas#: Planungswerte 	
   #DescEnd# 	
   */	
   SELECT	
      l.language_id,	
   l.language_desc,	
   l.language_iso_cd	
   FROM p_lew_core_ac.v_wawi_ref_language l	
;