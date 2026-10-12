--==============================================================
-- Table: in_l_leistungsart_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: in_l_leistungsart_2
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:46 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IN_L_LEISTUNGSART_2 (
   co_leistungsart_id                  VARCHAR(7)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der CO-Leistungsart aus der Quelle lstar',
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IN_L_LEISTUNGSART PRIMARY KEY (co_leistungsart_id, mandant_id) NOT ENFORCED
)  COMMENT = 'LIS - Lookup Tabelle der CO-Leistungsarten aus SAP Industrie cslt';
