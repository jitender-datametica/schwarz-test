--==============================================================
-- Table: l_werbebereich
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: l_werbebereich
   generated from Powerdesigner on Freitag, 11. Oktober 2024 15:09:43
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.L_WERBEBEREICH (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   werbebereich_cd                     VARCHAR(100)     NOT NULL COMMENT 'Code des Werbebereichs.',
   werbebereich_bez                    VARCHAR(100)     COMMENT 'Werbebereich - Bezeichnung.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_L_WERBEBEREICH PRIMARY KEY (mandant_id, werbebereich_cd) NOT ENFORCED
)  COMMENT = 'Bündelung von mehreren werbeteams zu einem Bereich.';
