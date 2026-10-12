--==============================================================
-- Table: brand_abschnitt_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: brand_abschnitt_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:15 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BRAND_ABSCHNITT_SPR_ZU (
   brand_abschnitt_id                  VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'ID des Brandabschnitts aus brand',
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Der Mandant 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   lagernummer_id                      VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Lagernummer - höchste Ebene der Lagerhierarchie',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
   brand_abschnitt_bez                 VARCHAR(20)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Brandabschnitts aus brant',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BRAND_ABSCHNITT_SPR_ZU PRIMARY KEY (brand_abschnitt_id, mandant_id, lagernummer_id, spr_id) NOT ENFORCED
)  COMMENT = 'LIS - Sprachabhängige Bezeichnungen der Brandabschnitte aus t309t';

