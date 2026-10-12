CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_ARTBEW_WG_MO_SUM
-- 26.10.2011 system_id entfernt
-- 02.10.2013 twie: Erweitert um mandant_id 2
-- 22.10.2013 twie: Join zu in_kunde vereinfacht über wup_id
-- 29.01.2014 twie: Währungsumrechnung, Achtung Tabelle hat keine wrg_id, manche Fakten sind immer in Euro, manche immer in Landeswrg.
-- 13.02.2014 twie: ek_mep ausgeben,  diff_umsatz_netto_konz entfernen
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
--18.09.2018 naku:  WG Umstellung und Anpassungen
(
kjmo
,mandant_id
,wg_id
,arthiertyp_id
,in_kunde_id
,umsatz_netto
,ek_mep_umsatz_temp
,ek_mep_umsatz
,bewart_id
,wrg_id
)
AS
SELECT
v01.kjmo
,v01.mandant_id
,v01.wg_id
,v01.arthiertyp_id
,in_kunde_id

-- umsatz_netto ist immer in Landeswährung -> wird für User in Euro angezeigt
,  CAST(
CASE WHEN  v200.wrg_typ_id = 0
THEN COALESCE(v01.umsatz_netto,0) * v500.umrechnungskurs
-- umsatz_netto ist immer in Landeswährung -> wird für User in Landeswährung angezeigt
WHEN v200.wrg_typ_id = 1
THEN COALESCE(v01.umsatz_netto,0)
END
AS DECIMAL(18,4))
AS umsatz_netto

-- EK Werte dürfen nur für Fleischartikel ausgegeben werden.
-- NAKU: Neue WG  (1,2) durch (122,128,146,147,184,186) ersetzt; laut Mapping Tabelle in SPEC0034878
,ek_mep_umsatz_temp

-- ek_mep_umsatz_temp ist immer in Landeswährung -> wird für User in Euro angezeigt
,  CAST(
CASE WHEN  v200.wrg_typ_id = 0
THEN COALESCE(ek_mep_umsatz_temp,0) * v500.umrechnungskurs
-- ek_mep_umsatz_temp ist immer in Landeswährung -> wird für User in Landeswährung angezeigt
WHEN  v200.wrg_typ_id = 1
THEN COALESCE(ek_mep_umsatz_temp,0)
END
AS DECIMAL(18,4))
AS ek_mep_umsatz

,v01.bewart_id
,v400.wrg_id
FROM DBP_MSI_VIEW_FLW.TBL_MV_F_ARTBEW_WG_MO_SUM v01

-- Ermittlung der eingestellter Währung
CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200

-- Ermittlung ob Tageskurs / Kaufland Kurs
CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu v300

JOIN dbp_view.v_mandant_wrg_typ_zu v400
ON v01.mandant_id = v400.mandant_id
AND v200.wrg_typ_id = v400.wrg_typ_id

-- Umrechnung Standardkurs, Tageskurs
LEFT OUTER JOIN dbp_view.v_kurs v500
ON v300.kurstyp_id = v500.kurstyp_id
AND v01.default_wrg = v500.von_wrg_id
AND v500.nach_wrg_id ='EUR'
AND v01.max_dat BETWEEN v500.dat_von AND v500.dat_bis
;

