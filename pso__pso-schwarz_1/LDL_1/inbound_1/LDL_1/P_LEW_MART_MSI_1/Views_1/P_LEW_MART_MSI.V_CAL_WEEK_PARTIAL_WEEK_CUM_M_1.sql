CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_WEEK_PARTIAL_WEEK_CUM_M_1 as
         /* 	
         #DescStart# 	
         #$Revision: 6244 $, $LastChangedBy: hwieber $ 	
         #SubjectAreas#: Kalender 	
         #DescEnd# 	
         */	
         SELECT	
           cy_week_partial_week_id,	
         cy_week_partial_week_id1,	
         cy_week_partial_week_id1_cmth,	
         cy_week_partial_week_id2,	
         cy_week_partial_week_id2_cmth,	
         cy_week_partial_week_id_cmth	
         FROM p_lew_core_ac.v_wawi_cal_week_partial_week_cum_m_1;