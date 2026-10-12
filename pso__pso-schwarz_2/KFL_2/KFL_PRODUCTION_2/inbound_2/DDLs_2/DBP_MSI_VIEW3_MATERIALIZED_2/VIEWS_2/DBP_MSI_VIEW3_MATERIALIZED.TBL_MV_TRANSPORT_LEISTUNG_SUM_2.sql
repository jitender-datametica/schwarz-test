create or replace view DBP_MSI_VIEW3_MATERIALIZED.TBL_MV_TRANSPORT_LEISTUNG_SUM_2(
	LAGERNUMMER_ID,
	MANDANT_ID,
	VON_LAGERTYP_ID,
	NACH_LAGERTYP_ID,
	WUP_ID,
	NB_ID,
	LEIST_EMPFAENGER_GRUPPE_ID,
	DAT_LEISTUNG,
	TRANSPORT_GV_ID,
	GP_ID,
	MENGE_KOLLI,
	ZEIT_SEKUNDEN,
	ZEIT_RUEST_SEKUNDEN,
	ZEIT_PAUSE_SEKUNDEN,
	ANZAHL_TRANSPORTAUFTRAG,
	ANZAHL_VERSANDBLOCK,
	ANZAHL_RUESTZEIT,
	ANZAHL_PAUSE,
	EXT_MA_FG,
	LEIST_EMPFAENGER_SAP_ID
) as
SELECT
	v01.lagernummer_id,
	v01.mandant_id,
	v01.von_lagertyp_id,
	v01.nach_lagertyp_id,
	v01.wup_id,
	v01.nb_id,
	v01.leist_empfaenger_gruppe_id,
	v01.dat_leistung,
	v01.transport_gv_id,
	v01.gp_id,
	v01.menge_kolli,
	v01.zeit_sekunden,
	v01.zeit_ruest_sekunden,
	v01.zeit_pause_sekunden,
	v01.anzahl_transportauftrag,
	v01.anzahl_versandblock,
	v01.anzahl_ruestzeit,
	v01.anzahl_pause,
	v04.ext_ma_fg,
	v01.leist_empfaenger_sap_id
FROM
	dbp_view.v_transport_leistung_sum_2 v01 
	-- Bei anonymisierten Usern kann es zwei Einträge pro SAP-Gruppe_2 geben (EXT_MA_FG 0 UND 1) -> um eine_2 Duplizierung der Ergebnisse zu verhindern nehmen wir das min()
	INNER JOIN (
		SELECT
			mandant_id,
			wup_id,
			nb_id,
			leist_empfaenger_sap_id,
			leist_empfaenger_gruppe_id,
			min(ext_ma_fg) as ext_ma_fg
		FROM
			dbp_view.v_l_leist_empfaenger_2
		group by
			mandant_id,
			wup_id,
			nb_id,
			leist_empfaenger_sap_id,
			leist_empfaenger_gruppe_id
	) v04 ON v01.mandant_id = v04.mandant_id
	AND v01.wup_id = v04.wup_id
	AND v01.nb_id = v04.nb_id
	AND v01.leist_empfaenger_sap_id = v04.leist_empfaenger_sap_id
	AND v01.leist_empfaenger_gruppe_id = v04.leist_empfaenger_gruppe_id;