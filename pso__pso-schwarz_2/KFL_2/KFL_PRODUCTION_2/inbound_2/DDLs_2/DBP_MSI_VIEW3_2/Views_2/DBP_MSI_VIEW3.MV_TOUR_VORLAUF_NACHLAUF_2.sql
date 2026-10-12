CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_TOUR_VORLAUF_NACHLAUF_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	DAT_TOUR,
	TOUR_ID,
	BELOS_TOURSTATUS_ID,
	DISTRIBUTION_ABR_FG,
	MANDANT_ID_KUNDE,
	KUNDE_ID,
	LAGERNUMMER_ID,
	LIEF_BELEG_ID,
	DAT_LIEF_SOLL,
	KJ,
	LIEF_PAL_TYP_ID,
	WERBEWARE_ID,
	CD_KZ,
	HANDLING_UNIT_ID_EXT,
	HU_STATUS_ID,
	TRAEGERTYP_BEZ,
	OUG_TOUR_FG,
	ERSTE_TOUR_DES_TAGES_FG,
	HU_STELLPLATZ_FAKTOR,
	HU_STELLPLATZ_FAKTOR_O_AUFGEPACKT,
	HU_STELLPLATZ_FAKTOR_GT_0_FG,
	ABWEICHUNG_IN_TAGEN,
	ABWEICHUNG_IN_TAGEN_BEREINIGT,
	STELLPLAETZE_VORLAUF,
	STELLPLAETZE_NACHLAUF_EQ_1TAG_OK_OUG,
	STELLPLAETZE_NACHLAUF_EQ_1TAG_NOK,
	STELLPLAETZE_NACHLAUF_GT_1TAG_NOK,
	STELLPLAETZE_TOUR_EQ_LIEFER_DATUM,
	SCHWELLWERT_VORLAUF,
	SCHWELLWERT_NACHLAUF
) AS
-- 15.11.2016, AP0006317 - Vor- und Nachlaufpaletten, srom0404 Neuerstellung
-- 04.04.2017, AP0006317 - Ergänzung: Erste Tour_2 des Tages Flag
-- 29.05.2017, AP0006317 - COALESCE(v03.werbeware_id, '.') es sollen auch die NULL durch den Berichtsfilter <> 'W' angezeigt werden
-- 03.01.2020, [nw] - Added kj(_lief_beleg)
-- 09.02.2021, AP0078007, SPEC0101516, srom0404, lief_pal_typ_id auf CHAR(2)
-- 2023-05-26, dknop, adding filter lief_typ_id in ('YM','YU','YNOT','NL','ZLFI','ZLCC','YCD2','ZDD') to v04
--2024-01-31, INC7963291, dknop, change kunde_id 
--2024-08-01,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
--2024-09-09, dknop, change to left join with dbp_view.v_wup_2
--2025-05-27, nwag, changes for WANKO
SELECT t1.mandant_id
,t1.wup_id
,t1.nb_id
,t1.dat_tour
,t1.tour_id
,t1.belos_tourstatus_id
,t1.distribution_abr_fg
,t1.mandant_id_kunde
--,CASE WHEN TRY_CAST(SUBSTR(kunde_id,7,4) AS INTEGER) IS NULL THEN -3 ELSE TRY_CAST(SUBSTR(kunde_id,7,4) AS INTEGER) END AS kunde_id
, CASE WHEN TRY_CAST(SUBSTR(kunde_id,7,4) AS INTEGER) IS NULL THEN -3 ELSE v05.aktuell_wup_id END kunde_id
,t1.lagernummer_id
,t1.lief_beleg_id
,t1.dat_lief_soll
,t1.kj
,t1.lief_pal_typ_id
,t1.werbeware_id
,t1.cd_kz
,t1.handling_unit_id_ext
,t1.hu_status_id
,CASE WHEN t1.versandeinheit_id NOT IN (1,-1) THEN 'AUFGEPACKT'
WHEN t1.versandeinheit_id = -1 THEN 'NORMAL'
WHEN t1.versandeinheit_id = 1 THEN 'TRÄGER'
END AS traegertyp_bez
,t1.oug_tour_fg AS oug_tour_fg
,t1.erste_tour_des_tages_fg AS erste_tour_des_tages_fg
,t1.hu_stellplatz_faktor AS hu_stellplatz_faktor
,CASE WHEN t1.versandeinheit_id IN (-1,1) THEN t1.hu_stellplatz_faktor --'NORMAL', 'TRÄGER'
ELSE 0 --'AUFGEPACKT'
END AS hu_stellplatz_faktor_o_aufgepackt
-- Abweichung soll nur für Datensätze mit hu_stellplatz_faktor_o_aufgepackt > 0
,CASE WHEN hu_stellplatz_faktor_o_aufgepackt > 0 THEN 1
ELSE 0
END AS hu_stellplatz_faktor_gt_0_fg
,hu_stellplatz_faktor_gt_0_fg * (t1.dat_tour - t1.dat_lief_soll) AS abweichung_in_tagen
,hu_stellplatz_faktor_gt_0_fg * t1.abweichung_in_tagen_bereinigt AS abweichung_in_tagen_bereinigt
,hu_stellplatz_faktor_gt_0_fg * (CASE WHEN abweichung_in_tagen_bereinigt < 0 THEN hu_stellplatz_faktor_o_aufgepackt ELSE 0 END) AS stellplaetze_vorlauf
-- erste Tour_2 des Tages (sollte die O&G Tour_2 sein, muss aber nicht immer) wird auch betrachtet
,hu_stellplatz_faktor_gt_0_fg * (CASE WHEN abweichung_in_tagen_bereinigt = 1 AND (t1.oug_tour_fg = 1 OR t1.erste_tour_des_tages_fg = 1) THEN hu_stellplatz_faktor_o_aufgepackt ELSE 0 END) AS stellplaetze_nachlauf_eq_1tag_ok_oug
,hu_stellplatz_faktor_gt_0_fg * (CASE WHEN abweichung_in_tagen_bereinigt = 1 AND (t1.oug_tour_fg = 0 AND t1.erste_tour_des_tages_fg = 0) THEN hu_stellplatz_faktor_o_aufgepackt ELSE 0 END) AS stellplaetze_nachlauf_eq_1tag_nok
,hu_stellplatz_faktor_gt_0_fg * (CASE WHEN abweichung_in_tagen_bereinigt > 1 THEN hu_stellplatz_faktor_o_aufgepackt ELSE 0 END) AS stellplaetze_nachlauf_gt_1tag_nok
,hu_stellplatz_faktor_gt_0_fg * (CASE WHEN abweichung_in_tagen_bereinigt = 0 THEN hu_stellplatz_faktor_o_aufgepackt ELSE 0 END) AS stellplaetze_tour_eq_liefer_datum

-- Anzahl Märkte mit Fehler Vorlaufpaletten. Um Anzahl als Summe abzubilden, wird eine_2 1 weggeschrieben
-- Diese kann dann im Bericht aufsummiert werden.
-- Metrik hat MAX in der Definitionen und SUM bei Aggregation
-- Auch wenn ein Markt mehrere Fehler pro Tag_2 in verschiedenen Touren hat, wird das pro Tag_2 nur 1x gezählt
--,CASE WHEN SUM(CASE WHEN stellplaetze_vorlauf > 0 THEN stellplaetze_vorlauf ELSE 0 END) OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.mandant_id_kunde, t1.kunde_id, t1.dat_tour)
--           > schwellwert_vorlauf THEN 1
--      ELSE 0
-- END AS fehler_vorlauf_fg

-- Anzahl Märkte mit Fehler Vorlaufpaletten. Um Anzahl als Summe abzubilden, wird eine_2 1 weggeschrieben
-- Diese kann dann im Bericht aufsummiert werden.
-- Metrik hat MAX in der Definitionen und SUM bei Aggregation
-- Auch wenn ein Markt mehrere Fehler pro Tag_2 in verschiedenen Touren hat, wird das pro Tag_2 nur 1x gezählt
--,CASE WHEN SUM(CASE WHEN stellplaetze_nachlauf_eq_1tag_ok_oug > 0 THEN stellplaetze_nachlauf_eq_1tag_ok_oug ELSE 0 END) OVER (PARTITION BY t1.mandant_id, t1.wup_id, t1.mandant_id_kunde, t1.kunde_id, t1.dat_tour)
--           > schwellwert_nachlauf
--        OR stellplaetze_nachlauf_eq_1tag_nok > 0 OR stellplaetze_nachlauf_gt_1tag_nok > 0 THEN 1
--     ELSE 0
-- END AS fehler_nachlauf_fg

,v09.schwellwert_vorlauf AS schwellwert_vorlauf
,v10.schwellwert_nachlauf AS schwellwert_nachlauf

FROM
( -- t1_2
SELECT t001.mandant_id
,t001.wup_id
,t001.nb_id
,t001.dat_tour
,t001.tour_id
,t001.belos_tourstatus_id
,t001.distribution_abr_fg
,t001.mandant_id_kunde
,t001.kunde_id
,t001.lagernummer_id
,t001.lief_beleg_id
,t001.dat_lief_soll
,t001.kj
,MAX(t001.abweichung_in_tagen_bereinigt) AS abweichung_in_tagen_bereinigt
,t001.lief_pal_typ_id
,t001.werbeware_id
,t001.cd_kz
,v07.handling_unit_id_ext
,v07.hu_status_id
,v07.versandeinheit_id
,v08.oug_tour_fg
,v08.erste_tour_des_tages_fg
,v07.hu_stellplatz_faktor
FROM
( --t001_2
SELECT t01.mandant_id
,t01.wup_id
,t01.nb_id
,t01.dat_tour
,t01.tour_id
,t01.belos_tourstatus_id
,t01.distribution_abr_fg
,t01.mandant_id_kunde
,t01.kunde_id
,t01.lagernummer_id
,t01.lief_beleg_id
,t01.dat_lief_soll
,t01.kj
,SUM(t01.abweichung_in_tagen_bereinigt) AS abweichung_in_tagen_bereinigt
,Cast(t01.lief_pal_typ_id AS VARCHAR(2)) AS lief_pal_typ_id
,t01.werbeware_id_ AS werbeware_id
,t01.cd_kz_ AS cd_kz
FROM
( --t01
SELECT v01.mandant_id
,v01.wup_id
,v01.nb_id
,v01.dat_tour
,v01.tour_id
,CASE WHEN v021.tms_tourstatus_id IN (10,20) THEN -1
      WHEN v021.tms_tourstatus_id IN (30,40) THEN 2 
      WHEN v021.tms_tourstatus_id IN (50,51) THEN 3
      ELSE COALESCE (v01.belos_tourstatus_id ,-1) END AS belos_tourstatus_id
,COALESCE(v021.distribution_abr_fg, v01.distribution_abr_fg) AS distribution_abr_fg
,v02.mandant_id_kunde
,v02.kunde_id
,v02.lagernummer_id
,v02.lief_beleg_id
,v03.dat_lief_soll
,v04.dat_lief_soll AS liefertage
,v03.kj
,CASE WHEN v01.dat_tour < v04.dat_lief_soll THEN -1
WHEN v01.dat_tour > v04.dat_lief_soll THEN 1
WHEN v01.dat_tour = v04.dat_lief_soll THEN 0
END AS abweichung_in_tagen_bereinigt
,v03.lief_pal_typ_id
,COALESCE(v03.werbeware_id,'-') AS werbeware_id_
,CASE WHEN v03.cd_kz IS NULL OR v03.cd_kz = '' THEN '-1'
ELSE v03.cd_kz
END AS cd_kz_

FROM dbp_view.v_tour_2 v01
INNER JOIN dbp_view.v_tour_det_2 v02
ON v01.mandant_id  = v02.mandant_id
AND v01.wup_id     = v02.wup_id
AND v01.tour_id    = v02.tour_id

LEFT JOIN (
SELECT DISTINCT tms_tour.mandant_id , TRY_CAST(tms_tour.startlager_tms_gp_id AS NUMBER) AS wup_id, 
TRY_CAST( RIGHT(tms_tour.transportation_unit_id_ext, LENGTH(TRIM(tms_tour.transportation_unit_id_ext) ) -6 ) AS NUMBER) AS tour_id
, tms_tour.dat_tour, CASE WHEN tms_tour.tms_tourtyp_id=105 THEN 0 ELSE 1 END AS distribution_abr_fg ,tms_tour.tms_tourart_id, TMS_TOURSTATUS_ID
FROM dbp_data.tms_tour_2 tms_tour_2
WHERE LEFT(tms_tour.transportation_unit_id_ext,3) = 'SAP' AND YEAR(tms_tour.DAT_TOUR) >= YEAR(CURRENT_DATE) -2
AND EXISTS (SELECT 1 FROM DBP_MSI_data.TS_LAGERNUMMER_SORTIERUNG_SCM_2 v022 WHERE  tms_tour.dat_tour >= v022.dat_tms_wanko AND  tms_tour.mandant_id=v022.mandant_id AND   TRY_CAST(tms_tour.startlager_tms_gp_id AS NUMBER) = v022.wup_id  ) ) v021 
ON v01.mandant_id  = v021.mandant_id
AND v01.wup_id     = v021.wup_id
AND v01.tour_id    = v021.tour_id 
  
INNER JOIN dbp_view.v_besch_lief_2 v03
ON v02.mandant_id_kunde  = v03.mandant_id_kunde
AND v02.kunde_id         = v03.kunde_id
AND v02.lief_beleg_id    = v03.lief_beleg_id
AND v02.kj_lief_beleg = v03.kj

-- Änderung gegenüber Konzept. Man geht davon aus, das die Soll Liefertage keine Feiertage o.ä enthalten
-- Alle Soll- Liefertage pro Kunde (unabhängig von der Lieferung) zeigen also die möglichen Liefertage
-- Durch JOIN Between werden dann zusätzliche Sätze erzeugt. Das Flag abweichung_in_tagen_bereinigt pro erzeugten Satz kann aufsummiert werden
-- und zeigt dann die Anzahl möglicher Liefertage zwischen Tourdatum und Soll-Lieferdatum

LEFT JOIN (SELECT mandant_id_kunde
,kunde_id
,dat_lief_soll
FROM dbp_view.v_besch_lief_2
  --new: only consider relevant deliveries (e.g. no store returns to DC):

WHERE lief_typ_id IN ('YM','YU','YNOT','NL','ZLFI','ZLCC','YCD2','ZDD')
GROUP BY mandant_id_kunde
,kunde_id
,dat_lief_soll
) v04
ON v02.mandant_id_kunde = v04.mandant_id_kunde
AND v02.kunde_id         = v04.kunde_id
AND (v04.dat_lief_soll BETWEEN v01.dat_tour AND v03.dat_lief_soll -- Lieferdatum nach Tourdatum
OR v04.dat_lief_soll BETWEEN v03.dat_lief_soll AND v01.dat_tour -- Lieferdatum vor Tourdatum
)

WHERE v02.loesch_fg = 0
) t01

GROUP BY t01.mandant_id
,t01.wup_id
,t01.nb_id
,t01.dat_tour
,t01.tour_id
,t01.belos_tourstatus_id
,t01.distribution_abr_fg
,t01.mandant_id_kunde
,t01.kunde_id
,t01.lagernummer_id
,t01.lief_beleg_id
,t01.dat_lief_soll
,t01.kj
,t01.lief_pal_typ_id
,t01.werbeware_id_
,t01.cd_kz_
) t001_2

INNER JOIN dbp_view.v_handling_unit_2 v07
ON t001.mandant_id    = v07.mandant_id
AND t001.wup_id        = v07.wup_id
AND t001.nb_id         = v07.nb_id
AND t001.lief_beleg_id = v07.lief_beleg_id
AND t001.kj = v07.kj_lief_beleg

LEFT JOIN ( --v08, ermittelt die erste Tour_2 des Tages
SELECT v08a.mandant_id
,v08a.wup_id
,v08a.nb_id
,v08a.tour_id
,v08a.mandant_id_kunde
,v08a.kunde_id
,MAX(v08a.oug_tour_fg) AS oug_tour_fg
,MAX(v08a.erste_tour_des_tages_fg) AS erste_tour_des_tages_fg
FROM (SELECT v081.mandant_id
,v081.wup_id
,v081.nb_id
,v081.tour_id
,v081.mandant_id_kunde
,v081.kunde_id
,v081.oug_tour_fg
,CASE WHEN v081.zeit_plan_ankunft <> '00:00:00' AND v081.zeit_relevant_fg = 1 THEN 1 ELSE 0 END AS zeit_relevant_
-- Nur nach Zeit_2 sortieren ist nicht eindeutig. Es kann mehrere Touren zur gleichen Zeit_2 geben. Daher noch die tour_id als Hilfskonstrukt genommen
-- tour_id ist eine_2 fortlaufende Nummer und daher ist dann wohl bei gleichen Zeiten die kleinere tour_id, die erste Tour_2
,CASE WHEN ROW_NUMBER() OVER (PARTITION  BY v081.mandant_id, v081.wup_id, v081.mandant_id_kunde, v081.kunde_id, v081.dat_tour ORDER BY v082.distribution_abr_fg DESC NULLS LAST, zeit_relevant_ DESC NULLS LAST, v081.zeit_plan_ankunft ASC, v081.tour_id ASC) = 1 THEN 1 ELSE 0 END  AS erste_tour_des_tages_fg
FROM dbp_view.v_tour_det_zlv_vttkl_2 v081
INNER JOIN dbp_view.v_tour_2 v082
ON v081.mandant_id = v082.mandant_id
AND v081.wup_id     = v082.wup_id
AND v081.tour_id    = v082.tour_id
) v08a

GROUP BY v08a.mandant_id
,v08a.wup_id
,v08a.nb_id
,v08a.tour_id
,v08a.mandant_id_kunde
,v08a.kunde_id
) v08
ON t001.mandant_id       = v08.mandant_id
AND t001.wup_id           = v08.wup_id
AND t001.nb_id            = v08.nb_id
AND t001.tour_id          = v08.tour_id
AND t001.mandant_id_kunde = v08.mandant_id_kunde
AND t001.kunde_id         = v08.kunde_id

GROUP BY
t001.mandant_id
,t001.wup_id
,t001.nb_id
,t001.dat_tour
,t001.tour_id
,t001.belos_tourstatus_id
,t001.distribution_abr_fg
,t001.mandant_id_kunde
,t001.kunde_id
,t001.lagernummer_id
,t001.lief_beleg_id
,t001.dat_lief_soll
,t001.kj
,t001.lief_pal_typ_id
,t001.werbeware_id
,t001.cd_kz
,v07.handling_unit_id_ext
,v07.hu_status_id
,v07.versandeinheit_id
,v08.oug_tour_fg
,v08.erste_tour_des_tages_fg
,v07.hu_stellplatz_faktor
) t1_2

INNER JOIN dbp_view.v_wup_2 v05
   ON v05.mandant_id = CASE WHEN t1.mandant_id_kunde IS NULL OR t1.mandant_id_kunde = 0 THEN t1.mandant_id ELSE t1.mandant_id_kunde END
   AND v05.wup_id = CASE WHEN TRY_CAST(kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(kunde_id AS INTEGER) END
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))

INNER JOIN (SELECT mandant_id
,wup_id
,nb_id
,schwellwert AS schwellwert_vorlauf
FROM dbp_msi_view3.ts_lis_schwellwerte_2
WHERE schwellwert_typ_bez = '08.23 Vor und Nachlauf Vorlaufpaletten'
) v09
ON t1.mandant_id = v09.mandant_id
AND t1.wup_id     = v09.wup_id
AND t1.nb_id      = v09.nb_id

INNER JOIN (SELECT mandant_id
,wup_id
,nb_id
,schwellwert AS schwellwert_nachlauf
FROM dbp_msi_view3.ts_lis_schwellwerte_2
WHERE schwellwert_typ_bez = '08.23 Vor und Nachlauf Nachlauflaufpaletten'
) v10
ON t1.mandant_id = v10.mandant_id
AND t1.wup_id     = v10.wup_id
AND t1.nb_id      = v10.nb_id
WHERE EXTRACT(YEAR FROM dat_tour) >= YEAR(CURRENT_TIMESTAMP) - 2;