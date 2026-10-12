--==============================================================
-- Table: immo_mo_art_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_mo_art_spr_zu_1
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_MO_ART_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   mo_art_kz                           VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Kennzeichen der Flächenart (Mietobjekt)',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   mo_art_bez                          VARCHAR(40)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Bezeichnung der Flächenart (Mietobjekt) (z.B. Expansions-,Umbau-, Normalfläche etc.)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_MO_ART_SPR_ZU PRIMARY KEY (mandant_id, mo_art_kz, spr_id) NOT ENFORCED
)  COMMENT = 'IMMO - Sprachabhängige Bezeichnung für die Flächenart (Mietobjekt) - SAP REFX - ZRE_FLAECHENARTT';
