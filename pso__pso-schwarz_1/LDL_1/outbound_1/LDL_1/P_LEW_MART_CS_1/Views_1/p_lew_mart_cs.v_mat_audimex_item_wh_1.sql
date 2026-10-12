/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_cs_v_mat_audimex_item_wh.sql 15920 2020-09-21 07:06:55Z uross $
# $Revision: 15920 $
# $LastChangedBy: uross $
# $LastChangedDate: 2020-09-21 09:06:55 +0200 (Mon, 21 Sep 2020) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_cs/lew_mart_cs_v_mat_audimex_item_wh.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  14.08.2020    Ulrich, Ross            First Version
#  1.1  19.08.2020    Ulrich, Ross            comma at the beginning of line
#  1.2  28.08.2020    Ulrich, Ross            Qualify statement zur eindeutigkeit des Datensatzes eingeführt und ItemStatus_1 einschraenken
#  1.3  02.09.2020    Ulrich, Ross            Qualify statement geändert, ItemStatus_1 kann mehrfachvorkommen, aber eingeschränkt auf höchste LOAD ID
#  1.4  21.09.2020    Ulrich, Ross            Filter entfernt i.item_status_id BETWEEN 6 AND 11
#  1.5  22.03.2021    Ulrich, Ross            Change deliver WH_ID from delivery_wh to sales_wh
#  1.6  06.08.2021    Ulrich, Ross            Change logic to select BEGES and VGES
#  1.7  24.02.2023    Ulrich, Ross            Add UNION to get Betriebsgesellschaften
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
*/


-- Aktuelle Zuordnung der WH zu Store
 -- Betriebsgesellschaft
 -- Ermittlung Vertriebsgesellsschaft WH_ID

-- Ermittlung Betriebsgesellschaft
 -- Ermittlung Betriebsgesellschaft
 -- Ermittlung VGES WH loc_sid

-- Vertriebsgesellschaft
 CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_audimex_item_wh_1 (client_id, country_iso_cd,
wh_id, orig_item_nr, item_status_id, case_size, dwh_updated, dwh_created, dwh_load_id) AS SELECT t1.client_id,
 t1.country_iso_cd,
  t1.country_iso_cd || RIGHT('00' || CAST(t1.src_orig_wh_nr0 AS STRING) || '.03', 6) AS wh_id,
 t1.orig_item_nr,
 t1.item_status_id,
 COALESCE(t1.case_size, 1) AS case_size,
 t1.dwh_updated,
 t1.dwh_created,
 t1.dwh_load_id
FROM (SELECT I.client_id,
   I.orig_item_nr,
   I.case_size,
   I.country_iso_cd,
   I.item_status_id,
   I.dwh_updated,
   I.dwh_created,
   I.dwh_load_id,
   SALES_WH.src_orig_wh_nr AS src_orig_wh_nr0
  FROM ldl_p_lew_mart_cs.v_cs_item_wh_1 AS I
   INNER JOIN ldl_p_lew_core_ac.v_location_1 AS L ON I.client_id = L.client_id AND I.wh_id = L.src_orig_wh_nr AND L.wh_store_mark
      = 'B'
   INNER JOIN ldl_p_lew_core_ac.v_wawi_org_all_store_merge_act_1 AS BGES ON L.client_id = BGES.client_id AND L.loc_sid =
       BGES.wh_loc_sid AND BGES.aspect_id = 1 AND BGES.mis_store_active_fg = 1
   INNER JOIN ldl_p_lew_core_ac.v_wawi_org_all_store_merge_act_1 AS VGES ON BGES.client_id = VGES.client_id AND BGES.move_to_st_loc_sid
        = VGES.move_to_st_loc_sid AND VGES.aspect_id = 2 AND VGES.mis_store_active_fg = 1
   INNER JOIN ldl_p_lew_core_ac.v_location_1 AS SALES_WH ON VGES.client_id = SALES_WH.client_id AND VGES.wh_loc_sid =
      SALES_WH.loc_sid AND SALES_WH.wh_store_mark = 'B'
  WHERE DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN I.dwh_valid_from AND I.dwh_valid_to
   AND I.orig_item_nr > 0
   AND I.case_size > 0
  GROUP BY I.client_id,
   I.orig_item_nr,
   I.case_size,
   I.country_iso_cd,
   I.item_status_id,
   I.dwh_updated,
   I.dwh_created,
   I.dwh_load_id,
   SALES_WH.src_orig_wh_nr
  QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(I.client_id AS STRING), CAST(src_orig_wh_nr0 AS STRING), I.orig_item_nr
        , CAST(I.case_size AS STRING), CAST(I.item_status_id AS STRING) ORDER BY I.dwh_load_id IS NULL DESC, I.dwh_load_id
        DESC)) = 1) AS t1_1
UNION DISTINCT
SELECT I.client_id,
 I.country_iso_cd,
  I.country_iso_cd || RIGHT('00' || CAST(L.src_orig_wh_nr AS STRING) || '.02', 6) AS wh_id,
 I.orig_item_nr,
 I.item_status_id,
 COALESCE(I.case_size, 1) AS case_size,
 I.dwh_updated,
 I.dwh_created,
 I.dwh_load_id
FROM ldl_p_lew_mart_cs.v_cs_item_wh_1 AS I
 INNER JOIN ldl_p_lew_core_ac.v_location_1 AS L ON I.client_id = L.client_id AND I.wh_id = L.src_orig_wh_nr AND L.wh_store_mark
    = 'B'
WHERE DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY) BETWEEN I.dwh_valid_from AND I.dwh_valid_to
 AND I.orig_item_nr > 0
 AND I.case_size > 0
GROUP BY I.client_id,
 I.orig_item_nr,
 I.case_size,
 I.country_iso_cd,
 I.item_status_id,
 I.dwh_updated,
 I.dwh_created,
 I.dwh_load_id,
 L.src_orig_wh_nr
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(I.client_id AS STRING), CAST(L.src_orig_wh_nr AS STRING), I.orig_item_nr, CAST(I.case_size AS STRING)
      , CAST(I.item_status_id AS STRING) ORDER BY I.dwh_load_id IS NULL DESC, I.dwh_load_id DESC)) = 1;