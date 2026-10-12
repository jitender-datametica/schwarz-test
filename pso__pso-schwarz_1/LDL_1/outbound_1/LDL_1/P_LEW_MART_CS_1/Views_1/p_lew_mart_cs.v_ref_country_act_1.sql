/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_CS_ITEM_1
#----------------------------------------------------------------------------
# History:
#  1.0  01.10.2021    Ross, Ulrich               Transfer from MART_TDB to MART_CS.
#                                                Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_ref_country_act_1 (int_id, country_id, country_iso_cd, cluster_id,
sorting_order, country_desc, language_id, dashboard_relevant_fg) AS SELECT *
FROM ldl_p_lew_core_ac.v_wawi_ref_country_act_1;