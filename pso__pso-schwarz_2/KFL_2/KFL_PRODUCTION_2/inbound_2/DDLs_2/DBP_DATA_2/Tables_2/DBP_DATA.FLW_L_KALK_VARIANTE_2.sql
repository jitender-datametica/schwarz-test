--==============================================================
-- Table: flw_l_kalk_variante_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_kalk_variante_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_KALK_VARIANTE_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH',
   kalk_variante_id                    VARCHAR(4)       NOT NULL COMMENT 'Kalkulationsvariante aus klvar. Schlüssel, der festlegt, wie eine_2 Kalkulation durchgeführt und bewertet wird (Kalkulation mit oder ohne Mengengerüst).',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_KALK_VARIANTE PRIMARY KEY (mandant_id, kalk_variante_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookup der Kalkulationsvariante - SAP P21 TCK04';

