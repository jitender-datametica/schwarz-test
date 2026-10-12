/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_QV_OPEN_STORES
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-09-30 Rodrigo Cione           Table added to be used for filtering in FE
#                                         20200930_2603_Add_obj_QV_Dummy_Recs
#  2.0 2021-04-09 Tris Bayliff            Transfer to Snowflake
#                                         https://jira.schwarz/browse/REP2-9207
#
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_QV_OPEN_STORES COMMENT = 'QuickView view : Open stores to use for filtering in Front End'
(
  client_id
, move_to_store_id
, aspect_id
, sales_manager_id
, account_manager_id
, wh_id
, wh_id_exp
, qv_open_store_flag
)
AS
SELECT
  client_id
, move_to_store_id
, aspect_id
, sales_manager_id
, account_manager_id
, wh_id
, wh_id_exp
, qv_open_store_flag
FROM P_LEW_MART_LEAD.V_QV_OPEN_STORES
;
