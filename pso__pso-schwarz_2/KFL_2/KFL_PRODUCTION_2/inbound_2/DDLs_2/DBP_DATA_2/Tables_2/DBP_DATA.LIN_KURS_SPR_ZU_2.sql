--==============================================================
-- Table: lin_kurs_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: lin_kurs_spr_zu_2
   generated from Powerdesigner on Mittwoch, 17. Januar 2024 19:59:08
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.LIN_KURS_SPR_ZU_2 (
   lin_kurs_id                         VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'ID des Kurses, z:Bsp. 186obs',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID für jede Sprache',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'PK - Mandant_2 im DWH',
   lin_bericht                         VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Hinweis, in welchen Berichten der Kurs_2 relevant ist. Aus
            report_of
            Ausprägungen
            - VIS		(nur im VIS relevant)
            - UWL 		(nur im LIN Bericht "unternehmensweites Lernen" relevant)
            - BLANK	(für beide Berichte relevant)',
   lin_kurs_bez                        VARCHAR(255)     NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Kurses, z.Bsp. Warenkunde Obst',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_LIN_KURS_SPR_ZU PRIMARY KEY (lin_kurs_id, spr_id, mandant_id, lin_bericht) NOT ENFORCED
)  COMMENT = 'LIN - Sprachabhängige Bezeichnungen der LIN-Kurse';
