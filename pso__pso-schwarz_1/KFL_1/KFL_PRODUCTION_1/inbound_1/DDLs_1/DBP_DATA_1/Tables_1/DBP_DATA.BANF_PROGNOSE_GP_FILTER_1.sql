--==============================================================
-- Table: banf_prognose_gp_filter_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: banf_prognose_gp_filter_1
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BANF_PROGNOSE_GP_FILTER_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH',
   gp_id                               NUMBER(38,0)     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BANF_PROGNOSE_GP_FILTER PRIMARY KEY (mandant_id, gp_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookuptabelle - Filter der Lieferanten, die in den Bestellanforderungsprognosen berücksichtigt werden sollen - wird manuell versorgt';

