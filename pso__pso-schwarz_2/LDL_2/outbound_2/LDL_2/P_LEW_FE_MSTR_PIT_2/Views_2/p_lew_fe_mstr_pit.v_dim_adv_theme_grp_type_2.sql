/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for DIM_ADV_THEME_GRP_TYPE
#-------------------------------------------------------------------------------
# Describtion: Create View for Calendar_2 Table
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0	2023-06-26 Nikolai Toknov	INT/NAT. Release v.5.15. AP0100400_BS0011293_PIT_REPORTING_ADV_THEMA_NAT/INT - Promotion Impact Tracker - IT-Documentation (itdoc.schwarz) 
#-------------------------------------------------------------------------------
*/

/* 
---------------------------------------------------------------------
Create Access View <DB_NAME>.<SCHEMA>.V_<TABLENAME> Current Status_2
------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_fe_mstr_pit.v_dim_adv_theme_grp_type_2
OPTIONS(DESCRIPTION = `VIEW DIMENSION ACTION TYPE`) AS SELECT theme_grp_type_id,
 fe_mstr_relevant_fg,
 theme_grp_type_sort_val,
 theme_grp_type_name,
 theme_grp_type_descr,
 valid_from_dt,
 valid_to_dt,
 version_nr,
 current_fg,
 reject_fg,
 reject_reason_id,
 deleted_fg,
 dwh_created_ts,
 dwh_updated_ts,
 load_id
FROM ldl_p_lew_mart_pit.t_dim_adv_theme_grp_type_2 AS TYP
WHERE deleted_fg = 0
 AND reject_fg = 0
 AND current_fg = 1
QUALIFY version_nr = (MAX(version_nr) OVER (PARTITION BY theme_grp_type_id RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING));