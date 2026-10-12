--==============================================================
-- Table: hydra_ruestzeit_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: hydra_ruestzeit_1
   generated from Powerdesigner on Freitag, 2. Juni 2023 09:21:04
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.HYDRA_RUESTZEIT_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   pers_teilbereich_id                 VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Personalteilbereich der Gesellschaft, im Falle der KL Logistik 1:1 Zuordnung zum VZ (Company Division, in the case on KL Logistic it is 1:1 with Disctribution Centers)',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM_1-TT',
   praemiengrp_id                      VARCHAR(8)       NOT NULL COMMENT 'Prämiengruppe, z.B. 304001A1 - Code of the work group. 304 is code of distribution center, 001 code of task that this group should be doing, A1 is code for complecity of the task',
   transport_gv_id                     VARCHAR(18)      COMMENT 'Geschäftsvorfall',
   lagernummer_id                      VARCHAR(4)       COLLATE 'en-ci' COMMENT 'ID der Lagernummer - höchste Ebene der Lagerhierarchie',
   ewm_fg                              NUMBER(38,0)     DEFAULT 0 COMMENT 'Indicates if the LGNUM is an SAP EWM-run warehouse',
   dauer_ist                           NUMBER(9,2)      COMMENT 'Lohnscheindauer in Stunden_1 (gesamt, entspricht dem Wert in der Tabelle hydra_leistungsgrad_1 und wird in den folgenden Spalten aufgegliedert)
            Total sum of work-hours including actual activity time and overhead time. The overhead time is broken down in the columns dauer_ruest,dauer_wechsel,dauer_sonstiges. The actual activity time is the value in this columns - the sum of other 3 cols',
   dauer_ruest                         NUMBER(9,2)      COMMENT 'Dauer Rüstzeit je Prämiengruppe in Stunden_1 - Duration Set-up time per bonus group in hours',
   dauer_wechsel                       NUMBER(9,2)      COMMENT 'Dauer Wechselzeit je Prämiengruppe in Stunden_1 - Duration of changeover time per premium group in hours',
   dauer_sonstiges                     NUMBER(9,2)      COMMENT 'Dauer Sonstige Zeit_1 je Prämiengruppe in Stunden_1 - Duration Other time per premium group in hours',
   abrechnung_fg                       NUMBER(38,0)     COMMENT 'Flag gibt an ob die Abrechnung erfolgt ist und die Daten sich somit nicht mehr ändern',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_HYDRA_RUESTZEIT PRIMARY KEY (mandant_id, pers_teilbereich_id, dat, praemiengrp_id) NOT ENFORCED
)  COMMENT = 'Summary of work-hours spent per day by Company  Division and Work Group (in Logistic - warehouse tasks)';
