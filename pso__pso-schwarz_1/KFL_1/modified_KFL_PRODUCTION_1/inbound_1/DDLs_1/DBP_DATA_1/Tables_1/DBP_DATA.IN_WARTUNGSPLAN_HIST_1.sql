--==============================================================
-- Table: in_wartungsplan_hist_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_wartungsplan_hist_1
   generated from Powerdesigner on Montag, 17. Juli 2023 09:37:35
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_WARTUNGSPLAN_HIST_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   wart_plan_id                        INTEGER     NOT NULL COMMENT 'Wartungsplan',
   wart_plan_abruf_id                  INTEGER     NOT NULL COMMENT 'Nummer des Wartungsplanabrufs (Maintenance Plan Call number)',
   wart_plan_abruf_zaehler             INTEGER     NOT NULL COMMENT 'Nummer eines Wartungspaketes ( Maintenance Package_1 Number)',
   dat_plan                            DATE             COMMENT 'Plantermin (next planned date)',
   wart_plan_terminierungsart          VARCHAR(1)       COMMENT 'Terminierungsart (Scheduling type)',
   dat_start                           DATE             COMMENT 'Startdatum (start date) - when we have several scheduled execution of same maintenance plan, this is the first date of the schedule. Same for all exeuction,',
   dat_erledigung                      DATE             COMMENT 'Datum der letzten Erledigung im Wartungsplan',
   dat_abruf                           DATE             COMMENT 'Abrufdatum (Call Date) - actual execution date of the execution of this plan interation',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_WARTUNGSPLAN_HIST PRIMARY KEY (mandant_id, wart_plan_id, wart_plan_abruf_id, wart_plan_abruf_zaehler) NOT ENFORCED
)  COMMENT = 'Wartungsplan Historie SAP IND ( history of executions of maintenance plans - 1 rec for each run of a maintenance plan)';
