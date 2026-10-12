CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_ROLLING_TYPE as
      /* 	
      #DescStart# 	
      #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
      #SubjectAreas#: Kalender 	
      #DescEnd# 	
      */	
      SELECT	
      rolling_year_type_id,	
      rolling_year_type_rep_desc,	
      rolling_year_type_prompt_desc	
      FROM p_lew_core_ac.v_wawi_cal_rolling_type	
;