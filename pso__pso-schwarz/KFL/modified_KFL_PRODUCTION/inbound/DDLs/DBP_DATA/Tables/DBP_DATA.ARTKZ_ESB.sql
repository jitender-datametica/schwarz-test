--==============================================================
-- Table: artkz_esb
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: artkz_esb
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:28 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ARTKZ_ESB (
   esb_id                              VARCHAR(10)      NOT NULL COLLATE 'en-ci' COMMENT 'ID des esb_Kennzeichens, z.Bsp. B',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache
            ',
   esb_bez                             VARCHAR(40)      COLLATE 'en-ci' COMMENT 'Bezeichnung des esb_Kennzeichens, z.Bsp. Blickpunktartikel',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ARTKZ_ESB PRIMARY KEY (esb_id, mandant_id) NOT ENFORCED
)  COMMENT = 'TP2_AIS - Lookuptabelle des Kalkulationskennzeichens Nonfood';

