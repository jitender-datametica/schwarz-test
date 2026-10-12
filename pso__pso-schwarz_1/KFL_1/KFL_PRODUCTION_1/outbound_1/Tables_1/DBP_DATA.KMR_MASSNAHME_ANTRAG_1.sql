--==============================================================
-- Table: kmr_massnahme_antrag_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_massnahme_antrag_1
   generated from Powerdesigner on Montag, 27. Februar 2023 11:50:57
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kmr_massnahme_antrag_1 (
amx_system_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.'),
massnahme_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL OPTIONS(description='Maßnahme-ID. Quellfeld suggestion_id.'),
auditee_letzter_antrag_id BIGNUMERIC(38,0) DEFAULT - 1 NOT NULL
OPTIONS(description='Jüngste Antrag-ID vom Geprüften / Auditee bezüglich einer Maßnmahme. Ein vorheriger Antrag wird überschrieben / gelöscht. Quellfeld reaction_id_auditee.'),
auditee_letzter_antrag_bez STRING(255) DEFAULT ' '
OPTIONS(description='Jüngste Antrag-Bezeichnung bezüglich einer Maßnahme. Quellfeld reaction_type_auditee.'),
dat_auditee_letzter_antrag DATE
OPTIONS(description='Datum der jüngsten Antwort bezüglich einer Maßnahme. Quellfeld reaction_date_auditee.'),
auditor_letzte_antwort_id BIGNUMERIC(38,0) DEFAULT - 1
OPTIONS(description='Jüngste Antwort-ID, Prüfer / Auditor. Quellfeld reaction_id_auditor.'),
auditor_letzte_antwort_bez STRING(255) DEFAULT ' '
OPTIONS(description='Jüngste Antwort-Bezeichnung auf Antrag zu einer Maßnahme. Quellfeld reaction_type_auditor.'),
dat_auditor_letzte_antwort DATE
OPTIONS(description='Datum der jüngsten Antwort auf Antrag zu einer Maßnahme. Quellfeld reaction_date_auditor.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (amx_system_id, massnahme_id) NOT ENFORCED
)
OPTIONS(description='KMR - Delete / insert transactional snapshot_1 of the current date minus 365 days. This table contains the latest communication_1 (at the date of loading) regarding a suggestion (Maßnahme) and its response, between auditee and auditor. An auditee can make a request (Antrag stellen) regarding the suggestion (Maßnahme) that the auditor defined for an issue found during auditing (Feststellung in einer Prüfung). Requests include time extensions, change or closing of the issue, or no implementaton, and the auditor can approve or decline them. This data is not historized but built in order to fit reporting requirements as discussed with BC at creation. Only the most recent request and answer regarding a suggestion are loaded each day, meaning that previous antrag_ids and antwort_ids in the source were overwritten / deleted (when there is only a request with no answer yet, then the answer columns will be empty / have default values). Source view v_dwh_kl_data_reaction.');