--==============================================================
-- Table: flw_kalkulationsart_spr_zu_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_kalkulationsart_spr_zu_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_KALKULATIONSART_SPR_ZU_2 (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant_2 im DWH',
   kalkulationsart_id                  VARCHAR(2)       NOT NULL COMMENT 'ID der Kalkulationsart aus kalka. Schlüssel, der die interne Steuerung der Kalkulationsanwendung steuert (Bezugsobjekt z.B. Material, Musterkalkulation, Auftrag, Projekt). Die Kalkulationsart wird in der Kalkulationsvariante hinterlegt.',
   spr_id                              INTEGER     NOT NULL COMMENT 'ID der Sprache',
   kalkulationsart_bez                 VARCHAR(30)      NOT NULL DEFAULT ' ' COMMENT 'Bezeichnung der Kalkulationsart aus txlka',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_KALKULATIONSART_SPR_ZU PRIMARY KEY (mandant_id, kalkulationsart_id, spr_id) NOT ENFORCED
)  COMMENT = 'FLW - Sprachabhängige Bezeichnung der Kalkulationsart - SAP P21 TCK02';

