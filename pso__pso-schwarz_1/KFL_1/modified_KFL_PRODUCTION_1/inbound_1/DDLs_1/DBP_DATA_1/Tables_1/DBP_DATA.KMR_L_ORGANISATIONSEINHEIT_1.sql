--==============================================================
-- Table: kmr_l_organisationseinheit_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_organisationseinheit_1
   generated from Powerdesigner on Freitag, 17. Februar 2023 15:55:50
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_L_ORGANISATIONSEINHEIT_1 (
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.',
   orga_einheit_id                     INTEGER     NOT NULL DEFAULT -1 COMMENT 'Organisationseinheit-ID. Quellfelder auditing_audited_org_unit_id, suggestion_responsible_unit_id.',
   orga_einheit_imp_referenz           VARCHAR(255)     DEFAULT ' ' COMMENT 'Organisationseinheit Importreferenz. Quellfeld auditing_audited_org_unit_imp_reference.',
   orga_einheit_bez                    VARCHAR(255)     NOT NULL DEFAULT ' ' COMMENT 'Organisationseinheit-Bezeichnung. Quellfelder auditing_audited_org_unit_name, suggestion_responsible_unit_name.',
   mandant_id                          INTEGER     COMMENT 'Mandant_1 im DWH.',
   wup_id                              INTEGER     COMMENT 'Mutter Wup_1 ID, wird verwendet für Beziehung Lager zu Verteilzentrum.',
   nb_id                               INTEGER     COMMENT 'Nebenbetrieb-ID (Lager, Filiale, ...).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_L_ORGANISATIONSEINHEIT PRIMARY KEY (orga_einheit_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'KMR - Lookup table for Kaufland organizational units (Organisationseinheiten) in the context of auditing (Revision). An organizational unit_1 can be audited (gepruefte Organisationseinheiten), "Who was audited? (Wer wurde geprueft?)", or be the one that handles / helps with the improvement suggestions (zuständige Stelle) of the audited unit. Does not include "Kurzchecks". Source views v_dwh_kl_data_auditing, v_dwh_kl_data_suggestion.';
