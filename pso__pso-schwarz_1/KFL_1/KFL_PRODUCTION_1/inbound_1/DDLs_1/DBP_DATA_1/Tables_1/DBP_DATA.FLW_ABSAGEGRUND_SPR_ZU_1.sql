--==============================================================
-- Table: flw_absagegrund_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_absagegrund_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_ABSAGEGRUND_SPR_ZU_1 (
   absagegrund_id                      VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'ID des Absagegrunds für Kundenaufträge. Quelle ist das Feld abgru',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH. In der Regel länderbezogen',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'ID der DWH-Sprache, z.B. 22 ist deutsch',
   absagegrund_bez                     VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Bezeichnung des Absagegrundes aus bezei',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_ABSAGEGRUND_SPR_ZU PRIMARY KEY (absagegrund_id, mandant_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnung der Absagegründe aus der Tabelle tvagt';

