
/*
#-----------------------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------------------
# Interface: DDL for lew_mart_msi.v_itm_miss_item_wh_detail_1
#-----------------------------------------------------------------------------------------
# History:
#  1.1  02.07.2024    Chetana Patil    SPEC0257149 ADO 639226 Add filter on Artikel_1-Status_1
#-----------------------------------------------------------------------------------------
*/
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_MISS_ITEM_WH_DETAIL_1

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT
     a.dwh_cal_dt                                                 AS dat_sys
   , a.client_id                                                  AS client_id
   , itmp.item_sid_map                                            AS item_id
   , COALESCE(itmp.dwh_orig_item_nr, itmp.wawi_dwh_orig_item_nr)  AS orig_item_nr_pp
   , wh.src_wh_id                                                 AS wh_id_pp
   , a.missing_status_cd                       AS end_cd_pp
   , CAST(1 AS BYTEINT)                                           AS aspect_id
   , a.temp_missing_fg                                            AS temp_miss_fg
   , a.missing_reason_cd                                          AS missing_reason_cd
   , b.missing_reason_descr                                       AS missing_reason_desc
   FROM p_lew_core_ac.v_missing_item_wh_day_status_1 AS a
   LEFT OUTER JOIN
   (   /* Reference logic for missing reasons */SELECT
     client_id
   , CAST(code AS SMALLINT)    AS missing_reason_cd
   , description               AS missing_reason_descr
   FROM p_lew_core_ac.v_wawi_ref_description_1
      WHERE desc_type = 'T178'
      AND client_id = language_id
  ) AS b
   ON  a.client_id          = b.client_id
   AND a.missing_reason_cd  = b.missing_reason_cd
   INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh
   ON  wh.client_id         = a.client_id
   AND wh.loc_sid_wh        = a.loc_sid
   AND wh.dwh_actual_fg     = 1
   INNER JOIN p_lew_core_ac.v_item_map_key_1 AS itmp
   ON  itmp.client_id       = a.client_id
   AND itmp.item_sid        = a.item_sid
   
   LEFT OUTER JOIN p_lew_core_ac.v_wawi_itm_item_wh_1 itm
   ON  a.item_sid = itm.item_sid
   AND a.client_id = itm.client_id
   AND a.loc_sid = itm.wh_loc_sid
   AND a.dwh_cal_dt BETWEEN itm.dat_rec_start AND itm.dat_rec_end
    
   WHERE a.missing_status_cd IN ('f', 'g')
   AND a.missing_item_status_cd IN ('0', 'FEHLT')
   AND itm.item_status IN (7,8)
   AND CAST(a.missing_status_end_tmsp AS DATE) >= a.dwh_cal_dt
   QUALIFY ROW_NUMBER() OVER (PARTITION BY dat_sys, a.client_id, orig_item_nr_pp, wh_id_pp
   ORDER BY a.missing_status_end_tmsp DESC NULLS LAST, a.item_sid DESC NULLS LAST) = 1
   ;
