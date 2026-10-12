CREATE OR REPLACE VIEW DBP_MSI_VIEW_IVS.MV_IMMO_OBJEKT_PER_1
AS
-- STAMMDATEN Immobilie (immo_objekt)
-- Akt. Datenstand : Gueltigkeitsdatum 31.12.9999
-- 2011KW33 Hinzufügen von immo_objekt_obj_id; immo_objekt_bez; immo_objekt_nr
-- 2011KW37 buchungskreis_id hinzugefügt
-- 2011KW45 Gruppierungs-Bezeichung für Partnerobjekt angelegt.
-- 2011KW48 Dummy_1 Markt ergaenzt
-- 2011KW51 Erweiterung Umgliederung
-- 2012KW46 Erweiterung Dummy_1 Eintraege fuer KMO
-- 2013KW02 Implementierung Transkription
-- 2013KW31PU Offizielle Bezeichnungen
-- 2013KW37 Anpassung Eroeffnungsdatum (aus wup_1)
-- 2013KW47 Ueberarbeitung Eroeffnungsdatum (wup_1), Filterung

SELECT
io.mandant_id
, io.immo_objekt_id
, io.dat_von
, io.dat_bis
, io.objekt_groesse
, io.konzessionaer_groesse
, io.objekt_plz
, dbp_process.transcriptc(io.objekt_ort)     AS objekt_ort
, dbp_process.transcriptc(io.objekt_strasse) AS objekt_strasse
, dbp_process.transcriptc(io.objekt_name)    AS objekt_name
, io.dat_1bereich_oeffnung
, io.dat_objekt_oeffnung
-- Eroeffnung aus wup_1
, wp.dat_eroeffnung
, COALESCE(io.dat_objekt_oeffnung, wp.dat_eroeffnung) AS dat_eroeffnung_geplant

, io.objektart_id
, NULLIF(io.objektart_datum_von, CAST('1900-01-01' AS DATE))        AS objektart_datum_von
, NULLIF(io.objektart_datum_bis, CAST('9999-12-31' AS DATE))   AS objektart_datum_bis
, dat_umgl
, status_umgl
, io.eigenmiete_pro_qm    * kurs_1             AS eigenmiete_pro_qm
, io.eigenmiete_pro_monat * kurs_1             AS eigenmiete_pro_monat
, kurs.wrg_id
, kurs.wrg_typ_id
, immo_objekt_obj_id
, ref_immo_objekt_id
, immo_objekt_nr
, buchungskreis_id
, immo_objekt_bez
, dbp_process.transcriptc(
CASE
WHEN POSITION('PAOB' in objekt_name) > 0 THEN TRIM(SUBSTRING(objekt_name, 1,POSITION('PAOB' in objekt_name)-1))
WHEN POSITION(',PAOB' in objekt_name) > 0 THEN TRIM(SUBSTRING(objekt_name,1, POSITION(',PAOB' in objekt_name) -1))
WHEN POSITION('UMGL' in objekt_name) > 0 THEN TRIM(SUBSTRING(objekt_name, 1,POSITION('UMGL' in objekt_name)-1))
WHEN POSITION(',UMGL' in objekt_name) > 0 THEN TRIM(SUBSTRING(objekt_name, 1,POSITION(',UMGL' in objekt_name)-1))
WHEN POSITION('Partnerobjekt' in objekt_name) > 0 THEN TRIM(SUBSTRING(objekt_name,1, POSITION('Partnerobjekt' in objekt_name)-1))
ELSE objekt_name END
) AS objekt_name_grp
FROM dbp_view.v_ivs_immo_objekt_per_1 io

INNER JOIN dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per_1  kurs_1
ON kurs.mandant_id = io.mandant_id
AND CURRENT_DATE BETWEEN kurs_dat_von AND kurs_dat_bis

LEFT JOIN
(
SELECT mandant_id, wup_id, dat_eroeffnung
FROM dbp_view.v_wup_1
WHERE nb_id = 0
-- Ohne Defaultwerte (01.01.1900 bzw. 31.12.2090)
AND dat_eroeffnung BETWEEN CAST('1900-01-02' AS DATE) AND CAST('2090-12-30' AS DATE)
) wp
ON io.mandant_id = wp.mandant_id
AND immo_objekt_bez = wp.wup_id

WHERE io.dat_bis = CAST('9999-12-31' AS DATE)

-- Ermittlung der relevanten Objekt-Version bei Umgliederung
-- Basis: Statusinformationen und Umgliederungsdatum
AND (io.mandant_id, io.immo_objekt_id) NOT IN
(
SELECT mandant_id, immo_objekt_id
FROM dbp_view.v_ivs_immo_objekt_per_1
WHERE dat_bis = CAST('9999-12-31' AS DATE)
AND
(
dat_umgl > CURRENT_DATE  /*Daten der Umgliederung in der Zukunft*/
OR  /*mindestens ein Satz vorhanden mit Umgliederung in der Vergangenheit*/
(
status_umgl = 'UMGL'
AND dat_umgl IS NULL
AND (mandant_id, ref_immo_objekt_id) IN
(
SELECT mandant_id, ref_immo_objekt_id
FROM dbp_view.v_ivs_immo_objekt_per_1
WHERE dat_umgl <= CURRENT_DATE
AND dat_bis = CAST('9999-12-31' AS DATE)
)
)
)
)

UNION ALL  -- Dummy_1 Objekte 0 --
SELECT
mandant_id
, 'IW----------0'
, CAST('1900-01-01' AS DATE)
, CAST('9999-12-31' AS DATE)
, 0
, 0
, ''
, ''
, ''
, 'ohne Zuordnung'
, CAST('1900-01-01' AS DATE)
, CAST('1900-01-01' AS DATE)
, CAST('1900-01-01' AS DATE)
, CAST('1900-01-01' AS DATE)
, '3'
, CAST('1900-01-01' AS DATE)
, CAST('9999-12-31' AS DATE)
, CAST(NULL AS DATE)
, CAST(NULL AS CHAR(10))
, 0.00
, 0.00
, wrg_id
, wrg_typ_id
, 'IW----------0'
, 'IW----------0'
, ''
, 0
, 0
, 'ohne Zuordnung'
FROM dbp_view.v_mandant_wrg_typ_zu_1
;