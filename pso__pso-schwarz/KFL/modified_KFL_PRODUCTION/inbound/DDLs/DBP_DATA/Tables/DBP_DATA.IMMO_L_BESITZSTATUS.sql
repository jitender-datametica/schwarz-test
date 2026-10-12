--==============================================================
-- Table: immo_l_besitzstatus
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: immo_l_besitzstatus
   generated from Powerdesigner on Thursday, July 11, 2024 10:50:45 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.IMMO_L_BESITZSTATUS (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   besitzstatus_id                     VARCHAR(1)       NOT NULL COLLATE 'en-ci' COMMENT 'Besitzstatus ',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_IMMO_L_BESITZSTATUS PRIMARY KEY (mandant_id, besitzstatus_id) NOT ENFORCED
)  COMMENT = 'IMMO - Lookup-Tabelle Besitzstatus der Wirtschaftseinheit - SAP REFX - ZRE_BESITZSTATT';
