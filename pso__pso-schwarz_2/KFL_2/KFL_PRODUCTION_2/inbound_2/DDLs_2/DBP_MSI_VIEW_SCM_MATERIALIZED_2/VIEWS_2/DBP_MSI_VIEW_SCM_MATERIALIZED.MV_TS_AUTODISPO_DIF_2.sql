create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_TS_AUTODISPO_DIF_2(
	MANDANT_ID_KUNDE,
	WUP_ID_KUNDE,
	NB_ID_KUNDE,
	MANDANT_ID_VZ,
	WUP_ID_VZ,
	NB_ID_VZ,
	FRISCHE_MANAGER_ID,
	ART_ID,
	VS_ID,
	VKL_ID,
	WG_ID,
	ART_GRUPPE_ID,
	DAT_VON,
	DAT_BIS,
	SA_AF_FG,
	ART_CLUSTER_ID,
	WUP_CLUSTER_ID,
	WERBEGRUPPE_FLEISCH,
	DIF_FUNKTION_ID,
	DIF_TYP_ID,
	MENGE_EINH_ID,
	DIF_STATUS_ID,
	DIF_WERT,
	DIF_KOMMENTAR,
	DIF_TIMESTAMP,
	DELETE_FG,
	DATEINAME,
	DECODED_DATEINAME
) as 




SELECT
 v01.mandant_id_kunde

,COALESCE(v05.aktuell_wup_id,v01.wup_id_kunde) AS wup_id_kunde
,v01.nb_id_kunde
,v01.mandant_id_vz
,v01.wup_id_vz
,v01.nb_id_vz
,v01.frische_manager_id
,v01.art_id
,v01.vs_id
,v01.vkl_id
,v01.wg_id
,v01.art_gruppe_id
,v01.dat_von
,v01.dat_bis
,v01.sa_af_fg
,v01.art_cluster_id
,v01.wup_cluster_id
,v01.werbegruppe_fleisch
,v01.dif_funktion_id
,v01.dif_typ_id
,v01.menge_einh_id
,v01.dif_status_id
,v01.dif_wert
,v01.dif_kommentar
,v01.dif_timestamp
,0 AS delete_fg
,v01.dateiname
,REPLACE(v01.dateiname, '%20', ' ') AS decoded_dateiname
FROM DBP_VIEW.v_ts_autodispo_dif_2 v01
LEFT JOIN dbp_view.v_wup_2 v05
   ON v05.mandant_id = v01.mandant_id_kunde
   AND v05.wup_id = v01.wup_id_kunde
   
   AND ((v05.nb_id IN (2, 0, -111) AND v05.wup_id > 0) OR (v05.nb_id = -1 AND v05.wup_id = 0));