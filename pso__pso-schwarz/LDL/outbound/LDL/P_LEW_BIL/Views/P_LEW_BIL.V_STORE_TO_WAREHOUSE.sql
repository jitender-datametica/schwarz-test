/* #DescStart#
#$Revision: 7508 $, $LastChangedBy: jthole $
#SubjectAreas#: Organisationsstruktur
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_bil.v_store_to_warehouse AS -- NUR Aktuelle Sicht für die Zuordnung

-- NUR Aktivekennzeichen für die Zuordnung
 -- Nur aktuelle Sicht auf Filialen beruecksichtigen

-- Dummy Filialen fuer die WH anlegen

-- Orig Store Nummer darf nicht aus WH bezogen werden, sie ist ansonsten nicht mehr eindeutig
 SELECT client_id,
 loc_sid_store,
 orig_store_nr,
 loc_sid_wh,
 orig_wh_nr,
 dwh_valid_from,
 dwh_valid_to,
  CASE
  WHEN CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
  THEN 1
  ELSE 0
  END AS dwh_actual_fg,
  CASE
  WHEN deleted_fg = 1
  THEN 0
  ELSE 1
  END AS active_fg,
 0 AS future_active_fg
FROM (SELECT STWH.client_id,
    STWH.loc_sid_store,
    LOC.src_orig_store_nr AS orig_store_nr,
    STWH.loc_sid_wh_01 AS loc_sid_wh,
    WH.src_wh_id AS orig_wh_nr,
    STWH.deleted_fg,
    STWH.dwh_valid_from,
    STWH.dwh_valid_to
   FROM ldl_p_lew_bil.t_store_to_wh_delivery_hist AS STWH
    INNER JOIN ldl_p_lew_bil.v_store AS LOC ON STWH.client_id = LOC.client_id AND STWH.loc_sid_store = LOC.loc_sid_store
        AND LOC.dwh_actual_fg = 1 -- Ermittlung src_wh_id aus Stammdaten

    INNER JOIN ldl_p_lew_core_ac.v_location AS WH ON STWH.client_id = WH.client_id AND STWH.loc_sid_wh_01 = WH.loc_sid
   UNION ALL
   SELECT client_id,
    loc_sid_wh AS loc_sid_store,
    src_wh_id AS orig_store_nr,
    loc_sid_wh,
    src_wh_id AS orig_wh_nr,
    0 AS deleted_fg,
    PARSE_DATE('%F', '1900-01-01') AS dwh_valid_from,
    PARSE_DATE('%F', '9999-12-30') AS dwh_valid_to
   FROM ldl_p_lew_bil.v_warehouse AS LOC
   WHERE dwh_actual_fg = 1
    AND active_fg = 1) AS stwh_a;