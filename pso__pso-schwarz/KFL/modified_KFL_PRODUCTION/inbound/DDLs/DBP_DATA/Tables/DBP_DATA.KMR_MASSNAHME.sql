--==============================================================
-- Table: kmr_massnahme
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_massnahme
   generated from Powerdesigner on Mittwoch, 9. August 2023 11:09:20
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_MASSNAHME DATA_RETENTION_TIME_IN_DAYS = 15 (
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.',
   massnahme_id                        INTEGER     NOT NULL DEFAULT -1 COMMENT 'Maßnahme-ID. Eine Maßnahme wird für eine Feststellung angelegt um diese zu bearbeiten. Quellfeld suggestion_id.',
   feststellung_id                     INTEGER     NOT NULL DEFAULT -1 COMMENT 'Feststellung-ID. Eine Feststellung ein Sachverhalt der bei einer Revisionsprüfung aufgefallen ist. Quellfeld issue_id.',
   massnahme_txt                       VARCHAR(20000)   COMMENT 'Maßnahmetext. Beschreibung der Maßnahme zu einer Feststellung. Quellfeld suggestion_management_comment.',
   zustaendige_stelle_id               INTEGER     DEFAULT -1 COMMENT 'Zuständige Stelle ID. Enthält die Organisationseinheit (kmr_l_organisationseinheit.orga_einheit_id), die für die Umsetzung der Maßnahme mit zuständig ist. Kann von der geprüften Organisatinoseinheit abweichen, wenn die Feststellung eigentlich einen anderen Ursprung hatte, als die geprüfte Orga-Einheit. Quellfeld suggestion_responsible_unit_id.',
   massnahme_status_id                 INTEGER     DEFAULT -1 COMMENT 'Status-ID der Massnahme. The working status of the improvement suggestion (Massnahme) (improvement suggestions regarding issues found during auditing (Feststellungen bei einer Pruefung)). Example: offen, erledigt, nicht umgesetzt, etc., Some states can appear that should not, because of technical necessity or user errors that are made possible because the choices are not filtered. Quellfeld suggestion_state.',
   antwort_auditor_abwartend_fg        INTEGER     COMMENT 'Flag: Wird auf eine Antwort des Prüfers bezüglich eines gestellten Antrags gewartet? 0 = nein, 1 = ja. Quellfeld suggestion_on_auditor_s_agenda.',
   dat_umsetzung_angelegt              DATE             COMMENT 'Ursprünglich angesetzter Termin für die Umsetzung der Maßnahme. Dieses Feld wird bei erstmaliger Anlegung des Datensatzes befüllt und ändert sich nicht. Quellfeld suggestion_original_due_date.',
   dat_umsetzung_geplant               DATE             COMMENT 'Zuletzt geplanter Termin für die Umsetzung der Maßnahme. Kann sich ändern, wenn eine Verschiebung genehmigt wurde. Quellfeld suggestion_init_finish_date.',
   dat_umsetzung_erledigt              DATE             COMMENT 'Termin an dem die Maßnahme tatsächlich umgesetzt und damit auch vom Prüfer geschlossen wurde. Kann vor den anderen Terminen liegen, wenn die Umsetzung schneller vonstattenging. Quellfeld suggestion_closed_when.',
   verschiebungen_anz                  INTEGER     COMMENT 'Anzahl (genehmigter) Verschiebungen. Quellfeld cnt_deferments.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_MASSNAHME PRIMARY KEY (amx_system_id, massnahme_id) NOT ENFORCED
)  COMMENT = 'KMR - Delete / insert periodic snapshot of the current date minus 365 days. This table contains information on improvement suggestions (Maßnahmen) regarding issues found during auditing (Feststellungen bei einer Prüfung). This data is not historized but built in order to fit reporting requirements as discussed with BC at creation. Only the most current status is stored. The table contains the Source view v_dwh_kl_data_suggestion.';
