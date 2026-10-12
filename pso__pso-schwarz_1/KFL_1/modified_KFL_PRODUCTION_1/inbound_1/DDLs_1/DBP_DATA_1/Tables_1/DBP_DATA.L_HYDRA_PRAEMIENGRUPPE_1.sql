--==============================================================
-- Table: l_hydra_praemiengruppe_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_hydra_praemiengruppe_1
   generated from Powerdesigner on Freitag, 2. Juni 2023 09:18:04
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_HYDRA_PRAEMIENGRUPPE_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   pers_teilbereich_id                 VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Personalteilbereich der Gesellschaft, im Falle der KL Logistik 1:1 Zuordnung zum VZ (Company Division, in the case on KL Logistic it is 1:1 with Disctribution Centers)',
   praemiengrp_id                      VARCHAR(8)       NOT NULL COMMENT 'Prämiengruppe, z.B. 304001A1 - Code of the work group. 304 is code of distribution center, 001 code of task that this group should be doing, A1 is code for complecity of the task',
   praemiengrp_bez                     VARCHAR(30)      NOT NULL COMMENT 'Bezeichnung Prämiengruppe, z.B. 304001A1 = "TK MP Komis"',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_HYDRA_PRAEMIENGRUPPE PRIMARY KEY (mandant_id, pers_teilbereich_id, praemiengrp_id) NOT ENFORCED
)  COMMENT = 'Group of employees that do the same task(s) ( OG MP - obst gemuse mixed pallets), and therefore are subject to common group bonus
             We do not have translations in different languages. We have only a description in this table and no _SPR_ZU table';
