CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WERBUNG_KENNZAHLEN_WOCHE (
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	KJWO,
	WERBE_TYP_ID,
	WTAG_ID_START,
	WTAG_ID_ENDE,
	POSTEN_ID,
	ART_MUTTER_POSTEN_FG,
	POSTEN_FG,
	ART_MUTTER_WB_ID,
	ART_MUTTER_DISPLAY_ID,
	MWB_BASISMENGE_EINH_ID,
	MWB_VERPART_ID,
	ART_MUTTER_WB_NR,
	ART_MUTTER_WB_BEZ,
	ART_MUTTER_WB_FG,
	ANZ_ART_KIND,
	FAKTOR_FLAKI,
	ART_MUTTER_BEZUGSWEG_ID,
	ART_MUTTER_SAISON_ID,
	ART_ID,
	ART_DISPLAY_ID,
	ART_BASISMENGE_EINH_ID,
	ART_VERPART_ID,
	ART_SAISON_ID,
	MENGE_TAG1,
	MENGE_TAG2,
	MENGE_TAG3,
	MENGE_TAG4,
	MENGE_TAG5,
	MENGE_TAG6,
	MENGE_TAG7,
	MENGE,
	UMSATZ_NETTO_TAG1,
	UMSATZ_NETTO_TAG2,
	UMSATZ_NETTO_TAG3,
	UMSATZ_NETTO_TAG4,
	UMSATZ_NETTO_TAG5,
	UMSATZ_NETTO_TAG6,
	UMSATZ_NETTO_TAG7,
	UMSATZ_NETTO,
	MENGE_0_TAG1,
	MENGE_0_TAG2,
	MENGE_0_TAG3,
	MENGE_0_TAG4,
	MENGE_0_TAG5,
	MENGE_0_TAG6,
	MENGE_0_TAG7,
	TAGE_MENGE_0,
	MENGE_WE_ZENTRALE,
	MENGE_WE,
	MENGE_AKTIONSSTART,
	MENGE_ENDBESTAND,
	MIN_SICHERH_BESTAND,
	MENGE_HISTORIE_AF,
	ANZAHL_NULLBESTAND,
	ANZAHL_TAGE_AKTION,
	TAGE_MENGE_0_ORG,
	MENGE_WUP,
	AVK_QUOTE,
	UMSATZ_NETTO_WUP,
	ART_WUP_FG,
	MENGE_WARENEINSATZ,
	ANTEIL_SAMS,
	MENGE_AF_MO_MITTEL,
	MENGE_AF_DI_MITTEL,
	MENGE_MO,
	MENGE_DI,
	MENGE_MI,
	MENGE_DO,
	MENGE_FR,
	MENGE_SAMS,
	UMSATZ_NETTO_MO,
	UMSATZ_NETTO_DI,
	UMSATZ_NETTO_MI,
	UMSATZ_NETTO_DO,
	UMSATZ_NETTO_FR,
	UMSATZ_NETTO_SAMS,
	LAGER_PROZENT,
	MHD_ZEITRAUM,
	SOLLBESTAND,
	MENGE_BESTAND_SOLL_MAX,
	WE_MENGE_VOR_AKTION,
	ANZAHL_NULLBESTAND_TAG1,
	ANZAHL_NULLBESTAND_TAG1BIS3,
	ANZAHL_MINUSBESTAND,
	ANZAHL_MINUSBESTAND_TAG1,
	ANZAHL_MINUSBESTAND_TAG1BIS3,
	VK_VOR_AKTION_BRUTTO,
	VK_AKTION_BRUTTO,
	VK_KCARD_BRUTTO
) 

AS
-- SPEZIAL Sonderauswertung Werbung pro Filiale/Artikel in Werbewoche + Tageswerte/Ateile
-- 20160112 ssch0611 : INITIAL
-- 20160126 ssch0611 : Version 2 - Werbung erweitert um Abverkaufsquote, Tageswerte
-- 20160202 ssch0611 : Version 3 - WE Menge Vorwoche/Zentrale
-- 20160331 ssch0611 : REDESIGN und Erweiterungen: 7 Tage, verschiedene Wertetypen, KMO
-- 17.0918 ssch0611 : Erweiterung Display_id + Reichweite (AP0019069) + Fehlartikel (AP0019065)
-- 20180621 jszc2108 : AVQ - added additional fact columns (AP0023487)
-- 20180723 jszc2108: added columns: art_mutter_bezugsweg_id, art_mutter_saison_id and art_saison_id; join to art_wup_status_per (AP0027015)
--20190122 aszu1204: added new columns for we_menge_vor_aktion and art_mutter_bezugsweg_id, remove join to art_wup_status_per as not needed any more (AP0023487)
--20190429 mcie1607: added new columns: anzahl_nullbestand_tag1 anzahl_nullbestand_tag1bis3  (AP0027015)
--20200129 nwag2310: extension of display_id with artikeltyp 12 (also implies art_id is a display)
--20200225 nwag2310: bugfix/extension of art_display_id with artikeltyp 12 (also implies art_id is a display)
--20201012 nwag2310: AP0070036 -> new columns for minusbestand (negative stock)
--20201020 nwag2310: AP0070036 -> switch to current mutter_wb_id
--20201125 nwag2310: AP0070036 -> always use _current_ mutter_wb_id -> bugfix for products that where made single instead of MuKi
--20220719 dknop: AP0135037_SPEC0157981 adding avq_relevant_fg  = 1
--20221028, dknop: changing to COALESCE(avq_relevant_fg,1)
--20231127, dknop: posten_fg taken from mwb instead of wkw
--2024-03-01, dknop, AP0197132, SPEC0224688, new logic for art_mutter_posten_fg and posten_fg, adding new columns: vk_vor_aktion_brutto,vk_aktion_brutto,vk_kcard_brutto 
--2024-08-27,AP0204035, SPEC0254614,dknop, adding aktuell_wup_id logic

SELECT
 wkw.mandant_id
,wkw.nb_id
--,wkw.wup_id
,aktuell_wup_id AS wup_id
,wkw.kjwo
,werbe_typ_id -- Kennzeichnung Werbewoche/Typ
,wtag_id_start
,wtag_id_ende
,wkw.posten_id -- Kennzeichnung von Posten

/*CASE
WHEN SUBSTR( msz.art_bez, 1, 2) = 'W.'  THEN 1
WHEN SUBSTR( msz.art_bez, 1, 3) = 'IW.' THEN 1
WHEN SUBSTR( msz.art_bez, LENGTH( msz.art_bez) - 1) = '/P'  THEN 1
WHEN mwb.posten_id = '1' THEN 1
ELSE 0
END::BYTEINT AS posten_fg,*/

,CASE WHEN mwb.posten_kz_sap <> '' THEN 1 ELSE 0 END AS art_mutter_posten_fg
,CASE WHEN art.posten_kz_sap <> '' THEN 1 ELSE 0 END AS posten_fg

,COALESCE(art.mutter_wb_id,art.art_id) AS art_mutter_wb_id
,CASE WHEN mwb.artikeltyp_id = 12 THEN  mwb.artikeltyp_id ELSE mwb.display_id END AS art_mutter_display_id
,mwb.basismenge_einh_id AS mwb_basismenge_einh_id
,COALESCE(mwb.verpart_id,' ')  AS mwb_verpart_id
-- Anpassung für Snowflake
,TO_VARCHAR(CASE WHEN wkw.mandant_id = 1 THEN (wkw.mutter_wb_id/100) ELSE (wkw.mutter_wb_id/10) END, 'FM00000000') AS art_mutter_wb_nr -- formatierte Mutter-Artikelnr.
 
,msz.art_bez AS art_mutter_wb_bez
,CASE WHEN wkw.mutter_wb_id = wkw.art_id THEN 0 ELSE 1 END::BYTEINT AS art_mutter_wb_fg -- Kennzeichnung Mutterelement
 
,RANK() OVER (PARTITION BY wkw.mandant_id, wkw.wup_id, wkw.kjwo, werbe_typ_id, art_mutter_wb_id ORDER BY wkw.mandant_id, wkw.wup_id, wkw.kjwo, werbe_typ_id, art_mutter_wb_id, wkw.art_id) - 1 AS anz_art_kind
,wkw.faktor_flaki     -- Faktor zur Umrechnung der Menge (Mutter-Artikel)
 
,wkw.art_mutter_bezugsweg_id
,mwb.saison_id AS art_mutter_saison_id
,wkw.art_id
,CASE WHEN art.artikeltyp_id = 12 THEN  art.artikeltyp_id ELSE art.display_id END AS art_display_id
,art.basismenge_einh_id       AS art_basismenge_einh_id
,COALESCE(art.verpart_id,' ') AS art_verpart_id
,art.saison_id AS art_saison_id
,wkw.menge_tag1
,wkw.menge_tag2
,wkw.menge_tag3
,wkw.menge_tag4
,wkw.menge_tag5
,wkw.menge_tag6
,wkw.menge_tag7
,(wkw.menge_tag1 + wkw.menge_tag2 + wkw.menge_tag3 + wkw.menge_tag4 + wkw.menge_tag5 + wkw.menge_tag6 + wkw.menge_tag7)  AS menge
,wkw.umsatz_netto_tag1
,wkw.umsatz_netto_tag2
,wkw.umsatz_netto_tag3
,wkw.umsatz_netto_tag4
,wkw.umsatz_netto_tag5
,wkw.umsatz_netto_tag6
,wkw.umsatz_netto_tag7
,(wkw.umsatz_netto_tag1 + wkw.umsatz_netto_tag2 + wkw.umsatz_netto_tag3 + wkw.umsatz_netto_tag4 + wkw.umsatz_netto_tag5 + wkw.umsatz_netto_tag6 + wkw.umsatz_netto_tag7)  AS umsatz_netto
,CASE WHEN wkw.menge_tag1 = 0 THEN 1 ELSE 0 END::BYTEINT  AS menge_0_tag1
,CASE WHEN wkw.menge_tag2 = 0 THEN 1 ELSE 0 END::BYTEINT  AS menge_0_tag2
,CASE WHEN wkw.menge_tag3 = 0 THEN 1 ELSE 0 END::BYTEINT  AS menge_0_tag3
,CASE WHEN wkw.menge_tag4 = 0 THEN 1 ELSE 0 END::BYTEINT  AS menge_0_tag4
,CASE WHEN wkw.menge_tag5 = 0 THEN 1 ELSE 0 END::BYTEINT  AS menge_0_tag5
,CASE WHEN wkw.menge_tag6 = 0 THEN 1 ELSE 0 END::BYTEINT  AS menge_0_tag6
,CASE WHEN wkw.menge_tag7 = 0 THEN 1 ELSE 0 END::BYTEINT  AS menge_0_tag7
,wkw.tage_menge_0  -- Anzahl der Tage ohne Abverkauf (berechnet im Backend)
,wkw.we_menge_zentral AS menge_we_zentrale
,wkw.we_menge AS menge_we
,wkw.menge_aktionsstart
,wkw.menge_endbestand
,wkw.min_sicherh_bestand
,menge_historie_af
,anzahl_nullbestand
,anzahl_tage_aktion
,wkw.tage_menge_0 AS tage_menge_0_org
,AVG(menge) OVER(PARTITION BY wkw.mandant_id, wkw.kjwo, wkw.art_id ORDER BY wkw.mandant_id, wkw.kjwo, wkw.art_id,wkw.nb_id, wkw.wup_id) AS menge_wup
,(menge) / CASE WHEN (wkw.menge_aktionsstart + wkw.we_menge) - wkw.min_sicherh_bestand = 0 THEN NULL ELSE (wkw.menge_aktionsstart + wkw.we_menge) - wkw.min_sicherh_bestand END AS avk_quote
,AVG(umsatz_netto) OVER(PARTITION BY wkw.mandant_id, wkw.kjwo, wkw.art_id ORDER BY wkw.mandant_id, wkw.kjwo, wkw.art_id,wkw.nb_id, wkw.wup_id) AS umsatz_netto_wup
,1::BYTEINT AS art_wup_fg
,(wkw.menge_aktionsstart + wkw.we_menge) - wkw.min_sicherh_bestand AS menge_wareneinsatz
,0.00  AS anteil_sams
,0.00  AS menge_af_mo_mittel
,0.00  AS menge_af_di_mittel
,0.00  AS menge_mo
,0.00  AS menge_di
,0.00  AS menge_mi
,0.00  AS menge_do
,0.00  AS menge_fr
,0.00  AS menge_sams
,0.00  AS umsatz_netto_mo
,0.00  AS umsatz_netto_di
,0.00  AS umsatz_netto_mi
,0.00  AS umsatz_netto_do
,0.00  AS umsatz_netto_fr
,0.00  AS umsatz_netto_sams
,(wkw.lager_prozent*0.01) AS lager_prozent
,wkw.mhd_zeitraum
,wkw.sollbestand
,wkw.menge_bestand_soll_max
,wkw.we_menge_vor_aktion
,wkw.anzahl_nullbestand_tag1
,wkw.anzahl_nullbestand_tag1bis3
,wkw.anzahl_minusbestand
,wkw.anzahl_minusbestand_tag1
,wkw.anzahl_minusbestand_tag1bis3
,wkw.vk_vor_aktion_brutto
,wkw.vk_aktion_brutto
,wkw.vk_kcard_brutto
FROM dbp_view.v_werbung_kennzahlen_woche wkw

INNER JOIN dbp_view.v_wup v05
ON v05.mandant_id = wkw.mandant_id
AND v05.wup_id = wkw.wup_id
AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0))


JOIN dbp_view.v_art art
ON art.mandant_id = wkw.mandant_id AND art.art_id = wkw.art_id
AND art.dat_bis = '9999-12-31'

JOIN dbp_view.v_art_spr_zu msz
ON msz.mandant_id = wkw.mandant_id AND msz.art_id = COALESCE(art.mutter_wb_id,art.art_id)
AND msz.spr_id = 22

JOIN dbp_view.v_art mwb
ON mwb.mandant_id = wkw.mandant_id AND mwb.art_id = COALESCE(art.mutter_wb_id,art.art_id)
AND mwb.dat_bis = '9999-12-31'

WHERE COALESCE(avq_relevant_fg,1)  = 1;