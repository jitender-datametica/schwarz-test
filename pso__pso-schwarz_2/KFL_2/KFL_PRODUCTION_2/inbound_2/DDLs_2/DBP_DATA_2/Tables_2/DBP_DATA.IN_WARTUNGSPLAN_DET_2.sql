--==============================================================
-- Table: in_wartungsplan_det_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_wartungsplan_det_2
   generated from Powerdesigner on Montag, 17. Juli 2023 09:38:31
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_WARTUNGSPLAN_DET_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   wart_plan_pos_id                    NUMBER(38,0)     NOT NULL COMMENT 'Wartungsposition (this value is unique per mandant_id and is enough to indetify a wartungsplan)',
   wart_plan_id                        NUMBER(38,0)     NOT NULL COMMENT 'Wartungsplan',
   wart_plan_pos_bez                   VARCHAR(40)      COMMENT 'Kurztext der Position',
   tp_objekt_id                        NUMBER(38,0)     NOT NULL COMMENT 'Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_2',
   plantyp_id                          VARCHAR(1)       NOT NULL COMMENT 'Plantyp (z.B. A = Wartungsplan)',
   plangruppe_id                       VARCHAR(10)      NOT NULL COMMENT 'Schlüssel der Plangruppe',
   plangruppenzaehler                  VARCHAR(2)       NOT NULL COMMENT 'Plangruppenzähler',
   werk_id                             NUMBER(38,0)     COMMENT 'Numerischer Surrogate key für das Werk werks',
   wart_plan_status                    VARCHAR(1)       COMMENT 'Status_2 der Wartungsposition ',
   standort_kontierung_id              VARCHAR(12)      COMMENT 'Standort und Kontierung zum technischen Objekt (location_2 used for accounting)',
   instandhaltung_leistungsart_id      VARCHAR(3)       COMMENT 'Instandhaltungsleistungsart (maintenance activity type, e. g. “Maintenance” or “Inspection” or “Repair”,…)',
   qual_meldung_id                     NUMBER(18,0)     COMMENT 'Meldungsnummer (Quality Notification, similar to an INC )',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_WARTUNGSPLAN_DET PRIMARY KEY (mandant_id, wart_plan_pos_id, wart_plan_id) NOT ENFORCED
)  COMMENT = 'Wartungspläne je Equipment SAP IND ( relationship table between "Maintenance Plan" (in_wartungsplan_2), "Work Plan Group" (in_plangruppe) and "Functional/Technical Object" (tp_l_object))';
