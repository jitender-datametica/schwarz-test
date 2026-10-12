/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.v_mat_lago_item_sub_actiongroup
#----------------------------------------------------------------------------
# History:
#  1.0  16.06.2021    Ross, Ulrich             Initial version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_cs.v_mat_lago_item_sub_actiongroup
(
client_id
,item_actiongroup_id
,item_sub_actiongroup_id
,valid_from
,valid_until
,item_actiongroup_descr
,item_sub_actiongroup_descr
,language_id
,src_id
,load_id
)
AS
SELECT 
client_id
,COALESCE(item_actiongroup_id, -1)
,COALESCE(item_sub_actiongroup_id, -1)
,valid_from
,valid_until
,COALESCE(item_actiongroup_descr, 'tdb')
,COALESCE(item_sub_actiongroup_descr, 'tdb')
,language_id
,src_id
,load_id
FROM p_lew_mart_cs.v_cs_item_sub_actiongroup
;