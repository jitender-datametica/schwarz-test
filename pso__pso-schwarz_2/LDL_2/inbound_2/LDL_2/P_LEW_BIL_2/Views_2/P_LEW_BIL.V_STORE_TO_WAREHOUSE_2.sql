CREATE OR REPLACE VIEW P_LEW_BIL.V_STORE_TO_WAREHOUSE_2
AS
/*
#DescStart#
#$Revision: 7508 $, $LastChangedBy: jthole $
#SubjectAreas#: Organisationsstruktur
#DescEnd#
*/
SELECT
stwh_a.client_id,
stwh_a.loc_sid_store,
stwh_a.orig_store_nr,
stwh_a.loc_sid_wh,
stwh_a.orig_wh_nr,
stwh_a.dwh_valid_from,
stwh_a.dwh_valid_to,
CASE WHEN CURRENT_DATE BETWEEN stwh_a.dwh_valid_from AND stwh_a.dwh_valid_to THEN 1 ELSE 0 END AS dwh_actual_fg -- NUR Aktuelle Sicht für die Zuordnung
,
CASE WHEN deleted_fg=1 THEN 0 ELSE 1 end AS active_fg -- NUR Aktivekennzeichen für die Zuordnung
,
0 AS future_active_fg
FROM
(SELECT
stwh.client_id,
stwh.loc_sid_store,
loc.src_orig_store_nr AS orig_store_nr,
stwh.loc_sid_wh_01 AS loc_sid_wh,
wh.src_wh_id AS orig_wh_nr,
stwh.deleted_fg,
stwh.dwh_valid_from,
stwh.dwh_valid_to
FROM p_lew_bil.t_store_to_wh_delivery_hist_2 AS stwh

-- Nur aktuelle Sicht auf Filialen beruecksichtigen
INNER JOIN p_lew_bil.v_store_2 AS loc
ON stwh.client_id = loc.client_id
  AND stwh.loc_sid_store = loc.loc_sid_store
  AND loc.dwh_actual_fg = 1

-- Ermittlung src_wh_id aus Stammdaten
INNER JOIN p_lew_core_ac.v_location_2 AS wh
ON stwh.client_id = wh.client_id
  AND stwh.loc_sid_wh_01 = wh.loc_sid

UNION ALL

-- Dummy_2 Filialen fuer die WH anlegen
-- Orig Store Nummer darf nicht aus WH bezogen werden, sie ist ansonsten nicht mehr eindeutig
SELECT
loc.client_id,
loc.loc_sid_wh AS loc_sid_store,
loc.src_wh_id  AS orig_store_nr,
loc.loc_sid_wh,
loc.src_wh_id AS orig_wh_nr,
0 deleted_fg,
TO_DATE('1900-01-01', 'yyyy-mm_2-dd') AS dwh_valid_from,
TO_DATE('9999-12-30', 'yyyy-mm_2-dd') AS dwh_valid_to
FROM p_lew_bil.v_warehouse_2 loc
WHERE dwh_actual_fg = 1
  AND active_fg = 1
) stwh_a
;



