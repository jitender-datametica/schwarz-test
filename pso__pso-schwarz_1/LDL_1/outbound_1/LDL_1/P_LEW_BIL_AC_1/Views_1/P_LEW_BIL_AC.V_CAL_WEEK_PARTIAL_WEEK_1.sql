/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL_AC.V_CAL_WEEK_PARTIAL_WEEK.
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# History:
#  1.0  15.09.2021    Syrokosz, Jaroslaw       First draft 
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil_ac.v_cal_week_partial_week_1 (cy_week_partial_week_id1, cy_week_partial_week_id2,
cy_week_partial_week_name, cy_month, busyear, cy_week_partial_week_id, partialweek_in_mth_seq_asc,
partialweek_in_mth_seq_desc, cy_partial_week_short_name, cy_partial_week_short_name_de, cy_partial_week_short_name_en,
cy_partial_week_short_name_bg, cy_partial_week_short_name_cs, cy_partial_week_short_name_da,
cy_partial_week_short_name_el, cy_partial_week_short_name_es, cy_partial_week_short_name_fi,
cy_partial_week_short_name_fr, cy_partial_week_short_name_hr, cy_partial_week_short_name_hu,
cy_partial_week_short_name_it, cy_partial_week_short_name_lt, cy_partial_week_short_name_nl,
cy_partial_week_short_name_pl, cy_partial_week_short_name_pt, cy_partial_week_short_name_ro,
cy_partial_week_short_name_sh, cy_partial_week_short_name_sk, cy_partial_week_short_name_sl,
cy_partial_week_short_name_sv) AS SELECT *
FROM ldl_p_lew_bil.v_cal_week_partial_week_1;