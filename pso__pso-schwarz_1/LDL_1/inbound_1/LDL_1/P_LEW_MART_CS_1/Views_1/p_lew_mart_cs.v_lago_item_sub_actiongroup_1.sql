/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS.v_lago_item_sub_actiongroup_1
#----------------------------------------------------------------------------
# History:
#  1.0  17.06.2021    Ross, Ulrich             Initial version
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_cs.v_lago_item_sub_actiongroup_1
(
  client_id
  ,item_actiongroup_id
  ,item_sub_actiongroup_id
  ,valid_from
  ,valid_until
  ,item_actiongroup_descr
  ,item_sub_actiongroup_descr
  ,language_id
  ,last_refresh
  ,cs_updated 
  ,cs_created
  ,cs_load_id
)
AS
SELECT
   i.client_id
  ,i.item_actiongroup_id
  ,i.item_sub_actiongroup_id
  ,i.valid_from
  ,i.valid_until
  ,i.item_actiongroup_descr
  ,i.item_sub_actiongroup_descr
  ,i.language_id
  ,i.last_refresh
  ,i.cs_updated 
  ,i.cs_created
  ,i.cs_load_id
FROM p_lew_mart_cs.t_lago_item_sub_actiongroup_1 AS i   
;