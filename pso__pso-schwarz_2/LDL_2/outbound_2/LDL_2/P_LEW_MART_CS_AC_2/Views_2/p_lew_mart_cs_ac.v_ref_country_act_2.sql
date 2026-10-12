/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_CS_ITEM_2
#----------------------------------------------------------------------------
# History:
#  1.0  01.10.2021    Ross, Ulrich               Transfer from MART_TDB_AC to MART_CS_AC.
#                                                Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_ref_country_act_2 (int_id, country_id, country_iso_cd, cluster_id,
sorting_order, country_desc, language_id, dashboard_relevant_fg) AS SELECT *
FROM ldl_p_lew_mart_cs.v_ref_country_act_2;