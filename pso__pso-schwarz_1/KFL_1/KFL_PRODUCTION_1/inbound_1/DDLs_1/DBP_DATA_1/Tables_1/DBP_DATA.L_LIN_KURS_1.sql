--==============================================================
-- Table: l_lin_kurs_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_lin_kurs_1
   generated from Powerdesigner on Dienstag, 2. Januar 2024 09:16:04
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_LIN_KURS_1 (
   lin_kurs_id                         VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'ID des Kurses, z:Bsp. 186obs',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'PK - Mandant_1 im DWH',
   sortkz                              NUMBER(38,0),
   lin_kursgruppe_id                   VARCHAR(10)      COLLATE 'en-ci' COMMENT 'ID der Kursgruppe aus coursegroup_id',
   lin_bericht                         VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Hinweis, in welchen Berichten der Kurs_1 relevant ist. Aus
            report_of
            Ausprägungen
            - VIS		(nur im VIS relevant)
            - UWL 		(nur im LIN Bericht "unternehmensweites Lernen" relevant)
            - BLANK	(für beide Berichte relevant)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_LIN_KURS PRIMARY KEY (lin_kurs_id, mandant_id, lin_bericht) NOT ENFORCED
)  COMMENT = 'LIN - Lookuptabelle der Kurse';
