CREATE OR REPLACE VIEW dbp_msi_view3.mv_wup_kunde_art_disporhythmus_lft_zu_per_2(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	MANDANT_ID_KUNDE,
	KUNDE_ID,
	AUSLIEFERUNGSGRUPPE_ID,
	TERMINIERUNGSGRUPPE_1_ID,
	TERMINIERUNGSGRUPPE_2_ID,
	TERMINIERUNGSGRUPPE_3_ID,
	DISPOSITION_RHYTHMUS_LTF_ID,
	WG_ID,
	ARTHIERTYP_ID,
	AUSG_MENGE_EINH_ID,
	PALETTEN_FAKTOR_EINH_ID,
	ART_ID,
	DISPONENT_ID,
	WG_VERKETT_ID,
	DAT_LIEF_SOLL,
	LAGERNUMMER_ID,
	LAGERORT_ID,
	LIEF_PAL_TYP_ID,
	BESTELLART_ID,
	MENGE_LIEF_IST_KOLLI
) AS
-- Die historisch korrekte Zuordnung zu Lieferdatum wird aus verschiedenen Tabellen abgeleitet
-- Der entsprechende Bericht wird wohl selten aufgerufen und eine_2 vorgahaltene Tabelle scheint dafür nicht notwendig/wirtschaftlich
-- Für die Darstellung der aktuellen Sicht, wird eine_2 Tabelle vorgehalten und durch die Datenbeladung versorgt
-- 26.09.2018, srom0404, lt. Email N. Wagner bestellart_id direkt aus besch_lief_det_2
-- 25.02.2019, AP0018098, srom0404 - Disporhythmus, Erweiterung Grundmenge um auf VZ-Markt-Artikel_2 Kombinationen anzuzeigen bei denen der Disporhythmus nicht bzw. falsch gepflegt ist
-- 27.11.2019, AP0041558, nwag2310, added KJ in join (LIKP/LIPS)
-- 14.10.2020, INC, nwag2310, Terminierungsgruppen aus Store Term statt MARC_2 im Verhalten Berichte 09.01.05 und 09.01.01 zu harmonisieren
-- 09.02.2021, AP0078007, SPEC0101516, srom0404, lief_pal_typ_id auf CHAR(2)
-- 10.03.2021, INC2449335, nwag2310, lagerort_id hinzugefügt
--2024-07-24,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic
SELECT
v05.mandant_id,
v05.wup_id -- Verteilzentrum
,
v05.nb_id  -- Verteilzentrum
,
v05.mandant_id AS mandant_id_kunde,
--v05.kunde_id,
CASE WHEN TRY_CAST(v05.kunde_id AS INTEGER) = 0 THEN NULL ELSE v06.aktuell_wup_id END kunde_id,
CAST(COALESCE(v01.auslieferungsgruppe_id,'-1') AS CHAR(4)) AS auslieferungsgruppe_id,
CAST(COALESCE(v01.terminierungsgruppe_1_id,'-1') AS CHAR(3)) AS terminierungsgruppe_1_id,
CAST(COALESCE(v01.terminierungsgruppe_2_id,'-1') AS CHAR(2)) AS terminierungsgruppe_2_id,
CAST(COALESCE(v01.terminierungsgruppe_3_id,'-1') AS CHAR(2)) AS terminierungsgruppe_3_id,
CAST(COALESCE(v01.disposition_rhythmus_ltf_id,'-1') AS CHAR(3)) AS disposition_rhythmus_ltf_id,
v02.wg_id,
v02.arthiertyp_id,
v03.ausg_menge_einh_id,
v03.paletten_faktor_einh_id,
v05.art_id,
v04.disponent_id,
v04.wg_verkett_id,
v05.dat_lief_soll,
v05.lagernummer_id,
v05.lagerort_id,
CAST(v05.lief_pal_typ_id AS CHAR(2)) AS lief_pal_typ_id,
v05.bestellart_id,
v05.menge_lief_ist_kolli
FROM (SELECT
v051.mandant_id,
v051.wup_id AS kunde_id   -- Markt steht im Kopf
,
v051.nb_id AS nb_id_kunde -- Markt steht im Kopf	
,
/* ,v051.kunde_id*/
v051.dat_lief_soll,
v051.lagernummer_id,
v052.lagerort_id,
v051.lief_pal_typ_id,
v052.wup_id -- Verteilzentrum steht in der Position (Ein Markt kann die Bestellung von mehreren VZ geliefert bekommen)
,
v052.nb_id  -- Verteilzentrum steht in der Position (Ein Markt kann die Bestellung von mehreren VZ geliefert bekommen)
,
v052.art_id,
v052.best_beleg_id,
v052.bestellart_id,
/*,v053.bestellart_id*/
SUM(v052.menge_lief_ist_kolli) AS menge_lief_ist_kolli
FROM dbp_view.v_besch_lief_2 v051

INNER JOIN dbp_view.v_besch_lief_det_2 v052
ON v051.mandant_id = v052.mandant_id
AND v051.lief_beleg_id = v052.lief_beleg_id
AND v051.dat_lief_soll = v052.dat_lief_soll
AND v051.kj = v052.kj

/** lt. Email N. Wagner 26.09.2018 direkt aus besch_lief_det_2
	INNER JOIN dbp_data_fed_lis.besch_best_2 v053
		ON v052.mandant_id = v053.mandant_id
		AND v052.best_beleg_id = v053.best_beleg_id
		**/
GROUP BY v051.mandant_id
,v051.wup_id
,v051.nb_id
,v051.kunde_id
,v051.dat_lief_soll
,v051.lagernummer_id
,v052.lagerort_id
,v051.lief_pal_typ_id
,v052.wup_id   -- Verteilzentrum
,v052.nb_id    -- nb_id Verteilzentrum
,v052.art_id
,v052.best_beleg_id
,v052.bestellart_id
 --,v053.bestellart_id
) v05

INNER JOIN dbp_view.v_art_wg_zu_per_2 v02
ON v05.mandant_id    = v02.mandant_id
AND v05.art_id        = v02.art_id
AND v02.arthiertyp_id = 2
AND v02.dat_bis       = TO_DATE('9999-12-31', 'YYYY-MM_2-DD')

INNER JOIN dbp_view.v_art_vorschlagswert_per_2 v03
ON v05.mandant_id = v03.mandant_id
AND v05.art_id     = v03.art_id
AND v05.dat_lief_soll BETWEEN v03.dat_von AND v03.dat_bis

INNER JOIN dbp_view.v_art_wup_status_per_2 v04
ON v05.mandant_id = v04.mandant_id
AND v05.kunde_id   = v04.wup_id
AND v02.art_id     = v04.art_id
AND v05.dat_lief_soll BETWEEN v04.dat_von AND v04.dat_bis

LEFT JOIN
(-- das Max() auf den BBTYP sollte eigentlich nicht erforderlich sein, ist es aber! (Stand: 13.08.2018)
-- insbes. für NF-WGs kommt aus der Quelle kein Wert im BBTYP, zudem gibt es Duplikate
SELECT
v01_1.mandant_id,
v01_1.wup_id,
v01_1.nb_id,
v01_1.mandant_id AS mandant_id_kunde,
v01_1.kunde_id,
v01_1.auslieferungsgruppe_id,
v01_1.terminierungsgruppe_1_id,
v01_1.terminierungsgruppe_2_id,
v01_1.terminierungsgruppe_3_id,
v01_1.disposition_rhythmus_ltf_id,
v01_1.wg_id,
v01_1.arthiertyp_id,
v01_1.dat_von,
v01_1.dat_bis
FROM dbp_view.v_wup_kunde_wg_disporhythmus_lft_zu_per_2 v01_1
QUALIFY ROW_NUMBER() OVER (PARTITION BY v01_1.mandant_id
,v01_1.wup_id
,v01_1.nb_id
,v01_1.kunde_id
,v01_1.wg_id
,v01_1.arthiertyp_id
,v01_1.terminierungsgruppe_1_id
,v01_1.terminierungsgruppe_2_id
,v01_1.terminierungsgruppe_3_id
,v01_1.dat_bis
ORDER BY v01_1.sortimentslistenart_id DESC NULLS LAST) = 1
) v01
ON v05.mandant_id    = v01.mandant_id
AND v05.wup_id        = v01.wup_id  -- Verteilzentrum
AND v05.nb_id         = v01.nb_id   -- Verteilzentrum
AND v05.kunde_id      = v01.kunde_id
AND v02.wg_id         = v01.wg_id
AND v02.arthiertyp_id = v01.arthiertyp_id
AND v05.dat_lief_soll BETWEEN v01.dat_von AND v01.dat_bis
-- Tabelle wup_kunde_wg_disporhythmus_lft_zu_per_2 ist nur eindeutig mit den Terminierungsgruppen zum Disporhythmus zu joinen
-- das vorhande Feld art_wup_status_per.disposition_rhythmus_id ist eine_2 alte Information und wird nicht verwendet
-- der Disporhythmus muss daher aus der Tabelle dbp_data.wup_kunde_wg_disporhythmus_lft_zu_per_2 genommen werden
AND v04.terminierungsgruppe_1_id = v01.terminierungsgruppe_1_id
AND v04.terminierungsgruppe_2_id = v01.terminierungsgruppe_2_id
AND v04.terminierungsgruppe_3_id = v01.terminierungsgruppe_3_id

INNER JOIN dbp_view.v_wup_2 v06
   ON v06.mandant_id = v05.mandant_id
   AND v06.wup_id = CASE WHEN TRY_CAST(v05.kunde_id AS INTEGER) = 0 THEN NULL ELSE TRY_CAST(v05.kunde_id AS INTEGER) END
   AND ((v06.nb_id IN (2, 0, -111) AND v06.wup_id > 0) OR (v06.nb_id = -1 AND v06.wup_id = 0))


;