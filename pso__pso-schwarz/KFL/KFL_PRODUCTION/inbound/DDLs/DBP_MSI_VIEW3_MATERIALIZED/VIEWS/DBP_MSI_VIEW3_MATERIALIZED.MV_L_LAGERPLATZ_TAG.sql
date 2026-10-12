create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_L_LAGERPLATZ_TAG(
	LAGERPLATZ_ID,
	LAGERNUMMER_ID,
	MANDANT_ID,
	LAGERTYP_ID,
	WUP_ID,
	NB_ID,
	LAGERBEREICH_ID,
	EINLAGER_SPERR_FG,
	AUSLAGER_SPERR_FG,
	ANZAHL_QUANT,
	KOMM_BEREICH,
	BRAND_ABSCHNITT_ID,
	LAGERPLATZ_TYP_ID,
	LAGERPLATZ_GEWICHT_MAX,
	DAT
) as
   SELECT

   v01.lagerplatz_id, v01.lagernummer_id, v01.mandant_id, v01.lagertyp_id, v01.wup_id, v01.nb_id, v01.lagerbereich_id, v01.einlager_sperr_fg, v01.auslager_sperr_fg, v01.anzahl_quant, CASE WHEN TRIM(COALESCE(v01.komm_bereich,'')) <> '' THEN v01.komm_bereich ELSE 'kein Kommbereich' END AS komm_bereich, CAST(COALESCE(v01.brand_abschnitt_id,'-1') AS CHAR(2) ) AS brand_abschnitt_id, v01.lagerplatz_typ_id, lagerplatz_gewicht_max, v02.dat
   FROM dbp_view.v_l_lagerplatz v01
   INNER JOIN dbp_view.v_tag v02
   ON v02.dat BETWEEN v01.dat_von AND v01.dat_bis
   WHERE v02.dat >= '2014-01-01';