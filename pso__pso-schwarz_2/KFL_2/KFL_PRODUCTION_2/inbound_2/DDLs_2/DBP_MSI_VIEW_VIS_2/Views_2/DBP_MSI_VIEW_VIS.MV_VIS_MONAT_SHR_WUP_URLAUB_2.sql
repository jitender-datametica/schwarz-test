CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VIS_MONAT_SHR_WUP_URLAUB_2 (
	MANDANT_ID,
	NB_ID,
	WRG_ID,
	WUP_ID,
	GJ,
	KJMO,
	AKT_MO,
	AKT_MO_SHR,
	FRUEHINFO2,
	KOPF,
	KOPF_KVJ,
	TAGE_URLAUB_REST_VJ_KJ,
	TAGE_URLAUB_ANSPRUCH_AKT_KJ,
	TAGE_URLAUB_GENOMMEN_KJ_KUM,
	TAGE_URLAUB_ABGELTUNG_KJ_KUM,
	TAGE_URLAUB_REST_VJ_KJ_KVJ,
	TAGE_URLAUB_ANSPRUCH_AKT_KJ_KVJ,
	TAGE_URLAUB_GENOMMEN_KJ_KUM_KVJ,
	TAGE_URLAUB_ABGELTUNG_KJ_KUM_KVJ
) AS 
 
/*
	FAKT/AGGREGAT -- Resturlaub auf Ebene Filiale/Monat_2, Transformation auf KVJ
	REDESIGN_RUQ auf Basis Excel Upload
	2018.0906 ssch0611 : Initial. Mapping MA auf Filiale des Berichtsmonat
	2018.0926 ssch0611 : Finetuning/QS. Urlaub exklusiv in dieser view
	2018.1106 ssch0611 : Final/Release - Anpassung nur positver Resturlaub VJ
	2018.1212 ssch0611 : Redesign_RUQ. Datenbasis Excel upload
	2024-09-11 ssch0611 : Filialumgliederung + Review [P1760-DWH] 
*/
 
SELECT
  vis.mandant_id, vis.nb_id, vis.wrg_id, vis.wup_id
, vis.gj, vis.kjmo
, vis.akt_mo 
, vis.akt_fruehinfo2 - 1 AS akt_mo_shr -- Berichtsmonat = -1
, vis.akt_fruehinfo2     AS fruehinfo2 -- original Fruehinfo2 FG
, ruq.kopf     AS kopf     -- rowcount
, ruq_kvj.kopf AS kopf_kvj -- rowcount
/* Resturlaub aktuelles Kalenderjahr */
, ruq.tage_urlaub_rest_vj_kj       AS tage_urlaub_rest_vj_kj
, ruq.tage_urlaub_anspruch_akt_kj  AS tage_urlaub_anspruch_akt_kj
, ruq.tage_urlaub_genommen_kj_kum  AS tage_urlaub_genommen_kj_kum
, ruq.tage_urlaub_abgeltung_kj_kum AS tage_urlaub_abgeltung_kj_kum
/* Resturlaub vorheriges Kalenderjahr */
, ruq_kvj.tage_urlaub_rest_vj_kj       AS tage_urlaub_rest_vj_kj_kvj
, ruq_kvj.tage_urlaub_anspruch_akt_kj  AS tage_urlaub_anspruch_akt_kj_kvj
, ruq_kvj.tage_urlaub_genommen_kj_kum  AS tage_urlaub_genommen_kj_kum_kvj
, ruq_kvj.tage_urlaub_abgeltung_kj_kum AS tage_urlaub_abgeltung_kj_kum_kvj
FROM ( /* MV_VIS_MONAT_FAKT_WUP_2 gruppiert (wup_2 = aktuell_wup) */
	SELECT vis.mandant_id, vis.nb_id, vis.wup_id, vis.wrg_id, vis.kjmo
	, zeit.gj
	, zeit.akt_mo
	, ker.akt_fruehinfo2
	, ker.akt_buchungs_schluss -- not used 
	FROM DBP_MSI_VIEW_VIS.MV_VIS_MONAT_FAKT_WUP_2 vis
 
	INNER JOIN DBP_DATA.MONAT_2 zeit_2
	ON zeit.kjmo = vis.kjmo 
 
	INNER JOIN DBP_DATA.L_BUCHUNGSSTATUS_KER_2 ker
	ON ker.kj_ker_mo_id = vis.kjmo
 
	GROUP BY ALL
) vis
 
LEFT JOIN ( /* RUQ gruppiert (aktuell_wup) */
	SELECT ruq0.mandant_id, ruq0.nb_id, ruq0.kjmo
	, 1 AS kopf
	, wup.aktuell_wup_id                    AS wup_id -- Mapping
	, SUM(anz_tage_urlaub_rest_vj_kj)       AS tage_urlaub_rest_vj_kj
	, SUM(anz_tage_urlaub_anspruch_akt_kj)  AS tage_urlaub_anspruch_akt_kj
	, SUM(anz_tage_urlaub_genommen_kj_kum)  AS tage_urlaub_genommen_kj_kum
	, SUM(anz_tage_urlaub_abgeltung_kj_kum) AS tage_urlaub_abgeltung_kj_kum
	FROM dbp_view.v_vis_monat_shr_wup_funktgr_upload_2  ruq0
 
	INNER JOIN dbp_view.v_wup_2 wup_2
	ON wup.mandant_id = ruq0.mandant_id AND wup.wup_id = ruq0.wup_id
 
	WHERE ruq0.shr_ma_funktion_gruppe_id = -1 -- Upload ohne Filialstruktur
	GROUP BY ALL
) ruq
ON ruq.mandant_id = vis.mandant_id AND ruq.wup_id = vis.wup_id
AND ruq.kjmo = vis.kjmo
 
	LEFT JOIN ( /* RUQ gruppiert (aktuell_wup) - KVJ Transformation */
	SELECT ruq0.mandant_id, ruq0.nb_id, ruq0.kjmo
	, 1 AS kopf
	, wup.aktuell_wup_id                    AS wup_id -- Mapping
	, SUM(anz_tage_urlaub_rest_vj_kj )      AS tage_urlaub_rest_vj_kj
	, SUM(anz_tage_urlaub_anspruch_akt_kj)  AS tage_urlaub_anspruch_akt_kj
	, SUM(anz_tage_urlaub_genommen_kj_kum)  AS tage_urlaub_genommen_kj_kum
	, SUM(anz_tage_urlaub_abgeltung_kj_kum) AS tage_urlaub_abgeltung_kj_kum
	FROM dbp_view.v_vis_monat_shr_wup_funktgr_upload_2  ruq0
 
	INNER JOIN dbp_view.v_wup_2 wup_2
	ON wup.mandant_id = ruq0.mandant_id AND wup.wup_id = ruq0.wup_id
 
	WHERE ruq0.shr_ma_funktion_gruppe_id = -1 -- Upload ohne Filialstruktur
	GROUP BY ALL
) ruq_kvj
ON ruq_kvj.mandant_id = vis.mandant_id AND ruq_kvj.wup_id = vis.wup_id
AND (ruq_kvj.kjmo + 100) = vis.kjmo
;