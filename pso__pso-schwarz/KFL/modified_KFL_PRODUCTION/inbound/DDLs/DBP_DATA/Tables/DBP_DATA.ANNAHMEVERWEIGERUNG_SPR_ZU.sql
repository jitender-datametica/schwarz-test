--==============================================================
-- Table: annahmeverweigerung_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: annahmeverweigerung_spr_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:31 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ANNAHMEVERWEIGERUNG_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   annahmeverweigerung_id              INTEGER     NOT NULL COMMENT 'Kennzeichen für den Annahmeverweigerungsgrund
            ',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   annahmeverweigerung_bez             VARCHAR(30)      COLLATE 'en-ci' COMMENT 'Bezeichnung des Grundes aus der Quelle text, z.Bsp. EAN fehlt',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ANNAHMEVERWEIGERUNG_SPR_ZU PRIMARY KEY (mandant_id, annahmeverweigerung_id, spr_id) NOT ENFORCED
)  COMMENT = 'LIS -Sprachabhängige Bezeichnungen der Gründe für die Annahmeverweigerung aus SAP PRL ZLV_AVG';

