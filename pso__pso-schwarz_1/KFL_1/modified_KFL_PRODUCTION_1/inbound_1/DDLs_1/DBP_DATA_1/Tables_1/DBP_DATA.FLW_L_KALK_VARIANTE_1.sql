--==============================================================
-- Table: flw_l_kalk_variante_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_kalk_variante_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_KALK_VARIANTE_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   kalk_variante_id                    VARCHAR(4)       NOT NULL COMMENT 'Kalkulationsvariante aus klvar. Schlüssel, der festlegt, wie eine_1 Kalkulation durchgeführt und bewertet wird (Kalkulation mit oder ohne Mengengerüst).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_KALK_VARIANTE PRIMARY KEY (mandant_id, kalk_variante_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookup der Kalkulationsvariante - SAP P21 TCK04';

