
/*
#-----------------------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#-----------------------------------------------------------------------------------------
# Interface: DDL for lew_mart_msi.v_itm_day_miss_item_wh_1
#-----------------------------------------------------------------------------------------
# History:
#  1.1  02.07.2024    Chetana Patil    SPEC0257149 ADO 639226 Add filter on Artikel_1-Status_1
#-----------------------------------------------------------------------------------------
*/
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_ITM_DAY_MISS_ITEM_WH_1

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT
     a.dwh_cal_dt                                                  AS dat_sys
   , a.client_id                                                   AS client_id
   , wh.src_wh_id                                                  AS wh_id_pp
   , CAST(1 AS BYTEINT)                                            AS aspect_id
   , itmp.item_sid_map                                             AS item_id
   , COALESCE(itmp.dwh_orig_item_nr, itmp.wawi_dwh_orig_item_nr)   AS orig_item_nr_pp
   FROM p_lew_core_ac.v_missing_item_wh_day_status_1 AS a
   INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh
   ON  a.client_id       = wh.client_id
   AND a.loc_sid         = wh.loc_sid_wh
   AND wh.dwh_actual_fg  = 1
   INNER JOIN p_lew_core_ac.v_item_map_key_1 AS itmp
   ON  a.client_id       = itmp.client_id
   AND a.item_sid        = itmp.item_sid
   
   LEFT OUTER JOIN p_lew_core_ac.v_wawi_itm_item_wh_1 itm
   ON         a.item_sid = itm.item_sid
   AND        a.client_id = itm.client_id
   AND        a.loc_sid = itm.wh_loc_sid
   AND        a.dwh_cal_dt BETWEEN itm.dat_rec_start AND itm.dat_rec_end
   
   WHERE itm.item_status IN (7,8)
   GROUP BY 1,2,3,5,6
;
