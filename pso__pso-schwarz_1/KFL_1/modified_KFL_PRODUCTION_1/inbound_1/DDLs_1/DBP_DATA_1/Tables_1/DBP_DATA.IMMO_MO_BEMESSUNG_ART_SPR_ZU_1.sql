--==============================================================
-- Table: immo_mo_bemessung_art_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_mo_bemessung_art_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_MO_BEMESSUNG_ART_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   bemessung_art_id                    VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Bemessungsart',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   bemessung_art_bez                   VARCHAR(30)      NOT NULL COLLATE 'en-ci' DEFAULT ' ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_MO_BEMESSUNG_ART_SPR_ZU PRIMARY KEY (mandant_id, bemessung_art_id, spr_id) NOT ENFORCED
)  COMMENT = 'IMMO - Sprachabhängige Bezeichnung für die Bemessungsart (Mietobjekt) - SAP REFX - TIVBDMEAST';
