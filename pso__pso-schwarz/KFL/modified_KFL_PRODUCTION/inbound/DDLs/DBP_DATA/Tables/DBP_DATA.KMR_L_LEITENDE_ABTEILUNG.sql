--==============================================================
-- Table: kmr_l_leitende_abteilung
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_leitende_abteilung
   generated from Powerdesigner on Freitag, 17. Februar 2023 16:13:50
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_L_LEITENDE_ABTEILUNG (
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.',
   leit_abteilung_id                   INTEGER     NOT NULL DEFAULT -1 COMMENT 'Leitende Abteilung-ID. Quellfeld auditing_leading_dep_id.',
   leit_abteilung_bez                  VARCHAR(255)     NOT NULL DEFAULT ' ' COMMENT 'Leitende Abteilung-Bezeichnung. Quellfeld auditing_leading_dep_name.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_L_LEITENDE_ABTEILUNG PRIMARY KEY (leit_abteilung_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'KMR - Lookup table for the leading department (leitende Abteilung). Department that initiates the audit, i.e. Revision Kaufland International, Bulgaria, etc. Does not include "Kurzchecks". Source view v_dwh_kl_data_auditing.';
