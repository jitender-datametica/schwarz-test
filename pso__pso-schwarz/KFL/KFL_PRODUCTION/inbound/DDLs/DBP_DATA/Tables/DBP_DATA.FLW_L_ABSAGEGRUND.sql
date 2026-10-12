--==============================================================
-- Table: flw_l_absagegrund
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_absagegrund
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_ABSAGEGRUND (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH. In der Regel länderbezogen',
   absagegrund_id                      VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'ID des Absagegrunds für Kundenaufträge. Quelle ist das Feld abgru',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_ABSAGEGRUND PRIMARY KEY (mandant_id, absagegrund_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookup der Absagegründe aus der Tabelle tvag';

