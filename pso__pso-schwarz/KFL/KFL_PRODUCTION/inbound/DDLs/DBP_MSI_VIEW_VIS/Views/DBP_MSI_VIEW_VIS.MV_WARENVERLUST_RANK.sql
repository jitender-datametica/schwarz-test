create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_WARENVERLUST_RANK(
	MANDANT_ID COMMENT 'Mandant im DWH',
	VS_ID COMMENT 'ID der Vertriebsschiene',
	WUP_ID COMMENT 'Der \""WUP\"" beinhaltet Märkte und Lager. WUP = WarenUmschlagsPlatz. Mutter WUP ID wird verwendet für Beziehung Lager zu Verteilzentrum.',
	ART_ID COMMENT 'Artikelnummer im DWH. Input: Artikel-ID einschließlich der Generationen-ID (9-stellig); Output: 7-stellige L&S-ID + Counter = 8-stellige Artikel-ID. WWNNNNPC (Warengruppe, Nummer, Prüfziffer, Counter) Regel: Neuer Artikel -> Counter +1.',
	WG_HIST_ID COMMENT 'ID der Warengruppe',
	OWG_HIST_ID COMMENT 'ID der Oberwarengruppe',
	HWG_HIST_ID COMMENT 'ID der Hauptwarengruppe',
	ABT_HIST_ID COMMENT 'Abteilungs-ID, negative Werte: im DWH generierte IDs; positive Werte: aus Stammdatensystem übernommen.',
	WRG_ID COMMENT 'Kurzbezeichnung der Währung, z.B. CZK, EUR',
	INVENTURART_ID COMMENT 'Inventurarten aus SAP. Unterscheidung, ob bsp. Jahres-, Frische- oder Sonderinventur. Siehe Inventurart_spr_zu.',
	DAT_INVENTUR_VON COMMENT 'Start des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land unterscheiden.',
	DAT_INVENTUR_BIS COMMENT 'Ende des betrachteten Inventurzeitraums. Dieser Zeitraum unterliegt keiner festen zeitlichen Größe und kann sich je Land unterscheiden.',
	GJ COMMENT 'Geschäftsjahr, dem Inventurzeitraum zugeordnet werden soll. 28.02.2024 kann beispielsweise in der Betrachtung zum Inventurzeitraum des GJ 2024 statt 2023 gehören.',
	INVENTUR_ID COMMENT 'Eindeutige hochgezählte Nummer über alle Felder des Excel-Uploads',
	WV_UMSATZ_NETTO_WUP COMMENT 'Umsatz der betroffenen Inventur-Artikel im definierten Inventur-Zeitraum je Betrieb',
	WV_INVENTUR_NETTO_WUP COMMENT 'Saldierte Inventur-Differenz-Werte je Artikel und Betrieb im definierten Inventur-Zeitraum',
	WV_MENGE_INVENTUR_WUP COMMENT 'Saldierte Inventur-Differenz-Mengen je Artikel und Betrieb im definierten Inventur-Zeitraum',
	WV_UMSATZ_NETTO_AUFG_WUP COMMENT 'Aufgelaufener Umsatz der betroffenen Inventur-Artikel im definierten Inventur-Zeitraum je Betrieb',
	WV_INVENTUR_NETTO_AUFG_WUP COMMENT 'Aufgelaufene Saldierte Inventur-Differenz-Werte je Artikel und Betrieb im definierten Inventur-Zeitraum',
	WV_MENGE_INVENTUR_AUFG_WUP COMMENT 'Aufgelaufene Saldierte Inventur-Differenz-Mengen je Artikel und Betrieb im definierten Inventur-Zeitraum',
	ART_WUP_FG COMMENT 'Flag for first appearance of an article for one store and one business year',
	ART_VS_FG COMMENT 'Flag for first appearance of an article for one region and one business year',
	ART_MDT_FG COMMENT 'Flag for first appearance of an article for one country and one business year',
	WV_INVENTUR_NETTO_QUOTE COMMENT 'Anteil von Inventurdifferenz zu Umsatz (auf Filialebene)',
	WV_INVENTUR_NETTO_AUFG_QUOTE COMMENT 'Anteil von aufgelaufener Inventurdifferenz zu aufgelaufenem Umsatz (auf Filialebene)',
	WV_INVENTUR_NETTO_VS COMMENT 'Inventurdifferenz aggregiert auf Regionsebene (nur einmal pro Region und nicht für alle Zeilen berechnet)',
	WV_UMSATZ_NETTO_VS COMMENT 'Umsatz aggregiert auf Regionsebene (nur einmal pro Region und nicht für alle Zeilen berechnet)',
	WV_INVENTUR_NETTO_MDT COMMENT 'Inventurdifferenz aggregiert auf Landesebene (nur einmal pro Land und nicht für alle Zeilen berechnet)',
	WV_UMSATZ_NETTO_MDT COMMENT 'Umsatz aggregiert auf Landesebene (nur einmal pro Land und nicht für alle Zeilen berechnet)',
	WV_INVENTUR_NETTO_RANK COMMENT 'Ranking nach Inventurdifferenz',
	WV_INVENTUR_NETTO_RANK_AUFG COMMENT 'Ranking nach aufgelaufener Inventurdifferenz',
	WV_INVENTUR_NETTO_RANK_VS COMMENT 'Ranking nach Inventurdifferenz pro Region',
	WV_INVENTUR_NETTO_RANK_MDT COMMENT 'Ranking nach Inventurdifferenz pro Land'
) as




WITH 

facts_inventur_warenverlust AS (
	SELECT i.mandant_id
		, w.vs_id 
		, i.wup_id
		, i.art_id
		, i.wg_hist_id
		, i.owg_hist_id
		, i.hwg_hist_id
		, i.abt_hist_id
		, i.wrg_id
		, i.inventurart_id
		, i.dat_inventur_von
		, i.dat_inventur_bis
		, i.gj
		, i.inventur_id
		, i.wv_umsatz_netto
		
		
		, i.wv_inventur_netto
		, i.wv_menge_inventur
		
		, i.wv_umsatz_netto_aufg
		
		
		, i.wv_inventur_netto_aufg
		, i.wv_menge_inventur_aufg
		
	FROM dbp_msi_view_vis.mv_warenverlust i 
	LEFT OUTER JOIN dbp_msi_view_vis.mv_wup w 
		USING (mandant_id, wup_id)
	WHERE i.inventurart_id = 3 
	QUALIFY DENSE_RANK() OVER (
		PARTITION BY i.mandant_id, w.vs_id, i.wup_id, i.wrg_id 
		ORDER BY i.mandant_id, w.vs_id, i.wup_id, i.wrg_id, i.dat_inventur_bis DESC
		) <= 3 
	
	),

facts_flagged AS (
	SELECT mandant_id
		, vs_id
		, wup_id
		, art_id
		, wg_hist_id
		, owg_hist_id
		, hwg_hist_id
		, abt_hist_id
		, wrg_id
		, inventurart_id
		, dat_inventur_von
		, dat_inventur_bis
		, gj
		, inventur_id
		, wv_umsatz_netto
		, wv_inventur_netto
		, wv_menge_inventur
		, wv_umsatz_netto_aufg
		, wv_inventur_netto_aufg
		, wv_menge_inventur_aufg
		, ROW_NUMBER() OVER (
			PARTITION BY mandant_id, vs_id, wup_id, wrg_id, art_id, gj 
			ORDER BY mandant_id, vs_id, wup_id, wrg_id, art_id, gj, dat_inventur_bis DESC
			) AS art_wup_nr
		, IFF(art_wup_nr = 1, art_wup_nr, 0) AS art_wup_fg 
		, ROW_NUMBER() OVER (
			PARTITION BY mandant_id, vs_id, wrg_id, art_id, gj 
			ORDER BY mandant_id, vs_id, wup_id, wrg_id, art_id, gj, dat_inventur_bis DESC
			) AS art_vs_nr
		, IFF(art_vs_nr = 1, art_vs_nr, 0) AS art_vs_fg 
		, ROW_NUMBER() OVER (
			PARTITION BY mandant_id, wrg_id, art_id, gj 
			ORDER BY mandant_id, vs_id, wup_id, wrg_id, art_id, gj, dat_inventur_bis DESC
			) AS art_mandant_nr
		, IFF(art_mandant_nr = 1, art_mandant_nr, 0) AS art_mdt_fg 
	FROM facts_inventur_warenverlust 
	),

facts_aggregated AS (
	SELECT mandant_id
		, vs_id
		, wup_id
		, art_id
		, wg_hist_id
		, owg_hist_id
		, hwg_hist_id
		, abt_hist_id
		, wrg_id
		, inventurart_id
		, dat_inventur_von
		, dat_inventur_bis
		, gj
		, inventur_id
		, wv_umsatz_netto 
		, wv_inventur_netto	
		, wv_menge_inventur
		, wv_umsatz_netto_aufg 
		, wv_inventur_netto_aufg 
		, wv_menge_inventur_aufg
		, art_wup_fg 
		, art_vs_fg 
		, art_mdt_fg 
		
		, DIV0(wv_inventur_netto, wv_umsatz_netto) AS wv_inventur_netto_quote
		, DIV0(wv_inventur_netto_aufg, wv_umsatz_netto_aufg) AS wv_inventur_netto_aufg_quote
		 
		, IFF(art_vs_fg = 1, 
			SUM(wv_inventur_netto) OVER (PARTITION BY mandant_id, vs_id, wrg_id, art_id, gj), 
			NULL) AS wv_inventur_netto_vs
		, IFF(art_vs_fg = 1
			, SUM(wv_umsatz_netto) OVER (PARTITION BY mandant_id, vs_id, wrg_id, art_id, gj), 
			NULL) AS wv_umsatz_netto_vs
		
		
		, IFF(art_mdt_fg = 1, 
			SUM(wv_inventur_netto) OVER (PARTITION BY mandant_id, wrg_id, art_id, gj), 
			NULL) AS wv_inventur_netto_mdt
		, IFF(art_mdt_fg = 1, 
			SUM(wv_umsatz_netto) OVER (PARTITION BY mandant_id, wrg_id, art_id, gj), 
			NULL) AS wv_umsatz_netto_mdt
		
	FROM facts_flagged
	),
rankings AS (
	SELECT mandant_id
		, vs_id
		, wup_id
		, art_id
		, wg_hist_id
		, owg_hist_id
		, hwg_hist_id
		, abt_hist_id
		, wrg_id
		, inventurart_id
		, dat_inventur_von
		, dat_inventur_bis
		, gj
		, inventur_id
		, wv_umsatz_netto
		, wv_inventur_netto
		, wv_menge_inventur
		, wv_umsatz_netto_aufg
		, wv_inventur_netto_aufg
		, wv_menge_inventur_aufg
		, art_wup_fg 
		, art_vs_fg 
		, art_mdt_fg
		, wv_inventur_netto_quote
		, wv_inventur_netto_aufg_quote
		, wv_inventur_netto_vs
		, wv_umsatz_netto_vs
		, wv_inventur_netto_mdt
		, wv_umsatz_netto_mdt
		
		
		
		, IFF(wv_inventur_netto IS NOT NULL, 
			DENSE_RANK() OVER ( 
				PARTITION BY mandant_id, vs_id, wup_id, wrg_id, gj
				ORDER BY wv_inventur_netto DESC NULLS LAST 
				),
			NULL) AS wv_inventur_netto_rank
		, IFF(wv_inventur_netto_aufg IS NOT NULL, 
			DENSE_RANK() OVER ( 
				PARTITION BY mandant_id, vs_id, wup_id, wrg_id, gj 
				ORDER BY wv_inventur_netto_aufg DESC NULLS LAST  
				),
			NULL) AS wv_inventur_netto_rank_aufg
		 
		, IFF(wv_inventur_netto_vs IS NOT NULL, 
			DENSE_RANK() OVER ( 
				PARTITION BY mandant_id, vs_id, wrg_id, gj 
				ORDER BY wv_inventur_netto_vs DESC NULLS LAST 
				),
			NULL) AS wv_inventur_netto_rank_vs
		
		, IFF(wv_inventur_netto_mdt IS NOT NULL, 
			DENSE_RANK() OVER ( 
				PARTITION BY mandant_id, wrg_id, gj 
				ORDER BY wv_inventur_netto_mdt DESC NULLS LAST 
				),
			NULL) AS wv_inventur_netto_rank_mdt
	FROM facts_aggregated
	WHERE wv_umsatz_netto IS NOT NULL 
		OR (wv_umsatz_netto_aufg IS NOT NULL 
			AND wv_umsatz_netto_aufg <> 0) 
		OR wv_inventur_netto IS NOT NULL 
		OR (wv_inventur_netto_aufg IS NOT NULL 
			AND wv_inventur_netto_aufg <> 0) 
		OR wv_menge_inventur IS NOT NULL 
		OR (wv_menge_inventur_aufg IS NOT NULL 
			AND wv_menge_inventur_aufg <> 0) 
	)
SELECT mandant_id
	, vs_id
	, wup_id
	, art_id
	, wg_hist_id
	, owg_hist_id
	, hwg_hist_id
	, abt_hist_id
	, wrg_id
	, inventurart_id
	, dat_inventur_von
	, dat_inventur_bis
	, gj
	, inventur_id
	, wv_umsatz_netto			AS wv_umsatz_netto_wup
	, wv_inventur_netto			AS wv_inventur_netto_wup
	, wv_menge_inventur			AS wv_menge_inventur_wup
	, wv_umsatz_netto_aufg		AS wv_umsatz_netto_aufg_wup
	, wv_inventur_netto_aufg	AS wv_inventur_netto_aufg_wup
	, wv_menge_inventur_aufg	AS wv_menge_inventur_aufg_wup
	, art_wup_fg 
	, art_vs_fg 
	, art_mdt_fg
	, wv_inventur_netto_quote
	, wv_inventur_netto_aufg_quote
	, wv_inventur_netto_vs
	, wv_umsatz_netto_vs
	, wv_inventur_netto_mdt
	, wv_umsatz_netto_mdt
	
	
	, wv_inventur_netto_rank
	, wv_inventur_netto_rank_aufg
	, wv_inventur_netto_rank_vs
	, wv_inventur_netto_rank_mdt
FROM rankings	

;
