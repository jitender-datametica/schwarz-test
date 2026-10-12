--==============================================================
-- Table: kmr_l_pruefung_klasse_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: kmr_l_pruefung_klasse_1
   generated from Powerdesigner on Freitag, 17. Februar 2023 16:16:57
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.KMR_L_PRUEFUNG_KLASSE_1 (
   amx_system_id                       INTEGER     NOT NULL DEFAULT -1 COMMENT 'AMX-Quellsystem-ID zur Unterscheidung der verschiedenen AMX Systeme (1 = Core and 2 = Unternehmenssicherheit). Quellfeld amx_system.',
   pruefung_klasse_id                  INTEGER     NOT NULL DEFAULT -1 COMMENT 'Prüfungsklasse / -art_1-ID. Quellfeld auditing_auditing_class_id.',
   pruefung_klasse_bez                 VARCHAR(255)     NOT NULL DEFAULT ' ' COMMENT 'Prüfungsklasse / -art_1-Bezeichnung. Quellfeld auditing_auditing_class_name.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_KMR_L_PRUEFUNG_KLASSE PRIMARY KEY (pruefung_klasse_id, amx_system_id) NOT ENFORCED
)  COMMENT = 'KMR - Lookup table for the audit class (Pruefungsklasse/-art_1). Does not include "Kurzchecks". Source view v_dwh_kl_data_auditing.';
