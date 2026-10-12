CREATE OR REPLACE TABLE kfl_production_dbp_data.kmr_pruefung (
amx_system_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.'),
pruefung_id INTEGER NOT NULL OPTIONS(description='Prüfungs-ID. Quellfeld auditing_id.'),
fehlerverdacht_fg INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Flag: Identifizierung fehlerhafter Prüfprogramme in der Quelle.\"Errechnetes\" Hierarchielevel = 1 -> Bei späteren INCs soll sich Prüfprogramm anschauen, ob fachliche Vorgaben erfüllt sind. Quellfeld has_flawed_audit_program.'),
pruefung_nr STRING(30) DEFAULT ' ' NOT NULL OPTIONS(description='Prüfungsnummer. Quellfeld auditing_a_number.'),
pruefung_bez STRING(350) DEFAULT ' ' NOT NULL OPTIONS(description='Prüfungsname. Quellfeld auditing_name.'),
pruefung_klasse_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Prüfungsart / -klasse-ID. Quellfeld auditing_auditing_class_id.'),
pruefung_typ_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Prüfungstyp-ID, bspw. Ad hoc, Revisionsauftrag etc. Quellfeld auditing_auditing_type_id.'),
pruefung_status_id INTEGER OPTIONS(description='Prüfungsstatus-ID. Quellfeld auditing_state.'),
mandant_id INTEGER NOT NULL OPTIONS(description='Mandant im DWH.'),
standort_id INTEGER DEFAULT - 1 NOT NULL OPTIONS(description='Standort-ID. Quellfeld auditing_location_id.'),
gepr_oe_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Geprüfte Organisationseinheit-ID. Enthält die ID der Organisationseinheit (kmr_l_organisationseinheit.orga_einheit_id), die geprüft wurde. Muss nicht unbedingt für eine Feststellung verantwortlich sein, weshalb die zuständige Stelle für eine Maßnahme von hier abweichen kann. Quellfeld auditing_audited_org_unit_id.'),
leit_abteilung_id INTEGER DEFAULT - 1 NOT NULL
OPTIONS(description='Leitende Abteilung-ID. Quellfeld auditing_leading_dep_id.'),
dat_pruef_zeitraum_von DATE
OPTIONS(description='Datum Prüfungsbeginn,\"Prüfungszeitraum von\". Nicht zwingend das gleiche Datum wie dat_beginn_pruefung. Quellfeld auditing_start_date.'),
dat_pruef_zeitraum_bis DATE
OPTIONS(description='Datum Prüfungsende,\"Prüfungszeitraum bis\". Nicht zwingend das gleiche Datum wie dat_ende_pruefung. Quellfeld auditing_end_date.'),
dat_termin_vereinbart DATE OPTIONS(description='Datum Termin vereinbart. Quellfeld auditing_state_date_1.'),
dat_versand_ankuendigung DATE
OPTIONS(description='Datum Prüfungsankündigung verschickt. Quellfeld auditing_state_date_2.'),
dat_beginn_pruefung DATE
OPTIONS(description='Datum Prüfungsbeginn. Nicht zwingend das gleiche Datum wie dat_pruef_zeitraum_von. Quellfeld auditing_state_date_3.'),
dat_ende_pruefung DATE
OPTIONS(description='Datum Prüfungsende. Nicht zwingend das gleiche Datum wie dat_pruef_zeitraum_bis. Quellfeld auditing_state_date_4.'),
dat_versand_berichtsentwurf DATE OPTIONS(description='Datum Berichtsentwurf versandt. Quellfeld auditing_state_date_5.'),
dat_rueckmeldung_berichtsentwurf DATE
OPTIONS(description='Datum Rückmeldung Berichtsentwurf. Quellfeld auditing_state_date_6.'),
dat_versand_bericht DATE OPTIONS(description='Datum Bericht versandt. Quellfeld auditing_state_date_7.'),
dat_versand_bericht_korrigiert DATE
OPTIONS(description='Datum Korrigierter Bericht versandt. Datum des Berichtsversandts, nachdem der Bericht nach dem ersten Versand zwischenzeitlich korrigiert wurde. Quellfeld auditing_state_date_8.'),
tageszeit_id INTEGER DEFAULT - 1
OPTIONS(description='Tageszeit (früh, mittel, spät). Quellfeld auditing_reserve_sel_auditing_00_id.'),
prueffeld_id INTEGER
OPTIONS(description='Prüffeld-ID, Prüfungsebene. Rückbezug auf den Ursprung des Ergebnisses zu Analysezwecken der Prüfung, Prüfungprogramm oder Prüfergebnis. Quellfeld contains_pu_id_audit_level.'),
ergebnis INTEGER
OPTIONS(description='Endergebnis, Prüfungsebene. Prüfungsergebnis, unabhängig von durchgeführtem Prüfprogramm. Quellfeld numeric_result_audit_level.'),
ergebnis_berechnet INTEGER
OPTIONS(description='Ergebnis Prüfung (berechnet). Ergebnis auf Prüfungsebene, 1 oder 0, anhand von z.B. einer Quote zur Warenverfügbarkeit. Kann abweichen von ergebnis_manuell. Quellfeld contains_pu_computed_numeric_result_audit_level.'),
ergebnis_manuell INTEGER
OPTIONS(description='Ergebnis Prüfung (manuell). Einschätzung vom Prüfer. Ergebnis auf Prüfungsebene, 1 oder 0. Kann abweichen vom berechneten Wert. Quellfeld contains_pu_manual_numeric_result_audit_level.'),
gepr_prozess_id INTEGER DEFAULT - 1
OPTIONS(description='Geprüfter Prozess-ID. Quellfeld audit_universe_audited_process_id_audit_level.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
pruefung_bereich_id INTEGER
OPTIONS(description='Zu berücksichtigende Bereiche / Code of area which should be considered / revisioned in a quick audit /\"Kurzcheck\". For other audit types these codes are not applicable.'),
PRIMARY KEY (amx_system_id, pruefung_id) NOT ENFORCED
)
OPTIONS(description='KMR - Delete / insert tansactional snapshot of the current date minus 365 days.\n\n             The data in the table contains results of all possible audit types.\n             This includes, for example, the data from the store audit (Filialrevision), topic (Area) and process audits and Audit checks by the Corporate Security department.\n             Newly, as of 01.08.24 the table contains quick checks (Kurzchecks) as well.\n\n             The column pruefung_klasse_id shows what kind of audit each row represents.\n\n             Source view v_dwh_kl_data_auditing.');