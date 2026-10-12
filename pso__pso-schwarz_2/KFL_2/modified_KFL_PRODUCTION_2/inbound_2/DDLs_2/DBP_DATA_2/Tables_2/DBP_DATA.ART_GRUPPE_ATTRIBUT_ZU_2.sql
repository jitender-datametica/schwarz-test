--==============================================================
-- Table: art_gruppe_attribut_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_gruppe_attribut_zu_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_GRUPPE_ATTRIBUT_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   art_id                              INTEGER     NOT NULL COMMENT 'Artikelnummer',
   art_gruppe_id                       VARCHAR(5)       NOT NULL COLLATE 'en-ci' COMMENT 'Artikelgruppe',
   art_attribut_id                     VARCHAR(5)       NOT NULL COLLATE 'en-ci' DEFAULT '     ' COMMENT 'Artikelattribut',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_GRUPPE_ATTRIBUT_ZU PRIMARY KEY (mandant_id, art_id, art_gruppe_id, art_attribut_id) NOT ENFORCED
)  COMMENT = 'Artikelattributzuordnung';

