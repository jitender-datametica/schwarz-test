--==============================================================
-- Table: flw_l_herkunft_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_herkunft_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_HERKUNFT_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   herkunft_id                         INTEGER     NOT NULL COMMENT 'ID der Herkunft',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_HERKUNFT PRIMARY KEY (mandant_id, herkunft_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookup-Tabelle für die Herkunft - SAP P21 -/SPMEAT/ORIGIN';

