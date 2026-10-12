--==============================================================
-- Table: kmr_l_massnahme_status_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_massnahme_status_1
   generated from Powerdesigner on Mittwoch, 9. August 2023 11:11:31
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_L_MASSNAHME_STATUS_1 (
   amx_system_id                       INTEGER     NOT NULL COMMENT 'AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.',
   massnahme_status_id                 INTEGER     NOT NULL COMMENT 'Status_1-ID der Massnahme. The working status_1 of the improvement suggestion (Massnahme) (improvement suggestions regarding issues found during auditing (Feststellungen bei einer Pruefung)). Example: offen, erledigt, nicht umgesetzt, etc., Some states can appear that should not, because of technical necessity or user errors that are made possible because the choices are not filtered. Quellfeld suggestion_state.',
   massnahme_status_bez                VARCHAR(255)     NOT NULL DEFAULT ' ' COMMENT 'Beschreibungstext des Massnahmenstatus. The working status_1 name of the improvement suggestion (Massnahme) (improvement suggestions regarding issues found during auditing (Feststellungen bei einer Pruefung)). Example: offen, erledigt, nicht umgesetzt, etc., Quellfeld suggestion_state_name.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_L_MASSNAHME_STATUS PRIMARY KEY (amx_system_id, massnahme_status_id) NOT ENFORCED
)  COMMENT = 'KMR - Lookup table for the working status_1 of the improvement suggestion (Massnahme) (improvement suggestions regarding issues found during auditing (Feststellungen bei einer Pruefung)). Example: offen, erledigt, nicht umgesetzt, etc., Some states can appear that should not, because of technical necessity or user errors that are made possible because the choices are not filtered. Does not contain "Kurzchecks". Source view v_dwh_kl_data_suggestion.';
