--==============================================================
-- Table: flw_kalk_variante_spr_zu_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_kalk_variante_spr_zu_1
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_1
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_KALK_VARIANTE_SPR_ZU_1 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_1 im DWH',
   kalk_variante_id                    VARCHAR(4)       NOT NULL COMMENT 'Kalkulationsvariante aus klvar. Schlüssel, der festlegt, wie eine_1 Kalkulation durchgeführt und bewertet wird (Kalkulation mit oder ohne Mengengerüst).',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   kalk_variante_bez                   VARCHAR(30)      NOT NULL DEFAULT ' ' COMMENT 'Bezeichnung der Kalkulationsvariante aus txklv',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_KALK_VARIANTE_SPR_ZU PRIMARY KEY (mandant_id, kalk_variante_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnung der Kalkulationsvariante - SAP P21 TCK04';

