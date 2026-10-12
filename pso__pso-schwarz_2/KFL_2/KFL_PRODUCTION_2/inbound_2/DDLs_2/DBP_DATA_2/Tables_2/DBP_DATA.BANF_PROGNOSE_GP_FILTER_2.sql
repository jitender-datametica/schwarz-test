--==============================================================
-- Table: banf_prognose_gp_filter_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: banf_prognose_gp_filter_2
   generated from Powerdesigner on Tuesday, February 20, 2024 3:55:30 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.BANF_PROGNOSE_GP_FILTER_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   gp_id                               NUMBER(38,0)     NOT NULL COMMENT 'Geschäftspartner - ID (Lieferanten - ID)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_BANF_PROGNOSE_GP_FILTER PRIMARY KEY (mandant_id, gp_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookuptabelle - Filter der Lieferanten, die in den Bestellanforderungsprognosen berücksichtigt werden sollen - wird manuell versorgt';

