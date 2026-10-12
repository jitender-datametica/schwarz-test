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


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_cal_week_cum_y AS SELECT cy_week_partial_week_id1 AS cy_week,
 cy_week_partial_week_id1_cbyr AS cy_week_cbyr
FROM ldl_p_lew_core_ac.v_wawi_cal_week_partial_week_cum_y
WHERE cy_week_partial_week_id2 = 9
GROUP BY cy_week,
 cy_week_cbyr;