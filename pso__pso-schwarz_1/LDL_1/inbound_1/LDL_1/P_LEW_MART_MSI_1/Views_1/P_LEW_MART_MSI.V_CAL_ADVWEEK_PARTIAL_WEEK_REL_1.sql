CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_ADVWEEK_PARTIAL_WEEK_REL_1
    /* 	
    #DescStart# 	
    #$Revision: 12835 $, $LastChangedBy: umeister $ 	
    #SubjectAreas#: calendar_1 	
    #DescEnd# 	
    */	
    (	
    cy_week	
    , cy_week_partial_week_id1	
    , cy_week_partial_week_id2	
    , cy_week_partial_week_name	
    , cy_month	
    , byr	
    , cy_week_partial_week_id	
     )	
    AS	
       SELECT	
           cy_week,	
       cy_week_partial_week_id1,	
       cy_week_partial_week_id2,	
       cy_week_partial_week_name,	
       cy_month,	
       byr,	
       cy_week_partial_week_id	
       FROM p_lew_mart_msi.t_cal_advweek_partial_week_rel_1	
;