CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_TIME_1 as
   /* 	
   #DescStart# 	
   #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
   #SubjectAreas#: 	
   #DescEnd# 	
   */	
	
   SELECT	
   rt.time_hour_id,	
   rt.time_hour_display,	
   rt.time_halfhour_id,	
   rt.time_halfhour_display	
	
    FROM p_lew_core_ac.v_wawi_ref_time_1 rt;