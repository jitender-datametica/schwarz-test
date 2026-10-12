--==============================================================
-- Table: hydra_leistungsgrad_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: hydra_leistungsgrad_2
   generated from Powerdesigner on Freitag, 2. Juni 2023 09:22:07
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.HYDRA_LEISTUNGSGRAD_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   pers_teilbereich_id                 VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Personalteilbereich der Gesellschaft, im Falle der KL Logistik 1:1 Zuordnung zum VZ (Company Division, in the case on KL Logistic it is 1:1 with Disctribution Centers)',
   dat                                 DATE             NOT NULL COMMENT 'Datum im Format JJJJ-MM_2-TT',
   lohnart_id                          VARCHAR(4)       NOT NULL COMMENT 'Lohnart/Wage Type  (H100, H200 oder H300)',
   zeitart_id                          VARCHAR(3)       NOT NULL COMMENT 'Zeitart, z.B. GRP , ZL',
   praemiengrp_id                      VARCHAR(8)       NOT NULL COMMENT 'Prämiengruppe, z.B. 304001A1 - Code of the work group. 304 is code of distribution center, 001 code of task that this group should be doing, A1 is code for complecity of the task',
   transport_gv_id                     VARCHAR(18)      COMMENT 'Geschäftsvorfall',
   lagernummer_id                      VARCHAR(4)       COLLATE 'en-ci' COMMENT 'ID der Lagernummer - höchste Ebene der Lagerhierarchie',
   ewm_fg                              INTEGER     DEFAULT 0 COMMENT 'Indicates if the LGNUM is an SAP EWM-run warehouse',
   dauer_ist                           NUMBER(29,2)      COMMENT 'Lohnscheindauer in Stunden_2 (gesamt, entspricht dem Wert in der Tabelle hydra_leistungsgrad_2 und wird in den folgenden Spalten aufgegliedert)
            Total sum of work-hours including actual activity time and overhead time. The overhead time is broken down in the columns dauer_ruest,dauer_wechsel,dauer_sonstiges. The actual activity time is the value in this columns - the sum of other 3 cols',
   dauer_soll                          NUMBER(29,2)      COMMENT 'Vorgabezeit je Prämiengruppe in Stunden_2 - Target time per premium group in work-hours',
   grad_leistung                       NUMBER(29,2)      COMMENT 'Leistungsgrad in % (efficiency in % - actual /target)',
   menge                               NUMBER(29,3)     COMMENT 'Menge, z. B. Anzahl bewegte Kolli - quantity of pieces of work done in this task - the type of work is determined by column TRANSPORT_GV_ID',
   abrechnung_fg                       INTEGER     COMMENT 'Flag gibt an ob die Abrechnung erfolgt ist und die Daten sich somit nicht mehr ändern',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_HYDRA_LEISTUNGSGRAD PRIMARY KEY (mandant_id, pers_teilbereich_id, dat, lohnart_id, zeitart_id, praemiengrp_id) NOT ENFORCED
)  COMMENT = 'Summary of work-hours spent, grouped by Date, Company  Division. Work Group, Wage Type, and Work Performance Measurement Type (in Logistic - warehouse tasks)';
