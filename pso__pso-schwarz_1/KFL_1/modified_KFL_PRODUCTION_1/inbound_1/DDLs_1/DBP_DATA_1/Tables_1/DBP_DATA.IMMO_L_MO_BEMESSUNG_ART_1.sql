--==============================================================
-- Table: immo_l_mo_bemessung_art_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_l_mo_bemessung_art_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_L_MO_BEMESSUNG_ART_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   bemessung_art_id                    VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'Bemessungsart',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_L_MO_BEMESSUNG_ART PRIMARY KEY (mandant_id, bemessung_art_id) NOT ENFORCED
)  COMMENT = 'IMMO - Lookup Tabelle für die Bemessungsart (Mietobjekt) - SAP REFX - TIVBDMEAST';
