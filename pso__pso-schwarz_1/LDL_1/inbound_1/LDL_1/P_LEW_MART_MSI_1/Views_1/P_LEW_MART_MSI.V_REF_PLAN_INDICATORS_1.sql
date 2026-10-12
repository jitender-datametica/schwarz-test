CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_REF_PLAN_INDICATORS_1 as
      /* 	
      #DescStart# 	
      #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
      #SubjectAreas#: Planungswerte 	
      #DescEnd# 	
      */	
	
      SELECT	
      rpi.indicator_id,	
      rpi.indicator_desc,	
      rpi.indicator_valuetype,	
      rpi.dat_dayend	
       FROM p_lew_core_ac.v_wawi_ref_plan_indicators_1 rpi;