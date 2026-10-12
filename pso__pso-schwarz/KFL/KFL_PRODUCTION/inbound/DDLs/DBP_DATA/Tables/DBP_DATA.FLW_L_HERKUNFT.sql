--==============================================================
-- Table: flw_l_herkunft
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_herkunft
   generated from Powerdesigner on Monday, March 4, 2024 12:59:41 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_HERKUNFT (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   herkunft_id                         NUMBER(38,0)     NOT NULL COMMENT 'ID der Herkunft',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_HERKUNFT PRIMARY KEY (mandant_id, herkunft_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookup-Tabelle für die Herkunft - SAP P21 -/SPMEAT/ORIGIN';

