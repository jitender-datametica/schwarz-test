--==============================================================
-- Table: kmr_pruefung_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_pruefung_1
   generated from Powerdesigner on Mittwoch, 14. August 2024 15:11:32
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_PRUEFUNG_1 DATA_RETENTION_TIME_IN_DAYS = 15 (
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.',
   pruefung_id                         INTEGER     NOT NULL COMMENT 'Prüfungs-ID. Quellfeld auditing_id.',
   fehlerverdacht_fg                   INTEGER     NOT NULL DEFAULT -1 COMMENT 'Flag: Identifizierung fehlerhafter Prüfprogramme in der Quelle. "Errechnetes" Hierarchielevel = 1 -> Bei späteren INCs soll sich Prüfprogramm anschauen, ob fachliche Vorgaben erfüllt sind. Quellfeld has_flawed_audit_program.',
   pruefung_nr                         VARCHAR(30)      NOT NULL DEFAULT ' ' COMMENT 'Prüfungsnummer. Quellfeld auditing_a_number.',
   pruefung_bez                        VARCHAR(350)     NOT NULL DEFAULT ' ' COMMENT 'Prüfungsname. Quellfeld auditing_name.',
   pruefung_klasse_id                  INTEGER     NOT NULL DEFAULT -1 COMMENT 'Prüfungsart / -klasse-ID. Quellfeld auditing_auditing_class_id.',
   pruefung_typ_id                     INTEGER     NOT NULL DEFAULT -1 COMMENT 'Prüfungstyp-ID, bspw. Ad hoc, Revisionsauftrag etc. Quellfeld auditing_auditing_type_id.',
   pruefung_status_id                  INTEGER     COMMENT 'Prüfungsstatus-ID. Quellfeld auditing_state.',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH.',
   standort_id                         INTEGER     NOT NULL DEFAULT -1 COMMENT 'Standort-ID. Quellfeld auditing_location_id.',
   gepr_oe_id                          INTEGER     NOT NULL DEFAULT -1 COMMENT 'Geprüfte Organisationseinheit-ID. Enthält die ID der Organisationseinheit (kmr_l_organisationseinheit.orga_einheit_id), die geprüft wurde. Muss nicht unbedingt für eine_1 Feststellung verantwortlich sein, weshalb die zuständige Stelle für eine_1 Maßnahme von hier abweichen kann. Quellfeld auditing_audited_org_unit_id.',
   leit_abteilung_id                   INTEGER     NOT NULL DEFAULT -1 COMMENT 'Leitende Abteilung-ID. Quellfeld auditing_leading_dep_id.',
   dat_pruef_zeitraum_von              DATE             COMMENT 'Datum Prüfungsbeginn, "Prüfungszeitraum von". Nicht zwingend das gleiche Datum wie dat_beginn_pruefung. Quellfeld auditing_start_date.',
   dat_pruef_zeitraum_bis              DATE             COMMENT 'Datum Prüfungsende, "Prüfungszeitraum bis". Nicht zwingend das gleiche Datum wie dat_ende_pruefung. Quellfeld auditing_end_date.',
   dat_termin_vereinbart               DATE             COMMENT 'Datum Termin vereinbart. Quellfeld auditing_state_date_1.',
   dat_versand_ankuendigung            DATE             COMMENT 'Datum Prüfungsankündigung verschickt. Quellfeld auditing_state_date_2.',
   dat_beginn_pruefung                 DATE             COMMENT 'Datum Prüfungsbeginn. Nicht zwingend das gleiche Datum wie dat_pruef_zeitraum_von. Quellfeld auditing_state_date_3.',
   dat_ende_pruefung                   DATE             COMMENT 'Datum Prüfungsende. Nicht zwingend das gleiche Datum wie dat_pruef_zeitraum_bis. Quellfeld auditing_state_date_4.',
   dat_versand_berichtsentwurf         DATE             COMMENT 'Datum Berichtsentwurf versandt. Quellfeld auditing_state_date_5.',
   dat_rueckmeldung_berichtsentwurf    DATE             COMMENT 'Datum Rückmeldung Berichtsentwurf. Quellfeld auditing_state_date_6.',
   dat_versand_bericht                 DATE             COMMENT 'Datum Bericht versandt. Quellfeld auditing_state_date_7.',
   dat_versand_bericht_korrigiert      DATE             COMMENT 'Datum Korrigierter Bericht versandt. Datum des Berichtsversandts, nachdem der Bericht nach dem ersten Versand zwischenzeitlich korrigiert wurde. Quellfeld auditing_state_date_8.',
   tageszeit_id                        INTEGER     DEFAULT -1 COMMENT 'Tageszeit (früh, mittel, spät). Quellfeld auditing_reserve_sel_auditing_00_id.',
   prueffeld_id                        INTEGER     COMMENT 'Prüffeld-ID, Prüfungsebene. Rückbezug auf den Ursprung des Ergebnisses zu Analysezwecken der Prüfung, Prüfungprogramm oder Prüfergebnis. Quellfeld contains_pu_id_audit_level.',
   ergebnis                            INTEGER     COMMENT 'Endergebnis, Prüfungsebene. Prüfungsergebnis, unabhängig von durchgeführtem Prüfprogramm. Quellfeld numeric_result_audit_level.',
   ergebnis_berechnet                  INTEGER     COMMENT 'Ergebnis Prüfung (berechnet). Ergebnis auf Prüfungsebene, 1 oder 0, anhand von z.B. einer Quote zur Warenverfügbarkeit. Kann abweichen von ergebnis_manuell. Quellfeld contains_pu_computed_numeric_result_audit_level.',
   ergebnis_manuell                    INTEGER     COMMENT 'Ergebnis Prüfung (manuell). Einschätzung vom Prüfer. Ergebnis auf Prüfungsebene, 1 oder 0. Kann abweichen vom berechneten Wert. Quellfeld contains_pu_manual_numeric_result_audit_level.',
   gepr_prozess_id                     INTEGER     DEFAULT -1 COMMENT 'Geprüfter Prozess-ID. Quellfeld audit_universe_audited_process_id_audit_level.',
   pruefung_bereich_id                 INTEGER     COMMENT 'Zu berücksichtigende Bereiche / Code of area which should be considered / revisioned in a quick audit / "Kurzcheck". For other audit types these codes are not applicable.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_PRUEFUNG PRIMARY KEY (amx_system_id, pruefung_id) NOT ENFORCED
)  COMMENT = 'KMR - Delete / insert tansactional snapshot_1 of the current date minus 365 days. 
             
             The data in the table contains results of all possible audit types. 
             This includes, for example, the data from the store audit (Filialrevision), topic (Area) and process audits and Audit checks by the Corporate Security department. 
             Newly, as of 01.08.24 the table contains quick checks (Kurzchecks) as well.
             
             The column pruefung_klasse_id shows what kind of audit each row represents.
             
             Source view v_dwh_kl_data_auditing.';
