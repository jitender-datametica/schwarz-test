--==============================================================
-- Table: in_wartungsplan_status_per_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_wartungsplan_status_per_2
   generated from Powerdesigner on Dienstag, 2. Mai 2023 09:47:24
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_WARTUNGSPLAN_STATUS_PER_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   wart_plan_id                        INTEGER     NOT NULL COMMENT 'Wartungsplan',
   wart_plan_status_id                 VARCHAR(5)       NOT NULL COMMENT 'Status_2 of the maintenace plan (for example relevant = I0320)',
   status_fg                           INTEGER     COMMENT 'Kennzeichen: Status_2 inaktiv (flag indicating if the status_2 is active or inactive)',
   dat_von                             DATE             NOT NULL COMMENT 'Gültig von',
   dat_bis                             DATE             COMMENT 'Gültig bis',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_WARTUNGSPLAN_STATUS_PER PRIMARY KEY (mandant_id, wart_plan_id, wart_plan_status_id, dat_von) NOT ENFORCED
)  COMMENT = 'Wartungsplan Status_2  SAP IND (historical information for statuses of  maintenance plans. A maintenanca plan is a type of Work Plan (in_plangruppe))';
