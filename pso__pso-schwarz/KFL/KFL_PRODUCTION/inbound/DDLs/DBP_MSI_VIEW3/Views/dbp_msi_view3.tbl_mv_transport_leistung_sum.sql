CREATE OR REPLACE VIEW dbp_msi_view3.tbl_mv_transport_leistung_sum 
-- 05.10.2016, AP0003754, srom0404, Erweiterung sap_id, gruppe_id
-- 16.11.2016, AP0003754, SPEC0005757, srom0404, Erweiterung um zusätzliche Sicherheitsview
-- Das 'Eigen' Konstrukt wird nicht mehr benötigt
-- 14.12.2016, srom0404 Extern sollen immer sichtbar sein, auch wenn nicht in Steuertabelle vorhanden
-- LEFT JOIN auf leist_einzelauswertung_wup, zusätzlich WHERE Bedingung am Ende
-- 03.04.2018, INC0179339, srom0404, doppelte Einträge, wenn ein User auf Grund der Berechtigungsvergabe 0 und 1 bei leist_auswerteberechtigt_fg hat
-- nfis: Vermeidung von doppelten Einträgen von anonymisierten Usern
AS
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
	dbp_view.v_transport_leistung_sum v01 
	-- Bei anonymisierten Usern kann es zwei Einträge pro SAP-Gruppe geben (EXT_MA_FG 0 UND 1) -> um eine Duplizierung der Ergebnisse zu verhindern nehmen wir das min()
	INNER JOIN (
		SELECT
			mandant_id,
			wup_id,
			nb_id,
			leist_empfaenger_sap_id,
			leist_empfaenger_gruppe_id,
			min(ext_ma_fg) as ext_ma_fg
		FROM
			dbp_view.v_l_leist_empfaenger
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
	AND v01.leist_empfaenger_gruppe_id = v04.leist_empfaenger_gruppe_id 
	;