/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs_ac.v_lago_item_sub_actiongroup
#----------------------------------------------------------------------------
# History:
#  1.0  17.06.2021    Ross, Ulrich             Initial version
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_lago_item_sub_actiongroup (client_id, item_actiongroup_id,
item_sub_actiongroup_id, valid_from, valid_until, item_actiongroup_descr, item_sub_actiongroup_descr, language_id,
last_refresh, cs_updated, cs_created, cs_load_id) AS SELECT *
FROM ldl_p_lew_mart_cs.v_lago_item_sub_actiongroup AS I;