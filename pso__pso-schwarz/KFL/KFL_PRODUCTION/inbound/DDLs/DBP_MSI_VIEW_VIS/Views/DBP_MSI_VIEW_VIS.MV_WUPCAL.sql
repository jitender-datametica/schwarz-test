create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_WUPCAL(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	DAT,
	WRG_ID,
	OFFEN,
	OFFEN_VON,
	OFFEN_BIS,
	WERBEWOCHE,
	EREIGNISTYP_ID,
	EREIGNIS_ID,
	EREIGNIS_BEZ_KURZ,
	EREIGNIS_BEZ_LANG,
	EREIGNIS_FG,
	EREIGNIS_PIC,
	BONANZAHL,
	BONANZAHL_IMBISS,
	DATENLIEFERUNG,
	DATENLIEFERUNG_BON,
	BONANZAHL_SUG,
	UMSATZ_BRUTTO_ODS_VERKAUF,
	UMSATZ_BRUTTO_ODS_KASSENABSCHLUSS,
	DATENLIEFERUNG_ARTBEW,
	DATENLIEFERUNG_ARTBEW_WG_SUM,
	DATENLIEFERUNG_BONANZAHL,
	DATENLIEFERUNG_MISVIER,
	DATENLIEFERUNG_QBM_STATUS,
	PRUEF_GRUND_ID_KUNDE,
	PRUEF_GRUND_ID_UMSATZ,
	PRUEF_STATUS_ID_KUNDE,
	PRUEF_STATUS_ID_UMSATZ,
	BONANZAHL_KUNDENKARTE,
	BONANZAHL_KUNDENKARTE_PAYBACK,
	BONANZAHL_FRISCHETHEKE_OHNE_FISCH,
	UMSATZ_NETTO_KUNDENKARTE COMMENT 'Umsatz netto mit Kaufland Loyalty Programm (kundenkarte_typ_id =2) auf Markt- und Tagebene'
) as
















WITH 
ereignis AS (
	SELECT v01.mandant_id
		, v01.nb_id
		, v01.wup_id
		, v01.dat
		, MAX(CASE WHEN v01.ereignistyp_id IN (12310) THEN v01.ereignistyp_id ELSE NULL END) AS ereignistyp_id
		, MAX(CASE WHEN v01.ereignistyp_id IN (12310) THEN v01.ereignis_id ELSE NULL END) AS ereignis_id
		, MAX(CASE WHEN v01.ereignistyp_id IN (12310) THEN v02.ereignis_bez_kurz ELSE NULL END) AS ereignis_bez_kurz
		, MAX(CASE WHEN v01.ereignistyp_id IN (12310) THEN v02.ereignis_bez_lang ELSE NULL END) AS ereignis_bez_lang
		, MAX(CASE WHEN v01.mandant_id = 1 AND v01.ereignistyp_id = 2 AND v01.ereignis_id = 1 THEN NULL ELSE 1 END) AS ereignis_fg
	FROM dbp_view.v_tag v00
	JOIN dbp_view.v_wupcal_ereignis_zu v01
		ON v00.dat = v01.dat
	JOIN dbp_view.v_ereignis_spr_zu v02
		ON v01.mandant_id = v02.mandant_id
			AND v01.ereignis_id = v02.ereignis_id
			AND v01.ereignistyp_id = v02.ereignistyp_id
	WHERE v00.akt_gj BETWEEN -2 AND 0
		AND v01.nb_id IN (0, 2, 7)
		AND v02.spr_id = 22
	GROUP BY v01.mandant_id
		, v01.nb_id
		, v01.wup_id
		, v01.dat
	)
SELECT
	v01.mandant_id
	, v01.nb_id
	, w.aktuell_wup_id AS wup_id
	, v01.dat
	, k.nach_wrg_id AS wrg_id
	, v01.offen
	, v01.offen_von
	, v01.offen_bis
	, v01.werbewoche
	, v03.ereignistyp_id
	, v03.ereignis_id
	, v03.ereignis_bez_kurz
	, v03.ereignis_bez_lang
	, v03.ereignis_fg
	, CASE WHEN v03.ereignis_fg = 1 THEN 'iconDetails.gif' ELSE 'demo/transparent.gif' END::VARCHAR(200) AS ereignis_pic
	, v01.bonanzahl
	, v01.bonanzahl_imbiss
	, v01.datenlieferung_artbew_wg_sum AS datenlieferung
	, v01.datenlieferung_bonanzahl AS datenlieferung_bon
	, v01.bonanzahl_sug
	, v01.umsatz_brutto_ods_verkauf * k.umrechnungskurs AS umsatz_brutto_ods_verkauf
	, v01.umsatz_brutto_ods_kassenabschluss * k.umrechnungskurs AS umsatz_brutto_ods_kassenabschluss
	, v01.datenlieferung_artbew
	, v01.datenlieferung_artbew_wg_sum
	, v01.datenlieferung_bonanzahl
	, v01.datenlieferung_misvier
	, v01.datenlieferung_qbm_status
	, v01.pruef_grund_id_kunde
	, v01.pruef_grund_id_umsatz
	, v01.pruef_status_id_kunde
	, v01.pruef_status_id_umsatz
	, v01.bonanzahl_kundenkarte
	, v01.bonanzahl_kundenkarte_payback
	, v01.bonanzahl_frischetheke_ohne_fisch
	, v01.betrag_vk_netto_kundenkarte * k.umrechnungskurs AS umsatz_netto_kundenkarte
FROM dbp_view.v_wupcal v01 
JOIN dbp_view.v_tag v02
	ON v01.dat = v02.dat
LEFT JOIN ereignis v03
	ON v01.mandant_id = v03.mandant_id
		AND v01.nb_id= v03.nb_id
		AND v01.wup_id = v03.wup_id
		AND v01.dat = v03.dat
INNER JOIN dbp_view.v_wup w 
	ON v01.mandant_id = w.mandant_id 
		AND v01.wup_id = w.wup_id 
INNER JOIN dbp_msi_view_vis.mv_kurs_umrechnung k 
	ON v01.wrg_id = k.von_wrg_id
WHERE v01.nb_id IN (0, 2, 7)
;
