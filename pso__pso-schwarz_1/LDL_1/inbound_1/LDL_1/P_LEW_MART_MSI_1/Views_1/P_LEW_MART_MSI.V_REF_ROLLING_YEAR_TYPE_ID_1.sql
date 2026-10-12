CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_ROLLING_YEAR_TYPE_ID_1 as
      /* 	
      #DescStart# 	
      #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
      #SubjectAreas#: Kalender 	
      #DescEnd# 	
      */	
      SELECT	
      month_until_id,	
      rolling_year_type_id	
      FROM p_lew_mart_msi.v_cal_rolling_year_1	
      GROUP BY month_until_id, rolling_year_type_id	
;