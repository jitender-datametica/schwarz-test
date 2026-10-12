--==============================================================
-- Table: belos_tourstatus_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belos_tourstatus_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BELOS_TOURSTATUS_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Der Mandant_1 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   belos_tourstatus_id                 INTEGER     NOT NULL COMMENT 'ID des Tourstatus. Unterscheidet, ob im System angelegt, gesendet oder abgerechnet',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.
            ',
   belos_tourstatus_bez                VARCHAR(40)      COLLATE 'en-ci',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BELOS_TOURSTATUS_SPR_ZU PRIMARY KEY (mandant_id, belos_tourstatus_id, spr_id) NOT ENFORCED
)  COMMENT = 'LIS - Sprachabhängige Bezeichnung der Tourstati. Initial befüllt - keine Versorgung vorgesehen.';
