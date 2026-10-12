/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.V_ITEM_WH_MISSING_DELTA
#----------------------------------------------------------------------------
# History:
#  1.0  26.08.2021    Martin Murtenthaler        VTWG-334
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ITEM_WH_MISSING_DELTA COMMENT = 'Fehlartikel'
(
  client_id              COMMENT 'Landeskennzeichen'
 ,country_lidl_cd        COMMENT 'ISO-Code Land'
 ,wh_id                  COMMENT 'Warehouse'
 ,orig_item_nr           COMMENT 'Artikelnummer'
 ,dat_formdate           COMMENT 'Datum'
)
AS

SELECT 
  miss.client_id
 ,cli.src_country_lidl_cd
 ,loc.src_wh_id
 ,TRY_CAST(COALESCE(itm.src_orig_item_nr,itm.config_item_cd,itm.src_matnr) AS BIGINT)
 ,miss.dwh_cal_dt

FROM p_lew_core_ac.v_missing_item_wh_day_status miss

INNER JOIN p_lew_core_ac.v_location loc
ON loc.client_id=miss.client_id
AND loc.loc_sid=miss.loc_sid

INNER JOIN p_lew_core_ac.v_item itm
ON itm.client_id=miss.client_id
AND itm.item_sid=miss.item_sid

INNER JOIN p_lew_core_ac.v_item_hist ihist 
ON ihist.client_id=itm.client_id
AND ihist.item_sid=itm.item_sid
AND CURRENT_DATE BETWEEN ihist.dwh_valid_from AND ihist.dwh_valid_to

INNER JOIN p_lew_core_ac.v_item_familygroup_hist fam
ON fam.client_id=ihist.client_id
AND fam.item_fam_grp_sid=ihist.item_fam_grp_sid
AND CURRENT_DATE BETWEEN fam.dwh_valid_from AND fam.dwh_valid_to 

INNER JOIN p_lew_core_ac.v_subitemgroup_hist sub
ON sub.client_id=fam.client_id
AND sub.sub_item_grp_sid=fam.sub_item_grp_sid
AND CURRENT_DATE BETWEEN sub.dwh_valid_from AND sub.dwh_valid_to 

INNER JOIN p_lew_core_ac.v_itemgroup_international iint
ON iint.client_id=fam.client_id
AND iint.item_grp_int_sid=sub.item_grp_int_sid

INNER JOIN p_lew_core_ac.v_client cli
ON cli.client_id=miss.client_id

INNER JOIN
(
  SELECT
    expospecs.client_id
   ,expolast.last_export_tmsp
  FROM p_lew_process_ac.v_wfm_export_specification expospecs
  
  INNER JOIN p_lew_process_ac.v_wfm_last_export expolast
  ON expolast.export_specification=expospecs.export_specification
  AND expolast.process_name='export_wfm_item_wh_missing'
  AND expolast.process_specification='delta'
) expo
ON expo.client_id=miss.client_id
AND expo.last_export_tmsp<=miss.dwh_updated

WHERE CAST(TO_NUMBER(iint.src_itemgrp_int_cd) AS INTEGER) IN
(40  /*TiKo*/
,50  /*Kuehlung*/
,60  /*Food TS*/ 
,4   /*TiKo*/
,5   /*Kuehlung*/
,6   /*Food TS*/ 
)
AND miss.missing_status_cd IN ('f', 'g')
AND miss.missing_item_status_cd IN ('0', 'FEHLT')
AND CAST(miss.missing_status_end_tmsp AS DATE)>=miss.dwh_cal_dt
AND miss.dwh_cal_dt>=DATEADD('MONTH',-22,    DATEADD('MONTH',-2,CURRENT_DATE)  -  DAYOFYEAR( DATEADD('MONTH',-2,CURRENT_DATE))  +  1)

QUALIFY ROW_NUMBER() OVER (PARTITION BY miss.client_id, miss.dwh_cal_dt, TRY_CAST(COALESCE(itm.src_orig_item_nr,itm.config_item_cd,itm.src_matnr) AS BIGINT), loc.src_wh_id
                           ORDER BY miss.missing_status_end_tmsp DESC, miss.missing_status_cd, miss.item_sid DESC) = 1
;