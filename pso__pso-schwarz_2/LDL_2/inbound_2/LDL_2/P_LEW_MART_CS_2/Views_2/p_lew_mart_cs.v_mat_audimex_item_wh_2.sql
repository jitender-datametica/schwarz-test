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
#  1.2  28.08.2020    Ulrich, Ross            Qualify statement zur eindeutigkeit des Datensatzes eingeführt und ItemStatus_2 einschraenken
#  1.3  02.09.2020    Ulrich, Ross            Qualify statement geändert, ItemStatus_2 kann mehrfachvorkommen, aber eingeschränkt auf höchste LOAD ID
#  1.4  21.09.2020    Ulrich, Ross            Filter entfernt i.item_status_id BETWEEN 6 AND 11
#  1.5  22.03.2021    Ulrich, Ross            Change deliver WH_ID from delivery_wh to sales_wh
#  1.6  06.08.2021    Ulrich, Ross            Change logic to select BEGES and VGES
#  1.7  24.02.2023    Ulrich, Ross            Add UNION to get Betriebsgesellschaften
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_CS.v_mat_audimex_item_wh_2
(
  client_id
, country_iso_cd
, wh_id
, orig_item_nr
, item_status_id
, case_size
, dwh_updated
, dwh_created
, dwh_load_id
)
AS

--Vertriebsgesellschaft
SELECT  
    erg.client_id
  , erg.country_iso_cd
  , erg.wh_id
  , erg.orig_item_nr
  , erg.item_status_id
  , erg.case_size
  , erg.dwh_updated
  , erg.dwh_created
  , erg.dwh_load_id
FROM
(
  SELECT  
      i.client_id
    , i.country_iso_cd
    , i.country_iso_cd || RIGHT('00' || CAST(sales_wh.src_orig_wh_nr AS VARCHAR(20)) || '.03', 6) AS wh_id
    , i.orig_item_nr
    , i.item_status_id
    , COALESCE(i.case_size,1) AS case_size
    , i.dwh_updated
    , i.dwh_created
    , i.dwh_load_id
  FROM p_lew_mart_cs.v_cs_item_wh_2 AS i
    
  INNER JOIN p_lew_core_ac.v_location_2 AS l  -- Ermittlung Betriebsgesellschaft
  ON i.client_id = l.client_id
    AND i.wh_id = l.src_orig_wh_nr
    AND l.wh_store_mark = 'B'
    
  INNER JOIN p_lew_core_ac.v_wawi_org_all_store_merge_act_2 AS bges -- Aktuelle Zuordnung der WH zu Store
  ON l.client_id = bges.client_id
    AND l.loc_sid = bges.wh_loc_sid
    AND bges.aspect_id = 1
    AND bges.mis_store_active_fg = 1

  INNER JOIN p_lew_core_ac.v_wawi_org_all_store_merge_act_2 AS vges --Ermittlung VGES WH loc_sid
  ON bges.client_id = vges.client_id
    AND bges.move_to_st_loc_sid = vges.move_to_st_loc_sid
    AND vges.aspect_id = 2
    AND vges.mis_store_active_fg = 1

  
  INNER JOIN p_lew_core_ac.v_location_2 AS sales_wh  -- Ermittlung Vertriebsgesellsschaft WH_ID
  ON vges.client_id = sales_wh.client_id
    AND vges.wh_loc_sid = sales_wh.loc_sid
    AND sales_wh.wh_store_mark = 'B'	  
    
  WHERE CURRENT_DATE - 1 BETWEEN i.dwh_valid_from AND i.dwh_valid_to
    AND i.orig_item_nr > 0
    AND i.case_size > 0
  GROUP BY i.client_id, i.country_iso_cd, sales_wh.src_orig_wh_nr, i.orig_item_nr, i.item_status_id, i.case_size,i.dwh_updated, i.dwh_created,i.dwh_load_id
    
  QUALIFY ROW_NUMBER () OVER (PARTITION BY i.client_id, sales_wh.src_orig_wh_nr, i.orig_item_nr, i.case_size, i.item_status_id ORDER BY i.dwh_load_id DESC) = 1
 
  ) AS erg
    
UNION
    
--Betriebsgesellschaft
SELECT  
    i.client_id
  , i.country_iso_cd
  , i.country_iso_cd || RIGHT('00' || CAST(l.src_orig_wh_nr AS VARCHAR(20)) || '.02', 6) AS wh_id
  , i.orig_item_nr
  , i.item_status_id
  , COALESCE(i.case_size,1) AS case_size
  , i.dwh_updated
  , i.dwh_created
  , i.dwh_load_id
FROM p_lew_mart_cs.v_cs_item_wh_2 AS i
  
INNER JOIN p_lew_core_ac.v_location_2 AS l  -- Ermittlung Betriebsgesellschaft
ON i.client_id = l.client_id
  AND i.wh_id = l.src_orig_wh_nr
  AND l.wh_store_mark = 'B'
      
WHERE CURRENT_DATE - 1 BETWEEN i.dwh_valid_from AND i.dwh_valid_to
  AND i.orig_item_nr > 0
  AND i.case_size > 0

GROUP BY i.client_id, i.country_iso_cd, l.src_orig_wh_nr, i.orig_item_nr, i.item_status_id, i.case_size,i.dwh_updated, i.dwh_created,i.dwh_load_id
  
QUALIFY ROW_NUMBER () OVER (PARTITION BY i.client_id, l.src_orig_wh_nr, i.orig_item_nr, i.case_size, i.item_status_id ORDER BY i.dwh_load_id DESC) = 1  
;