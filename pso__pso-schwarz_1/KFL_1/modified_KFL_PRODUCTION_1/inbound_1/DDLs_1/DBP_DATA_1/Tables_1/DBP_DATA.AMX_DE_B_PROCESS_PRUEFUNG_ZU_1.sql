--==============================================================
-- Table: amx_de_b_process_pruefung_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: amx_de_b_process_pruefung_zu_1
   generated from Powerdesigner on Wednesday, February 14, 2024 10:50:35 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.AMX_DE_B_PROCESS_PRUEFUNG_ZU_1 (
   business_process_id                 INTEGER     NOT NULL COMMENT 'Eindeutige ID des Geschäftsprozesses',
   pruefung_id                         INTEGER     NOT NULL COMMENT 'Eindeutige ID der Prüfung',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_AMX_DE_B_PROCESS_PRUEFUNG_ZU PRIMARY KEY (business_process_id, pruefung_id) NOT ENFORCED
)  COMMENT = 'KMR - Audimex. Bildet n:m Beziehungen für business_process_id und Pruefungen ab für Kurzcheck DE Daten';

