-- AL 23.04.2012 Anzeige nicht vorhandenen Werte als NULL
 -- TB 22.01.2013 Erweitert um VKPK4_Netto

-- Ergänzen um mwst, art als führende Tabelle
 -- SSchü 16.01.2014 Erweiterung VKPK6 - 10 - Projekt P0713

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_artikel_vkpreis (art_id, mandant_id, vkpk1, vkpk1_netto,
vkpk2, vkpk3, vkpk4, vkpk4_netto, vkpk5, vkpk6, vkpk7, vkpk8, vkpk9, vkpk10, mwst) AS
-- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / in diesem Fall nur Umstellung auf akt. Berichtskurs, da immer aktueller Preis - sschuecke 10.01.2025

-- CASE WHEN v200.wrg_typ_id = 1 THEN 1.00 ELSE v01.umrechnungskurs END umrechnungskurs_,
 SELECT V01.art_id,
 V01.mandant_id,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN V01.`_vkpk1` * V01.umrechnungskurs
   ELSE V01.`_vkpk1`
   END AS NUMERIC) AS vkpk1,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN V01.`_vkpk1` * V01.umrechnungskurs / (1.000 + V01.mwst / 100.000)
   ELSE V01.`_vkpk1` / (1.000 + V01.mwst / 100.000)
   END AS NUMERIC) AS vkpk1_netto,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN V01.`_vkpk2` * V01.umrechnungskurs
   ELSE V01.`_vkpk2`
   END AS NUMERIC) AS vkpk2,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN V01.`_vkpk3` * V01.umrechnungskurs
   ELSE V01.`_vkpk3`
   END AS NUMERIC) AS vkpk3,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN V01.`_vkpk4` * V01.umrechnungskurs
   ELSE V01.`_vkpk4`
   END AS NUMERIC) AS vkpk4,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN V01.`_vkpk4` * V01.umrechnungskurs / (1.000 + V01.mwst / 100.000)
   ELSE V01.`_vkpk4` / (1.000 + V01.mwst / 100.000)
   END AS NUMERIC) AS vkpk4_netto,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN V01.`_vkpk5` * V01.umrechnungskurs
   ELSE V01.`_vkpk5`
   END AS NUMERIC) AS vkpk5,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN V01.`_vkpk6` * V01.umrechnungskurs
   ELSE V01.`_vkpk6`
   END AS NUMERIC) AS vkpk6,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN V01.`_vkpk7` * V01.umrechnungskurs
   ELSE V01.`_vkpk7`
   END AS NUMERIC) AS vkpk7,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN V01.`_vkpk8` * V01.umrechnungskurs
   ELSE V01.`_vkpk8`
   END AS NUMERIC) AS vkpk8,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN V01.`_vkpk9` * V01.umrechnungskurs
   ELSE V01.`_vkpk9`
   END AS NUMERIC) AS vkpk9,
 CAST(CASE
   WHEN V200.wrg_typ_id = 0
   THEN V01.`_vkpk10` * V01.umrechnungskurs
   ELSE V01.`_vkpk10`
   END AS NUMERIC) AS vkpk10,
 V01.mwst
FROM kfl_production_dbp_msi_view_ais_kmo.tbl_mv_artikel_vkpreis AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu AS V200 ON TRUE;