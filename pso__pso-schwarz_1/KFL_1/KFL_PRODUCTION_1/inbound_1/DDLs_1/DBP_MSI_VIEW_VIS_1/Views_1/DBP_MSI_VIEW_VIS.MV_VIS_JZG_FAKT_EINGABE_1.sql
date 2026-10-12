CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_JZG_FAKT_EINGABE_1 (
	METRIK_ID,
	TYP_ID,
	LEVEL_ID,
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	GJ,
	ZIELWERT_EINGABE,
	KOMMENTAR_EINGABE,
	ZIELERREICH_EINGABE,
	ZEITSTEMPEL
) AS 
/*	FAKT JZG - Jahreszielgespräch - Eingabe Werte / Kommentare
	2025-01-21 ssch0611 : Review 2025. Neue TS Tabelle mit Zielereichung VJ [AP0244672]
	2025-03-31 ssch0611 : Final GJ2025. Umstellung Scans/min (KPOS) [AP0264011]
*/

SELECT jzg.metrik_id
	, jzg.typ_id
	, jzg.level_id
	, jzg.mandant_id
	, jzg.nb_id
	, wup.aktuell_wup_id  AS wup_id
	, krs.nach_wrg_id     AS wrg_id
	, jzg.gj
	, CASE /* Umrechnung 10 UMSATZ */
		WHEN jzg.metrik_id IN (10) THEN jzg.wert_eingabe * krs.umrechnungskurs
		ELSE jzg.wert_eingabe
		END AS zielwert_eingabe
	, jzg.kommentar_eingabe
	, jzg.zielerreich_eingabe
	, jzg.zeitstempel
FROM DBP_MSI_VIEW_VIS.TS_VIS_JZG_ZIEL_EINGABE_2025_1 jzg
INNER JOIN (
	SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs
	FROM DBP_DATA.KURS_1 krs1
	WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
	UNION ALL
	SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000
	FROM DBP_DATA.KURS_1 krs2
	WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31' AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')
	) krs
	ON krs.von_wrg_id = jzg.wrg_id
INNER JOIN DBP_VIEW.V_WUP_1 wup_1
	ON wup.mandant_id = jzg.mandant_id AND wup.wup_id = jzg.wup_id
;