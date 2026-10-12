--==============================================================
-- Table: in_l_mass_typ
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_l_mass_typ
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_L_MASS_TYP (
   in_massnahme_typ_id                 VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Eindeutige ID eins Massnahmetyps',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_L_MASS_TYP PRIMARY KEY (in_massnahme_typ_id) NOT ENFORCED
)  COMMENT = 'IMS - Lookup Tabelle der Massnahmentypen aus SAP Industrie zco_mass_type';
