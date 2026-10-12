/* #DescStart#
#$Revision: 7497 $, $LastChangedBy: cmarose $
#SubjectAreas#: Fehlartikel
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_bil.v_itm_pp_item AS -- LGORT konstant 100
 -- keine Variantennummer ausgeben

-- reason code, only the last code of the day
 -- temporary missing
 -- WGI, nicht für COEX_VIEW

-- SIG, nicht für COEX_VIEW
 -- aufbereitete Fehlartikel

-- ( Cast(changed_dat AS TIMESTAMP) + (changed_time - TO_VARCHAR( TIME '00:00:00', 'HH24:MM:SS')) ) AS timestamp_from_pp  -- changed_timestamp enthält Zeitzonen-Transformation, daher extra berechnet

-- Coalesce(Max(timestamp_from_pp) Over

-- (PARTITION BY client_id, item_missing_id ORDER BY item_missing_progress_id ROWS BETWEEN 1 Following AND 1 Following) - INTERVAL '1 second', -- timestamp_from_pp nächster Satz, abzgl. 1 Sek.

-- TO_TIMESTAMP('9999-12-31 00:00:00', 'YYYY/MM/DD HH:MI:SS')) AS timestamp_until_pp_calc  -- letzter Satz bis 31.12.9999 00:00:00

-- Endedatum zum Aufspannen über Kalender
 -- Referenz zur LookUp-Tabelle

-- Referenz zur Artikelhierarchie (SIG ==> WGI)
 -- Referenz zum WH-Item

-- Fehlartikel-Grund, zur Zeit nicht berücksichtigt / NULL
 SELECT DISTINCT CAST(mi.client_id AS BIGNUMERIC) AS
 client_id,
 WH.loc_sid AS loc_sid_wh_pp,
 100 AS picking_area_nr_pp,
  CASE
  WHEN CAST(COALESCE(H.src_orig_item_nr, H.src_matnr) AS FLOAT64) >= 100000000
  THEN ROUND(CAST(CAST(COALESCE(H.src_orig_item_nr, H.src_matnr) AS FLOAT64) / 1000 AS BIGNUMERIC), 0)
  ELSE ROUND(CAST(COALESCE(H.src_orig_item_nr, H.src_matnr) AS BIGNUMERIC), 0)
  END AS orig_item_nr_pp,
 ROUND(CAST(umg.conv_to_base_numerator AS BIGNUMERIC), 0) AS case_size_pp,
 CAST(L.item_sid AS BIGNUMERIC) AS item_id,
 mi.timestamp_from_pp,
 mi.timestamp_until_pp,
 CAL.cal_dt AS dat_sys,
 R.mis_end_cd_pp AS end_cd_pp,
 R.mis_item_missing_reason_cd AS item_status_pp,
 CAST(CASE
   WHEN CAL.cal_dt = mi.changed_dat_next
   THEN CASE
    WHEN R.mis_end_cd_pp IN ('g', 'f') AND R.mis_item_missing_reason_cd IN ('FEHLT', '0')
    THEN 1
    ELSE 0
    END
   ELSE 0
   END AS BIGNUMERIC) AS temporary_missing_fg,
  CASE
  WHEN (MAX(mi.timestamp_until_pp) OVER (PARTITION BY CAST(mi.client_id AS STRING), CAST(WH.loc_sid AS STRING), CAST(L.item_sid AS STRING)
       , CAL.cal_dt RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = mi.timestamp_until_pp
  THEN mi.missing_reason_cd
  ELSE NULL
  END AS missing_reason_cd
FROM (SELECT client_id,
   item_missing_id -- itm_missing_nr
,
   item_missing_progress_id -- itm_missing_pos
,
   missing_state_cd -- itm_missing_state
,
   missing_reason_cd -- itm_missing_reason_cd
,
   DATE(change_dttm) AS changed_dat,
   CAST(change_dttm AS TIME) AS changed_time,
   DATETIME(DATE(change_dttm), CAST(change_dttm AS TIME)) AS timestamp_from_pp,
   COALESCE(DATETIME_ADD(MAX(DATETIME(DATE(change_dttm), CAST(change_dttm AS TIME))) OVER (PARTITION BY CAST(client_id AS STRING)
        , CAST(item_missing_id AS STRING) ORDER BY item_missing_progress_id IS NULL, item_missing_progress_id
      ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING), INTERVAL - 1 SECOND), CAST('9999-12-31 00:00:00' AS DATETIME)) AS
   timestamp_until_pp_calc,
    CASE
    WHEN DATETIME(DATE(change_dttm), CAST(change_dttm AS TIME)) < COALESCE(DATETIME_ADD(MAX(DATETIME(DATE(change_dttm), CAST(change_dttm AS TIME)
         )) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_missing_id AS STRING) ORDER BY
          item_missing_progress_id IS NULL, item_missing_progress_id ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING), INTERVAL
       - 1 SECOND), CAST('9999-12-31 00:00:00' AS DATETIME))
    THEN COALESCE(DATETIME_ADD(MAX(DATETIME(DATE(change_dttm), CAST(change_dttm AS TIME))) OVER (PARTITION BY CAST(client_id AS STRING)
         , CAST(item_missing_id AS STRING) ORDER BY item_missing_progress_id IS NULL, item_missing_progress_id
       ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING), INTERVAL - 1 SECOND), CAST('9999-12-31 00:00:00' AS DATETIME))
    ELSE DATETIME(DATE(change_dttm), CAST(change_dttm AS TIME))
    END AS timestamp_until_pp,
   DATE(CASE
     WHEN DATETIME(DATE(change_dttm), CAST(change_dttm AS TIME)) < COALESCE(DATETIME_ADD(MAX(DATETIME(DATE(change_dttm)
          , CAST(change_dttm AS TIME))) OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_missing_id AS STRING)
         ORDER BY item_missing_progress_id IS NULL, item_missing_progress_id ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING),
        INTERVAL - 1 SECOND), CAST('9999-12-31 00:00:00' AS DATETIME))
     THEN COALESCE(DATETIME_ADD(MAX(DATETIME(DATE(change_dttm), CAST(change_dttm AS TIME))) OVER (PARTITION BY CAST(client_id AS STRING)
          , CAST(item_missing_id AS STRING) ORDER BY item_missing_progress_id IS NULL, item_missing_progress_id
        ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING), INTERVAL - 1 SECOND), CAST('9999-12-31 00:00:00' AS DATETIME))
     ELSE DATETIME(DATE(change_dttm), CAST(change_dttm AS TIME))
     END) AS changed_dat_next
  FROM ldl_p_lew_core_ac.v_item_missing_progress) AS mi
 INNER JOIN ldl_p_lew_core_ac.v_item_missing AS L ON mi.client_id = L.client_id AND mi.item_missing_id
   -- Ermittlung der loc_sid der Betriebsgesellschaften
 = L.item_missing_id
 INNER JOIN ldl_p_lew_core_ac.v_location AS WH ON L.client_id = WH.client_id AND L.loc_sid = WH.loc_sid AND LOWER(WH.wh_store_label
    ) = 'warehouse' -- Referenz zum Item

 INNER JOIN ldl_p_lew_core_ac.v_item AS H ON L.client_id = H.client_id AND L.item_sid
   -- deaktiviert AND TO_NUMBER(h.itm_id) IS NOT NULL  -- nur migriere Artikel (numerisch) berücksichigen

   -- Ermittlung der korrekten case_size
 = H.item_sid
 LEFT JOIN (SELECT UM.client_id,
   UM.item_sid,
   UM.log_var_cd,
   MIN(UMH.conv_to_base_numerator) AS conv_to_base_numerator
  FROM ldl_p_lew_core_ac.v_item_unit_of_measurement AS UM
   INNER JOIN ldl_p_lew_core_ac.v_item_unit_of_measurement_hist AS UMH ON UM.client_id = UMH.client_id AND UM.item_sid =
        UMH.item_sid AND UM.uom_sid = UMH.uom_sid AND CURRENT_DATE BETWEEN UMH.dwh_valid_from AND UMH.dwh_valid_to AND
     UMH.deleted_fg = 0
  WHERE UM.log_var_cd IS NOT NULL
  GROUP BY UM.client_id,
   UM.item_sid,
   UM.log_var_cd) AS umg ON H.client_id = umg.client_id AND H.item_sid = umg.item_sid AND H.log_var_cd = umg.log_var_cd
  AND (H.log_var_cd <> '1' OR H.config_item_cd IS NOT NULL)
 INNER JOIN ldl_p_lew_bil.v_item_hierarchy AS SIG ON L.item_sid = SIG.item_sid AND L.client_id
   -- Aufspannen über Kalender, maximal bis CURRENT_DATE
 = SIG.client_id
 INNER JOIN ldl_p_lew_core_ac.v_cal_calendarday AS CAL ON CAL.cal_dt BETWEEN mi.changed_dat AND mi.changed_dat_next AND
   CAL.cal_dt <= CURRENT_DATE
 INNER JOIN ldl_p_lew_core_ac.v_item_info_per_location_hist AS ILH ON L.loc_sid = ILH.loc_sid AND L.item_sid = ILH.item_sid
     AND CAL.cal_dt BETWEEN ILH.dwh_valid_from AND ILH.dwh_valid_to
   -- asis-Sicht: aktueller Status am Tag des Ausweises des Fehlartikels, nicht zum Anlage-Zeitpunkt changed_dat

   -- Mapping Fehlartikel-Status SAP zu WAWI

 INNER JOIN ldl_p_lew_core_ac.v_map_mis_item_missing_status AS R ON mi.client_id = R.client_id AND ILH.item_status_cd
     -- SAP-Artikel-Status im WH
 = R.item_status_cd AND mi.missing_state_cd -- SAP-Fehlartikel-Status
 = R.missing_state_cd
     AND (R.missing_reason_cd IS NULL OR mi.missing_reason_cd = R.missing_reason_cd)
WHERE mi.missing_state_cd <> 'b' -- keine Fehlartikel mit "Artikelstatus beendet"

  -- keine Fehlartikel mit "Artikelstatus beendet"
;