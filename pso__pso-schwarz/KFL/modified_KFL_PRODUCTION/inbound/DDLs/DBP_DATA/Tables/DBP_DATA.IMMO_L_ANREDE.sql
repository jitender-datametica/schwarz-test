--==============================================================
-- Table: immo_l_anrede
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_l_anrede
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_L_ANREDE (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   anrede_id                           VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID Anrede Partner',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_L_ANREDE PRIMARY KEY (mandant_id, anrede_id) NOT ENFORCED
)  COMMENT = 'IMMO - Lookup-Tabelle für die Anrede - SAP REFX - TSAD3T';
