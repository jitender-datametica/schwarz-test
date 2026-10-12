--==============================================================
-- Table: artikelart_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artikelart_spr_zu_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTIKELART_SPR_ZU_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   artikelart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Die Artikelart ist ein SAP_internes Steuerungsfeld zur Gruppierung von Artikeln. Inhalt z.Bsp. HAWA, Z620
            
            ',
   spr_id                              NUMBER(38,0)     NOT NULL COMMENT 'Eindeutige ID für jede Sprache
            ',
   artikelart_bez                      VARCHAR(40)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'sprachabhängige Bezeichnung der Artikelart, z.Bsp. Fahrradzubehoer, Gemuesekonserven',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTIKELART_SPR_ZU PRIMARY KEY (mandant_id, artikelart_id, spr_id) NOT ENFORCED
)  COMMENT = 'TP408_LVS - Sprachabhängige Bezeichnung der Artikelart';

