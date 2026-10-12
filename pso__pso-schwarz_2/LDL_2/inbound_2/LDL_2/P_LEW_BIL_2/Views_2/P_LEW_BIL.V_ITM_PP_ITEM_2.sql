CREATE OR REPLACE VIEW P_LEW_BIL.V_ITM_PP_ITEM_2
AS
/*
#DescStart#
#$Revision: 7497 $, $LastChangedBy: cmarose $
#SubjectAreas#: Fehlartikel
#DescEnd#
*/
SELECT DISTINCT
client_id,
loc_sid_wh_pp,
picking_area_nr_pp,
orig_item_nr_pp,
case_size_pp,
item_id,
timestamp_from_pp,
timestamp_until_pp,
dat_sys,
end_cd_pp,
item_status_pp,
temporary_missing_fg,
missing_reason_cd
FROM
(SELECT
Cast(mi.client_id AS SMALLINT)                      AS client_id,
wh.loc_sid                                          AS loc_sid_wh_pp,
CAST(100 AS SMALLINT)                               AS picking_area_nr_pp -- LGORT konstant 100
,
CASE
        WHEN Coalesce(h.src_orig_item_nr, h.src_matnr) >= 100000000
        THEN Cast(Coalesce(h.src_orig_item_nr, h.src_matnr) / 1000 AS INTEGER) -- keine Variantennummer ausgeben
ELSE Cast(Coalesce(h.src_orig_item_nr, h.src_matnr) AS INTEGER)
END                                                 AS orig_item_nr_pp,
Cast(umg.conv_to_base_numerator AS INTEGER)         AS case_size_pp,
l.item_sid::INTEGER                                AS item_id,
mi.timestamp_from_pp,
mi.timestamp_until_pp,
cal.cal_dt                                          AS dat_sys,
r.mis_end_cd_pp                                     AS end_cd_pp,
r.mis_item_missing_reason_cd                        AS item_status_pp,
CASE WHEN Max(mi.timestamp_until_pp) Over(PARTITION BY mi.client_id,wh.loc_sid,l.item_sid,cal.cal_dt) = mi.timestamp_until_pp
          THEN  mi.missing_reason_cd
          ELSE NULL
     END AS missing_reason_cd        -- reason code, only the last code of the day
,
(CASE WHEN cal.cal_dt = mi.changed_dat_next
                     THEN CASE WHEN r.mis_end_cd_pp IN ('g','f') AND r.mis_item_missing_reason_cd IN ('FEHLT','0')
                               THEN  1
                               ELSE 0
                           END
                     ELSE 0
                END)::SMALLINT  AS temporary_missing_fg   -- temporary missing
,
Cast(To_Number(sig.src_itemgrp_int_cd) AS INTEGER)  AS itemgroup_int_id   -- WGI, nicht für COEX_VIEW
,
Cast(To_Number(sig.src_subitemgrp_cd) AS INTEGER)   AS subitemgroup_id    -- SIG, nicht für COEX_VIEW

FROM
(
-- aufbereitete Fehlartikel
SELECT
client_id,
item_missing_id              --itm_missing_nr
,
item_missing_progress_id     --itm_missing_pos
,
missing_state_cd             --itm_missing_state
,
missing_reason_cd            --itm_missing_reason_cd
,
Cast(change_dttm AS DATE)    AS changed_dat,
Cast(change_dttm AS TIME(6)) AS changed_time,
--( Cast(changed_dat AS TIMESTAMP(0)) + (changed_time - TO_VARCHAR( TIME '00:00:00', 'HH24:MM_2:SS')) ) AS timestamp_from_pp  -- changed_timestamp enthält Zeitzonen-Transformation, daher extra berechnet
TIMESTAMP_NTZ_FROM_PARTS(changed_dat,changed_time) as timestamp_from_pp,  
--Coalesce(Max(timestamp_from_pp) Over
--(PARTITION BY client_id, item_missing_id ORDER BY item_missing_progress_id ROWS BETWEEN 1 Following AND 1 Following) - INTERVAL '1 second', -- timestamp_from_pp nächster Satz, abzgl. 1 Sek.
--TO_TIMESTAMP('9999-12-31 00:00:00', 'YYYY/MM_2/DD HH:MI:SS')) AS timestamp_until_pp_calc  -- letzter Satz bis 31.12.9999 00:00:00
  
 Coalesce(dateadd(sec,-1,Max(timestamp_from_pp) Over(PARTITION BY client_id, item_missing_id ORDER BY item_missing_progress_id ROWS BETWEEN 1 Following AND 1 Following)), Cast('9999-12-31 00:00:00' AS TIMESTAMP)) AS timestamp_until_pp_calc
  
,

  
CASE WHEN timestamp_from_pp < timestamp_until_pp_calc THEN timestamp_until_pp_calc ELSE timestamp_from_pp END AS timestamp_until_pp,
Cast(timestamp_until_pp AS DATE) AS changed_dat_next  -- Endedatum zum Aufspannen über Kalender

FROM p_lew_core_ac.v_item_missing_progress_2
   ) mi

   -- Referenz zur LookUp-Tabelle
   INNER JOIN p_lew_core_ac.v_item_missing_2 l
ON l.client_id = mi.client_id
AND l.item_missing_id = mi.item_missing_id

-- Ermittlung der loc_sid der Betriebsgesellschaften
INNER JOIN p_lew_core_ac.v_location_2 wh
ON l.client_id = wh.client_id
AND l.loc_sid = wh.loc_sid
AND Lower(wh_store_label)='warehouse'

-- Referenz zum Item_2
INNER JOIN p_lew_core_ac.v_item_2 h
ON h.client_id = l.client_id
AND h.item_sid = l.item_sid
  --deaktiviert AND TO_NUMBER(h.itm_id) IS NOT NULL  -- nur migriere Artikel_2 (numerisch) berücksichigen

-- Ermittlung der korrekten case_size
LEFT OUTER JOIN
(SELECT
um.client_id,
um.item_sid,
um.log_var_cd,
Min(umh.conv_to_base_numerator) AS conv_to_base_numerator
FROM p_lew_core_ac.v_item_unit_of_measurement_2            AS um

INNER JOIN p_lew_core_ac.v_item_unit_of_measurement_hist_2 AS umh
ON  umh.client_id = um.client_id
AND umh.item_sid = um.item_sid
AND umh.uom_sid = um.uom_sid
AND Current_Date BETWEEN umh.dwh_valid_from AND umh.dwh_valid_to
AND umh.deleted_fg = 0
WHERE um.log_var_cd IS NOT NULL
GROUP BY 1,2,3
) umg
ON  umg.client_id = h.client_id
AND umg.item_sid = h.item_sid
AND umg.log_var_cd = h.log_var_cd
AND (h.log_var_cd <> '1' OR h.config_item_cd IS NOT NULL)

-- Referenz zur Artikelhierarchie (SIG ==> WGI)
INNER JOIN p_lew_bil.v_item_hierarchy_2 sig
ON sig.item_sid = l.item_sid
AND sig.client_id=l.client_id

 -- Aufspannen über Kalender, maximal bis CURRENT_DATE
INNER JOIN p_lew_core_ac.v_cal_calendarday_2  cal
ON (cal.cal_dt BETWEEN mi.changed_dat AND mi.changed_dat_next AND cal.cal_dt <= Current_Date)

-- Referenz zum WH-Item_2
INNER JOIN p_lew_core_ac.v_item_info_per_location_hist_2 ilh
ON ilh.loc_sid = l.loc_sid
AND ilh.item_sid = l.item_sid
AND cal.cal_dt BETWEEN ilh.dwh_valid_from AND ilh.dwh_valid_to  -- asis-Sicht: aktueller Status_2 am Tag_2 des Ausweises des Fehlartikels, nicht zum Anlage_2-Zeitpunkt changed_dat

-- Mapping Fehlartikel-Status_2 SAP zu WAWI
INNER JOIN p_lew_core_ac.v_map_mis_item_missing_status_2 r
ON r.client_id = mi.client_id
AND r.item_status_cd = ilh.item_status_cd  -- SAP-Artikel_2-Status_2 im WH
AND r.missing_state_cd = mi.missing_state_cd  -- SAP-Fehlartikel-Status_2
AND (r.missing_reason_cd = mi.missing_reason_cd OR r.missing_reason_cd IS NULL)  -- Fehlartikel-Grund, zur Zeit_2 nicht berücksichtigt / NULL

WHERE mi.missing_state_cd <> 'b'  -- keine Fehlartikel mit "Artikelstatus beendet"
-- keine Fehlartikel mit "Artikelstatus beendet"
) ppi
;





