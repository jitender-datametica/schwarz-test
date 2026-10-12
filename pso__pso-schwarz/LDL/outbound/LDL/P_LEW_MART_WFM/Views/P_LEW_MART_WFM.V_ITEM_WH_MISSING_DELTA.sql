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




CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_item_wh_missing_delta (client_id OPTIONS(description='Landeskennzeichen'),
country_lidl_cd OPTIONS(description='ISO-Code Land'), wh_id OPTIONS(description='Warehouse'), orig_item_nr
OPTIONS(description='Artikelnummer'), dat_formdate OPTIONS(description='Datum')) OPTIONS(DESCRIPTION = `FEHLARTIKEL`) AS
SELECT MISS.client_id,
 CLI.src_country_lidl_cd AS country_lidl_cd,
 LOC.src_wh_id AS wh_id,
 ROUND(SAFE_CAST(COALESCE(ITM.src_orig_item_nr, ITM.config_item_cd, ITM.src_matnr) AS BIGNUMERIC), 0) AS orig_item_nr,
 MISS.dwh_cal_dt AS dat_formdate
FROM ldl_p_lew_core_ac.v_missing_item_wh_day_status AS MISS
 INNER JOIN ldl_p_lew_core_ac.v_location AS LOC ON MISS.client_id = LOC.client_id AND MISS.loc_sid = LOC.loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_item AS ITM ON MISS.client_id = ITM.client_id AND MISS.item_sid = ITM.item_sid
 INNER JOIN ldl_p_lew_core_ac.v_item_hist AS IHIST ON ITM.client_id = IHIST.client_id AND ITM.item_sid = IHIST.item_sid
  AND CURRENT_DATE BETWEEN IHIST.dwh_valid_from AND IHIST.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_item_familygroup_hist AS FAM ON IHIST.client_id = FAM.client_id AND IHIST.item_fam_grp_sid
     = FAM.item_fam_grp_sid AND CURRENT_DATE BETWEEN FAM.dwh_valid_from AND FAM.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_hist AS SUB ON FAM.client_id = SUB.client_id AND FAM.sub_item_grp_sid = SUB
    .sub_item_grp_sid AND CURRENT_DATE BETWEEN SUB.dwh_valid_from AND SUB.dwh_valid_to
 INNER JOIN ldl_p_lew_core_ac.v_itemgroup_international AS IINT ON FAM.client_id = IINT.client_id AND SUB.item_grp_int_sid
    = IINT.item_grp_int_sid
 INNER JOIN ldl_p_lew_core_ac.v_client AS CLI ON MISS.client_id = CLI.client_id
 INNER JOIN (SELECT EXPOSPECS.client_id,
   EXPOLAST.last_export_tmsp
  FROM ldl_p_lew_process_ac.v_wfm_export_specification AS EXPOSPECS
   INNER JOIN ldl_p_lew_process_ac.v_wfm_last_export AS EXPOLAST ON EXPOSPECS.export_specification = EXPOLAST.export_specification
       AND EXPOLAST.process_name = 'export_wfm_item_wh_missing' AND EXPOLAST.process_specification = 'delta') AS expo ON
   MISS.client_id = expo.client_id AND MISS.dwh_updated >= expo.last_export_tmsp
WHERE CAST(ROUND(CAST(IINT.src_itemgrp_int_cd AS BIGNUMERIC), 0) AS BIGNUMERIC) IN (40 /* TiKo */, 50 /* Kuehlung */, 60
   /* Food TS */, 4 /* TiKo */, 5 /* Kuehlung */, 6 /* Food TS */)
 AND MISS.missing_status_cd IN ('f', 'g')
 AND MISS.missing_item_status_cd IN ('0', 'FEHLT')
 AND DATE(MISS.missing_status_end_tmsp) >= MISS.dwh_cal_dt
 AND MISS.dwh_cal_dt >= date_sub(date_add(date_sub(date_sub(current_date(), interval 2 MONTH), interval extract(DAYOFYEAR from date_sub(current_date(), interval 2 MONTH)) DAY), interval 1 DAY), interval 22 MONTH)
 
  
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(MISS.client_id AS STRING), dat_formdate, CAST(orig_item_nr AS STRING), CAST(wh_id AS STRING)
      ORDER BY MISS.missing_status_end_tmsp IS NULL DESC, MISS.missing_status_end_tmsp DESC, MISS.missing_status_cd
      IS NULL, MISS.missing_status_cd, MISS.item_sid IS NULL DESC, MISS.item_sid DESC)) = 1;



