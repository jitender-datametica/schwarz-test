--==============================================================
-- Table: kmr_massnahme_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_massnahme_1
   generated from Powerdesigner on Mittwoch, 9. August 2023 11:09:20
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kmr_massnahme_1 (
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.'),
massnahme_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Maßnahme-ID. Eine_1 Maßnahme wird für eine_1 Feststellung angelegt um diese zu bearbeiten. Quellfeld suggestion_id.'),
feststellung_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Feststellung-ID. Eine_1 Feststellung ein Sachverhalt der bei einer Revisionsprüfung aufgefallen ist. Quellfeld issue_id.'),
massnahme_txt STRING(20000)
OPTIONS(description='Maßnahmetext. Beschreibung der Maßnahme zu einer Feststellung. Quellfeld suggestion_management_comment.'),
zustaendige_stelle_id BIGNUMERIC(38,0) DEFAULT - 1
OPTIONS(description='Zuständige Stelle ID. Enthält die Organisationseinheit (kmr_l_organisationseinheit.orga_einheit_id), die für die Umsetzung der Maßnahme mit zuständig ist. Kann von der geprüften Organisatinoseinheit abweichen, wenn die Feststellung eigentlich einen anderen Ursprung hatte, als die geprüfte Orga-Einheit. Quellfeld suggestion_responsible_unit_id.'),
massnahme_status_id BIGNUMERIC(38,0) DEFAULT - 1
OPTIONS(description='Status_1-ID der Massnahme. The working status_1 of the improvement suggestion (Massnahme) (improvement suggestions regarding issues found during auditing (Feststellungen bei einer Pruefung)). Example: offen, erledigt, nicht umgesetzt, etc., Some states can appear that should not, because of technical necessity or user errors that are made possible because the choices are not filtered. Quellfeld suggestion_state.'),
antwort_auditor_abwartend_fg BIGNUMERIC(38,0)
OPTIONS(description='Flag: Wird auf eine_1 Antwort des Prüfers bezüglich eines gestellten Antrags gewartet? 0 = nein, 1 = ja. Quellfeld suggestion_on_auditor_s_agenda.'),
dat_umsetzung_angelegt DATE
OPTIONS(description='Ursprünglich angesetzter Termin für die Umsetzung der Maßnahme. Dieses Feld wird bei erstmaliger Anlegung des Datensatzes befüllt und ändert sich nicht. Quellfeld suggestion_original_due_date.'),
dat_umsetzung_geplant DATE
OPTIONS(description='Zuletzt geplanter Termin für die Umsetzung der Maßnahme. Kann sich ändern, wenn eine_1 Verschiebung genehmigt wurde. Quellfeld suggestion_init_finish_date.'),
dat_umsetzung_erledigt DATE
OPTIONS(description='Termin an dem die Maßnahme tatsächlich umgesetzt und damit auch vom Prüfer geschlossen wurde. Kann vor den anderen Terminen liegen, wenn die Umsetzung schneller vonstattenging. Quellfeld suggestion_closed_when.'),
verschiebungen_anz BIGNUMERIC(38,0)
OPTIONS(description='Anzahl (genehmigter) Verschiebungen. Quellfeld cnt_deferments.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (amx_system_id, massnahme_id) NOT ENFORCED
)
OPTIONS(description='KMR - Delete / insert periodic snapshot_1 of the current date minus 365 days. This table contains information on improvement suggestions (Maßnahmen) regarding issues found during auditing (Feststellungen bei einer Prüfung). This data is not historized but built in order to fit reporting requirements as discussed with BC at creation. Only the most current status_1 is stored. The table contains the Source view v_dwh_kl_data_suggestion.');