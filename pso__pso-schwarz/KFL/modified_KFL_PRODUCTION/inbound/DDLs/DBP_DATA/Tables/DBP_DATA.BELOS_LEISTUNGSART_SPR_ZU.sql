--==============================================================
-- Table: belos_leistungsart_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belos_leistungsart_spr_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BELOS_LEISTUNGSART_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Der Mandant 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   belos_leistungsart_id               INTEGER     NOT NULL COMMENT 'ID der Leistungsart, 1, 2 oder 3',
   spr_id                              INTEGER     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
   belos_leistungsart_bez              VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Leistungsart, z.Bsp. Vorlauf',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BELOS_LEISTUNGSART_SPR_ZU PRIMARY KEY (mandant_id, belos_leistungsart_id, spr_id) NOT ENFORCED
)  COMMENT = 'LIS - Sprachabhängige Bezeichnungen der Belos-Leistungsarten (manuell gepflegt)';

