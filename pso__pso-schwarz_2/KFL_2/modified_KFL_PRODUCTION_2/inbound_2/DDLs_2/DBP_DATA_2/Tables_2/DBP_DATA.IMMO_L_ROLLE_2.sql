--==============================================================
-- Table: immo_l_rolle_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_l_rolle_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:44 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_L_ROLLE_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   rolle_kz                            VARCHAR(7)       NOT NULL COLLATE 'en-ci' COMMENT 'Geschäftspartner: Rolle',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_L_ROLLE PRIMARY KEY (mandant_id, rolle_kz) NOT ENFORCED
)  COMMENT = 'IMMO - Mitarbeiterrolle - SAP REFX - TB003T';
