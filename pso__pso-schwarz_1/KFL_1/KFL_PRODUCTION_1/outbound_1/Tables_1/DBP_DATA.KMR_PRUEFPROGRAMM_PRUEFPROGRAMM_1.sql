--==============================================================
-- Table: kmr_pruefprogramm_pruefprogramm_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_pruefprogramm_pruefprogramm_1
   generated from Powerdesigner on Freitag, 17. Februar 2023 15:59:46
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kmr_pruefprogramm_pruefprogramm_1 (
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-Quellsystem-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.'),
pruefprogramm_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Kapitel-ID. Quellfeld activity_id.'),
pruefung_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Prüfungs-ID. Quellfeld auditing_id. Eindeutige ID des Prüfprogramms.'),
kapitel_nr STRING(255) DEFAULT ' ' OPTIONS(description='Kapitelnummer. Quellfeld activity_sort_order.'),
sort_nr BIGNUMERIC(38,0)
OPTIONS(description='Sortiernummer des Kapiteleintrags im Prüfprogramm. Quellfeld program_sort_order.'),
fehlerverdacht_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag: Identifizierung fehlerhafter Prüfprogramme in der Quelle; "Errechnetes" Hierarchielevel = 1 -> Bei späteren INCs soll sich Prüfprogramm anschauen, ob fachliche Vorgaben erfüllt sind. Quellfeld has_flawed_audit_program.'),
pruefprogramm_bez STRING(255) DEFAULT ' '
OPTIONS(description='Kapitel-Bezeichnung, Ebene Prüfprogramm. Quellfeld activity_name_pp. Bezeichnung des Prüfprogramms.'),
gepr_prozess_id BIGNUMERIC(38,0) DEFAULT - 1
OPTIONS(description='Geprüfter Prozess-ID, Ebene Prüfprogramm. Quellfeld audit_universe_audited_process_id_pp.'),
ergebnis BIGNUMERIC(38,0) OPTIONS(description='Endergebnis, Ebene Prüfprogramm. Quellfeld numeric_result_pp.'),
ergebnis_berechnet BIGNUMERIC(38,0)
OPTIONS(description='Ergebnis berechnet, Ebene Prüfprogramm. Quellfeld contains_pu_computed_numeric_result_pp.'),
ergebnis_manuell BIGNUMERIC(38,0)
OPTIONS(description='Ergebnis manuell, Ebene Prüfprogramm. Quellfeld contains_pu_manual_numeric_result_pp.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (amx_system_id, pruefprogramm_id) NOT ENFORCED
)
OPTIONS(description='KMR - Table for the "Prüfprogramm"-hierarchy_1 level of the audit activities (Kapitel, kapitel_id in kmr_l_pruefprogramm_kapitel, hier als pruefprogramm_id). While MSI in frontend needs a complete hierarchy_1, audit activities unfortunately do not strictly have to follow it, which means that sometimes levels could be missing and are displayed as NULLs. Does not include "Kurzchecks". Source view v_dwh_kl_data_audit_program.');