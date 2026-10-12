create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_TRANSPORTAUFTRAG_DET_2(
	MANDANT_ID,
	TRANSPORT_BELEG_ID,
	TRANSPORT_BELEG_POS_ID,
	LAGERNUMMER_ID,
	WUP_ID,
	NB_ID,
	LAGERORT_ID,
	ART_ID,
	DAT_QUITTIERUNG,
	DAT_ERSTELLUNG,
	VON_LAGERPLATZ_ID,
	VON_LAGERTYP_ID,
	NACH_LAGERPLATZ_ID,
	NACH_LAGERTYP_ID,
	SYSTEM_ID,
	MENGE_TRANSPORTAUFTRAG_KOLLI,
	DAT_ENTNAHME_QUITTIERUNG,
	ZEIT_ENTNAHME_QUITTIERUNG,
	LAGER_EINHEIT_ID_VON,
	LAGER_EINHEIT_ID_NACH,
	ZEIT_QUITTIERUNG,
	MENGE_IST_NACH,
	MENGE_SOLL_VON,
	QUITTIERUNG_FG,
	LAGER_EINHEITEN_TYP,
	TRANSPORT_VORGANG_ID,
	DAT_VERFALL,
	BRUTTOGEW_KG,
	NACHSCHUBZEIT_SEKUNDEN,
	PLATZ_LEER_FG,
	MENGE_SOLL_NACH_ALTNV,
	MIN_NACHSCHUB_KDR,
	DISTANZ,
	EINL_EBENE,
	SAP_USER,
	HANDLING_UNIT_ID_EXT
) as  SELECT
 mandant_id
,transport_beleg_id
,transport_beleg_pos_id
,lagernummer_id
,wup_id
,nb_id
,lagerort_id
,art_id
,dat_quittierung
,dat_erstellung
,von_lagerplatz_id
,von_lagertyp_id
,nach_lagerplatz_id
,nach_lagertyp_id
,system_id
,menge_transportauftrag_kolli
,dat_entnahme_quittierung
,try_to_time(TO_CHAR(zeit_entnahme_quittierung,'000000'),'HH24MISS') AS zeit_entnahme_quittierung
,lager_einheit_id_von
,lager_einheit_id_nach
,try_to_time(TO_CHAR(zeit_quittierung,'000000'),'HH24MISS') AS zeit_quittierung
,menge_ist_nach
,menge_soll_von
,quittierung_fg
,lager_einheiten_typ
,transport_vorgang_id
,dat_verfall
,bruttogew_kg
,nachschubzeit_sekunden
,platz_leer_fg
,menge_soll_nach_altnv
,min_nachschub_kdr
,distanz
,einl_ebene
,sap_user
,handling_unit_id_ext

FROM DBP_DATA.TRANSPORTAUFTRAG_DET_2

;
