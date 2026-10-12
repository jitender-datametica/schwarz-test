--==============================================================
-- Table: dispomerkmal_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: dispomerkmal_spr_zu
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.DISPOMERKMAL_SPR_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Der Mandant 1 steht im DWH für Deutschland (der Wert 222 aus dem SAP System für Deutschland wird in Wert 1 umgewandelt).',
   dispomerkmal                        VARCHAR(2)       NOT NULL COLLATE 'en-ci' COMMENT 'Schlüssel, der bestimmt, ob und wie das Material disponiert wird, z.Bsp. manuelle Bestellpunktdisposition',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'In diesem Feld werden die Sprachen der DWH Tabelle spr referenziert.',
   dispomerkmal_bez                    VARCHAR(40)      NOT NULL COLLATE 'en-ci' COMMENT 'Sprachabhängige Bezeichnung des Dispomerkmals',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_DISPOMERKMAL_SPR_ZU PRIMARY KEY (mandant_id, dispomerkmal, spr_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS- Sprachabhängige Bezeichnungen des Dispomerkmals';

