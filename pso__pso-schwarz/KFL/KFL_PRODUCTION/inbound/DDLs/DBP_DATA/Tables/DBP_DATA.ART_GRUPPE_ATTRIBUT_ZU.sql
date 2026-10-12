--==============================================================
-- Table: art_gruppe_attribut_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: art_gruppe_attribut_zu
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:29 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.ART_GRUPPE_ATTRIBUT_ZU (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   art_id                              NUMBER(38,0)     NOT NULL COMMENT 'Artikelnummer',
   art_gruppe_id                       VARCHAR(5)       NOT NULL COLLATE 'en-ci' COMMENT 'Artikelgruppe',
   art_attribut_id                     VARCHAR(5)       NOT NULL COLLATE 'en-ci' DEFAULT '     ' COMMENT 'Artikelattribut',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_ART_GRUPPE_ATTRIBUT_ZU PRIMARY KEY (mandant_id, art_id, art_gruppe_id, art_attribut_id) NOT ENFORCED
)  COMMENT = 'Artikelattributzuordnung';

