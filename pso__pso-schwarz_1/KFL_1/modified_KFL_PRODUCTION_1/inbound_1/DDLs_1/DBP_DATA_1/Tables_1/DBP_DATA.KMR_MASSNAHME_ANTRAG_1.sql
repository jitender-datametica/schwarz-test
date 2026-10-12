--==============================================================
-- Table: kmr_massnahme_antrag_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_massnahme_antrag_1
   generated from Powerdesigner on Montag, 27. Februar 2023 11:50:57
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_MASSNAHME_ANTRAG_1 DATA_RETENTION_TIME_IN_DAYS = 15 (
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.',
   massnahme_id                        INTEGER     NOT NULL DEFAULT -1 COMMENT 'Maßnahme-ID. Quellfeld suggestion_id.',
   auditee_letzter_antrag_id           INTEGER     NOT NULL DEFAULT -1 COMMENT 'Jüngste Antrag-ID vom Geprüften / Auditee bezüglich einer Maßnmahme. Ein vorheriger Antrag wird überschrieben / gelöscht. Quellfeld reaction_id_auditee.',
   auditee_letzter_antrag_bez          VARCHAR(255)     DEFAULT ' ' COMMENT 'Jüngste Antrag-Bezeichnung bezüglich einer Maßnahme. Quellfeld reaction_type_auditee.',
   dat_auditee_letzter_antrag          DATE             COMMENT 'Datum der jüngsten Antwort bezüglich einer Maßnahme. Quellfeld reaction_date_auditee.',
   auditor_letzte_antwort_id           INTEGER     DEFAULT -1 COMMENT 'Jüngste Antwort-ID, Prüfer / Auditor. Quellfeld reaction_id_auditor.',
   auditor_letzte_antwort_bez          VARCHAR(255)     DEFAULT ' ' COMMENT 'Jüngste Antwort-Bezeichnung auf Antrag zu einer Maßnahme. Quellfeld reaction_type_auditor.',
   dat_auditor_letzte_antwort          DATE             COMMENT 'Datum der jüngsten Antwort auf Antrag zu einer Maßnahme. Quellfeld reaction_date_auditor.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_MASSNAHME_ANTRAG PRIMARY KEY (amx_system_id, massnahme_id) NOT ENFORCED
)  COMMENT = 'KMR - Delete / insert transactional snapshot_1 of the current date minus 365 days. This table contains the latest communication_1 (at the date of loading) regarding a suggestion (Maßnahme) and its response, between auditee and auditor. An auditee can make a request (Antrag stellen) regarding the suggestion (Maßnahme) that the auditor defined for an issue found during auditing (Feststellung in einer Prüfung). Requests include time extensions, change or closing of the issue, or no implementaton, and the auditor can approve or decline them. This data is not historized but built in order to fit reporting requirements as discussed with BC at creation. Only the most recent request and answer regarding a suggestion are loaded each day, meaning that previous antrag_ids and antwort_ids in the source were overwritten / deleted (when there is only a request with no answer yet, then the answer columns will be empty / have default values). Source view v_dwh_kl_data_reaction.';
