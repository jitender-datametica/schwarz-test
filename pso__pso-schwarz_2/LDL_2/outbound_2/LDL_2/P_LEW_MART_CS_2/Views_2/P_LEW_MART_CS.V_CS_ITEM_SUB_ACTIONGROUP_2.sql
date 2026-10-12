/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.v_cs_item_sub_actiongroup_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.06.2021    Ulrich Ross                  Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_cs_item_sub_actiongroup_2 (client_id, item_actiongroup_id,
item_sub_actiongroup_id, valid_from, valid_until, item_actiongroup_descr, item_sub_actiongroup_descr, language_id,
src_id, load_id) AS SELECT client_id,
 item_actiongroup_id,
 item_sub_actiongroup_id,
 dat_rec_start AS valid_from,
 dat_rec_end AS valid_until,
 item_actgroup_desc AS item_actiongroup_descr,
 item_sub_actgroup_desc AS item_sub_actiongroup_descr,
 language_id,
 1 AS src_id,
 load_id
FROM ldl_p_lew_core_ac.v_wawi_itm_actiongroup_desc_2
WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end;