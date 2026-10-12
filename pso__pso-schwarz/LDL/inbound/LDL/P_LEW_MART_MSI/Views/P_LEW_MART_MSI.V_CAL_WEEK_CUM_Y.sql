/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_CAL_WEEK_CUM_Y
#----------------------------------------------------------------------------
# History:
#  1.0  21.01.2021    Patrick Mittler          Initial Version
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_WEEK_CUM_Y AS
SELECT
 cy_week_partial_week_id1 			AS cy_week
 , cy_week_partial_week_id1_cbyr 	AS cy_week_cbyr
FROM p_lew_core_ac.v_wawi_cal_week_partial_week_cum_y
 -- Filter auf 9; Ganze Woche; Exclude partial_week (id 1 and id 2)
 WHERE cy_week_partial_week_id2 = 9
 GROUP BY 1,2
;