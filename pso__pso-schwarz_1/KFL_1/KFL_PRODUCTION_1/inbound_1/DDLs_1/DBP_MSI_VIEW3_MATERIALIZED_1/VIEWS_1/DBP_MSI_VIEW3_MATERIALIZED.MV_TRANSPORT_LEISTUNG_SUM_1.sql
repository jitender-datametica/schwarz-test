create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_TRANSPORT_LEISTUNG_SUM_1(
	LAGERNUMMER_ID,
	MANDANT_ID,
	VON_LAGERTYP_ID,
	NACH_LAGERTYP_ID,
	WUP_ID,
	NB_ID,
	LEIST_EMPFAENGER_SAP_ID,
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
	ANZAHL_PAUSE
) as
SELECT
	v01.lagernummer_id,
	v01.mandant_id,
	v01.von_lagertyp_id,
	v01.nach_lagertyp_id,
	v01.wup_id,
	v01.nb_id 
	-- siehe dazu auch View mv_l_leist_empfaenger. Dort wird ein 'Eigen' Satz angehängt,
	-- um weiterhin einen JOIN auf leist_empfaenger_sap_id zu ermöglichen
	--,CASE WHEN v02.leist_einzelauswertung_fg = 1 AND v04.ext_ma_fg = 0 THEN v01.leist_empfaenger_sap_id
	--      WHEN v02.leist_einzelauswertung_fg = 0 AND v04.ext_ma_fg = 0 THEN 'Eigen'
	--      ELSE v01.leist_empfaenger_sap_id
	-- END AS leist_empfaenger_sap_id
,
CASE
		WHEN v02.leist_einzelauswertung_fg = 1
		AND v03.leist_auswerteberechtigt_fg = 1
		AND v01.ext_ma_fg = 0 THEN v01.leist_empfaenger_sap_id 
		-- externe MA dürfen immer auf Einzelebene ausgewertet werden
		WHEN v01.ext_ma_fg = 1 THEN v01.leist_empfaenger_sap_id 
		--- In mv_l_leist_empfaenger_1 werden 'Eigen' Sätze generiert, damit diese dort einen JOIN-Partner finden
		-- Berichtsfilter (Attribut 'Leistungsempfänger Einzel') auf ext_ma_fg = 0 und leist_empfaenger_sap_id <> 'Eigen'
		-- zeigt dann im Bericht keine Daten an, wenn keine Einzelberechtigung besteht.
		ELSE 'Eigen'
	END AS leist_empfaenger_sap_id,
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
	v01.anzahl_pause
FROM
	DBP_MSI_VIEW3_MATERIALIZED.tbl_mv_transport_leistung_sum_1 v01 
	-- Extern sollen immer sichtbar sein, auch wenn nicht in Steuertabelle vorhanden (entsprechende WHERE Bedingung)

	LEFT JOIN dbp_security.leist_einzelauswertung_wup_1 v02 
	ON v01.mandant_id = v02.mandant_id
	AND v01.wup_id = v02.wup_id
	AND v01.nb_id = v02.nb_id 

	
	-- LEFT JOIN, Ist ein User nicht eingetragen, sieht er durch obiges CASE keine leist_empfaenger_sap_id, sondern nur NULL
	-- Freigabe erfolgt auf Ebene VZ / Leistungsempfaenger. Lagernummer nicht erforderlich
	-- Nur für den angemeldeten User. Es werden für seine VZ / Freigabe Zuordnung die Daten entsprechend auf Einzel oder NULL dargestellt
	-- Alle anderen VZ (für die er nicht zugeordnet ist) werden auf NULL dargestellt. NULL ist in Lookup nicht vorhanden und somit sieht ein nicht berechtigter User keine Daten
	-- Über den MSI Sicherheitsfilter (kommt im Bericht dazu, wird dann nur sein Land_1, VZ oder GP_1 herausgefiltert.

	LEFT JOIN (
		SELECT
			v030.mandant_id,
			v030.wup_id,
			v030.nb_id 
			-- ,v030.leist_empfaenger_sap_id
			-- NC0179339, doppelte Einträge
,
			MAX(v030.leist_auswerteberechtigt_fg) AS leist_auswerteberechtigt_fg
		FROM
			dbp_security.leist_empfaenger_ldap_zu_1 v030
			WHERE  v030.ma_ldap = getvariable('USERID') -- Session Variable statt Akt_MSI_User_1 verwenden 
		GROUP BY
			mandant_id,
			wup_id,
			nb_id 
			--,leist_empfaenger_sap_id
			-- NC0179339, doppelte Einträge
			--,leist_auswerteberechtigt_fg
	) v03 
	-- Der Join ist ohne leist_empfaenger_sap_id, da hier nur der aktuelle User vorhanden ist und die Freigabe auf VZ Ebene erfolgt
	ON v01.mandant_id = v03.mandant_id
	AND v01.wup_id = v03.wup_id
	AND v01.nb_id = v03.nb_id

WHERE
	(
		v02.leist_einzelauswertung_fg IS NOT NULL
		OR v01.ext_ma_fg = 1
	);