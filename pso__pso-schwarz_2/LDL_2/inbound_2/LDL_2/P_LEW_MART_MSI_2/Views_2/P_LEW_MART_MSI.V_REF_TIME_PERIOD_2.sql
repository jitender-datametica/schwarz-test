CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_TIME_PERIOD_2 as
           /* 	
           #DescStart# 	
           #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
           #SubjectAreas#: 	
           #DescEnd# 	
           */	
           SELECT	
           period_id,	
           dat_calendar_from,	
           dat_calendar_to	
            FROM p_lew_core_ac.v_wawi_ref_time_period_2	
;