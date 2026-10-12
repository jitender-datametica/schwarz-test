--==============================================================
-- Table: immo_l_mo_art
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_l_mo_art
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_L_MO_ART (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   mo_art_kz                           VARCHAR(1)       NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Kennzeichen der Flächenart (Mietobjekt)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_L_MO_ART PRIMARY KEY (mandant_id, mo_art_kz) NOT ENFORCED
)  COMMENT = 'IMMO - Lookup Tabelle für die Flächenart (Mietobjekt) - SAP REFX - ZRE_FLAECHENARTT';
