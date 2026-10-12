/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------
# Interface: 20180801_1778_LidlPlus_KPIs
#            1:1 DDL
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-00-10 Marcin Kikola           Initial version
#                                         20201008_2610_OpenStoreViews
#  1.1 2020-11-16 Pawel Wieczorek         add column store_id SD-1508
#
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   Object DDL
   ============================================================================== */


CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.v_store_open_ldpl_wk_1
COMMENT = 'Precalculated Lidl Plus KPIs'
(
client_id
,cy_week
,move_to_store_id
,store_id
,aspect_id
,cw_wk_str_open_fg
,pw_wk_str_open_fg
,pyw_wk_str_open_fg
)
AS 
SELECT
client_id
,cy_week
,move_to_store_id
,store_id
,aspect_id
,cw_wk_str_open_fg
,pw_wk_str_open_fg
,pyw_wk_str_open_fg
FROM P_LEW_MART_LIDL_DIGITAL.v_store_open_ldpl_wk_1
;


