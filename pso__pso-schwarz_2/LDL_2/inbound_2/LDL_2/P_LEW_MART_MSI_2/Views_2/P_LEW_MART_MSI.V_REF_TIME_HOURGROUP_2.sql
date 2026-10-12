CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_TIME_HOURGROUP_2 as
       /* 	
       #DescStart# 	
       #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
       #SubjectAreas#: 	
       #DescEnd# 	
       */	
	
       SELECT	
       thg.time_hour_id,	
       thg.time_halfhour_id,	
       thg.time_halfhour_display,	
       thg.time_hourgroup_id,	
       thg.time_hourgroup_display,	
       thg.time_total_id,	
       thg.time_total_display	
	
        FROM p_lew_core_ac.v_wawi_ref_time_hourgroup_2 thg;