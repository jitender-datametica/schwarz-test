--==============================================================
-- Table: in_wartungsplan_abruf_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_wartungsplan_abruf_1
   generated from Powerdesigner on Montag, 17. Juli 2023 09:36:20
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_WARTUNGSPLAN_ABRUF_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   wart_plan_id                        INTEGER     NOT NULL COMMENT 'Wartungsplan',
   wart_plan_abruf_id                  INTEGER     NOT NULL COMMENT 'Nummer des Wartungsplanabrufs (Maintenance Plan execution number - starts from 1 for every plan)',
   wart_plan_pos_id                    INTEGER     NOT NULL COMMENT 'Wartungsposition (this value is unique per mandant_id and is enough to indetify a wartungsplan)',
   auftrag_id                          VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Auftragsnummer aus aufnr (maintenance order id)',
   dat_start_geplant                   DATE             COMMENT 'Eckstarttermin, in der Quelle nur bis zum Abruf gefüllt (wenn AUFNR gefüllt, ist das Feld in SAP leer) - scheduled start date for future executions. ',
   dat_start                           DATE             COMMENT 'Eckstarttermin aus gstrp - the actual date when the process related to this order started (looked up from in_auftrag_pps_1)',
   dat_abschluss                       DATE             COMMENT 'Abschlußdatum des Abrufobjektes - until maintenance plan is completed this date is null. When it is completed this is the date of the completion',
   qual_meldung_id                     INTEGER     COMMENT 'ID der Qualitätsmeldung aus qmnum (QA Notification ID, similar to an INC )',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_WARTUNGSPLAN_ABRUF PRIMARY KEY (mandant_id, wart_plan_id, wart_plan_abruf_id, wart_plan_pos_id) NOT ENFORCED
)  COMMENT = 'Wartungsplan Position executions -> 1 row per Maintenance plan position (step) for every past (finished) executon and future (scheduled) execution';
