--==============================================================
-- Table: kmr_l_pruefung_status_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_pruefung_status_2
   generated from Powerdesigner on Freitag, 17. Februar 2023 16:14:47
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_L_PRUEFUNG_STATUS_2 (
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.',
   pruefung_status_id                  INTEGER     NOT NULL DEFAULT -1 COMMENT 'Prüfungsstatus-ID. Quellfeld auditing_state.',
   pruefung_status_bez                 VARCHAR(255)     NOT NULL DEFAULT ' ' COMMENT 'Prüfungsstatus-Bezeichnung. Quellfeld auditing_state_name.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_L_PRUEFUNG_STATUS PRIMARY KEY (pruefung_status_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'KMR - Lookup table for the auditing state (Pruefungsstatus). Does not include "Kurzchecks". Source view v_dwh_kl_data_auditing.';
