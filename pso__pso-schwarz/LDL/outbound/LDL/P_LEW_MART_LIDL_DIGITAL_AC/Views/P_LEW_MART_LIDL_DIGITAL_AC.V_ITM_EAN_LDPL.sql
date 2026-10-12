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
#                                         AP0133752 - creation of EAN logic for Article hierarchy in LP project
#----------------------------------------------------------------------------
*/



/* ==============================================================================
   Object DDL
   ============================================================================== */


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_itm_ean_ldpl (client_id, item_sid, ean_barcode, ean_barcode_desc
) OPTIONS(DESCRIPTION = `LIDLPLUS : ITEAM EAN DESCRIPTION VIEW ON THE BASIS OF V_WAWI_ITM_EAN`) AS SELECT client_id,
 item_sid,
 CAST(ean AS STRING) AS ean,
 ean_item_desc AS ean_barcode_desc
FROM ldl_p_lew_core_ac.v_wawi_itm_ean
WHERE dat_rec_end = DATE('9999-12-31')
 AND language_id = 7;