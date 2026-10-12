--==============================================================
-- Table: belos_leistungsart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: belos_leistungsart_spr_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BELOS_LEISTUNGSART_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Der Mandant_1 1 steht im DWH für Deutschland (der Wert 22 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   belos_leistungsart_id               NUMBER(38,0)     NOT NULL COMMENT 'ID der Leistungsart, 1, 2 oder 3',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr_1 referenziert.',
   belos_leistungsart_bez              VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung der Leistungsart, z.Bsp. Vorlauf',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BELOS_LEISTUNGSART_SPR_ZU PRIMARY KEY (mandant_id, belos_leistungsart_id, spr_id) NOT ENFORCED
)  COMMENT = 'LIS - Sprachabhängige Bezeichnungen der Belos-Leistungsarten (manuell gepflegt)';

