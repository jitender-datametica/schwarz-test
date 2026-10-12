--==============================================================
-- Table: ean
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ean
   generated from Powerdesigner on Tuesday, February 27, 2024 8:30:13 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.EAN (
   ean_id                              NUMBER(29,0)     NOT NULL COMMENT 'Europäische Artikelnummer',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_EAN PRIMARY KEY (ean_id) NOT ENFORCED
)  COMMENT = 'Europäische Artikelnummern. Wird zu KW46_15 gelöscht';

