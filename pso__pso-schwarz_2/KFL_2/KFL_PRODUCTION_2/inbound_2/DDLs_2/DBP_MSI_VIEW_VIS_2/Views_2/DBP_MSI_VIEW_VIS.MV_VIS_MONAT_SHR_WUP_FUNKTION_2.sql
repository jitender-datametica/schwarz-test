CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_SHR_WUP_FUNKTION_2 (
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
	SHR_MA_FUNKTION_GRUPPE_ID,
	KOPF,
	KOPF_VMO,
	KOPF_AKT,
	VZK_AKT,
	VZK_EXT,
	KOPF_GESAMT,
	KOPF_OHNE_LZA,
	KOPF_TEILZEIT,
	KOPF_EINTRITTE,
	STUNDEN_VERTRAG,
	STUNDEN_ZUSCHLAG_FEIERTAG,
	STUNDEN_ZUSCHLAG_MEHR,
	STUNDEN_ZUSCHLAG_SPAET_NACHT,
	STUNDEN_ZUSCHLAG_WOCHENENDE,
	STUNDEN_MEHR_GELEISTET,
	STUNDEN_MEHR_BEZAHLT,
	TAGE_KRANK,
	TAGE_ARBEIT_SOLL,
	KOPF_FLUKTUATION_VMO,
	KOPF_FLUKTUATION,
	KOPF_FLUKTUATION_ROL,
	KOPF_AUSTRITTE,
	KOPF_AUSTRITTE_ROL,
	AUSTRITT_AN,
	AUSTRITT_AN_ROL,
	AUSTRITT_AG,
	AUSTRITT_AG_ROL,
	AUSTRITT_TRW,
	AUSTRITT_TRW_ROL,
	AUSTRITT_VTG,
	AUSTRITT_VTG_ROL,
	AUSTRITT_ANA,
	AUSTRITT_ANA_ROL,
	AUSTRITT_UGSI,
	AUSTRITT_UGSI_ROL,
	AUSTRITT_UGSW,
	AUSTRITT_UGSW_ROL,
	AUSTRITT_BU,
	AUSTRITT_BU_ROL,
	MONATE_00_03_VMO,
	MONATE_00_03,
	MONATE_00_03_ROL,
	MONATE_03_06_VMO,
	MONATE_03_06,
	MONATE_03_06_ROL,
	MONATE_06_12_VMO,
	MONATE_06_12,
	MONATE_06_12_ROL,
	MONATE_12_36_VMO,
	MONATE_12_36,
	MONATE_12_36_ROL,
	MONATE_36_VMO,
	MONATE_36,
	MONATE_36_ROL,
	AUSTRITT_00_03,
	AUSTRITT_00_03_ROL,
	AUSTRITT_03_06,
	AUSTRITT_03_06_ROL,
	AUSTRITT_06_12,
	AUSTRITT_06_12_ROL,
	AUSTRITT_12_36,
	AUSTRITT_12_36_ROL,
	AUSTRITT_36,
	AUSTRITT_36_ROL,
	FUNK_FLUKT_ROL_FG,
	FUNK_KOPF_FLUKTUATION,
	FUNK_KOPF_AUSTRITTE,
	FUNK_KOPF_AUSTRITT_AN,
	FUNK_KOPF_AUSTRITT_AG,
	FUNK_KOPF_FLUKTUATION_ROL,
	FUNK_KOPF_AUSTRITTE_ROL,
	FUNK_KOPF_AUSTRITT_AN_ROL,
	FUNK_KOPF_AUSTRITT_AG_ROL,
	FUNK_KOPF_FLUKTUATION_00_03,
	FUNK_KOPF_FLUKTUATION_03_06,
	FUNK_KOPF_FLUKTUATION_06_12,
	FUNK_KOPF_FLUKTUATION_12_36,
	FUNK_KOPF_FLUKTUATION_36,
	VZK_GESAMT,
	VZK_EINTRITT,
	VZK_FLUKTUATION,
	VZK_FLUKTUATION_VMO,
	VZK_AUSTRITT,
	MONATE_00,
	MONATE_00_VMO,
	MONATE_00_ROL,
	AUSTRITT_00,
	AUSTRITT_00_ROL,
	KOPF_FLUKT,
	KOPF_FLUKT_IST,
	KOPF_FLUKT_00_03,
	KOPF_FLUKT_03_06,
	KOPF_FLUKT_06_12,
	KOPF_FLUKT_12_36,
	KOPF_FLUKT_36,
	KOPF_FLUKTUATION_AUFG,
	MONATE_00_03_AUFG,
	MONATE_03_06_AUFG,
	MONATE_06_12_AUFG,
	MONATE_12_36_AUFG,
	MONATE_36_AUFG,
	KOPF_AUSTRITTE_AUFG,
	AUSTRITT_00_03_AUFG,
	AUSTRITT_03_06_AUFG,
	AUSTRITT_06_12_AUFG,
	AUSTRITT_12_36_AUFG,
	AUSTRITT_36_AUFG,
	AUSTRITT_TRW_AUFG,
	AUSTRITT_VTG_AUFG,
	AUSTRITT_AN_AUFG,
	AUSTRITT_AG_AUFG
) AS 

/*	FAKT/AGGREGAT : Koepfe, VZK, TZK, Fluktuation pro Filiale + MA Struktur und Monat_2 
	BASIS : Ausland shr_mitarbeiterbew + DE Excel Upload - REDESIGN 
	2018.0611 ssch0611 : Anbindung neue Struktur. Mapping der vorhanden Felder. Transformation VMO, KVJ, KVJMO
	2018.0626 ssch0611 : Finetuning + Mehrarbeit/Zuschlaege + Externe (kostenstelle)
	2018.0720 ssch0611 : Finetuning. Fluktuation aufg. 
	2018.0801 ssch0611 : Final. Berichtsmonat pro Land_2 (optional)
	2018.0904 ssch0611 : Zahlenformate VZK + Mapping ZF + FI2 - keine VJ Werte pro Funktion!
	2018.0904 ssch0611 : Finetuning/QS. Kein Mapping ZF. Kein Urlaub.
	2018.0611 ssch0611 : Final/Release - Cross Join Funktion zur Abbildung Vormonat/Vorjahr
	2019.0114 ssch0611 : Erweiterung DE (aus Excel Upload)
	2019.0131 ssch0611 : Anpassung Fluktuation (Azubi CZ) > Faktor FLUKT bei Austritten ergaenzt
	2019.0204 ssch0611 : Korrektur Fluktuation! FLUKT_AUSTRITTE Austritte ohne Sonderfall (Azubi CZ, ext Studenten HR)
	2019.0205 ssch0611 : Anpassung NULL Check / COALESCE
	2019.0211 ssch0611 : Synchronisation DE (Union Part)
	2019.0220 ssch0611 : Anpassung NULL Check Fluktuation
	2019.0325 ssch0611 : Erweiterung Moldau MD (mandant_id=4)
	2019.0405 ssch0611 : Anpassung NULL Check Fluktuation (DE)
	2020-12-07 ssch0611 : adjusted Kopf Extern = VZK Extern, Subselect(UNION to LEFT JOIN) (AP0078054_SPEC0093688)
	2021-05-10 ssch0611 : Fluktuation: (new base logic in mabew), added 12Mo rollierend (AP0082232_SPEC0109407)
	2021-09-21 ssch0611 : Finetuning Fluktuation rollierend (AP0082232_SPEC0109407)
	2022-05-04 ssch0611 : DE: anz_kopf _gesamt with anz_kopf _ohne_lza replaced in 2 columns (NSR2616397)
	2024-09-11 ssch0611 : Filialumgliederung + Review [P1760-DWH] nur DE 
	2025-06-30 ssch0611 : Review (CTE + Window Function) + Bereinigung Fluktuation rollierend [AP0184927]
	2025-07-31 ssch0611 : Fix Fluktuation rollierend
*/

/* Basis CTE */
WITH basis_vis AS (
	/* Basis : mv_vis_monat_fakt_wup_2 gruppiert (wup_2 = aktuell_wup) + Zeit_2 */
	SELECT vis.mandant_id
		, vis.nb_id
		, vis.wup_id
		, vis.wrg_id
		, vis.kjmo
		, zeit.akt_mo
		, zeit.mo_kj
		, zeit.gj
		, bsk.akt_fruehinfo2
		, wup.dat_eroeffnung AS dat_neo 
		, wup.dat_bis        AS dat_stl 
		, EXTRACT(YEAR FROM dat_neo) * 100 + EXTRACT(MONTH FROM dat_neo) AS kjmo_neo
		, EXTRACT(YEAR FROM dat_stl) * 100 + EXTRACT(MONTH FROM dat_stl) AS kjmo_stl
		/* Fluktuation rollierend ab dem 12. Monat_2 nach Eröffnung bis zum Schließungsmonat */
		, IFF(vis.kjmo BETWEEN kjmo_neo + 100 AND kjmo_stl, 1, 0) AS flukt_fg 
		, SUM(vis.ums_netto_plan) AS ums_netto_plan
	FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FAKT_WUP_2 vis
	/* mv_wup_2 (wup_2 = aktuell_wup) */ 
	INNER JOIN DBP_MSI_VIEW_VIS.MV_WUP_2 wup_2 
		ON wup.mandant_id = vis.mandant_id AND wup.wup_id = vis.wup_id
	/* Berichtsmonat = Fruehinfo 2 */
	INNER JOIN DBP_DATA.L_BUCHUNGSSTATUS_KER_2 bsk 
		ON bsk.kj_ker_mo_id = vis.kjmo
	INNER JOIN DBP_DATA.MONAT_2 zeit_2
		ON zeit.kjmo = vis.kjmo AND zeit.akt_gj < 1 
	WHERE vis.nb_id IN (-1, 0) /* Filialen + ZF */
	GROUP BY ALL
)
, basis_shr AS (
	/* Ausland : SHR Mitarbeiterdaten inkl Vormonat */
	SELECT mandant_id
		, wup_id
		, kjmo
		, akt_mo
		, shr_ma_funktion_gruppe_id
		, kpf
		, stunden_vertrag
		, stunden_zuschlag_feiertag
		, stunden_zuschlag_mehr
		, stunden_zuschlag_spaet_nacht
		, stunden_zuschlag_wochenende
		, stunden_mehr_bezahlt
		, tage_krank
		, tage_arbeit_soll
		, kpf_aktiv
		, kopf_ohne_lza
		, kopf_teilzeit
		, kopf_eintritte
		, kopf_flukt
		, LAST_VALUE(kopf_flukt) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo 
			ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS kopf_flukt_vmo
		, AVG(kopf_flukt) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo 
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_flukt_rol
		, austritte
		, austritt_an
		, austritt_ag
		,SUM(austritte) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo 
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS austritt_rol
		, SUM(austritt_an) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo 
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS austritt_an_rol
		, SUM(austritt_ag) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS austritt_ag_rol
		, austritt_trw
		, austritt_vtg
		, austritt_ana
		, austritt_ugsi
		, austritt_ugsw
		, austritt_bu
		, SUM(austritt_trw) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo 
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS austritt_trw_rol
		, SUM(austritt_vtg) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo 
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS austritt_vtg_rol
		, SUM(austritt_ana) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo 
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS austritt_ana_rol
		, SUM(austritt_ugsi) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo 
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS austritt_ugsi_rol
		, SUM(austritt_ugsw) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo 
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS austritt_ugsw_rol
		, SUM(austritt_bu) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo 
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS austritt_bu_rol
		, monate_00_03
		, monate_03_06
		, monate_06_12
		, monate_12_36
		, monate_36
		, LAST_VALUE(monate_00_03) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo
			ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS monate_00_03_vmo
		, LAST_VALUE(monate_03_06) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo
			ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS monate_03_06_vmo
		, LAST_VALUE(monate_06_12) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo
			ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS monate_06_12_vmo
		, LAST_VALUE(monate_12_36) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo
			ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS monate_12_36_vmo
		, LAST_VALUE(monate_36) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo
			ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS monate_36_vmo
		, AVG(monate_00_03) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS monate_00_03_rol
		, AVG(monate_03_06) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS monate_03_06_rol
		, AVG(monate_06_12) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS monate_06_12_rol
		, AVG(monate_12_36) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS monate_12_36_rol
		, AVG(monate_36) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS monate_36_rol
		, austritt_00_03
		, austritt_03_06
		, austritt_06_12
		, austritt_12_36
		, austritt_36
		, SUM(austritt_00_03) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS austritt_00_03_rol
		, SUM(austritt_03_06) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS austritt_03_06_rol
		, SUM(austritt_06_12) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS austritt_06_12_rol
		, SUM(austritt_12_36) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS austritt_12_36_rol
		, SUM(austritt_36) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS austritt_36_rol
		, vzk_aktiv
		, vzk_eintritt
		, vzk_flukt
		, LAST_VALUE(vzk_flukt) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo 
			ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS vzk_flukt_vmo
		, vzk_austritt
	FROM (
		SELECT mandant_id
			, wup_id
			, kjmo
			, akt_mo
			, shr_ma_funktion_gruppe_id
			, SUM(kopf)               AS kpf
			/* Stunden_2 */
			, SUM(STD_VERTRAG * AKTIV)  AS stunden_vertrag
			, SUM(FEIERTAG_ZUSCHLAG)    AS stunden_zuschlag_feiertag
			, SUM(MEHRSTD_ZUSCHLAG)     AS stunden_zuschlag_mehr
			, SUM(NACHT_ZUSCHLAG)       AS stunden_zuschlag_spaet_nacht
			, SUM(WOCHENEND_ZUSCHLAG)   AS stunden_zuschlag_wochenende
			, SUM(MEHRSTD_AUSBEZ)       AS stunden_mehr_bezahlt
			, SUM(STD_KRANK * KEIN_LZA) AS tage_krank
			, SUM(STD_SOLL  * KEIN_LZA) AS tage_arbeit_soll
			/* Köpfe/Mitarbeiter */
			, SUM(kopf * AKTIV)       AS kpf_aktiv
			, SUM(kopf * KEIN_LZA)    AS kopf_ohne_lza
			, SUM(TZK  * AKTIV)       AS kopf_teilzeit
			, SUM(kopf * eintritt_fg) AS kopf_eintritte
			/* Fluktuation -- 2021-05 */
			, SUM(kopf     * FLUKT) AS kopf_flukt
			, SUM(bzg_00   * FLUKT) AS monate_00
			, SUM(bzg_0003 * FLUKT) AS monate_00_03
			, SUM(bzg_0306 * FLUKT) AS monate_03_06
			, SUM(bzg_0612 * FLUKT) AS monate_06_12
			, SUM(bzg_1236 * FLUKT) AS monate_12_36
			, SUM(bzg_36   * FLUKT) AS monate_36
			, SUM(kopf           * FLUKT_AUSTRITT) AS austritte
			, SUM(austritt_an_fg * FLUKT_AUSTRITT) AS austritt_an
			, SUM(austritt_ag_fg * FLUKT_AUSTRITT) AS austritt_ag
			, SUM(bzg_00         * FLUKT_AUSTRITT) AS austritt_00
			, SUM(bzg_0003       * FLUKT_AUSTRITT) AS austritt_00_03
			, SUM(bzg_0306       * FLUKT_AUSTRITT) AS austritt_03_06
			, SUM(bzg_0612       * FLUKT_AUSTRITT) AS austritt_06_12
			, SUM(bzg_1236       * FLUKT_AUSTRITT) AS austritt_12_36
			, SUM(bzg_36         * FLUKT_AUSTRITT) AS austritt_36
			/* Austritte (keine Fluktuation) 2021-05 */
			, SUM(austritt_trw_fg  * FLUKT) AS austritt_trw
			, SUM(austritt_vtg_fg  * FLUKT) AS austritt_vtg
			, SUM(austritt_ana_fg  * FLUKT) AS austritt_ana
			, SUM(austritt_ugsi_fg * FLUKT) AS austritt_ugsi
			, SUM(austritt_ugsw_fg * FLUKT) AS austritt_ugsw
			, SUM(austritt_bu_fg   * FLUKT) AS austritt_bu
			/* VZK/Vollzeitkräfte */
			, SUM(VZK  * AKTIV)          AS vzk_aktiv
			, SUM(VZK  * eintritt_fg)    AS vzk_eintritt
			, SUM(VZK  * FLUKT)          AS vzk_flukt
			, SUM(VZK  * FLUKT_AUSTRITT) AS vzk_austritt
		FROM dbp_msi_view_vis.mv_vis_monat_shr_mitarbeiterbew_2 
		WHERE mandant_id <> 1 
		GROUP BY ALL
	)
)
, basis_ext AS (
	/* Ausland : Externe pro Kostenstelle gemappt auf wup_2 */
	SELECT kost_ext.mandant_id
		, wp.aktuell_wup_id AS wup_id
		, kost_ext.kjmo AS kjmo
		, 100 AS shr_ma_funktion_gruppe_id /* fix 100 Externe */
		, SUM(CASE
			WHEN kost_ext.mandant_id = 2 THEN kost_ext.anzahl_lohnart / 174.00
			WHEN kost_ext.mandant_id = 5 THEN kost_ext.anzahl_lohnart / 174.00
			WHEN kost_ext.mandant_id = 6 THEN kost_ext.anzahl_lohnart / 173.00
			WHEN kost_ext.mandant_id = 3 THEN kost_ext.anzahl_lohnart / 174.00
			WHEN kost_ext.mandant_id = 7 THEN kost_ext.anzahl_lohnart / 173.00
			WHEN kost_ext.mandant_id = 8 THEN kost_ext.anzahl_lohnart / 173.00
			WHEN kost_ext.mandant_id = 4 THEN kost_ext.anzahl_lohnart / 173.00 
			ELSE 0 END) AS vzk_x /* VZK = Kopf (2 Nachkommastellen) */
	FROM dbp_view.v_kostenstelle_lohnart_zu_per_2  kost_ext
	JOIN dbp_view.v_wup_2 wp
		ON wp.mandant_id = kost_ext.mandant_id AND wp.wup_id = try_to_numeric(SUBSTRING(kost_ext.kostenstelle_id, 1, 4)) ::INTEGER /* Maping Kostenstelle */
	WHERE kost_ext.lohnart_id = '/EXT' AND  kost_ext.anzahl_lohnart > 0
		AND kost_ext.mandant_id <> 1
	GROUP BY ALL
)
, basis_xls AS (
	/* DE : Excel Upload gruppiert + Mapping (aktuell_wup) */ 
		SELECT mandant_id
		, wup_id
		, kjmo
		, shr_ma_funktion_gruppe_id
		, kpf
		, stunden_vertrag
		, stunden_zuschlag_feiertag
		, stunden_zuschlag_mehr
		, stunden_zuschlag_spaet_nacht
		, stunden_zuschlag_wochenende
		, stunden_mehr_geleistet
		, stunden_mehr_bezahlt 
		, tage_krank
		, tage_arbeit_soll
		, kpf_aktiv
		, kopf_ext
		, kopf_ohne_lza
		, kopf_teilzeit
		, kopf_eintritte
		, kopf_flukt
		, LAST_VALUE(kopf_flukt) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo 
			ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS kopf_flukt_vmo
		, AVG(kopf_flukt) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo 
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS kopf_flukt_rol
		, austritte
		,SUM(austritte) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo 
			ROWS BETWEEN 11 PRECEDING AND CURRENT ROW) AS austritt_rol
		, vzk_aktiv
		, vzk_x
		, vzk_eintritt
		, vzk_flukt
		, LAST_VALUE(vzk_flukt) OVER (
			PARTITION BY mandant_id, wup_id, shr_ma_funktion_gruppe_id ORDER BY kjmo 
			ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS vzk_flukt_vmo
		, vzk_austritt
	FROM (
		SELECT upld.mandant_id
			, wup.aktuell_wup_id AS wup_id
			, upld.kjmo
			, upld.shr_ma_funktion_gruppe_id
			, MAX(1.00) AS kpf
			/* DE Werte auf ID = 50 MA  */
			, SUM(CASE WHEN upld.shr_ma_funktion_gruppe_id <> 100 THEN anz_kopf_ohne_lza ELSE 0.00 END) AS kpf_aktiv
			, SUM(CASE WHEN upld.shr_ma_funktion_gruppe_id =  100 THEN anz_kopf_ohne_lza ELSE 0.00 END) AS kopf_ext /* nicht verwendet */
			, SUM(anz_kopf_ohne_lza)    AS kopf_ohne_lza
			, SUM(anz_kopf_teilzeit)    AS kopf_teilzeit
			, SUM(anz_kopf_eintritte)   AS kopf_eintritte
			, SUM(anz_kopf_austritte)   AS austritte
			, SUM(anz_kopf_fluktuation) AS kopf_flukt
			, SUM(CASE WHEN upld.shr_ma_funktion_gruppe_id <> 100 THEN anz_vzk_gesamt ELSE 0.00 END) AS vzk_aktiv
			, SUM(CASE WHEN upld.shr_ma_funktion_gruppe_id =  100 THEN anz_vzk_gesamt ELSE 0.00 END) AS vzk_x
			, SUM(anz_vzk_eintritt)    AS vzk_eintritt
			, SUM(anz_vzk_austritt)    AS vzk_austritt
			, SUM(anz_vzk_fluktuation) AS vzk_flukt
			, SUM(anz_stunden_vertrag)  AS stunden_vertrag
			/* DE Werte auf ID = -1 sonst. */
			, SUM(anz_tage_krank) AS tage_krank
			, SUM(anz_tage_arbeit_soll) AS tage_arbeit_soll
			, SUM(anz_stunden_zuschlag_feiertag) AS stunden_zuschlag_feiertag
			, SUM(anz_stunden_zuschlag_mehr) AS stunden_zuschlag_mehr
			, SUM(anz_stunden_zuschlag_spaet_nacht) AS stunden_zuschlag_spaet_nacht
			, SUM(anz_stunden_zuschlag_wochenende) AS stunden_zuschlag_wochenende
			, SUM(anz_stunden_mehr_geleistet) AS stunden_mehr_geleistet
			, SUM(anz_stunden_mehr_bezahlt) AS stunden_mehr_bezahlt 
		FROM dbp_view.v_vis_monat_shr_wup_funktgr_upload_2 upld
		INNER JOIN dbp_view.v_wup_2 wup_2
			ON wup.mandant_id = upld.mandant_id AND wup.wup_id = upld.wup_id
		WHERE upld.mandant_id = 1
		GROUP BY ALL
	) sub0 
)


/* PART 1 - Ausland SHR */

SELECT vis.mandant_id
	, vis.nb_id
	, vis.wup_id
	, vis.wrg_id
	, vis.gj
	, vis.kjmo
	/* Zeit_2 : Berichtmonat (-1) = Fruehinfo2 (0) */
	, vis.akt_mo
	, vis.mo_kj
	, vis.akt_fruehinfo2 - 1 AS akt_mo_shr
	, vis.akt_fruehinfo2     AS fruehinfo2
	, smfg.shr_ma_funktion_gruppe_id
	/* Ausland : Helper rowcounts + interne + externe */ 
	, ZEROIFNULL(basis.kpf)       AS kopf
	, 0                           AS kopf_vmo
	, ZEROIFNULL(basis.kpf_aktiv) AS kopf_akt
	, ZEROIFNULL(basis.vzk_aktiv) AS vzk_akt
	, ZEROIFNULL(ext.vzk_x)       AS vzk_ext /* vzk extern = kopf extern */
	/* Ausland : Köpfe Gesamt inkl Externe */ 
	, kopf_akt + vzk_ext AS kopf_gesamt
	, basis.kopf_ohne_lza
	, basis.kopf_teilzeit
	, basis.kopf_eintritte
	/* Ausland : Stunden_2 */  
	, basis.stunden_vertrag
	, basis.stunden_zuschlag_feiertag
	, basis.stunden_zuschlag_mehr
	, basis.stunden_zuschlag_spaet_nacht
	, basis.stunden_zuschlag_wochenende
	, 0 AS stunden_mehr_geleistet /* nicht definiert */
	, basis.stunden_mehr_bezahlt
	, basis.tage_krank
	, basis.tage_arbeit_soll
	/* Ausland : Fluktuation + rolliernd -- 2021-05 */
	, basis.kopf_flukt_vmo AS kopf_fluktuation_vmo
	, basis.kopf_flukt     AS kopf_fluktuation
	, basis.kopf_flukt_rol AS kopf_fluktuation_rol
	, basis.austritte      AS kopf_austritte
	, basis.austritt_rol   AS kopf_austritte_rol
	, basis.austritt_an
	, basis.austritt_an_rol
	, basis.austritt_ag
	, basis.austritt_ag_rol 
	/* Ausland : Austritte (keine Fluktuation) */
	, basis.austritt_trw
	, basis.austritt_trw_rol
	, basis.austritt_vtg
	, basis.austritt_vtg_rol
	, basis.austritt_ana
	, basis.austritt_ana_rol
	, basis.austritt_ugsi
	, basis.austritt_ugsi_rol
	, basis.austritt_ugsw
	, basis.austritt_ugsw_rol
	, basis.austritt_bu
	, basis.austritt_bu_rol
	/* Ausland : Fluktuation nach Betriebszugehörigkeit */
	, basis.monate_00_03_vmo
	, basis.monate_00_03
	, basis.monate_00_03_rol
	, basis.monate_03_06_vmo
	, basis.monate_03_06
	, basis.monate_03_06_rol
	, basis.monate_06_12_vmo
	, basis.monate_06_12
	, basis.monate_06_12_rol
	, basis.monate_12_36_vmo
	, basis.monate_12_36
	, basis.monate_12_36_rol
	, basis.monate_36_vmo
	, basis.monate_36
	, basis.monate_36_rol
	, basis.austritt_00_03
	, basis.austritt_00_03_rol
	, basis.austritt_03_06
	, basis.austritt_03_06_rol
	, basis.austritt_06_12
	, basis.austritt_06_12_rol
	, basis.austritt_12_36
	, basis.austritt_12_36_rol
	, basis.austritt_36
	, basis.austritt_36_rol

	/* Ausland : Fluktuation Filiale/Funktion -- NEUE SPALTEN 2025-06 */
	, vis.flukt_fg                                  AS funk_flukt_rol_fg
	, (kopf_fluktuation_vmo + kopf_fluktuation) / 2 AS funk_kopf_fluktuation
	, basis.austritte                               AS funk_kopf_austritte
	, basis.austritt_an                             AS funk_kopf_austritt_an
	, basis.austritt_ag                             AS funk_kopf_austritt_ag
	, basis.kopf_flukt_rol  * vis.flukt_fg          AS funk_kopf_fluktuation_rol
	, basis.austritt_rol    * vis.flukt_fg          AS funk_kopf_austritte_rol
	, basis.austritt_an_rol * vis.flukt_fg          AS funk_kopf_austritt_an_rol
	, basis.austritt_ag_rol * vis.flukt_fg          AS funk_kopf_austritt_ag_rol
	, (monate_00_03_vmo + monate_00_03)         / 2 AS funk_kopf_fluktuation_00_03
	, (monate_03_06_vmo + monate_03_06)         / 2 AS funk_kopf_fluktuation_03_06
	, (monate_06_12_vmo + monate_06_12)         / 2 AS funk_kopf_fluktuation_06_12
	, (monate_12_36_vmo + monate_12_36)         / 2 AS funk_kopf_fluktuation_12_36
	, (monate_36_vmo    + monate_36)            / 2 AS funk_kopf_fluktuation_36

	/* Ausland VZK */
	, vzk_akt + vzk_ext   AS vzk_gesamt
	, basis.vzk_eintritt
	, basis.vzk_flukt     AS vzk_fluktuation
	, basis.vzk_flukt_vmo AS vzk_fluktuation_vmo
	, basis.vzk_austritt

/* Ausland : LÖSCHSPALTEN */
	, 0 AS monate_00       /* nicht verwendet */
	, 0 AS monate_00_vmo   /* nicht verwendet */
	, 0 AS monate_00_rol   /* nicht verwendet */
	, 0 AS austritt_00     /* nicht verwendet */
	, 0 AS austritt_00_rol /* nicht verwendet */
	, 0 kopf_FLUKT
	, 0 kopf_FLUKT_IST
	, 0 kopf_FLUKT_00_03
	, 0 kopf_FLUKT_03_06
	, 0 kopf_FLUKT_06_12
	, 0 kopf_FLUKT_12_36
	, 0 kopf_FLUKT_36
	, 0 kopf_fluktuation_aufg
	, 0 monate_00_03_aufg
	, 0 monate_03_06_aufg
	, 0 monate_06_12_aufg
	, 0 monate_12_36_aufg
	, 0 monate_36_aufg
	, 0 kopf_austritte_aufg
	, 0 austritt_00_03_aufg
	, 0 austritt_03_06_aufg
	, 0 austritt_06_12_aufg
	, 0 austritt_12_36_aufg
	, 0 austritt_36_aufg
	, 0 austritt_trw_aufg
	, 0 austritt_vtg_aufg
	, 0 austritt_an_aufg
	, 0 austritt_ag_aufg

/* Ausland : Basis */ 
FROM basis_vis vis

/* Ausland : SHR MA Funktion */  
CROSS JOIN (
	SELECT DISTINCT shr_ma_funktion_gruppe_id
	FROM dbp_view.v_shr_ma_funktion_gruppe_spr_zu_2
 ) smfg

/* Ausland : SHR mitarbeiterbew_2 IST */
LEFT JOIN basis_shr basis
ON basis.mandant_id = vis.mandant_id AND basis.wup_id = vis.wup_id AND basis.kjmo = vis.kjmo
	AND basis.shr_ma_funktion_gruppe_id = smfg.shr_ma_funktion_gruppe_id

/* Ausland : Externe pro Kostenstelle */
LEFT JOIN basis_ext ext
ON ext.mandant_id = vis.mandant_id AND ext.wup_id = vis.wup_id AND ext.kjmo = vis.kjmo
	AND ext.shr_ma_funktion_gruppe_id = smfg.shr_ma_funktion_gruppe_id

WHERE vis.mandant_id <> 1 /* Ausland */


/* PART 2 -- DE Excel */

UNION ALL 
SELECT vis.mandant_id
	, vis.nb_id
	, vis.wup_id
	, vis.wrg_id
	, vis.gj
	, vis.kjmo
	/* Zeit_2 : Berichtmonat (-1) = Fruehinfo2 (0) */
	, vis.akt_mo
	, vis.mo_kj
	, vis.akt_fruehinfo2 - 1 AS akt_mo_shr
	, vis.akt_fruehinfo2     AS fruehinfo2
	, smfg.shr_ma_funktion_gruppe_id
	/* DE : Helper rowcounts + interne + externe */ 
	, ZEROIFNULL(basis.kpf)       AS kopf
	, 0                           AS kopf_vmo
	, ZEROIFNULL(basis.kpf_aktiv) AS kopf_akt
	, ZEROIFNULL(basis.vzk_aktiv) AS vzk_akt
	, ZEROIFNULL(basis.vzk_x)     AS vzk_ext /* vzk extern = kopf extern */
	/* DE : Köpfe Gesamt inkl Externe */ 
	, kopf_akt + vzk_ext AS kopf_gesamt
	, basis.kopf_ohne_lza
	, basis.kopf_teilzeit
	, basis.kopf_eintritte
	/* DE : Stunden_2 */  
	, basis.stunden_vertrag
	, basis.stunden_zuschlag_feiertag
	, basis.stunden_zuschlag_mehr
	, basis.stunden_zuschlag_spaet_nacht
	, basis.stunden_zuschlag_wochenende
	, basis.stunden_mehr_geleistet
	, basis.stunden_mehr_bezahlt
	, basis.tage_krank
	, basis.tage_arbeit_soll
	/* DE : Fluktuation + rolliernd -- 2021-05 */
	, basis.kopf_flukt_vmo AS kopf_fluktuation_vmo
	, basis.kopf_flukt     AS kopf_fluktuation
	, basis.kopf_flukt_rol AS kopf_fluktuation_rol
	, basis.austritte      AS kopf_austritte
	, basis.austritt_rol   AS kopf_austritte_rol
	/* DE : nicht definiert */
	, 0 austritt_an
	, 0 austritt_an_rol
	, 0 austritt_ag
	, 0 austritt_ag_rol 
	, 0 austritt_trw
	, 0 austritt_trw_rol
	, 0 austritt_vtg
	, 0 austritt_vtg_rol
	, 0 austritt_ana
	, 0 austritt_ana_rol
	, 0 austritt_ugsi
	, 0 austritt_ugsi_rol
	, 0 austritt_ugsw
	, 0 austritt_ugsw_rol
	, 0 austritt_bu
	, 0 austritt_bu_rol
	, 0 monate_00_03_vmo
	, 0 monate_00_03
	, 0 monate_00_03_rol
	, 0 monate_03_06_vmo
	, 0 monate_03_06
	, 0 monate_03_06_rol
	, 0 monate_06_12_vmo
	, 0 monate_06_12
	, 0 monate_06_12_rol
	, 0 monate_12_36_vmo
	, 0 monate_12_36
	, 0 monate_12_36_rol
	, 0 monate_36_vmo
	, 0 monate_36
	, 0 monate_36_rol
	, 0 austritt_00_03
	, 0 austritt_00_03_rol
	, 0 austritt_03_06
	, 0 austritt_03_06_rol
	, 0 austritt_06_12
	, 0 austritt_06_12_rol
	, 0 austritt_12_36
	, 0 austritt_12_36_rol
	, 0 austritt_36
	, 0 austritt_36_rol

	/* DE : Fluktuation Filiale/Funktion -- NEUE SPALTEN 2025-06 */
	, vis.flukt_fg                                  AS funk_flukt_rol_fg
	, (kopf_fluktuation_vmo + kopf_fluktuation) / 2 AS funk_kopf_fluktuation
	, basis.austritte                               AS funk_kopf_austritte
	, 0                                             AS funk_kopf_austritt_an
	, 0                                             AS funk_kopf_austritt_ag
	, basis.kopf_flukt_rol * vis.flukt_fg           AS funk_kopf_fluktuation_rol
	, basis.austritt_rol   * vis.flukt_fg           AS funk_kopf_austritte_rol
	, 0                                             AS funk_kopf_austritt_an_rol
	, 0                                             AS funk_kopf_austritt_ag_rol
	, 0                                             AS funk_kopf_fluktuation_00_03
	, 0                                             AS funk_kopf_fluktuation_03_06
	, 0                                             AS funk_kopf_fluktuation_06_12
	, 0                                             AS funk_kopf_fluktuation_12_36
	, 0                                             AS funk_kopf_fluktuation_36

	/* VZK */
	, vzk_akt + vzk_ext   AS vzk_gesamt
	, basis.vzk_eintritt
	, basis.vzk_flukt     AS vzk_fluktuation
	, basis.vzk_flukt_vmo AS vzk_fluktuation_vmo
	, basis.vzk_austritt

/* DE : LÖSCHSPALTEN */
	, 0 AS monate_00       /* nicht verwendet */
	, 0 AS monate_00_vmo   /* nicht verwendet */
	, 0 AS monate_00_rol   /* nicht verwendet */
	, 0 AS austritt_00     /* nicht verwendet */
	, 0 AS austritt_00_rol /* nicht verwendet */
	, 0 kopf_FLUKT
	, 0 kopf_FLUKT_IST
	, 0 kopf_FLUKT_00_03
	, 0 kopf_FLUKT_03_06
	, 0 kopf_FLUKT_06_12
	, 0 kopf_FLUKT_12_36
	, 0 kopf_FLUKT_36
	, 0 kopf_fluktuation_aufg
	, 0 monate_00_03_aufg
	, 0 monate_03_06_aufg
	, 0 monate_06_12_aufg
	, 0 monate_12_36_aufg
	, 0 monate_36_aufg
	, 0 kopf_austritte_aufg
	, 0 austritt_00_03_aufg
	, 0 austritt_03_06_aufg
	, 0 austritt_06_12_aufg
	, 0 austritt_12_36_aufg
	, 0 austritt_36_aufg
	, 0 austritt_trw_aufg
	, 0 austritt_vtg_aufg
	, 0 austritt_an_aufg
	, 0 austritt_ag_aufg

/* DE : Basis */ 
FROM basis_vis vis

/* DE : MA Funktion */  
CROSS JOIN (
	SELECT DISTINCT shr_ma_funktion_gruppe_id
	FROM dbp_view.v_shr_ma_funktion_gruppe_spr_zu_2
 ) smfg

/* DE : Excel IST */
LEFT JOIN basis_xls basis
ON basis.mandant_id = vis.mandant_id AND basis.wup_id = vis.wup_id AND basis.kjmo = vis.kjmo
	AND basis.shr_ma_funktion_gruppe_id = smfg.shr_ma_funktion_gruppe_id

WHERE vis.mandant_id = 1 /* DE */
;