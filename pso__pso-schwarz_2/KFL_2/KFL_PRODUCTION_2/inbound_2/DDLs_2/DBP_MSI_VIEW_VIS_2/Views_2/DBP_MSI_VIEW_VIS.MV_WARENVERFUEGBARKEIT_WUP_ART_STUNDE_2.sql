CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_WARENVERFUEGBARKEIT_WUP_ART_STUNDE_2 (
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	ART_ID,
	DAT,
	ZEIT_STUNDE,
	BEWART_ID,
	AUSVERKAUFT_FG,
	ECKARTIKEL_FG,
	TOPSELLER_FG,
	ANZ_BON_GESAMT,
	ANZ_BON_ARTIKEL,
	MENGE_ABSATZ,
	STD_OFFEN,
	STD_VON,
	STD_BIS,
	ANZ_STD_AUSVERKAUFT,
	ANZ_STD_VERFUEGBAR,
	MAX_STD_VERFUEGBAR,
	ANZ_STD_MIT,
	ANZ_STD_OHNE,
	KERNZEIT_BIS,
	KERNZEIT_FG,
	KERNZEIT_OFFEN,
	KERNZEIT_STD_AUSVERKAUFT,
	KERNZEIT_STD_VERFUEGBAR,
	LAND_FILIALEN,
	LAND_STD_OFFEN,
	LAND_STD_VON,
	LAND_STD_BIS,
	LAND_STD_AUSVERKAUFT,
	LAND_AVG_AUSVERKAUFT,
	LAND_STD_VERFUEGBAR,
	LAND_AVG_VERFUEGBAR,
	LAND_MAX_VERFUEGBAR,
	LAND_KERNZEIT_STD_AUSVERKAUFT,
	LAND_KERNZEIT_AVG_AUSVERKAUFT,
	LAND_KERNZEIT_STD_VERFUEGBAR,
	LAND_KERNZEIT_AVG_VERFUEGBAR
) AS 

/*
	FAKT : Out of Stock pro Artikel_2/Stunde (CO-I)
	2024-09-19 Initial. Anfo CO-I [AP0225933]
	2024-09-27 Erweiterung Kernzeit/national [AP0225933]
	2025-07-14 ssch0611 : Anpassung Kernzeiten landesabhängigig [AP0266049]
	2025-11-17 ssch0611 : Anpassung Kernzeiten [NSR5705301]
*/

SELECT wv.mandant_id
	, wv.nb_id
	, wv.wup_id
	, wv.art_id
	, wv.dat_auswertung AS dat
	, wv.zeit_stunde
	, COALESCE(wv.bewart_id, -1) AS bewart_id /* 1001=af 1002=sa */
	, wv.ausverkauft_fg                       /* 1=ausverkauft 2=verfügbar */
	, wv.eckartikel_fg
	, wv.topseller_fg
	, wv.anz_bon_gesamt
	, wv.anz_bon_artikel
	, wv.menge_verkauft AS menge_absatz
	/* Berechnungen (reguläre_2 Öffnungszeit) */
	, COUNT(wv.zeit_stunde) OVER (PARTITION BY wv.mandant_id, wv.wup_id, wv.art_id, wv.dat_auswertung) AS std_offen /* öffnungsstunden */
	, MIN(wv.zeit_stunde) OVER (PARTITION BY wv.mandant_id, wv.wup_id, wv.art_id, wv.dat_auswertung) AS std_von   /* öffnung von */
	, MAX(wv.zeit_stunde) OVER (PARTITION BY wv.mandant_id, wv.wup_id, wv.art_id, wv.dat_auswertung) AS std_bis   /* öffnung bis */
	, COUNT(CASE WHEN wv.ausverkauft_fg = 1 THEN wv.zeit_stunde END) OVER (PARTITION BY wv.mandant_id, wv.wup_id, wv.art_id, wv.dat_auswertung) AS anz_std_ausverkauft /* stunden_2 in denen ausverkauft */
	, COUNT(CASE WHEN wv.ausverkauft_fg = 0 THEN wv.zeit_stunde END) OVER (PARTITION BY wv.mandant_id, wv.wup_id, wv.art_id, wv.dat_auswertung) AS anz_std_verfuegbar /* stunden_2 in denen verfügbar */
	, MAX(CASE WHEN wv.ausverkauft_fg = 0 THEN wv.zeit_stunde END) OVER (PARTITION BY wv.mandant_id, wv.wup_id, wv.art_id, wv.dat_auswertung) AS max_std_verfuegbar /* verfügbar bis */
	, COUNT(CASE WHEN wv.menge_verkauft > 0 THEN wv.zeit_stunde END) OVER (PARTITION BY wv.mandant_id, wv.wup_id, wv.art_id, wv.dat_auswertung) AS anz_std_mit /* stunden_2 mit abverkauf */
	, COUNT(CASE WHEN wv.menge_verkauft = 0 THEN wv.zeit_stunde END) OVER (PARTITION BY wv.mandant_id, wv.wup_id, wv.art_id, wv.dat_auswertung) AS anz_std_ohne /* stunden_2 ohne abverkauf */
	/* Berechnungen Ende Kernzeit (landesabhängig) */
	, CASE 
		WHEN wg.owg_id = 1008 AND wv.mandant_id = 1 THEN 18 /* Backshop DE      18 Uhr */
		WHEN wg.owg_id = 1008 AND wv.mandant_id > 1 THEN 18 /* Backshop Ausland 18 Uhr */
		WHEN wg.owg_id = 1010 AND wv.mandant_id = 1 THEN 20 /* Obst & Gemüse DE      20 Uhr */
		WHEN wg.owg_id = 1010 AND wv.mandant_id > 1 THEN 20 /* Obst & Gemüse Ausland 20 Uhr */
		WHEN wg.owg_id = 1013 AND wv.mandant_id = 1 THEN 20 /* Pflanzen DE      20 Uhr */
		WHEN wg.owg_id = 1013 AND wv.mandant_id > 1 THEN 20 /* Pflanzen Ausland 20 Uhr */
		ELSE                                             24 /* undefiniert (24) */
	  END AS kernzeit_bis
	, CASE WHEN wv.zeit_stunde < kernzeit_bis THEN 1 ELSE 0 END ::INTEGER AS kernzeit_fg
	, COUNT(CASE WHEN wv.zeit_stunde < kernzeit_bis THEN wv.zeit_stunde END) OVER (PARTITION BY wv.mandant_id, wv.wup_id, wv.art_id, wv.dat_auswertung) AS kernzeit_offen /* kernzeit stunden_2 */
	, COUNT(CASE WHEN wv.ausverkauft_fg = 1 AND wv.zeit_stunde < kernzeit_bis THEN wv.zeit_stunde END) OVER (PARTITION BY wv.mandant_id, wv.wup_id, wv.art_id, wv.dat_auswertung) AS kernzeit_std_ausverkauft /* kernzeit in der ausverkauft */
	, COUNT(CASE WHEN wv.ausverkauft_fg = 0 AND wv.zeit_stunde < kernzeit_bis THEN wv.zeit_stunde END) OVER (PARTITION BY wv.mandant_id, wv.wup_id, wv.art_id, wv.dat_auswertung) AS kernzeit_std_verfuegbar  /* kernzeit in der verfügbar */
	/* Berechnungen national */
	, COUNT(DISTINCT wv.wup_id)      OVER (PARTITION BY wv.mandant_id, wv.art_id, wv.dat_auswertung) AS land_filialen  /* filialen land_2*/
	, COUNT(DISTINCT wv.zeit_stunde) OVER (PARTITION BY wv.mandant_id, wv.art_id, wv.dat_auswertung) AS land_std_offen /* öffnungsstunden land_2 */
	, MIN(wv.zeit_stunde) OVER (PARTITION BY wv.mandant_id, wv.art_id, wv.dat_auswertung) AS land_std_von /* öffnung von land_2 */
	, MAX(wv.zeit_stunde) OVER (PARTITION BY wv.mandant_id, wv.art_id, wv.dat_auswertung) AS land_std_bis /* öffnung bis land_2 */
	, COUNT(CASE WHEN wv.ausverkauft_fg = 1 THEN wv.zeit_stunde END) OVER (PARTITION BY wv.mandant_id, wv.art_id, wv.dat_auswertung) AS land_std_ausverkauft /* gesamtstunden land_2 in denen ausverkauft */
	, land_std_ausverkauft / NULLIFZERO(land_filialen) AS land_avg_ausverkauft /* ø stunden_2 in denen ausverkauft */
	, COUNT(CASE WHEN wv.ausverkauft_fg = 0 THEN wv.zeit_stunde END) OVER (PARTITION BY wv.mandant_id, wv.art_id, wv.dat_auswertung) AS land_std_verfuegbar /* gesamtstunden land_2 in denen verfügbar */
	, land_std_verfuegbar / NULLIFZERO(land_filialen) AS land_avg_verfuegbar /* ø stunden_2 in denen verfügbar */
	, MAX(CASE WHEN wv.ausverkauft_fg = 0 THEN wv.zeit_stunde END) OVER (PARTITION BY wv.mandant_id, wv.art_id, wv.dat_auswertung) AS land_max_verfuegbar /* max. verfügbar bis land_2 */
	/* Berechnungen national Kernzeit */
	, COUNT(CASE WHEN wv.ausverkauft_fg = 1 AND wv.zeit_stunde < kernzeit_bis THEN wv.zeit_stunde END) OVER (PARTITION BY wv.mandant_id, wv.art_id, wv.dat_auswertung) AS land_kernzeit_std_ausverkauft /* kernzeit in der ausverkauft */
	, land_kernzeit_std_ausverkauft / NULLIFZERO(land_filialen) AS land_kernzeit_avg_ausverkauft /* ø stunden_2 in denen ausverkauft */
	, COUNT(CASE WHEN wv.ausverkauft_fg = 0 AND wv.zeit_stunde < kernzeit_bis THEN wv.zeit_stunde END) OVER (PARTITION BY wv.mandant_id, wv.art_id, wv.dat_auswertung) AS land_kernzeit_std_verfuegbar /* kernzeit in der verfügbar */
	, land_kernzeit_std_verfuegbar / NULLIFZERO(land_filialen) AS land_kernzeit_avg_verfuegbar   /* ø stunden_2 in denen verfügbar */
FROM dbp_data.warenverfuegbarkeit_wup_art_stunde_2 AS wv

INNER JOIN dbp_msi_view_vis.mv_art_wg_zu_2 AS art_2
	ON art.art_id = wv.art_id AND art.mandant_id = wv.mandant_id

INNER JOIN dbp_msi_view_vis.mv_wg_int_2 AS wg
	ON wg.wg_id = art.wg_id
;