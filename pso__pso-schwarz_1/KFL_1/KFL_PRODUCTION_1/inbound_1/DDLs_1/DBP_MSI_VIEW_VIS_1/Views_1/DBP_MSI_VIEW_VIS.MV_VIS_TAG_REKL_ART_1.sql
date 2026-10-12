CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_TAG_REKL_ART_1(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	DAT,
	ART_ID,
	REKLAMATIONSGRUND_ID,
	KASSE_NR,
	BON_NR,
	START_BON_ZEILE,
	GP_ID,
	MHD,
	LOS_CHARGE,
	ART_ID_REF,
	KUNDEN_TEXT,
	BON_STORNO_FG,
	MIT_WARE_FG,
	WRG_ID,
	BETRAG,
	VK_MENGE_RE,
	VK_MENGE_KUGA,
	VK_BRUTTO_RE,
	VK_NETTO_RE,
	VK_MWST_RE,
	ANZ_POS
) AS
 
/*
	FAKT : Reklamationen Artikelebene pro Filiale/Tag_1 
	2012KW19 : Initial QBM-Bericht Retouren ohne Ware
	20150703 : Anpassung Berechnung Menge (aus Betrag) + Union fuer EUR Werte
	20161005 srom0404: die Zeilenstorno werden über ODS in die Tabelle rekl_1 geliefert. Dadurch werden die Reklamationen doppelt gezählt
			ODS muss um Storno Flag erweitert werden und nur die 'echten' Reklamationen an rekl_1 geliefert werden.
			Die historischen Daten werden idealerweise korrigiert. Als Workaround hier in der View die Verdichtung und nur die Sätze 
			behalten, deren Menge in der Summe <> 0 ist. Die Storno heben die ursprüngliche Zeile auf.
			Unschärfe: Ist der gleiche Artikel_1 mehrmals pro Bon enthalten, werden die nicht stornierten zu einer Zeile zusammengefasst und als eine_1 Reklamation gezählt.
			Über pos_nr kann nicht gruppiert werden, dadurch entfällt dieses Feld in der View 
	2019.0123 ssch0611 : Betrag zeitabhaengig
	2019.03.08 dsim0608: Adding start_bon_zeile - SPEC0049553
	2019.0520 ssch0611 : Added Moldau + Bugfix in EUR-Part
	20200619 mwst join geändert auf dat between
	2020-09-15 ssch0611 : changed 2nd mwst join, added count pos_nr 
	2022-12-09 ssch0611 : Review + Calculation EUR with new logic [P16167] 
	2024-06-20 muellerpatri : Filialumgliederung + Review [P1760-DWH]
	2024-09-02 ssch0611 : Kundengarantie - Betrag MD = 50 MDL geändert
	2025-04-01 ssch0611 : Historisierung art_1 > art_per_1 
	2026-01-13 ssch0611 : Logik für BETRAG Gutschein_1 angepasst(wir nicht mehr benötigt) [EUR/BG]
*/ 

SELECT rekl.mandant_id
	, rekl.nb_id
	, wup.aktuell_wup_id AS wup_id
	, rekl.dat
	, rekl.art_id
	, rekl.reklamationsgrund_id
	, rekl.kasse_nr
	, rekl.bon_nr
	, rekl.start_bon_zeile
	, rekl.gp_id
	, rekl.mhd
	, rekl.los_charge
	, rekl.art_id_ref
	, rekl.kunden_text
	, rekl.bon_storno_fg
	, rekl.mit_ware_fg
	, krs.nach_wrg_id AS wrg_id
	/* Helper. Fester Gutschein_1 Betrag um Menge für Kundengarantien zu berechnen -- 2026-01-13 */
	, MAX(CASE WHEN rekl.reklamationsgrund_id IN (91, 92, 93) THEN CASE
		WHEN rekl.mandant_id = 1 AND rekl.wrg_id='EUR' THEN  2.50
		WHEN rekl.mandant_id = 5 AND rekl.wrg_id='EUR' THEN  2.00
		WHEN rekl.mandant_id = 2 AND rekl.wrg_id='CZK' THEN 50.00 
		WHEN rekl.mandant_id = 3 AND rekl.wrg_id='PLN' THEN  5.00
		WHEN rekl.mandant_id = 7 AND rekl.wrg_id='RON' THEN 10.00
		WHEN rekl.mandant_id = 4 AND rekl.wrg_id='MDL' THEN 50.00 
		WHEN rekl.mandant_id = 6 AND rekl.wrg_id='EUR' AND rekl.dat > '2022-12-31' THEN  2.00 /*  2.00 EUR Einführung HR */
		WHEN rekl.mandant_id = 6 AND rekl.wrg_id='EUR' AND rekl.dat < '2023-01-01' THEN  1.33 /* 10.00 HRK rückbewertet */
		WHEN rekl.mandant_id = 8 AND rekl.wrg_id='EUR' AND rekl.dat > '2025-12-31' THEN  1.50 /*  1.50 EUR Einführung BG */
		WHEN rekl.mandant_id = 8 AND rekl.wrg_id='EUR' AND rekl.dat < '2026-01-01' THEN  1.53 /*  3.00 BGN rüchbewertet */
		ELSE 1.00 END /* undefiniert */
	ELSE 1 END) AS BETRAG 
	, SUM(rekl.vk_menge_re)                                                         AS vk_menge_re
	, SUM(rekl.vk_brutto_re) / BETRAG                                               AS vk_menge_kuga /* Fallback, alte Logik */
	, SUM(rekl.vk_brutto_re * krs.umrechnungskurs)                                  AS vk_brutto_re
	, SUM((rekl.vk_brutto_re / (1.00 + mwstp.mwst / 100.00)) * krs.umrechnungskurs) AS vk_netto_re
	, SUM(rekl.vk_brutto_re * krs.umrechnungskurs) - vk_netto_re                    AS vk_mwst_re
	, COUNT(DISTINCT rekl.pos_nr)                                                   AS anz_pos
FROM DBP_VIEW.V_REKL_1  rekl_1

JOIN DBP_VIEW.V_ART_PER_1 artp
ON rekl.art_id = artp.art_id AND rekl.mandant_id = artp.mandant_id
	AND rekl.dat BETWEEN artp.dat_von AND artp.dat_bis

JOIN DBP_VIEW.V_MWST_PER_1 mwstp
ON artp.mwst_id = mwstp.mwst_id AND artp.mandant_id = mwstp.mandant_id
	AND rekl.dat BETWEEN mwstp.dat_von AND mwstp.dat_bis

INNER JOIN ( 
	/*PART I : Landeswährung in EUR */
	SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
	FROM DBP_DATA.KURS_1 krs1 
	WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
		AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
	UNION ALL 
	/* PART II : Landeswährung beibehalten */
	SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
	FROM DBP_DATA.KURS_1 krs2 
	WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
		AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
) krs
ON krs.von_wrg_id = rekl.wrg_id

JOIN DBP_VIEW.V_WUP_1 wup_1
ON rekl.mandant_id = wup.mandant_id AND rekl.wup_id = wup.wup_id

WHERE rekl.bon_storno_fg = 0 /* ohne Bonstornos (analog AIS) */

GROUP BY ALL

HAVING SUM(rekl.vk_menge_re) <> 0 /* Zeilenstorno heben sich auf (Test_1 ist 0) */
;