--==============================================================
-- Table: kmr_l_pruefung_standort
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_pruefung_standort
   generated from Powerdesigner on Freitag, 17. Februar 2023 16:10:41
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_L_PRUEFUNG_STANDORT (
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.',
   standort_id                         INTEGER     NOT NULL DEFAULT -1 COMMENT 'Standort-ID. Quellfeld auditing_location_id.',
   standort_bez                        VARCHAR(255)     NOT NULL DEFAULT ' ' COMMENT 'Standort-Bezeichnung. Quellfeld auditing_location_name.',
   standort_typ_id                     INTEGER     NOT NULL DEFAULT -1 COMMENT 'Standorttyp-ID. Quellfeld auditing_location_type_id.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_L_PRUEFUNG_STANDORT PRIMARY KEY (standort_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'KMR - Lookup table for the location (Standort), Does not include "Kurzchecks". Source view v_dwh_kl_data_auditing.';
