--==============================================================
-- Table: immo_rolle_spr_zu
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_rolle_spr_zu
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_ROLLE_SPR_ZU (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   rolle_kz                            VARCHAR(7)       NOT NULL COLLATE 'en-ci' COMMENT 'Geschäftspartner: Rolle',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   rolle_bez                           VARCHAR(30)      NOT NULL COLLATE 'en-ci' DEFAULT ' ' COMMENT 'Rollenbezeichnung Geschäftspartner',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_ROLLE_SPR_ZU PRIMARY KEY (mandant_id, rolle_kz, spr_id) NOT ENFORCED
)  COMMENT = 'IMMO - Sprachabhängige Bezeichungen für die Mitarbeiterrolle - SAP REFX - TB003T';
