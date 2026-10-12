/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL_AC.V_CAL_WEEK_PARTIAL_WEEK_REL.
#----------------------------------------------------------------------------
# History:
#  1.0  15.09.2021    Syrokosz, Jaroslaw       First draft 
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_cal_week_partial_week_rel (dat_calendar, cy_week_partial_week_id1,
cy_week_partial_week_id2, cy_week_partial_week_id, cy_day_sequence) AS SELECT *
FROM ldl_p_lew_bil.v_cal_week_partial_week_rel;