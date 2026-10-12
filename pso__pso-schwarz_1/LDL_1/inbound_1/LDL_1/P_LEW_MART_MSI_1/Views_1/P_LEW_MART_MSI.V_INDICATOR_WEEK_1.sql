CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_INDICATOR_WEEK_1 as
   /* 	
   #DescStart# 	
   #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
   #SubjectAreas#: KPGES Views 	
   #DescEnd# 	
   */	
   SELECT	
   client_id,	
   org_type_id,	
   org_unit_nr,	
   indicator_id,	
   indicator_type_id,	
   cy,	
   cal_week,	
   val_indicator,	
   dat_dayend,	
   load_id	
   FROM p_lew_core_ac.v_wawi_indicator_week_1;