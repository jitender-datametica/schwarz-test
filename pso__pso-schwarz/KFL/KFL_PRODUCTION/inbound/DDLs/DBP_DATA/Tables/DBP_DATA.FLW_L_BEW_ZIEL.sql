--==============================================================
-- Table: flw_l_bew_ziel
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_bew_ziel
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_BEW_ZIEL (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant im DWH',
   flw_ziel_id                         NUMBER(38,0)     NOT NULL COMMENT 'Ziel (PDAO) aus SAP Quelle /SPDGS/PDAOE1.ZZFWZIEL',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_BEW_ZIEL PRIMARY KEY (mandant_id, flw_ziel_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookuptabelle Ziel (PDAO)';

