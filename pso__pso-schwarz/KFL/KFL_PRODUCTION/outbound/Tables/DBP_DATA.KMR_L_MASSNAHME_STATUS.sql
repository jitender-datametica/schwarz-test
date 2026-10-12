--==============================================================
-- Table: kmr_l_massnahme_status
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_massnahme_status
   generated from Powerdesigner on Mittwoch, 9. August 2023 11:11:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.kmr_l_massnahme_status (
amx_system_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='AMX-System-ID (Core vs. Unternehmenssicherheit). Quellfeld amx_system.'),
massnahme_status_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Status-ID der Massnahme. The working status of the improvement suggestion (Massnahme) (improvement suggestions regarding issues found during auditing (Feststellungen bei einer Pruefung)). Example: offen, erledigt, nicht umgesetzt, etc., Some states can appear that should not, because of technical necessity or user errors that are made possible because the choices are not filtered. Quellfeld suggestion_state.'),
massnahme_status_bez STRING(255) DEFAULT ' ' NOT NULL
OPTIONS(description='Beschreibungstext des Massnahmenstatus. The working status name of the improvement suggestion (Massnahme) (improvement suggestions regarding issues found during auditing (Feststellungen bei einer Pruefung)). Example: offen, erledigt, nicht umgesetzt, etc., Quellfeld suggestion_state_name.'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (amx_system_id, massnahme_status_id) NOT ENFORCED
)
OPTIONS(description='KMR - Lookup table for the working status of the improvement suggestion (Massnahme) (improvement suggestions regarding issues found during auditing (Feststellungen bei einer Pruefung)). Example: offen, erledigt, nicht umgesetzt, etc., Some states can appear that should not, because of technical necessity or user errors that are made possible because the choices are not filtered. Does not contain "Kurzchecks". Source view v_dwh_kl_data_suggestion.');