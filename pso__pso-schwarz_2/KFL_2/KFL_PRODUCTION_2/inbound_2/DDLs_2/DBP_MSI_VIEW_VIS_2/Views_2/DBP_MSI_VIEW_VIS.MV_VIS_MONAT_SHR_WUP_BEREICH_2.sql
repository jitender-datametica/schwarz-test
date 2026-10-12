CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_SHR_WUP_BEREICH_2(
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
	HR_OBJEKT_BEREICH_ID,
	BER_KOPF_GESAMT,
	BER_FLUKT_ROL_FG,
	BER_KOPF_FLUKT_AKTMO,
	BER_KOPF_FLUKT_VORMO,
	BER_KOPF_FLUKTUATION,
	BER_KOPF_AUSTRITTE,
	BER_KOPF_AUSTRITT_AN,
	BER_KOPF_AUSTRITT_AG,
	BER_KOPF_FLUKTUATION_ROL,
	BER_KOPF_AUSTRITTE_ROL,
	BER_KOPF_AUSTRITT_AN_ROL,
	BER_KOPF_AUSTRITT_AG_ROL,
	BER_AUSTRITT_TRW,
	BER_AUSTRITT_VTG,
	BER_AUSTRITT_ANA,
	BER_AUSTRITT_UGSI,
	BER_AUSTRITT_UGSW,
	BER_AUSTRITT_BU,
	BER_AUSTRITT_TRW_ROL,
	BER_AUSTRITT_VTG_ROL,
	BER_AUSTRITT_ANA_ROL,
	BER_AUSTRITT_UGSI_ROL,
	BER_AUSTRITT_UGSW_ROL,
	BER_AUSTRITT_BU_ROL
) AS

/*
	FAKT/AGGREGAT : Koepfe, Fluktuation pro Filiale + Bereich und Monat_2 
	BASIS : nur Ausland (shr_mitarbeiterbew) + Bereich (hr_objekt_bereich_id) - ohne Deutschland
	2022-06-08 ssch0611 : Fluktuation Bereich initial setup - AP0111895
	2022-11-14 ssch0611 : Refresh (Fluktuation rollieren)
	2022-11-24 ssch0611 : Filter Fuehrung/MA/Azubi/Praktikant (shr_ma_funktion_gruppe_id IN 10,20,30,40,50,60,80) [AP0111895]
	2024-09 : keine Anpassung für Filialumgliederung [P1760-DWH] da nur Ausland
	2025-06-30 ssch0611 : Review (Window Function + Basis INT). Bereinigung Fluktuation rollierend [AP0184927]
*/


/* INT : Daten Fluktuation nur für Ausland (da nicht definiert für DE) */

SELECT vis.mandant_id
	, vis.nb_id
	, vis.wup_id
	, vis.wrg_id
	, vis.gj
	, vis.kjmo
	/* Zeit_2 akt_mo, Fruehinfo2 (0) = SHR Berichtmonat (-1) */
	, vis.akt_mo
	, vis.mo_kj
	, vis.akt_fruehinfo2 - 1 AS akt_mo_shr
	, vis.akt_fruehinfo2     AS fruehinfo2
	, obj_ber.hr_objekt_bereich_id
	/* Ausland : Dummy_2 Kopf ohne Externe */ 
	, ZEROIFNULL(shr_ist.kopf_aktiv) AS ber_kopf_gesamt
	/* Ausland : Fluktuation auf Ebene Filiale/Bereich monatlich + rollierend ab 12. Monat_2 -- 2025-06 */ 
	, vis.flukt_fg AS ber_flukt_rol_fg /* ab 12. Monat_2 nach Eröffnung */
	, shr_ist.kopf_flukt_aktmo AS ber_kopf_flukt_aktmo
	, shr_ist.kopf_flukt_vormo AS ber_kopf_flukt_vormo
	, (shr_ist.kopf_flukt_aktmo + shr_ist.kopf_flukt_vormo) / 2 AS ber_kopf_fluktuation
	, shr_ist.austritte   AS ber_kopf_austritte
	, shr_ist.austritt_an AS ber_kopf_austritt_an
	, shr_ist.austritt_ag AS ber_kopf_austritt_ag
	, shr_ist.kopf_flukt_rol  * vis.flukt_fg AS ber_kopf_fluktuation_rol
	, shr_ist.kopf_aus_rol    * vis.flukt_fg AS ber_kopf_austritte_rol
	, shr_ist.kopf_aus_an_rol * vis.flukt_fg AS ber_kopf_austritt_an_rol
	, shr_ist.kopf_aus_ag_rol * vis.flukt_fg AS ber_kopf_austritt_ag_rol

	/* Ausland : Austritte (keine Fluktuation) auf Ebene Filiale/Bereich monatlich + rollierend ab 12. Monat_2  */
	, shr_ist.austritt_trw  AS ber_austritt_trw
	, shr_ist.austritt_vtg  AS ber_austritt_vtg
	, shr_ist.austritt_ana  AS ber_austritt_ana
	, shr_ist.austritt_ugsi AS ber_austritt_ugsi
	, shr_ist.austritt_ugsw AS ber_austritt_ugsw
	, shr_ist.austritt_bu   AS ber_austritt_bu
	, kopf_aus_trw_rol  * vis.flukt_fg AS ber_austritt_trw_rol
	, kopf_aus_vtg_rol  * vis.flukt_fg AS ber_austritt_vtg_rol
	, kopf_aus_ana_rol  * vis.flukt_fg AS ber_austritt_ana_rol
	, kopf_aus_ugsi_rol * vis.flukt_fg AS ber_austritt_ugsi_rol
	, kopf_aus_ugsw_rol * vis.flukt_fg AS ber_austritt_ugsw_rol
	, kopf_aus_bu_rol   * vis.flukt_fg AS ber_austritt_bu_rol

/* INT : mv_vis_monat_fakt_wup_2 gruppiert (wup_2 = aktuell_wup) + Zeit_2 */ 
FROM ( 
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id
		, vis.wrg_id
		, vis.kjmo
		, zeit.akt_mo
		,zeit.mo_kj
		, zeit.gj
		, bsk.akt_fruehinfo2
		, wup.dat_eroeffnung 											AS dat_neo 
		, wup.dat_bis 													AS dat_stl 
		, EXTRACT(YEAR FROM dat_neo)*100 + EXTRACT(MONTH FROM dat_neo)	AS kjmo_neo
		, EXTRACT(YEAR FROM dat_stl)*100 + EXTRACT(MONTH FROM dat_stl)	AS kjmo_stl
		/* Fluktuation rollierend ab dem 12. Monat_2 nach Eröffnung bis zum Schließungsmonat */
		, IFF(vis.kjmo BETWEEN kjmo_neo + 100 AND kjmo_stl, 1, 0) 		AS flukt_fg 
	FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FAKT_WUP_2 vis
	/* INT : mv_wup_2 (wup_2 = aktuell_wup) */ 
	INNER JOIN DBP_MSI_VIEW_VIS.MV_WUP_2 wup_2 
		ON wup.mandant_id = vis.mandant_id AND wup.wup_id = vis.wup_id
	/* INT : Berichtsmonat = Fruehinfo 2 */
	INNER JOIN DBP_DATA.L_BUCHUNGSSTATUS_KER_2 bsk 
		ON bsk.kj_ker_mo_id = vis.kjmo
	INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = vis.kjmo AND zeit.akt_gj < 1 
	WHERE vis.nb_id IN (-1, 0)
	GROUP BY ALL
) vis

/* INT : Komplette Objekt Bereich Struktur pro Filiale */ 
CROSS JOIN ( 
	SELECT DISTINCT hr_objekt_bereich_id 
	FROM DBP_VIEW.V_L_ORG_EINHEIT_BEREICH_2
) obj_ber

/* Ausland : SHR mitarbeiterbew_2 - IST inkl. Vormonat + rollierend */ 
LEFT JOIN (
	SELECT mandant_id
		, wup_id
		, kjmo
		, hr_objekt_bereich_id
		, kopf_aktiv
		, kopf_flukt AS kopf_flukt_aktmo
		, austritte
		, austritt_an
		, austritt_ag
		, austritt_trw
		, austritt_vtg
		, austritt_ana
		, austritt_ugsi
		, austritt_ugsw
		, austritt_bu
		, LAST_VALUE(kopf_flukt) OVER (
			PARTITION BY mandant_id, wup_id, hr_objekt_bereich_id
			ORDER BY kjmo 
			ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS kopf_flukt_vormo
		, AVG(kopf_flukt) OVER (
			PARTITION BY mandant_id, wup_id, hr_objekt_bereich_id
			ORDER BY kjmo  
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_flukt_rol
		, SUM(austritte) OVER (
			PARTITION BY mandant_id, wup_id, hr_objekt_bereich_id
			ORDER BY kjmo  
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_rol
		, SUM(austritt_an) OVER (
			PARTITION BY mandant_id, wup_id, hr_objekt_bereich_id
			ORDER BY kjmo  
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_an_rol
		, SUM(austritt_ag) OVER (
			PARTITION BY mandant_id, wup_id, hr_objekt_bereich_id
			ORDER BY kjmo  
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_ag_rol
		, SUM(austritt_trw) OVER (
			PARTITION BY mandant_id, wup_id, hr_objekt_bereich_id
			ORDER BY kjmo  
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_trw_rol
		, SUM(austritt_vtg) OVER (
			PARTITION BY mandant_id, wup_id, hr_objekt_bereich_id
			ORDER BY kjmo  
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_vtg_rol
		, SUM(austritt_ana) OVER (
			PARTITION BY mandant_id, wup_id, hr_objekt_bereich_id
			ORDER BY kjmo  
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_ana_rol
		, SUM(austritt_ugsi) OVER (
			PARTITION BY mandant_id, wup_id, hr_objekt_bereich_id
			ORDER BY kjmo  
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_ugsi_rol
		, SUM(austritt_ugsw) OVER (
			PARTITION BY mandant_id, wup_id, hr_objekt_bereich_id
			ORDER BY kjmo  
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_ugsw_rol
		, SUM(austritt_bu) OVER (
			PARTITION BY mandant_id, wup_id, hr_objekt_bereich_id
			ORDER BY kjmo  
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_aus_bu_rol
	FROM ( /* Gruppierung SHR Daten auf Ebene hr_objekt_bereich */
		SELECT mandant_id
			, wup_id
			, kjmo
			, hr_objekt_bereich_id
			, SUM(KOPF             * AKTIV) AS kopf_aktiv
			, SUM(KOPF             * FLUKT) AS kopf_flukt
			, SUM(KOPF             * FLUKT_AUSTRITT) AS austritte
			, SUM(austritt_an_fg   * FLUKT_AUSTRITT) AS austritt_an
			, SUM(austritt_ag_fg   * FLUKT_AUSTRITT) AS austritt_ag
			, SUM(austritt_trw_fg  * FLUKT) AS austritt_trw
			, SUM(austritt_vtg_fg  * FLUKT) AS austritt_vtg
			, SUM(austritt_ana_fg  * FLUKT) AS austritt_ana
			, SUM(austritt_ugsi_fg * FLUKT) AS austritt_ugsi
			, SUM(austritt_ugsw_fg * FLUKT) AS austritt_ugsw
			, SUM(austritt_bu_fg   * FLUKT) AS austritt_bu
		FROM dbp_msi_view_vis.mv_vis_monat_shr_mitarbeiterbew_2
		WHERE shr_ma_funktion_gruppe_id IN (10, 20, 30, 40, 50, 60, 80) /* Fluktuation (ohne 70 Prakikant, 90 Aushilfe, 100 Extern) */
		AND mandant_id <> 1 /* Nur Ausland */
	GROUP BY ALL
	) shr0 
) shr_ist
ON shr_ist.mandant_id = vis.mandant_id AND shr_ist.wup_id = vis.wup_id AND shr_ist.kjmo = vis.kjmo
	AND shr_ist.hr_objekt_bereich_id = obj_ber.hr_objekt_bereich_id
;