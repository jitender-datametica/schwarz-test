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
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   View DDL
   ============================================================================== */


CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.v_store_open_ldpl_mth_1
COMMENT = 'Precalculated Lidl Plus KPIs'
(
client_id
,cy_month
,move_to_store_id
,store_id
,aspect_id
,cm_mth_str_open_fg
,pm_mth_str_open_fg
,pym_mth_str_open_fg
)
AS  
SELECT
client_id
,cy_month
,move_to_store_id
,store_id
,aspect_id
,cm_mth_str_open_fg
,pm_mth_str_open_fg
,pym_mth_str_open_fg
FROM P_LEW_MART_LIDL_DIGITAL.v_store_open_ldpl_mth_1
;


