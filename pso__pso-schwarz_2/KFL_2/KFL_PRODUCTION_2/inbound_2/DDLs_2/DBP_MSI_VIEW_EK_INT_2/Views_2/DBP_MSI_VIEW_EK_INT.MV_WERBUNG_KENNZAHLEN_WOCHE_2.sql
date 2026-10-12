CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_WERBUNG_KENNZAHLEN_WOCHE_2
(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	KJWO,
	WERBE_TYP_ID,
	WTAG_ID_START,
	WTAG_ID_ENDE,
	POSTEN_ID,
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
	ART_ID,
	ART_DISPLAY_ID,
	ART_BASISMENGE_EINH_ID,
	ART_VERPART_ID,
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
	ANZAHL_TAGE_AKTION
) AS
--2022-09-27, dknop, adding avq_relevant_fg=1
--20221028, dknop, changing to COALESCE(avq_relevant_fg,1)
   SELECT
   wkw.mandant_id, wkw.nb_id, wkw.wup_id, wkw.kjwo, werbe_typ_id -- Kennzeichnung Werbewoche/Typ
   , wtag_id_start, wtag_id_ende, wkw.posten_id -- Kennzeichnung von Posten
   , CASE
   WHEN SUBSTR( msz.art_bez, 1, 2) = 'W.'  THEN 1
   WHEN SUBSTR( msz.art_bez, 1, 3) = 'IW.' THEN 1
   WHEN SUBSTR( msz.art_bez, LENGTH( msz.art_bez) - 1) = '/P'  THEN 1
   WHEN wkw.posten_id = '1' THEN 1
   ELSE 0
   END ::BYTEINT AS posten_fg, wkw.mutter_wb_id              AS art_mutter_wb_id, mwb.display_id                AS art_mutter_display_id, mwb.basismenge_einh_id        AS mwb_basismenge_einh_id, COALESCE(mwb.verpart_id,' ')  AS mwb_verpart_id, TO_VARCHAR((CASE WHEN wkw.mandant_id = 1 THEN (wkw.mutter_wb_id/100) ELSE (wkw.mutter_wb_id/10) END), 'FM00000000')  AS art_mutter_wb_nr -- formatierte Mutter-Artikelnr.
   , msz.art_bez                   AS art_mutter_wb_bez, CASE WHEN wkw.mutter_wb_id = wkw.art_id THEN 0 ELSE 1 END ::BYTEINT AS art_mutter_wb_fg -- Kennzeichnung Mutterelement
   , RANK() OVER (PARTITION BY wkw.mandant_id, wkw.wup_id, wkw.kjwo, werbe_typ_id, art_mutter_wb_id ORDER BY wkw.mandant_id, wkw.wup_id, wkw.kjwo, werbe_typ_id, art_mutter_wb_id, wkw.art_id) - 1 AS anz_art_kind, wkw.faktor_flaki     -- Faktor zur Umrechnung der Menge (Mutter-Artikel_2)
   , wkw.art_id, art.display_id               AS art_display_id, art.basismenge_einh_id       AS art_basismenge_einh_id, COALESCE(art.verpart_id,' ') AS art_verpart_id, wkw.menge_tag1, wkw.menge_tag2, wkw.menge_tag3, wkw.menge_tag4, wkw.menge_tag5, wkw.menge_tag6, wkw.menge_tag7, (wkw.menge_tag1 + wkw.menge_tag2 + wkw.menge_tag3 + wkw.menge_tag4 + wkw.menge_tag5 + wkw.menge_tag6 + wkw.menge_tag7)  AS menge, wkw.umsatz_netto_tag1, wkw.umsatz_netto_tag2, wkw.umsatz_netto_tag3, wkw.umsatz_netto_tag4, wkw.umsatz_netto_tag5, wkw.umsatz_netto_tag6, wkw.umsatz_netto_tag7, (wkw.umsatz_netto_tag1 + wkw.umsatz_netto_tag2 + wkw.umsatz_netto_tag3 + wkw.umsatz_netto_tag4 + wkw.umsatz_netto_tag5 + wkw.umsatz_netto_tag6 + wkw.umsatz_netto_tag7)  AS umsatz_netto, CASE WHEN wkw.menge_tag1 = 0 THEN 1 ELSE 0 END ::BYTEINT  AS menge_0_tag1, CASE WHEN wkw.menge_tag2 = 0 THEN 1 ELSE 0 END ::BYTEINT  AS menge_0_tag2, CASE WHEN wkw.menge_tag3 = 0 THEN 1 ELSE 0 END ::BYTEINT  AS menge_0_tag3, CASE WHEN wkw.menge_tag4 = 0 THEN 1 ELSE 0 END ::BYTEINT  AS menge_0_tag4, CASE WHEN wkw.menge_tag5 = 0 THEN 1 ELSE 0 END ::BYTEINT  AS menge_0_tag5, CASE WHEN wkw.menge_tag6 = 0 THEN 1 ELSE 0 END ::BYTEINT  AS menge_0_tag6, CASE WHEN wkw.menge_tag7 = 0 THEN 1 ELSE 0 END ::BYTEINT  AS menge_0_tag7, wkw.tage_menge_0  -- Anzahl der Tage ohne Abverkauf (berechnet im Backend)
   , wkw.we_menge_zentral    AS menge_we_zentrale, wkw.we_menge            AS menge_we, wkw.menge_aktionsstart, wkw.menge_endbestand, wkw.min_sicherh_bestand, menge_historie_af, anzahl_nullbestand, anzahl_tage_aktion

   /*- restekiste (=objects from older/earlier version not used anymore)
   , wkw.tage_menge_0 AS tage_menge_0_org
   , AVG(menge) OVER(PARTITION BY wkw.mandant_id, wkw.kjwo, wkw.art_id ORDER BY wkw.mandant_id, wkw.kjwo, wkw.art_id,wkw.nb_id, wkw.wup_id) AS menge_wup
   , (menge) / NULLIFZERO(menge_wareneinsatz) AS avk_quote
   , AVG(umsatz_netto) OVER(PARTITION BY wkw.mandant_id, wkw.kjwo, wkw.art_id ORDER BY wkw.mandant_id, wkw.kjwo, wkw.art_id,wkw.nb_id, wkw.wup_id) AS umsatz_netto_wup
   , 1 (BYTEINT) AS art_wup_fg
   , (wkw.menge_aktionsstart + wkw.we_menge) - wkw.min_sicherh_bestand AS menge_wareneinsatz
   , 0.00  AS anteil_sams
   , 0.00  AS menge_af_mo_mittel
   , 0.00  AS menge_af_di_mittel
   , 0.00  AS menge_mo
   , 0.00  AS menge_di
   , 0.00  AS menge_mi
   , 0.00  AS menge_do
   , 0.00  AS menge_fr
   , 0.00  AS menge_sams
   , 0.00  AS umsatz_netto_mo
   , 0.00  AS umsatz_netto_di
   , 0.00  AS umsatz_netto_mi
   , 0.00  AS umsatz_netto_do
   , 0.00  AS umsatz_netto_fr
   , 0.00  AS umsatz_netto_sams*/

   FROM
   dbp_view.v_werbung_kennzahlen_woche_2  wkw

   JOIN dbp_view.v_art_2 art_2
   ON art.mandant_id = wkw.mandant_id AND art.art_id = wkw.art_id
   AND art.dat_bis = SNOWCONVERT.PUBLIC.INT_TO_DATE_UDF(80991231)

   JOIN dbp_view.v_art_spr_zu_2  msz
   ON msz.mandant_id = wkw.mandant_id AND msz.art_id = wkw.mutter_wb_id
   AND msz.spr_id = 22

   JOIN dbp_view.v_art_2  mwb
   ON mwb.mandant_id = wkw.mandant_id AND mwb.art_id = wkw.mutter_wb_id
   AND mwb.dat_bis = SNOWCONVERT.PUBLIC.INT_TO_DATE_UDF(80991231)

   WHERE (wkw.menge_tag1 + wkw.menge_tag2 + wkw.menge_tag3 + wkw.menge_tag4 + wkw.menge_tag5 + wkw.menge_tag6 + wkw.menge_tag7) / CASE WHEN wkw.faktor_flaki = 0 THEN NULL ELSE wkw.faktor_flaki END <> 0.0
   OR wkw.we_menge_zentral / CASE WHEN wkw.faktor_flaki = 0 THEN NULL ELSE wkw.faktor_flaki END <> 0.0 AND COALESCE(avq_relevant_fg,1)=1;
