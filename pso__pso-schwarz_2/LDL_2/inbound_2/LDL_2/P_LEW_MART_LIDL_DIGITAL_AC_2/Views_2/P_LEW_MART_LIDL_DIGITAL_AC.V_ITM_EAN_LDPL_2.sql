/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: 20180801_1778_LidlPlus_KPIs
#            1:1 DDL
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#
#  Vrs Date        Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2023-04-27  Marcin Kikola          Initial version
#                                         AP0133752 - creation of EAN_2 logic for Article hierarchy_2 in LP project
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   Object DDL
   ============================================================================== */




CREATE OR REPLACE VIEW P_LEW_MART_LIDL_DIGITAL_AC.V_ITM_EAN_LDPL_2 
COMMENT = 'LIDLPLUS : ITEAM EAN_2 DESCRIPTION VIEW ON THE BASIS OF V_WAWI_ITM_EAN_2'
( 
CLIENT_ID
,ITEM_SID
,EAN_BARCODE
,EAN_BARCODE_DESC

)
AS
SELECT
 CLIENT_ID
,ITEM_SID
,EAN_2::VARCHAR(100) COLLATE '' AS EAN_2
,EAN_ITEM_DESC
FROM P_LEW_CORE_AC.V_WAWI_ITM_EAN_2 
WHERE DAT_REC_END = '9999-12-31'::DATE 
AND LANGUAGE_ID=7;