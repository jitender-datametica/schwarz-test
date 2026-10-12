CREATE OR REPLACE VIEW P_LEW_BIL.V_MAT_STORE_TO_WAREHOUSE_LASTKNOWN_2
AS
/*
#DescStart#
  Formerly known as V_ORG_STORE_SKEY_2:
  Diese View repräsentiert die sogenannte LAST KNOWN SICHT (ohne Historisierung). Alle Zuordnungen sind so angegeben wie sie zuletzt bekannt waren.
  Gibt es also zu einem Store längst keine WH-Zuordnung (z.B. weil der Store längst gelöscht wurde) so erscheint hier dennoch der Store mit seinem letztbekannten historischen Warehouse.
  Motivation für diese Sicht ist die in COEX bekannte AS-IS-Sicht, die analog historisch falsch agiert, um den anscheinend bestehenden Reporting-Bedarf an immer gepflegten Zuordnungen zu erfüllen
#$Revision: 12471 $, $LastChangedBy: tkhusainov $
#SubjectAreas#: Organisationsstruktur
#DescEnd#
*/
SELECT
stwh.client_id,
stwh.loc_sid_store,
stwh.loc_sid_wh_01 AS loc_sid_wh,
wh.src_wh_id,
loc.src_orig_store_nr,
stwh.dwh_valid_from,
stwh.dwh_valid_to,
1 dwh_actual_fg,
CASE WHEN CURRENT_DATE BETWEEN stwh.dwh_valid_from AND stwh.dwh_valid_to THEN 1 ELSE 0 END AS active_fg,
0 AS future_active_fg
FROM p_lew_bil.v_store_to_wh_delivery_hist_2 AS stwh
-- Ermittlung src_orig_store_nr aus Stammdaten
INNER JOIN p_lew_core_ac.v_location_2 AS loc
ON stwh.client_id = loc.client_id
   AND stwh.loc_sid_store = loc.loc_sid
-- Ermittlung src_wh_id aus Stammdaten
INNER JOIN p_lew_core_ac.v_location_2 AS wh
ON stwh.client_id = wh.client_id
   AND stwh.loc_sid_wh_01 = wh.loc_sid
WHERE stwh.lastknown_fg=1

UNION ALL

-- Dummy_2 Filialen fuer die WH anlegen
-- Orig Store Nummer darf nicht aus WH bezogen werden, sie ist ansonsten nicht mehr eindeutig
SELECT
loc.client_id,
loc.loc_sid_wh AS loc_sid_store,
loc.loc_sid_wh,
loc.src_wh_id,
loc.src_wh_id  AS orig_store_nr,
TO_DATE('1900-01-01', 'yyyy-mm_2-dd') AS dwh_valid_from,
TO_DATE('9999-12-30', 'yyyy-mm_2-dd') AS dwh_valid_to,
1 dwh_actual_fg,
1 active_fg,
0 AS future_active_fg
FROM p_lew_bil.v_warehouse_2 loc
WHERE dwh_actual_fg = 1
  AND active_fg = 1
;



