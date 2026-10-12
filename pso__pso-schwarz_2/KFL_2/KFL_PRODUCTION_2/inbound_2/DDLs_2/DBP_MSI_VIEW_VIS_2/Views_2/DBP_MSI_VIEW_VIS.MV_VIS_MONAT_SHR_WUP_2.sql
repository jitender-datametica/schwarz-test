CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_SHR_WUP_2 (
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	WRG_ID,
	GJ,
	KJMO,
	AKT_MO,
	MO_KJ,
	AKT_MO_SHR,
	FRUEHINFO2,
	PERS_KOSTEN,
	PERS_KOSTEN_KVJ,
	PERS_KOSTEN_PLAN,
	UMS_NETTO,
	UMS_NETTO_KVJ,
	UMS_NETTO_PLAN,
	STUNDEN_NETTO,
	STUNDEN_NETTO_KVJ,
	STUNDEN_PLAN,
	KOPF,
	KOPF_KVJ,
	KOPF_FIL,
	KOPF_FIL_KVJ,
	VZK_EXT,
	VZK_EXT_KVJ,
	KOPF_FILIALE,
	KOPF_FILIALE_KVJ,
	KOPF_FILIALE_TEILZEIT,
	KOPF_FILIALE_TEILZEIT_KVJ,
	VZK_FILIALE,
	VZK_FILIALE_KVJ,
	STUNDEN_ZUSCHLAG_FEIERTAG,
	STUNDEN_ZUSCHLAG_FEIERTAG_KVJ,
	STUNDEN_ZUSCHLAG_MEHR,
	STUNDEN_ZUSCHLAG_MEHR_KVJ,
	STUNDEN_ZUSCHLAG_SPAET_NACHT,
	STUNDEN_ZUSCHLAG_SPAET_NACHT_KVJ,
	STUNDEN_ZUSCHLAG_WOCHENENDE,
	STUNDEN_ZUSCHLAG_WOCHENENDE_KVJ,
	STUNDEN_MEHR_GELEISTET,
	STUNDEN_MEHR_GELEISTET_KVJ,
	STUNDEN_MEHR_BEZAHLT,
	STUNDEN_MEHR_BEZAHLT_KVJ,
	STUNDEN_VERTRAG,
	STUNDEN_VERTRAG_KVJ,
	TAGE_KRANK,
	TAGE_KRANK_KVJ,
	TAGE_ARBEIT_SOLL,
	TAGE_ARBEIT_SOLL_KVJ,
	KOPF_MA,
	KOPF_MA_KVJ,
	KOPF_MA_TEILZEIT,
	KOPF_MA_TEILZEIT_KVJ,
	VZK_MA,
	VZK_MA_KVJ,
	STUNDEN_VERTRAG_MA,
	STUNDEN_VERTRAG_MA_KVJ,
	KOPF_FE,
	KOPF_FE_KVJ,
	KOPF_FE_TEILZEIT,
	KOPF_FE_TEILZEIT_KVJ,
	VZK_FE,
	VZK_FE_KVJ,
	STUNDEN_VERTRAG_FE,
	STUNDEN_VERTRAG_FE_KVJ,
	KOPF_GESAMT,
	KOPF_GESAMT_KVJ,
	KOPF_OHNE_LZA,
	KOPF_OHNE_LZA__KVJ,
	KOPF_TEILZEIT,
	KOPF_TEILZEIT_KVJ,
	KOPF_EINTRITTE,
	KOPF_EINTRITTE_KVJ,
	VZK_GESAMT,
	VZK_GESAMT_KVJ,
	VZK_EINTRITT,
	VZK_EINTRITT_KVJ,
	VZK_AUSTRITT,
	VZK_AUSTRITT_KVJ,
	VZK_FLUKTUATION,
	VZK_FLUKTUATION_VMO,
	VZK_FLUKTUATION_KVJ,
	VZK_FLUKTUATION_KVJMO,
	WUP_FLUKT_ROL_FG,
	WUP_KOPF_FLUKT_AKTMO,
	WUP_KOPF_FLUKT_VORMO,
	WUP_KOPF_FLUKT_AKTMOVJ,
	WUP_KOPF_FLUKT_VORMOVJ,
	WUP_KOPF_FLUKTUATION,
	WUP_KOPF_FLUKTUATION_KVJ,
	WUP_KOPF_AUSTRITTE,
	WUP_KOPF_AUSTRITTE_KVJ,
	WUP_KOPF_FLUKTUATION_ROL,
	WUP_KOPF_FLUKTUATION_KVJ_ROL,
	WUP_KOPF_AUSTRITTE_ROL,
	WUP_KOPF_AUSTRITTE_KVJ_ROL,
	WUP_KOPF_AUSTRITT_AN,
	WUP_KOPF_AUSTRITT_AG,
	WUP_KOPF_AUSTRITT_AN_KVJ,
	WUP_KOPF_AUSTRITT_AG_KVJ,
	WUP_KOPF_AUSTRITT_AN_ROL,
	WUP_KOPF_AUSTRITT_AG_ROL,
	WUP_KOPF_FLUKTUATION_AN_KVJ_ROL,
	WUP_KOPF_FLUKTUATION_AG_KVJ_ROL,
	WUP_KOPF_FLUKTUATION_0003,
	WUP_KOPF_FLUKTUATION_0306,
	WUP_KOPF_FLUKTUATION_0612,
	WUP_KOPF_FLUKTUATION_1236,
	WUP_KOPF_FLUKTUATION_3699,
	WUP_KOPF_AUSTRITT_0003,
	WUP_KOPF_AUSTRITT_0306,
	WUP_KOPF_AUSTRITT_0612,
	WUP_KOPF_AUSTRITT_1236,
	WUP_KOPF_AUSTRITT_3699,
	WUP_KOPF_FLUKTUATION_0003_ROL,
	WUP_KOPF_FLUKTUATION_0306_ROL,
	WUP_KOPF_FLUKTUATION_0612_ROL,
	WUP_KOPF_FLUKTUATION_1236_ROL,
	WUP_KOPF_FLUKTUATION_3699_ROL,
	WUP_KOPF_AUSTRITT_0003_ROL,
	WUP_KOPF_AUSTRITT_0306_ROL,
	WUP_KOPF_AUSTRITT_0612_ROL,
	WUP_KOPF_AUSTRITT_1236_ROL,
	WUP_KOPF_AUSTRITT_3699_ROL,
	KOPF_FLUKTUATION_AUFG,
	KOPF_FLUKTUATION_KVJ_AUFG,
	KOPF_AUSTRITTE_AUFG,
	KOPF_AUSTRITTE_KVJ_AUFG,
	KOPF_FLUKTUATION,
	KOPF_FLUKTUATION_VMO,
	KOPF_FLUKTUATION_KVJ,
	KOPF_FLUKTUATION_KVJMO,
	KOPF_FLUKTUATION_ROL,
	KOPF_FLUKTUATION_KVJ_ROL,
	KOPF_AUSTRITTE,
	KOPF_AUSTRITTE_KVJ,
	KOPF_AUSTRITTE_ROL,
	KOPF_AUSTRITTE_KVJ_ROL
) AS 

/*
	FAKT/AGGREGAT -- SHR Kennzahlen aggregiert auf Filiale/Monat_2, Transformation auf KVJ
	BASIS : Ausland SHR mitarbeiterbew_2 + DE Excel Upload - REDESIGN 
	2018.0616 ssch0611 : Anbindung neue Struktur. Mapping der vorhandene Felder + Dummy_2 Std.
	2018.0626 ssch0611 : Finetuning + Mehrarbeit/Zuschlaege (ohne Externe, ohne -1 unbekannt)
	2018.0720 ssch0611 : Finetuning. Fluktuation aufg. + Filterung (Angestellte + Azubi + Entsendet) auf mabew
	2018.0801 ssch0611 : Final. Berichtsmonat pro Land_2 (optional)
	2018.0904 ssch0611 : Zahlenformate VZK + Mapping ZF + FI2 - VJ Werte nur pro Filiale
	2018.0906 ssch0611 : Verschiedene Ebenen/Filter: Filiale/Angestellte/MA + Anbindung Externe
	2018.0904 ssch0611 : Finetuning/QS. Kein Mapping ZF. Kein Urlaub. Zuschlaege ungefiltert.
	2018.1106 ssch0611 : Final/Release
	2018.1115 ssch0611 : Filter auf VT (kostenstellen_hierarchie)
	2018.1116 ssch0611 : Filter auf VT entfernt (da sonst keine Historie)
	2019.0114 ssch0611 : Erweiterung DE (aus Excel Upload)
	2019.0131 ssch0611 : Anpassung Fluktuation (Azubi CZ) > Faktor FLUKT bei Austritten ergaenzt 
	2019.0204 ssch0611 : Korrektur Fluktuation! FLUKT_AUSTRITTE Austritte ohne Sonderfall (Azubi CZ, ext Studenten HR)
	2019.0205 ssch0611 : Anpassung NULL Check / COALESCE
	2019.0211 ssch0611 : Synchronisation DE (Union Part)
	2019.0220 ssch0611 : Anpassung NULL Check Fluktuation + Mapping DE/ZF (Personalkosten_2, Stunden_2)
	2019.0325 ssch0611 : Erweiterung Moldau MD (mandant_id=4)
	2019.0523 ssch0611 : Bugfix: PK Plan (subselect mandant_2/vs_2/wup_2) + Externe Stunden_2 (join wup_2)
	2020.0323 ssch0611 : Changed calculation (kopf), Added columns (xxx_fe)
	2020.0424 ssch0611 : Changed logic of Kopf Extern (external students in HR)
	2020-12-03 ssch0611 : adjusted Kopf Extern = VZK Extern, replaced change 2020.0424 (AP0078054_SPEC0093688)
	2021-05-10 ssch0611 : Fluktuation: (new base logic in mabew), added 12Mo rollierend (AP0082232_SPEC0109407) + removed old columns
	2021-11-17 ssch0611 : Finetuning Fluktuation rollierend (AP0082232_SPEC0109407)
	2022-04-29 ssch0611 : Bugfix DE Fluktuation rollierend
	2022-05-04 ssch0611 : DE: anz_kopf _gesamt with anz_kopf _ohne_lza replaced in 8 columns(NSR2616397)
	2024-09-11 ssch0611 : Filialumgliederung + Review [P1760-DWH] nur DE 
	2025-06-18 ssch0611 : Mapping PK Plan auf neue ZF DE Regionen [AP0279486]
	2025-06-30 ssch0611 : Review (CTE + Window Functions) + Bereinigung Fluktuation rollierend [AP0184927]
	2025-07-31 ssch0611 : Fix Fluktuation rollierend (alte Spalten) + Ergänzung BZG 
*/

WITH vis_basis AS (
	/* mv_vis_monat_fakt_wup_2 gruppiert + PK Plan ZF + Zeit_2 (Fruehinfo 2) */
	SELECT vis.mandant_id
		, vis.nb_id
		, vis.wup_id
		, vis.wrg_id
		, vis.kjmo
		, zeit.gj
		, zeit.akt_mo
		, zeit.mo_kj
		, bsk.akt_fruehinfo2
		, wup.dat_eroeffnung AS dat_neo
		, wup.dat_bis        AS dat_stl
		, EXTRACT(YEAR FROM dat_neo) * 100 + EXTRACT(MONTH FROM dat_neo) AS kjmo_neo
		, EXTRACT(YEAR FROM dat_stl) * 100 + EXTRACT(MONTH FROM dat_stl) AS kjmo_stl
		/* Anzeige Fluktuation rollierend zwischen 12. Monat_2 ab Eröffnung und Schließung */
		, IFF(vis.kjmo BETWEEN kjmo_neo + 100 AND kjmo_stl, 1, 0) AS flukt_fg
		, SUM(vis.ums_netto)      AS ums_netto
		, SUM(vis.ums_netto_kvj)  AS ums_netto_kvj
		, SUM(vis.ums_netto_plan) AS ums_netto_plan
		, SUM(vis.pers_std)      AS pers_std
		, SUM(vis.pers_std_kvj)  AS pers_std_kvj
		, SUM(vis.pers_std_plan) AS pers_std_plan
		, SUM(vis.pers_kosten)         AS pers_kosten
		, SUM(vis.pers_kosten_kvj)     AS pers_kosten_kvj
		, SUM(vis_zf.pers_kosten_plan) AS pers_kosten_plan /* gemappt */
	FROM dbp_msi_view_vis.mv_vis_monat_fakt_wup_2 vis
	/* Ausland : mv_wup_2 (wup_2 = aktuell_wup) */  
	INNER JOIN DBP_MSI_VIEW_VIS.MV_WUP_2 wup_2 
		ON wup.mandant_id = vis.mandant_id AND wup.wup_id = vis.wup_id
	/* Ausland : Berichtsmonat = Fruehinfo 2 */  
	INNER JOIN DBP_DATA.L_BUCHUNGSSTATUS_KER_2 bsk 
		ON bsk.kj_ker_mo_id = vis.kjmo
	INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = vis.kjmo AND zeit.akt_gj < 1 
	/* Ausland : Mapping PK Plan auf Zentralfilie pro Land_2 */
	LEFT JOIN ( 
		SELECT vis0.mandant_id
			, vis0.wrg_id
			, vs0.wup_id
			, vis0.kjmo
			, SUM(pers_kosten_plan) AS pers_kosten_plan
		FROM dbp_msi_view_vis.mv_vis_monat_fakt_wup_2 vis0
		INNER JOIN dbp_view.v_wup_2 wup0
			ON wup0.mandant_id = vis0.mandant_id AND wup0.wup_id = vis0.wup_id
		INNER JOIN (
			/* Mapping auf Zentralfiliale pro Region_2/Land_2 */ 
			SELECT mandant_id
				, vs_id
				, CASE 
					WHEN mandant_id = 1 AND vs_id = 2 THEN    2 -- ZF Süd Möckmühl_2  (kein Mapping auf ZF 22 Geissenfeld)
					WHEN mandant_id = 1 AND vs_id = 3 THEN   43 -- ZF Ost Lübbenau  (kein Mapping auf ZF 46 Osterfeld)
					WHEN mandant_id = 1 AND vs_id = 8 THEN  124 -- 6. West Dortmund (kein Mapping auf ZF 28 Barsinghausen)
					WHEN mandant_id = 2               THEN 8980
					WHEN mandant_id = 5               THEN 8980
					WHEN mandant_id = 6               THEN 8991
					WHEN mandant_id = 3               THEN 8980 -- RO kein Mapping pro Region_2 
					WHEN mandant_id = 7               THEN 8980
					WHEN mandant_id = 8               THEN 8980
					WHEN mandant_id = 4               THEN 8987
					ELSE 0 END ::INTEGER AS wup_id
			FROM dbp_view.v_vs_2
		) vs0
		ON vs0.mandant_id = vis0.mandant_id AND vs0.vs_id = wup0.vs_id 
		WHERE vis0.nb_id IN (-1, 0) 
		GROUP BY ALL
	) vis_zf
	ON vis_zf.mandant_id = vis.mandant_id AND vis_zf.wup_id = vis.wup_id AND vis_zf.wrg_id = vis.wrg_id
		AND vis_zf.kjmo = vis.kjmo
	WHERE vis.nb_id IN (-1, 0) /* Ausland Filiale + ZF */
	GROUP BY ALL
)
, shr_basis AS (
	/* Ausland : SHR Data */
	SELECT mandant_id
		, wup_id
		, gj
		, kjmo
		, kpf
		, kpf_fil
		, tzk_fil
		, vzk_fil
		, stunden_zuschlag_feiertag
		, stunden_zuschlag_mehr
		, stunden_zuschlag_spaet_nacht
		, stunden_zuschlag_wochenende
		, NULL AS stunden_mehr_geleistet /* Ausland nicht vorhanden */
		, stunden_mehr_bezahlt
		, stunden_vertrag
		, tage_krank
		, tage_arbeit_soll 
		, kopf_ma
		, kopf_ma_teilzeit
		, stunden_vertrag_ma
		, kopf_fe
		, kopf_fe_teilzeit
		, stunden_vertrag_fe
		, kopf_gesamt
		, kopf_ohne_lza
		, kopf_teilzeit
		, vzk_gesamt
		, vzk_ma
		, vzk_fe
		, vzk_eintritt
		, vzk_austritt
		, vzk_fluktuation AS vzk_flukt_aktmo
		, LAST_VALUE(vzk_fluktuation) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo 
			ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS vzk_flukt_vormo
		, kopf_eintritte
		, kopf_austritte 
		, kopf_austritt_an
		, kopf_austritt_ag
		, kopf_fluktuation AS kopf_flukt_aktmo
		, LAST_VALUE(kopf_fluktuation) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo 
			ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS kopf_flukt_vormo
		, AVG(kopf_fluktuation) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo  
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_flukt_rol
		, SUM(kopf_austritte) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo  
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_rol
		, SUM(kopf_austritt_an) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo  
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_an_rol
		, SUM(kopf_austritt_ag) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo  
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_ag_rol
		, SUM(kopf_fluktuation) OVER (
			PARTITION BY mandant_id, wup_id, gj ORDER BY kjmo 
			ROWS UNBOUNDED PRECEDING) AS kopf_flukt_aufg
		, SUM(kopf_austritte) OVER (
			PARTITION BY mandant_id, wup_id, gj ORDER BY kjmo 
			ROWS UNBOUNDED PRECEDING) AS kopf_aus_aufg
		, austritt_00_03 AS kopf_aus_0003
		, austritt_03_06 AS kopf_aus_0306
		, austritt_06_12 AS kopf_aus_0612
		, austritt_12_36 AS kopf_aus_1236
		, austritt_36    AS kopf_aus_3699
		, SUM(austritt_00_03) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_0003_rol
		, SUM(austritt_03_06) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_0306_rol
		, SUM(austritt_06_12) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_0612_rol
		, SUM(austritt_12_36) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_1236_rol
		, SUM(austritt_36) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_3699_rol
		, monate_00_03 AS kopf_0003_aktmo
		, monate_03_06 AS kopf_0306_aktmo
		, monate_06_12 AS kopf_0612_aktmo
		, monate_12_36 AS kopf_1236_aktmo
		, monate_36    AS kopf_3699_aktmo
		, LAST_VALUE(monate_00_03) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo
			ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS kopf_0003_vormo
		, LAST_VALUE(monate_03_06) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo
			ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS kopf_0306_vormo
		, LAST_VALUE(monate_06_12) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo
			ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS kopf_0612_vormo
		, LAST_VALUE(monate_12_36) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo
			ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS kopf_1236_vormo
		, LAST_VALUE(monate_36) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo
			ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS kopf_3699_vormo
		, AVG(monate_00_03) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_0003_rol
		, AVG(monate_03_06) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_0306_rol
		, AVG(monate_06_12) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_0612_rol
		, AVG(monate_12_36) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_1236_rol
		, AVG(monate_36) OVER (
			PARTITION BY mandant_id, wup_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_3699_rol
	FROM (
		SELECT mandant_id
		, wup_id
		, kjmo
		, akt_mo
		, gj
		, SUM(KOPF) AS kpf
		, SUM(KOPF * AKTIV) AS kpf_fil
		, SUM(TZK  * AKTIV) AS tzk_fil
		, SUM(VZK  * AKTIV) AS vzk_fil
		, SUM(IFF(shr_ma_funktion_gruppe_id = 50, KOPF * AKTIV, 0)) AS kopf_ma
		, SUM(IFF(shr_ma_funktion_gruppe_id = 50, TZK  * AKTIV, 0)) AS kopf_ma_teilzeit
		, SUM(IFF(shr_ma_funktion_gruppe_id = 50, VZK  * AKTIV, 0)) AS vzk_ma
		, SUM(IFF(shr_ma_funktion_gruppe_id IN (10, 20, 30, 40), KOPF * AKTIV, 0)) AS kopf_fe
		, SUM(IFF(shr_ma_funktion_gruppe_id IN (10, 20, 30, 40), TZK  * AKTIV, 0)) AS kopf_fe_teilzeit
		, SUM(IFF(shr_ma_funktion_gruppe_id IN (10, 20, 30, 40), VZK  * AKTIV, 0)) AS vzk_fe
		, SUM(KOPF * AKTIV       * FILIAL) AS kopf_gesamt
		, SUM(KOPF * KEIN_LZA    * FILIAL) AS kopf_ohne_lza
		, SUM(TZK  * AKTIV       * FILIAL) AS kopf_teilzeit
		, SUM(KOPF * eintritt_fg * FILIAL) AS kopf_eintritte
		, SUM(VZK  * AKTIV          * FILIAL) AS vzk_gesamt
		, SUM(VZK  * eintritt_fg    * FILIAL) AS vzk_eintritt
		, SUM(VZK  * FLUKT          * FILIAL) AS vzk_fluktuation
		, SUM(VZK  * FLUKT_AUSTRITT * FILIAL) AS vzk_austritt
		, SUM(KOPF           * FLUKT          * FILIAL) AS kopf_fluktuation
		, SUM(KOPF           * FLUKT_AUSTRITT * FILIAL) AS kopf_austritte
		, SUM(austritt_an_fg * FLUKT_AUSTRITT * FILIAL) AS kopf_austritt_an
		, SUM(austritt_ag_fg * FLUKT_AUSTRITT * FILIAL) AS kopf_austritt_ag
		, SUM(bzg_0003       * FLUKT          * FILIAL) AS monate_00_03
		, SUM(bzg_0306       * FLUKT          * FILIAL) AS monate_03_06
		, SUM(bzg_0612       * FLUKT          * FILIAL) AS monate_06_12
		, SUM(bzg_1236       * FLUKT          * FILIAL) AS monate_12_36
		, SUM(bzg_36         * FLUKT          * FILIAL) AS monate_36
		, SUM(bzg_0003       * FLUKT_AUSTRITT * FILIAL) AS austritt_00_03
		, SUM(bzg_0306       * FLUKT_AUSTRITT * FILIAL) AS austritt_03_06
		, SUM(bzg_0612       * FLUKT_AUSTRITT * FILIAL) AS austritt_06_12
		, SUM(bzg_1236       * FLUKT_AUSTRITT * FILIAL) AS austritt_12_36
		, SUM(bzg_36         * FLUKT_AUSTRITT * FILIAL) AS austritt_36
		, SUM(STD_KRANK   * KEIN_LZA * FILIAL) AS tage_krank
		, SUM(STD_SOLL    * KEIN_LZA * FILIAL) AS tage_arbeit_soll
		, SUM(STD_VERTRAG * AKTIV    * FILIAL) AS stunden_vertrag
		, SUM(IFF(shr_ma_funktion_gruppe_id = 50, STD_VERTRAG * AKTIV, 0)) AS stunden_vertrag_ma
		, SUM(IFF(shr_ma_funktion_gruppe_id IN (10, 20, 30, 40), STD_VERTRAG * AKTIV, 0)) AS stunden_vertrag_fe
		, SUM(FEIERTAG_ZUSCHLAG)  AS stunden_zuschlag_feiertag
		, SUM(MEHRSTD_ZUSCHLAG)   AS stunden_zuschlag_mehr
		, SUM(NACHT_ZUSCHLAG)     AS stunden_zuschlag_spaet_nacht
		, SUM(WOCHENEND_ZUSCHLAG) AS stunden_zuschlag_wochenende
		, SUM(MEHRSTD_AUSBEZ)     AS stunden_mehr_bezahlt
		FROM dbp_msi_view_vis.mv_vis_monat_shr_mitarbeiterbew_2
		WHERE mandant_id <> 1 AND shr_ma_funktion_gruppe_id > -1
		GROUP BY ALL
	) sub0
)
, ext_basis AS (
	SELECT kost_ext.mandant_id
		, wp.wup_id
		, kost_ext.kjmo AS kjmo
		, zeit.akt_mo   AS akt_mo
		, SUM(CASE
			WHEN kost_ext.mandant_id = 2 THEN kost_ext.anzahl_lohnart / 174.00
			WHEN kost_ext.mandant_id = 5 THEN kost_ext.anzahl_lohnart / 174.00
			WHEN kost_ext.mandant_id = 6 THEN kost_ext.anzahl_lohnart / 173.00
			WHEN kost_ext.mandant_id = 3 THEN kost_ext.anzahl_lohnart / 174.00
			WHEN kost_ext.mandant_id = 7 THEN kost_ext.anzahl_lohnart / 173.00
			WHEN kost_ext.mandant_id = 8 THEN kost_ext.anzahl_lohnart / 173.00
			WHEN kost_ext.mandant_id = 4 THEN kost_ext.anzahl_lohnart / 173.00 
			ELSE 0 END) AS vzk_x 
	FROM dbp_view.v_kostenstelle_lohnart_zu_per_2  kost_ext
	JOIN dbp_view.v_monat_2  zeit_2
		ON zeit.kjmo = kost_ext.kjmo
	JOIN dbp_view.v_wup_2 wp
		ON wp.mandant_id = kost_ext.mandant_id 
		AND wp.wup_id = try_to_numeric(SUBSTRING(kost_ext.kostenstelle_id, 1, 4)) ::INTEGER
	WHERE kost_ext.mandant_id <> 1 AND kost_ext.lohnart_id = '/EXT' AND  kost_ext.anzahl_lohnart > 0
	GROUP BY ALL
)
, xls_basis AS (
	/* DE : Excel Data inkl Mapping aktuell_wup */
	SELECT mandant_id
		, wup_id
		, gj
		, kjmo
		, kpf
		, kpf_fil
		, tzk_fil
		, vzk_fil
		, stunden_zuschlag_feiertag
		, stunden_zuschlag_mehr
		, stunden_zuschlag_spaet_nacht
		, stunden_zuschlag_wochenende
		, stunden_mehr_geleistet
		, stunden_mehr_bezahlt
		, stunden_vertrag
		, tage_krank
		, tage_arbeit_soll 
		, kopf_ma
		, kopf_ma_teilzeit
		, stunden_vertrag_ma
		, kopf_fe
		, kopf_fe_teilzeit
		, stunden_vertrag_fe
		, kopf_gesamt
		, kopf_ohne_lza
		, kopf_teilzeit
		, vzk_gesamt
		, vzk_ma
		, vzk_fe
		, vzk_x
		, vzk_eintritt
		, vzk_austritt
		, vzk_fluktuation AS vzk_flukt_aktmo
		, LAST_VALUE(vzk_fluktuation) OVER (
			PARTITION BY mandant_id, wup_id
			ORDER BY kjmo 
			ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS vzk_flukt_vormo
		, kopf_eintritte
		, kopf_austritte
		, kopf_fluktuation AS kopf_flukt_aktmo
		, LAST_VALUE(kopf_fluktuation) OVER (
			PARTITION BY mandant_id, wup_id
			ORDER BY kjmo 
			ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS kopf_flukt_vormo
		, AVG(kopf_fluktuation) OVER (
			PARTITION BY mandant_id, wup_id
			ORDER BY kjmo  
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_flukt_rol
		, SUM(kopf_austritte) OVER (
			PARTITION BY mandant_id, wup_id
			ORDER BY kjmo  
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_rol
		, SUM(kopf_austritte) OVER (
			PARTITION BY mandant_id, wup_id, gj
			ORDER BY kjmo 
			ROWS UNBOUNDED PRECEDING) AS kopf_aus_aufg
		, SUM(kopf_fluktuation) OVER (
			PARTITION BY mandant_id, wup_id, gj
			ORDER BY kjmo 
			ROWS UNBOUNDED PRECEDING) AS kopf_flukt_aufg
	FROM (
		SELECT upld.mandant_id
			, wup.aktuell_wup_id AS wup_id
			, upld.kjmo
			, zeit.akt_mo
			, zeit.gj
			, MAX(1.00) AS kpf
			/* DE - Gesamte Filiale VJ (inkl -1/unbekannt) ohne 100 Externe */
			, SUM(IFF(shr_ma_funktion_gruppe_id <> 100, anz_kopf_ohne_lza, 0)) AS kpf_fil
			, SUM(IFF(shr_ma_funktion_gruppe_id <> 100, anz_kopf_teilzeit, 0)) AS tzk_fil
			, SUM(IFF(shr_ma_funktion_gruppe_id <> 100, anz_vzk_gesamt,    0)) AS vzk_fil
			/* DE - Mitarbeiter Ebene 50 */
			, SUM(IFF(shr_ma_funktion_gruppe_id =  50, anz_kopf_ohne_lza, 0))   AS kopf_ma
			, SUM(IFF(shr_ma_funktion_gruppe_id =  50, anz_kopf_teilzeit, 0))   AS kopf_ma_teilzeit
			, SUM(IFF(shr_ma_funktion_gruppe_id =  50, anz_stunden_vertrag, 0)) AS stunden_vertrag_ma
			, SUM(IFF(shr_ma_funktion_gruppe_id =  50, anz_vzk_gesamt, 0))      AS vzk_ma
			/* DE - Führungsebene (10 HL_2, 20 WBL_2, 30 Erstkraft, 40 PSB) */
			, SUM(IFF(shr_ma_funktion_gruppe_id IN (10, 20, 30, 40), anz_kopf_ohne_lza, 0))   AS kopf_fe
			, SUM(IFF(shr_ma_funktion_gruppe_id IN (10, 20, 30, 40), anz_kopf_teilzeit, 0))   AS kopf_fe_teilzeit
			, SUM(IFF(shr_ma_funktion_gruppe_id IN (10, 20, 30, 40), anz_stunden_vertrag, 0)) AS stunden_vertrag_fe
			, SUM(IFF(shr_ma_funktion_gruppe_id IN (10, 20, 30, 40), anz_vzk_gesamt, 0))      AS vzk_fe
			/* DE - Angestellte = Führung + Mitarbeiter + 60 Azubi + 80 Entsendet OHNE 70 Prakikant, 90 Aushilfe, 100 Extern */
			, SUM(IFF(shr_ma_funktion_gruppe_id IN (10,20,30,40,50,60,80), anz_kopf_ohne_lza, 0))    AS kopf_gesamt
			, SUM(IFF(shr_ma_funktion_gruppe_id IN (10,20,30,40,50,60,80), anz_kopf_ohne_lza, 0))    AS kopf_ohne_lza
			, SUM(IFF(shr_ma_funktion_gruppe_id IN (10,20,30,40,50,60,80), anz_kopf_teilzeit, 0))    AS kopf_teilzeit
			, SUM(IFF(shr_ma_funktion_gruppe_id IN (10,20,30,40,50,60,80), anz_kopf_eintritte, 0))   AS kopf_eintritte
			, SUM(IFF(shr_ma_funktion_gruppe_id IN (10,20,30,40,50,60,80), anz_kopf_fluktuation, 0)) AS kopf_fluktuation
			, SUM(IFF(shr_ma_funktion_gruppe_id IN (10,20,30,40,50,60,80), anz_kopf_austritte, 0))   AS kopf_austritte
			, SUM(IFF(shr_ma_funktion_gruppe_id IN (10,20,30,40,50,60,80), anz_stunden_vertrag, 0))  AS stunden_vertrag
			, SUM(IFF(shr_ma_funktion_gruppe_id IN (10,20,30,40,50,60,80), anz_vzk_gesamt, 0))       AS vzk_gesamt
			, SUM(IFF(shr_ma_funktion_gruppe_id IN (10,20,30,40,50,60,80), anz_vzk_eintritt, 0))     AS vzk_eintritt
			, SUM(IFF(shr_ma_funktion_gruppe_id IN (10,20,30,40,50,60,80), anz_vzk_fluktuation, 0))  AS vzk_fluktuation
			, SUM(IFF(shr_ma_funktion_gruppe_id IN (10,20,30,40,50,60,80), anz_vzk_austritt, 0))     AS vzk_austritt
			/* DE - Externe (100, VZK = Kopf) */
			, SUM(IFF(shr_ma_funktion_gruppe_id = 100, anz_vzk_gesamt, 0)) AS vzk_x
			/* DE mapped on -1/unbekannt */
			, SUM(anz_stunden_zuschlag_feiertag)    AS stunden_zuschlag_feiertag
			, SUM(anz_stunden_zuschlag_mehr)        AS stunden_zuschlag_mehr
			, SUM(anz_stunden_zuschlag_spaet_nacht) AS stunden_zuschlag_spaet_nacht
			, SUM(anz_stunden_zuschlag_wochenende)  AS stunden_zuschlag_wochenende
			, SUM(anz_stunden_mehr_geleistet)       AS stunden_mehr_geleistet
			, SUM(anz_stunden_mehr_bezahlt)         AS stunden_mehr_bezahlt
			, SUM(anz_tage_krank) AS tage_krank
			, SUM(anz_tage_arbeit_soll)  AS tage_arbeit_soll 
		FROM dbp_view.v_vis_monat_shr_wup_funktgr_upload_2 upld
		JOIN dbp_view.v_wup_2 wup_2
			ON wup.mandant_id = upld.mandant_id AND wup.wup_id = upld.wup_id 
		JOIN dbp_view.v_monat_2 zeit_2 
			ON zeit.kjmo = upld.kjmo
		WHERE upld.mandant_id = 1
		GROUP BY ALL
	) sub0
)


/* PART 1 - Ausland (Basis SHR) */

SELECT vis.mandant_id
	, vis.nb_id
	, vis.wup_id
	, vis.wrg_id
	, vis.gj
	, vis.kjmo
	/* Ausland : Fruehinfo2 (0) = SHR Berichtmonat (-1) */
	, vis.akt_mo
	, vis.mo_kj
	, vis.akt_fruehinfo2 - 1 AS akt_mo_shr
	, vis.akt_fruehinfo2 AS fruehinfo2
	/* Ausland : VIS Daten */
	, vis.pers_kosten
	, vis.pers_kosten_kvj
	, vis.pers_kosten_plan
	, vis.ums_netto
	, vis.ums_netto_kvj
	, vis.ums_netto_plan
	, vis.pers_std      AS stunden_netto
	, vis.pers_std_kvj  AS stunden_netto_kvj
	, vis.pers_std_plan AS stunden_plan
	/* Ausland Helper : rowcounts + intern + extern */
	, ZEROIFNULL(b_ist.kpf) AS kopf
	, ZEROIFNULL(b_kvj.kpf) AS kopf_kvj
	, b_ist.kpf_fil AS kopf_fil
	, b_kvj.kpf_fil AS kopf_fil_kvj
	, ZEROIFNULL(x_ist.vzk_x) AS vzk_ext /* Externe (Kostenstelle) : Kopf = VZK */
	, ZEROIFNULL(x_kvj.vzk_x) AS vzk_ext_kvj
	/* Ausland : Gesamte Filiale inkl extern (ohne unbekannt) */
	, kopf_fil     + vzk_ext     AS kopf_filiale
	, kopf_fil_kvj + vzk_ext_kvj AS kopf_filiale_kvj
	, b_ist.tzk_fil AS kopf_filiale_teilzeit
	, b_kvj.tzk_fil AS kopf_filiale_teilzeit_kvj
	, b_ist.vzk_fil + vzk_ext AS vzk_filiale
	, b_kvj.vzk_fil + vzk_ext_kvj AS vzk_filiale_kvj
	, b_ist.stunden_zuschlag_feiertag AS stunden_zuschlag_feiertag
	, b_kvj.stunden_zuschlag_feiertag AS stunden_zuschlag_feiertag_kvj
	, b_ist.stunden_zuschlag_mehr AS stunden_zuschlag_mehr
	, b_kvj.stunden_zuschlag_mehr AS stunden_zuschlag_mehr_kvj
	, b_ist.stunden_zuschlag_spaet_nacht AS stunden_zuschlag_spaet_nacht
	, b_kvj.stunden_zuschlag_spaet_nacht AS stunden_zuschlag_spaet_nacht_kvj
	, b_ist.stunden_zuschlag_wochenende AS stunden_zuschlag_wochenende
	, b_kvj.stunden_zuschlag_wochenende AS stunden_zuschlag_wochenende_kvj
	/* Ausland : Mehrstunden ausbezahlt */
	, b_ist.stunden_mehr_geleistet AS stunden_mehr_geleistet /* NULL */
	, b_kvj.stunden_mehr_geleistet AS stunden_mehr_geleistet_kvj /* NULL */
	, b_ist.stunden_mehr_bezahlt AS stunden_mehr_bezahlt
	, b_kvj.stunden_mehr_bezahlt AS stunden_mehr_bezahlt_kvj
	/* Ausland : Vertragsstunden */
	, b_ist.stunden_vertrag AS stunden_vertrag
	, b_kvj.stunden_vertrag AS stunden_vertrag_kvj
	/* Ausland : Kranktage */
	, b_ist.tage_krank AS tage_krank
	, b_kvj.tage_krank AS tage_krank_kvj
	, b_ist.tage_arbeit_soll AS tage_arbeit_soll
	, b_kvj.tage_arbeit_soll AS tage_arbeit_soll_kvj
	/* Ausland : Ebene Mitarbeiter */
	, b_ist.kopf_ma AS kopf_ma
	, b_kvj.kopf_ma AS kopf_ma_kvj
	, b_ist.kopf_ma_teilzeit AS kopf_ma_teilzeit
	, b_kvj.kopf_ma_teilzeit AS kopf_ma_teilzeit_kvj
	, b_ist.vzk_ma AS vzk_ma
	, b_kvj.vzk_ma AS vzk_ma_kvj
	, b_ist.stunden_vertrag_ma AS stunden_vertrag_ma
	, b_kvj.stunden_vertrag_ma AS stunden_vertrag_ma_kvj
	/* Ausland : Ebene Fuehrung */
	, b_ist.kopf_fe AS kopf_fe
	, b_kvj.kopf_fe AS kopf_fe_kvj
	, b_ist.kopf_fe_teilzeit AS kopf_fe_teilzeit
	, b_kvj.kopf_fe_teilzeit AS kopf_fe_teilzeit_kvj
	, b_ist.vzk_fe AS vzk_fe
	, b_kvj.vzk_fe AS vzk_fe_kvj
	, b_ist.stunden_vertrag_fe AS stunden_vertrag_fe
	, b_kvj.stunden_vertrag_fe AS stunden_vertrag_fe_kvj
	/* Ausland : Ebene Angestellte */
	, b_ist.kopf_gesamt AS kopf_gesamt
	, b_kvj.kopf_gesamt AS kopf_gesamt_kvj
	, b_ist.kopf_ohne_lza AS kopf_ohne_lza
	, b_kvj.kopf_ohne_lza AS kopf_ohne_lza__kvj
	, b_ist.kopf_teilzeit AS kopf_teilzeit
	, b_kvj.kopf_teilzeit AS kopf_teilzeit_kvj
	, b_ist.kopf_eintritte AS kopf_eintritte
	, b_kvj.kopf_eintritte AS kopf_eintritte_kvj
	/* Ausland : VZK */
	, b_ist.vzk_gesamt   AS vzk_gesamt
	, b_kvj.vzk_gesamt   AS vzk_gesamt_kvj
	, b_ist.vzk_eintritt AS vzk_eintritt
	, b_kvj.vzk_eintritt AS vzk_eintritt_kvj
	, b_ist.vzk_austritt AS vzk_austritt
	, b_kvj.vzk_austritt AS vzk_austritt_kvj
	, ZEROIFNULL(b_ist.vzk_flukt_aktmo) AS vzk_fluktuation
	, ZEROIFNULL(b_ist.vzk_flukt_vormo) AS vzk_fluktuation_vmo
	, ZEROIFNULL(b_kvj.vzk_flukt_aktmo) AS vzk_fluktuation_kvj
	, ZEROIFNULL(b_kvj.vzk_flukt_vormo) AS vzk_fluktuation_kvjmo

	/* Ausland : Fluktuation Filiale monatlich + rollierend - NEU 2025-06 */
	, vis.flukt_fg AS wup_flukt_rol_fg /* 1 = Anzeige rollierende Fluktuation */
	, b_ist.kopf_flukt_aktmo AS wup_kopf_flukt_aktmo
	, b_ist.kopf_flukt_vormo AS wup_kopf_flukt_vormo
	, b_kvj.kopf_flukt_aktmo AS wup_kopf_flukt_aktmovj
	, b_kvj.kopf_flukt_vormo AS wup_kopf_flukt_vormovj
	, (b_ist.kopf_flukt_aktmo + b_ist.kopf_flukt_vormo) / 2 AS wup_kopf_fluktuation
	, (b_kvj.kopf_flukt_aktmo + b_kvj.kopf_flukt_vormo) / 2 AS wup_kopf_fluktuation_kvj
	, ZEROIFNULL(b_ist.kopf_austritte)   AS wup_kopf_austritte
	, ZEROIFNULL(b_kvj.kopf_austritte)   AS wup_kopf_austritte_kvj 
	, b_ist.kopf_flukt_rol    * flukt_fg AS wup_kopf_fluktuation_rol
	, b_kvj.kopf_flukt_rol    * flukt_fg AS wup_kopf_fluktuation_kvj_rol
	, b_ist.kopf_aus_rol      * flukt_fg AS wup_kopf_austritte_rol
	, b_kvj.kopf_aus_rol      * flukt_fg AS wup_kopf_austritte_kvj_rol
	/* Ausland : Fluktuation AN/AG monatlich + rollierend -- NEU 2025-06 */
	, ZEROIFNULL(b_ist.kopf_austritt_ag) AS wup_kopf_austritt_ag
	, ZEROIFNULL(b_ist.kopf_austritt_an) AS wup_kopf_austritt_an
	, ZEROIFNULL(b_kvj.kopf_austritt_ag) AS wup_kopf_austritt_ag_kvj 
	, ZEROIFNULL(b_kvj.kopf_austritt_an) AS wup_kopf_austritt_an_kvj 
	, b_ist.kopf_aus_an_rol   * flukt_fg AS wup_kopf_austritt_an_rol
	, b_ist.kopf_aus_ag_rol   * flukt_fg AS wup_kopf_austritt_ag_rol
	, b_kvj.kopf_aus_an_rol   * flukt_fg AS wup_kopf_austritt_an_kvj_rol
	, b_kvj.kopf_aus_ag_rol   * flukt_fg AS wup_kopf_austritt_ag_kvj_rol
	/* Ausland : Fluktuation BZG monatlich + rollierend -- NEU 2025-07 */
	, (b_ist.kopf_0003_aktmo + b_ist.kopf_0003_vormo) / 2 AS wup_kopf_fluktuation_0003
	, (b_ist.kopf_0306_aktmo + b_ist.kopf_0306_vormo) / 2 AS wup_kopf_fluktuation_0306
	, (b_ist.kopf_0612_aktmo + b_ist.kopf_0612_vormo) / 2 AS wup_kopf_fluktuation_0612
	, (b_ist.kopf_1236_aktmo + b_ist.kopf_1236_vormo) / 2 AS wup_kopf_fluktuation_1236
	, (b_ist.kopf_3699_aktmo + b_ist.kopf_3699_vormo) / 2 AS wup_kopf_fluktuation_3699
	, ZEROIFNULL(b_ist.kopf_aus_0003)                     AS wup_kopf_austritt_0003
	, ZEROIFNULL(b_ist.kopf_aus_0306)                     AS wup_kopf_austritt_0306
	, ZEROIFNULL(b_ist.kopf_aus_0612)                     AS wup_kopf_austritt_0612
	, ZEROIFNULL(b_ist.kopf_aus_1236)                     AS wup_kopf_austritt_1236
	, ZEROIFNULL(b_ist.kopf_aus_3699)                     AS wup_kopf_austritt_3699
	, b_ist.kopf_0003_rol                      * flukt_fg AS wup_kopf_fluktuation_0003_rol
	, b_ist.kopf_0306_rol                      * flukt_fg AS wup_kopf_fluktuation_0306_rol
	, b_ist.kopf_0612_rol                      * flukt_fg AS wup_kopf_fluktuation_0612_rol
	, b_ist.kopf_1236_rol                      * flukt_fg AS wup_kopf_fluktuation_1236_rol
	, b_ist.kopf_3699_rol                      * flukt_fg AS wup_kopf_fluktuation_3699_rol
	, b_ist.kopf_aus_0003_rol                  * flukt_fg AS wup_kopf_austritt_0003_rol
	, b_ist.kopf_aus_0306_rol                  * flukt_fg AS wup_kopf_austritt_0306_rol
	, b_ist.kopf_aus_0612_rol                  * flukt_fg AS wup_kopf_austritt_0612_rol
	, b_ist.kopf_aus_1236_rol                  * flukt_fg AS wup_kopf_austritt_1236_rol
	, b_ist.kopf_aus_3699_rol                  * flukt_fg AS wup_kopf_austritt_3699_rol

	/* Ausland : Fluktuation aufgelaufen (ohne Helper) - REVIEW 2025-06 */
	, IFF(vis.mo_kj = 3, wup_kopf_fluktuation,     b_ist.kopf_flukt_aufg) AS kopf_fluktuation_aufg
	, IFF(vis.mo_kj = 3, wup_kopf_fluktuation_kvj, b_kvj.kopf_flukt_aufg) AS kopf_fluktuation_kvj_aufg
	, b_ist.kopf_aus_aufg AS kopf_austritte_aufg
	, b_kvj.kopf_aus_aufg AS kopf_austritte_kvj_aufg

	/* Ausland : Fluktuation -- ALTE SPALTEN */
	, ZEROIFNULL(b_ist.kopf_flukt_aktmo) AS kopf_fluktuation
	, ZEROIFNULL(b_ist.kopf_flukt_vormo) AS kopf_fluktuation_vmo
	, ZEROIFNULL(b_kvj.kopf_flukt_aktmo) AS kopf_fluktuation_kvj
	, ZEROIFNULL(b_kvj.kopf_flukt_vormo) AS kopf_fluktuation_kvjmo
	, b_ist.kopf_flukt_rol AS kopf_fluktuation_rol
	, b_kvj.kopf_flukt_rol AS kopf_fluktuation_kvj_rol
	, b_ist.kopf_austritte AS kopf_austritte
	, b_kvj.kopf_austritte AS kopf_austritte_kvj
	, b_ist.kopf_aus_rol   AS kopf_austritte_rol
	, b_kvj.kopf_aus_rol   AS kopf_austritte_kvj_rol

/* Ausland : VIS */
FROM vis_basis vis

/* Ausland : SHR IST inkl Vormonat */ 
LEFT JOIN shr_basis b_ist
ON b_ist.mandant_id = vis.mandant_id AND b_ist.wup_id = vis.wup_id
AND b_ist.kjmo = vis.kjmo

/* Ausland : SHR Vorjahr inkl Vormonat */ 
LEFT JOIN shr_basis b_kvj
ON b_kvj.mandant_id = vis.mandant_id AND b_kvj.wup_id = vis.wup_id
AND (b_kvj.kjmo + 100) = vis.kjmo /* Transformation Vorjahr */

/* Ausland : Externe IST */ 
LEFT JOIN ext_basis x_ist
ON x_ist.mandant_id = vis.mandant_id AND x_ist.wup_id = vis.wup_id
AND x_ist.kjmo = vis.kjmo

/* Ausland : Externe Vorjahr */ 
LEFT JOIN ext_basis x_kvj
ON x_kvj.mandant_id = vis.mandant_id AND x_kvj.wup_id = vis.wup_id
AND (x_kvj.kjmo + 100) = vis.kjmo /* Transformation Vorjahr */

/* Ausland */
WHERE vis.mandant_id <> 1


/* PART 2 - DE (aus Excel Upload) */

UNION ALL
SELECT vis.mandant_id
	, vis.nb_id
	, vis.wup_id
	, vis.wrg_id
	, vis.gj
	, vis.kjmo
	/* DE : Fruehinfo2 (0) = SHR Berichtmonat (-1) */
	, vis.akt_mo
	, vis.mo_kj
	, vis.akt_fruehinfo2 - 1 AS akt_mo_shr
	, vis.akt_fruehinfo2 AS fruehinfo2
	/* DE : VIS Daten */
	, vis.pers_kosten
	, vis.pers_kosten_kvj
	, vis.pers_kosten_plan
	, vis.ums_netto
	, vis.ums_netto_kvj
	, vis.ums_netto_plan
	, vis.pers_std      AS stunden_netto
	, vis.pers_std_kvj  AS stunden_netto_kvj
	, vis.pers_std_plan AS stunden_plan
	/* DE Helper : rowcounts + intern + extern */
	, ZEROIFNULL(b_ist.kpf) AS kopf
	, ZEROIFNULL(b_kvj.kpf) AS kopf_kvj
	, b_ist.kpf_fil AS kopf_fil
	, b_kvj.kpf_fil AS kopf_fil_kvj
	, ZEROIFNULL(b_ist.vzk_x) AS vzk_ext /* Externe : Kopf = VZK */
	, ZEROIFNULL(b_kvj.vzk_x) AS vzk_ext_kvj
	/* DE  : Gesamte Filiale inkl extern (ohne unbekannt) */
	, kopf_fil     + vzk_ext     AS kopf_filiale
	, kopf_fil_kvj + vzk_ext_kvj AS kopf_filiale_kvj
	, b_ist.tzk_fil AS kopf_filiale_teilzeit
	, b_kvj.tzk_fil AS kopf_filiale_teilzeit_kvj
	, b_ist.vzk_fil + b_ist.vzk_x AS vzk_filiale
	, b_kvj.vzk_fil + b_kvj.vzk_x AS vzk_filiale_kvj
	, b_ist.stunden_zuschlag_feiertag AS stunden_zuschlag_feiertag
	, b_kvj.stunden_zuschlag_feiertag AS stunden_zuschlag_feiertag_kvj
	, b_ist.stunden_zuschlag_mehr AS stunden_zuschlag_mehr
	, b_kvj.stunden_zuschlag_mehr AS stunden_zuschlag_mehr_kvj
	, b_ist.stunden_zuschlag_spaet_nacht AS stunden_zuschlag_spaet_nacht
	, b_kvj.stunden_zuschlag_spaet_nacht AS stunden_zuschlag_spaet_nacht_kvj
	, b_ist.stunden_zuschlag_wochenende AS stunden_zuschlag_wochenende
	, b_kvj.stunden_zuschlag_wochenende AS stunden_zuschlag_wochenende_kvj
	/* DE : Mehrstunden geleistet + bezahlt */
	, b_ist.stunden_mehr_geleistet AS stunden_mehr_geleistet
	, b_kvj.stunden_mehr_geleistet AS stunden_mehr_geleistet_kvj
	, b_ist.stunden_mehr_bezahlt AS stunden_mehr_bezahlt 
	, b_kvj.stunden_mehr_bezahlt AS stunden_mehr_bezahlt_kvj 
	/* DE : Vertragsstunden */
	, b_ist.stunden_vertrag AS stunden_vertrag
	, b_kvj.stunden_vertrag AS stunden_vertrag_kvj
	/* DE : Kranktage */
	, b_ist.tage_krank AS tage_krank
	, b_kvj.tage_krank AS tage_krank_kvj
	, b_ist.tage_arbeit_soll AS tage_arbeit_soll
	, b_kvj.tage_arbeit_soll AS tage_arbeit_soll_kvj
	/* DE : Ebene Mitarbeiter */
	, b_ist.kopf_ma AS kopf_ma
	, b_kvj.kopf_ma AS kopf_ma_kvj
	, b_ist.kopf_ma_teilzeit AS kopf_ma_teilzeit
	, b_kvj.kopf_ma_teilzeit AS kopf_ma_teilzeit_kvj
	, b_ist.vzk_ma AS vzk_ma
	, b_kvj.vzk_ma AS vzk_ma_kvj
	, b_ist.stunden_vertrag_ma AS stunden_vertrag_ma
	, b_kvj.stunden_vertrag_ma AS stunden_vertrag_ma_kvj
	/* DE : Ebene Fuehrung */
	, b_ist.kopf_fe AS kopf_fe
	, b_kvj.kopf_fe AS kopf_fe_kvj
	, b_ist.kopf_fe_teilzeit AS kopf_fe_teilzeit
	, b_kvj.kopf_fe_teilzeit AS kopf_fe_teilzeit_kvj
	, b_ist.vzk_fe AS vzk_fe
	, b_kvj.vzk_fe AS vzk_fe_kvj
	, b_ist.stunden_vertrag_fe AS stunden_vertrag_fe
	, b_kvj.stunden_vertrag_fe AS stunden_vertrag_fe_kvj
	/* DE : Ebene Angestellte */
	, b_ist.kopf_gesamt AS kopf_gesamt
	, b_kvj.kopf_gesamt AS kopf_gesamt_kvj
	, b_ist.kopf_ohne_lza AS kopf_ohne_lza
	, b_kvj.kopf_ohne_lza AS kopf_ohne_lza__kvj
	, b_ist.kopf_teilzeit AS kopf_teilzeit
	, b_kvj.kopf_teilzeit AS kopf_teilzeit_kvj
	, b_ist.kopf_eintritte AS kopf_eintritte
	, b_kvj.kopf_eintritte AS kopf_eintritte_kvj
	/* DE : VZK */ 
	, b_ist.vzk_gesamt AS vzk_gesamt
	, b_kvj.vzk_gesamt AS vzk_gesamt_kvj
	, b_ist.vzk_eintritt AS vzk_eintritt
	, b_kvj.vzk_eintritt AS vzk_eintritt_kvj
	, b_ist.vzk_austritt AS vzk_austritt
	, b_kvj.vzk_austritt AS vzk_austritt_kvj
	, ZEROIFNULL(b_ist.vzk_flukt_aktmo) AS vzk_fluktuation
	, ZEROIFNULL(b_ist.vzk_flukt_vormo) AS vzk_fluktuation_vmo
	, ZEROIFNULL(b_kvj.vzk_flukt_aktmo) AS vzk_fluktuation_kvj
	, ZEROIFNULL(b_kvj.vzk_flukt_vormo) AS vzk_fluktuation_kvjmo

	/* DE : Fluktuation Filiale monatlich + rollierend - NEU 2025-06 */
	, vis.flukt_fg AS wup_flukt_rol_fg /* 1 = Anzeige rollierende Fluktuation */
	, b_ist.kopf_flukt_aktmo AS wup_kopf_flukt_aktmo
	, b_ist.kopf_flukt_vormo AS wup_kopf_flukt_vormo
	, b_kvj.kopf_flukt_aktmo AS wup_kopf_flukt_aktmovj
	, b_kvj.kopf_flukt_vormo AS wup_kopf_flukt_vormovj
	, (b_ist.kopf_flukt_aktmo + b_ist.kopf_flukt_vormo) / 2 AS wup_kopf_fluktuation
	, (b_kvj.kopf_flukt_aktmo + b_kvj.kopf_flukt_vormo) / 2 AS wup_kopf_fluktuation_kvj
	, ZEROIFNULL(b_ist.kopf_austritte) AS wup_kopf_austritte
	, ZEROIFNULL(b_kvj.kopf_austritte) AS wup_kopf_austritte_kvj 
	, b_ist.kopf_flukt_rol * flukt_fg AS wup_kopf_fluktuation_rol
	, b_kvj.kopf_flukt_rol * flukt_fg AS wup_kopf_fluktuation_kvj_rol
	, b_ist.kopf_aus_rol   * flukt_fg AS wup_kopf_austritte_rol
	, b_kvj.kopf_aus_rol   * flukt_fg AS wup_kopf_austritte_kvj_rol
	/* DE : Fluktuation AN/AG nicht verfügbar */
	, 0 AS wup_kopf_austritte_ag
	, 0 AS wup_kopf_austritte_an
	, 0 AS wup_kopf_austritte_ag_kvj 
	, 0 AS wup_kopf_austritte_an_kvj 
	, 0 AS wup_kopf_austritte_an_rol
	, 0 AS wup_kopf_austritte_ag_rol
	, 0 AS wup_kopf_austritte_an_kvj_rol
	, 0 AS wup_kopf_austritte_ag_kvj_rol
	/* DE : Fluktuation BZG nicht verfügbar */
	, 0 AS wup_kopf_fluktuation_0003
	, 0 AS wup_kopf_fluktuation_0306
	, 0 AS wup_kopf_fluktuation_0612
	, 0 AS wup_kopf_fluktuation_1236
	, 0 AS wup_kopf_fluktuation_3699
	, 0 AS wup_kopf_austritt_0003
	, 0 AS wup_kopf_austritt_0306
	, 0 AS wup_kopf_austritt_0612
	, 0 AS wup_kopf_austritt_1236
	, 0 AS wup_kopf_austritt_3699
	, 0 AS wup_kopf_fluktuation_0003_rol
	, 0 AS wup_kopf_fluktuation_0306_rol
	, 0 AS wup_kopf_fluktuation_0612_rol
	, 0 AS wup_kopf_fluktuation_1236_rol
	, 0 AS wup_kopf_fluktuation_3699_rol
	, 0 AS wup_kopf_austritt_0003_rol
	, 0 AS wup_kopf_austritt_0306_rol
	, 0 AS wup_kopf_austritt_0612_rol
	, 0 AS wup_kopf_austritt_1236_rol
	, 0 AS wup_kopf_austritt_3699_rol

	/* DE : Fluktuation aufgelaufen (ohne Helper) - REVIEW 2025-06 */
	, IFF(vis.mo_kj = 3, wup_kopf_fluktuation, b_ist.kopf_flukt_aufg)     AS kopf_fluktuation_aufg
	, IFF(vis.mo_kj = 3, wup_kopf_fluktuation_kvj, b_kvj.kopf_flukt_aufg) AS kopf_fluktuation_kvj_aufg
	, b_ist.kopf_aus_aufg AS kopf_austritte_aufg
	, b_kvj.kopf_aus_aufg AS kopf_austritte_kvj_aufg

	/* DE : Fluktuation -- ALTE SPALTEN */
	, ZEROIFNULL(b_ist.kopf_flukt_aktmo) AS kopf_fluktuation
	, ZEROIFNULL(b_ist.kopf_flukt_vormo) AS kopf_fluktuation_vmo
	, ZEROIFNULL(b_kvj.kopf_flukt_aktmo) AS kopf_fluktuation_kvj
	, ZEROIFNULL(b_kvj.kopf_flukt_vormo) AS kopf_fluktuation_kvjmo
	, b_ist.kopf_flukt_rol AS kopf_fluktuation_rol
	, b_kvj.kopf_flukt_rol AS kopf_fluktuation_kvj_rol
	, b_ist.kopf_austritte AS kopf_austritte
	, b_kvj.kopf_austritte AS kopf_austritte_kvj
	, b_ist.kopf_aus_rol   AS kopf_austritte_rol
	, b_kvj.kopf_aus_rol   AS kopf_austritte_kvj_rol

/* DE : VIS */
FROM vis_basis vis

/* DE : Excel IST inkl Vormonat */  
LEFT JOIN xls_basis b_ist
ON b_ist.mandant_id = vis.mandant_id AND b_ist.wup_id = vis.wup_id
	AND b_ist.kjmo = vis.kjmo

/* DE : Excel Vorjahr inkl Vormonat */  
LEFT JOIN xls_basis b_kvj
ON b_kvj.mandant_id = vis.mandant_id AND b_kvj.wup_id = vis.wup_id
	AND (b_kvj.kjmo + 100) = vis.kjmo

/* DE */
WHERE vis.mandant_id = 1
;