--==============================================================
-- Table: in_wartungsplan_det_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_wartungsplan_det_1
   generated from Powerdesigner on Montag, 17. Juli 2023 09:38:31
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_wartungsplan_det_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Mandant_1 im DWH'),
wart_plan_pos_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Wartungsposition (this value is unique per mandant_id and is enough to indetify a wartungsplan)'),
wart_plan_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Wartungsplan'),
wart_plan_pos_bez STRING(40) OPTIONS(description='Kurztext der Position'),
tp_objekt_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Ausprägung bzw. Objekt eines technischen Platzes. Quelle SAP: AUSP_1'),
plantyp_id STRING(1) NOT NULL OPTIONS(description='Plantyp (z.B. A = Wartungsplan)'),
plangruppe_id STRING(10) NOT NULL OPTIONS(description='Schlüssel der Plangruppe'),
plangruppenzaehler STRING(2) NOT NULL OPTIONS(description='Plangruppenzähler'),
werk_id BIGNUMERIC(38,0) OPTIONS(description='Numerischer Surrogate key für das Werk werks'),
wart_plan_status STRING(1) OPTIONS(description='Status_1 der Wartungsposition '),
standort_kontierung_id STRING(12)
OPTIONS(description='Standort und Kontierung zum technischen Objekt (location_1 used for accounting)'),
instandhaltung_leistungsart_id STRING(3)
OPTIONS(description='Instandhaltungsleistungsart (maintenance activity type, e. g. “Maintenance” or “Inspection” or “Repair”,…)'),
qual_meldung_id INTEGER OPTIONS(description='Meldungsnummer (Quality Notification, similar to an INC )'),
td_update TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
td_insert TIMESTAMP
OPTIONS(description='Technical fields for synchronisation framework. Will be delted after last product migration'),
PRIMARY KEY (mandant_id, wart_plan_pos_id, wart_plan_id) NOT ENFORCED
)
OPTIONS(description='Wartungspläne je Equipment SAP IND ( relationship table between "Maintenance Plan" (in_wartungsplan_1), "Work Plan Group" (in_plangruppe) and "Functional/Technical Object" (tp_l_object))');