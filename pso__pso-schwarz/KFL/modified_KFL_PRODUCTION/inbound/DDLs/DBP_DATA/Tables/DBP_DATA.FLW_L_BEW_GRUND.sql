--==============================================================
-- Table: flw_l_bew_grund
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_bew_grund
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_BEW_GRUND (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   flw_bew_grund_id                    INTEGER     NOT NULL COMMENT 'Grund der Bewegung (PDAO) aus SAP Quelle T157E.GRUND (Ursprung /SPDGS/PDAOE1.ZZGRUND)',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_BEW_GRUND PRIMARY KEY (mandant_id, flw_bew_grund_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookuptabelle Grund der Bewegung';

