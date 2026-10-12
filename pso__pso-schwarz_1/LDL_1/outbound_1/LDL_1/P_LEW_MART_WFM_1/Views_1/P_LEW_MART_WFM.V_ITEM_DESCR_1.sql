/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_ITEM_DESCR_1
#----------------------------------------------------------------------------
# History:
#  1.0  2024-02-20    Camila Arango         Remove eLWIS logic
#                                          
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_item_descr_1 AS SELECT country_iso_cd AS country_lidl_cd,
 CAST(orig_item_nr AS BIGNUMERIC) AS derived_item_nr,
 item_desc AS item_descr,
 language_id
FROM (SELECT CNTRY.country_iso_cd,
   ITM_DESCR.orig_item_nr,
   COALESCE(ITM_DESCR.item_desc, 'undefined') AS item_desc,
   ITM_DESCR.language_id,
   ITM_ITEM.dat_valid_from
  FROM ldl_p_lew_core_ac.v_wawi_itm_item_desc_1 AS ITM_DESCR
   INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_wh_1 AS ITM_WH ON ITM_DESCR.client_id = ITM_WH.client_id AND ITM_DESCR.item_sid
        = ITM_WH.item_sid AND CURRENT_DATE BETWEEN ITM_WH.dat_rec_start AND ITM_WH.dat_rec_end AND ITM_WH.item_status
     BETWEEN 5 AND 13
   INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_1 AS ITM_ITEM ON ITM_WH.client_id = ITM_ITEM.client_id AND ITM_WH.item_sid
       = ITM_ITEM.item_sid AND CURRENT_DATE BETWEEN ITM_ITEM.dat_rec_start AND ITM_ITEM.dat_rec_end
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_country_1 AS CLIENT_CNTRY ON ITM_DESCR.client_id = CLIENT_CNTRY.client_id
    
   INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_country_1 AS CNTRY ON CLIENT_CNTRY.country_id = CNTRY.country_id
   INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_1 AS MIG ON ITM_DESCR.client_id = MIG.client_id
  WHERE CURRENT_DATE BETWEEN ITM_DESCR.dat_rec_start AND ITM_DESCR.dat_rec_end
   AND (CURRENT_DATE < MIG.migration_dat_valid_from OR CURRENT_DATE > MIG.migration_dat_valid_to)
  GROUP BY CNTRY.country_iso_cd,
   ITM_DESCR.orig_item_nr,
   item_desc,
   ITM_DESCR.language_id,
   ITM_ITEM.dat_valid_from
  QUALIFY ITM_ITEM.dat_valid_from = (MAX(ITM_ITEM.dat_valid_from) OVER (PARTITION BY CNTRY.country_iso_cd, ITM_DESCR.orig_item_nr
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS t2
QUALIFY (ROW_NUMBER() OVER (PARTITION BY country_iso_cd, orig_item_nr, CAST(language_id AS STRING) ORDER BY COALESCE(item_desc
       , 'undefined') IS NULL, COALESCE(item_desc, 'undefined'))) = 1;