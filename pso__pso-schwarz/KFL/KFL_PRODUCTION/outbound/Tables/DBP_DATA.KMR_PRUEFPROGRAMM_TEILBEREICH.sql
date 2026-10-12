--==============================================================
-- Table: kmr_pruefprogramm_teilbereich
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_pruefprogramm_teilbereich
   generated from Powerdesigner on Freitag, 17. Februar 2023 15:58:04
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kmr_pruefprogramm_teilbereich (
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.'),
teilbereich_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Kapitel-ID. Quellfeld activity_id. Eindeutige ID eines Teilbereichs.'),
pruefung_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Prüfungs-ID. Quellfeld auditing_id.'),
hauptbereich_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Kapitel-ID, höheres Hierarchielevel Hauptbereich. Quellfeld activity_id_hb.'),
pruefprogramm_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Kapitel-ID, höheres Hierarchielevel Prüfprogramm. Quellfeld activity_id_pp.'),
kapitel_nr STRING(255) DEFAULT ' ' OPTIONS(description='Kapitelnummer. Quellfeld activity_sort_order.'),
sort_nr BIGNUMERIC(38,0)
OPTIONS(description='Sortiernummer des Kapiteleintrags im Prüfprogramm. Quellfeld program_sort_order.'),
fehlerverdacht_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag: Identifizierung fehlerhafter Prüfprogramme in der Quelle; "Errechnetes" Hierarchielevel = 1 -> Bei späteren INCs soll sich Prüfprogramm anschauen, ob fachliche Vorgaben erfüllt sind. Quellfeld has_flawed_audit_program.'),
teilbereich_bez STRING(255) DEFAULT ' '
OPTIONS(description='Kapitel-Bezeichung, Ebene Teilbereich. Quellfeld activity_name_tb. Bezeichnung des Teilbereichs.'),
gepr_prozess_id BIGNUMERIC(38,0) DEFAULT - 1
OPTIONS(description='Geprüfter Prozess-ID, Ebene Teilbereich. Quellfeld audit_universe_audited_process_id_tb.'),
ergebnis BIGNUMERIC(38,0) OPTIONS(description='Endergebnis, Ebene Teilbereich. Quellfeld numeric_result_tb.'),
ergebnis_berechnet BIGNUMERIC(38,0)
OPTIONS(description='Ergebnis berechnet, Ebene Teilbereich. Quellfeld contains_pu_computed_numeric_result_tb.'),
ergebnis_manuell BIGNUMERIC(38,0)
OPTIONS(description='Ergebnis manuell, Ebene Teilbereich. Quellfeld contains_pu_manual_numeric_result_tb.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (amx_system_id, teilbereich_id) NOT ENFORCED
)
OPTIONS(description='KMR - Table for the "Teilbereich"-hierarchy level of the audit activities (Kapitel, kapitel_id in kmr_l_pruefprogramm_kapitel, hier teilbereich_id und höher). While MSI in frontend needs a complete hierarchy, audit activities unfortunately do not strictly have to follow it, which means that sometimes levels could be missing and are displayed as NULLs. Does not include "Kurzchecks". Source view v_dwh_kl_data_audit_program.');