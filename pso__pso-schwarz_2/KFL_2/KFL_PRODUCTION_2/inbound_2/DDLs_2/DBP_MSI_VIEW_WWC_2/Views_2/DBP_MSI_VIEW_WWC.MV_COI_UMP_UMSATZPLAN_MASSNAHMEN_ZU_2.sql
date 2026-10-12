CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_COI_UMP_UMSATZPLAN_MASSNAHMEN_ZU_2
-- mcie, AP0047831, 27/08/2019, added wert column
-- srom0404, AP0047831, Hinzuf�gen von Tabelle coi_ump_umsatzplan_hwg_2
-- Der Bericht [2.01.03.07 Umsatzeffekte Auswirkungen Detail] stellt die einzelnen Faktoren und Basiswerte dar. Gespeichert in der Tabelle coi_ump_umsatzplan_massnahmen_zu.
-- Auf Grund der Eingabe/Datenpflege ist das Feld [Wert] nicht immer gef�llt. Feld [Faktor] ist immer gef�llt. BackEnd arbeitet mit [Faktor] und berechnet daraus [wert_basis_3]
-- Hier werden die beiden Tabellen zusammengef�hrt und [Wert] berechnet, falls es nicht gef�llt ist
(
mandant_id
,gj_plan
,version_id
,wup_id
,nb_id
,dat_plan
,arthiertyp_id
,hwg_id
,massnahme_art_id
,massnahme_typ_bez
,massnahme_id
,massnahme_art_bez
,massnahme_auswirkung_bez
,faktor
,wert_massnahme
,betriebsunterbrechung_fg
)
AS
SELECT
v01.mandant_id,
v01.gj_plan,
v01.version_id,
v01.wup_id,
v01.nb_id,
v01.dat_plan,
v01.arthiertyp_id,
v01.hwg_id,
v01.massnahme_art_id,
v01.massnahme_typ_bez,
v01.massnahme_id,
v01.massnahme_art_bez,
v01.massnahme_auswirkung_bez,
v01.faktor,

CASE
    WHEN v01.wert IS NULL THEN v01.faktor * v03.umsatz_netto_basis_3
ELSE v01.wert
END AS wert_massnahme,
COALESCE(v02.betriebsunterbrechung_fg,0) AS betriebsunterbrechung_fg
FROM dbp_view.v_coi_ump_umsatzplan_massnahmen_zu_2 v01

-- Ermittlung, ob eine_2 Betriebsunterbrechung vorliegt. Bei Betriebsunterbrechung soll der Kalendereffekt dem zum Datum passenden Immo Effekt zugeordnet werden
LEFT JOIN dbp_view.v_coi_ump_wup_immo_massnahme_per_2 v02
ON v01.mandant_id = v02.mandant_id
AND v01.gj_plan = v02.gj_plan
AND v01.version_id = v02.version_id
AND v01.massnahme_id = v02.massnahme_id

INNER JOIN dbp_view.v_coi_ump_umsatzplan_hwg_2 v03
ON v01.mandant_id = v03.mandant_id
AND v01.gj_plan = v03.gj_plan
AND v01.version_id = v03.version_id
AND v01.dat_plan   = v03.dat_plan
AND v01.wup_id     = v03.wup_id
AND v01.nb_id      = v03.nb_id
AND v01.hwg_id     = v03.hwg_id
;
