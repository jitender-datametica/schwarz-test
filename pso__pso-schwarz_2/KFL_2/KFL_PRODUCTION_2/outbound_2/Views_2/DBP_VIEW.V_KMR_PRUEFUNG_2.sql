CREATE OR REPLACE VIEW kfl_production_dbp_view.v_kmr_pruefung_2 (amx_system_id
OPTIONS(description='AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.'),
pruefung_id OPTIONS(description='Prüfungs-ID. Quellfeld auditing_id.'), fehlerverdacht_fg
OPTIONS(description='Flag: Identifizierung fehlerhafter Prüfprogramme in der Quelle. "Errechnetes" Hierarchielevel = 1 -> Bei späteren INCs soll sich Prüfprogramm anschauen, ob fachliche Vorgaben erfüllt sind. Quellfeld has_flawed_audit_program.'),
pruefung_nr OPTIONS(description='Prüfungsnummer. Quellfeld auditing_a_number.'), pruefung_bez
OPTIONS(description='Prüfungsname. Quellfeld auditing_name.'), pruefung_klasse_id
OPTIONS(description='Prüfungsart / -klasse-ID. Quellfeld auditing_auditing_class_id.'), pruefung_typ_id
OPTIONS(description='Prüfungstyp-ID, bspw. Ad hoc, Revisionsauftrag etc. Quellfeld auditing_auditing_type_id.'),
pruefung_status_id OPTIONS(description='Prüfungsstatus-ID. Quellfeld auditing_state.'), mandant_id
OPTIONS(description='Mandant_2 im DWH.'), standort_id OPTIONS(description='Standort-ID. Quellfeld auditing_location_id.'),
gepr_oe_id
OPTIONS(description='Geprüfte Organisationseinheit-ID. Enthält die ID der Organisationseinheit (kmr_l_organisationseinheit.orga_einheit_id), die geprüft wurde. Muss nicht unbedingt für eine_2 Feststellung verantwortlich sein, weshalb die zuständige Stelle für eine_2 Maßnahme von hier abweichen kann. Quellfeld auditing_audited_org_unit_id.'),
leit_abteilung_id OPTIONS(description='Leitende Abteilung-ID. Quellfeld auditing_leading_dep_id.'),
dat_pruef_zeitraum_von
OPTIONS(description='Datum Prüfungsbeginn, "Prüfungszeitraum von". Nicht zwingend das gleiche Datum wie dat_beginn_pruefung. Quellfeld auditing_start_date.'),
dat_pruef_zeitraum_bis
OPTIONS(description='Datum Prüfungsende, "Prüfungszeitraum bis". Nicht zwingend das gleiche Datum wie dat_ende_pruefung. Quellfeld auditing_end_date.'),
dat_termin_vereinbart OPTIONS(description='Datum Termin vereinbart. Quellfeld auditing_state_date_1.'),
dat_versand_ankuendigung OPTIONS(description='Datum Prüfungsankündigung verschickt. Quellfeld auditing_state_date_2.'),
dat_beginn_pruefung
OPTIONS(description='Datum Prüfungsbeginn. Nicht zwingend das gleiche Datum wie dat_pruef_zeitraum_von. Quellfeld auditing_state_date_3.'),
dat_ende_pruefung
OPTIONS(description='Datum Prüfungsende. Nicht zwingend das gleiche Datum wie dat_pruef_zeitraum_bis. Quellfeld auditing_state_date_4.'),
dat_versand_berichtsentwurf OPTIONS(description='Datum Berichtsentwurf versandt. Quellfeld auditing_state_date_5.'),
dat_rueckmeldung_berichtsentwurf
OPTIONS(description='Datum Rückmeldung Berichtsentwurf. Quellfeld auditing_state_date_6.'), dat_versand_bericht
OPTIONS(description='Datum Bericht versandt. Quellfeld auditing_state_date_7.'), dat_versand_bericht_korrigiert
OPTIONS(description='Datum Korrigierter Bericht versandt. Datum des Berichtsversandts, nachdem der Bericht nach dem ersten Versand zwischenzeitlich korrigiert wurde. Quellfeld auditing_state_date_8.'),
tageszeit_id OPTIONS(description='Tageszeit (früh, mittel, spät). Quellfeld auditing_reserve_sel_auditing_00_id.'),
prueffeld_id
OPTIONS(description='Prüffeld-ID, Prüfungsebene. Rückbezug auf den Ursprung des Ergebnisses zu Analysezwecken der Prüfung, Prüfungprogramm oder Prüfergebnis. Quellfeld contains_pu_id_audit_level.'),
ergebnis
OPTIONS(description='Endergebnis, Prüfungsebene. Prüfungsergebnis, unabhängig von durchgeführtem Prüfprogramm. Quellfeld numeric_result_audit_level.'),
ergebnis_berechnet
OPTIONS(description='Ergebnis Prüfung (berechnet). Ergebnis auf Prüfungsebene, 1 oder 0, anhand von z.B. einer Quote zur Warenverfügbarkeit. Kann abweichen von ergebnis_manuell. Quellfeld contains_pu_computed_numeric_result_audit_level.'),
ergebnis_manuell
OPTIONS(description='Ergebnis Prüfung (manuell). Einschätzung vom Prüfer. Ergebnis auf Prüfungsebene, 1 oder 0. Kann abweichen vom berechneten Wert. Quellfeld contains_pu_manual_numeric_result_audit_level.'),
gepr_prozess_id OPTIONS(description='Geprüfter Prozess-ID. Quellfeld audit_universe_audited_process_id_audit_level.'),
pruefung_bereich_id
OPTIONS(description='Zu berücksichtigende Bereiche / Code of area which should be considered / revisioned in a quick audit / "Kurzcheck". For other audit types these codes are not applicable.'))
OPTIONS(DESCRIPTION = `KMR - DELETE / INSERT TANSACTIONAL SNAPSHOT_2 OF THE CURRENT DATE MINUS 365 DAYS. THE DATA IN THE TABLE CONTAINS RESULTS OF ALL POSSIBLE AUDIT TYPES. THIS INCLUDES, FOR EXAMPLE, THE DATA FROM THE STORE AUDIT (FILIALREVISION), TOPIC (AREA) AND PROCESS AUDITS AND AUDIT CHECKS BY THE CORPORATE SECURITY DEPARTMENT. NEWLY, AS OF 01.08.24 THE TABLE CONTAINS QUICK CHECKS (KURZCHECKS) AS WELL.THE COLUMN PRUEFUNG_KLASSE_ID SHOWS WHAT KIND OF AUDIT EACH ROW REPRESENTS.SOURCE VIEW V_DWH_KL_DATA_AUDITING.`)
AS SELECT amx_system_id,
 pruefung_id,
 fehlerverdacht_fg,
 pruefung_nr,
 pruefung_bez,
 pruefung_klasse_id,
 pruefung_typ_id,
 pruefung_status_id,
 mandant_id,
 standort_id,
 gepr_oe_id,
 leit_abteilung_id,
 dat_pruef_zeitraum_von,
 dat_pruef_zeitraum_bis,
 dat_termin_vereinbart,
 dat_versand_ankuendigung,
 dat_beginn_pruefung,
 dat_ende_pruefung,
 dat_versand_berichtsentwurf,
 dat_rueckmeldung_berichtsentwurf,
 dat_versand_bericht,
 dat_versand_bericht_korrigiert,
 tageszeit_id,
 prueffeld_id,
 ergebnis,
 ergebnis_berechnet,
 ergebnis_manuell,
 gepr_prozess_id,
 pruefung_bereich_id
FROM kfl_production_dbp_data.kmr_pruefung_2;