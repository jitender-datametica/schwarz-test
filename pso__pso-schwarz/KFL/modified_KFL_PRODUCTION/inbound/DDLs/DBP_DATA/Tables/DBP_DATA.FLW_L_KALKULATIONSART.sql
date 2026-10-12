--==============================================================
-- Table: flw_l_kalkulationsart
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_kalkulationsart
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_KALKULATIONSART (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH',
   kalkulationsart_id                  VARCHAR(2)       NOT NULL COMMENT 'ID der Kalkulationsart aus kalka. Schlüssel, der die interne Steuerung der Kalkulationsanwendung steuert (Bezugsobjekt z.B. Material, Musterkalkulation, Auftrag, Projekt). Die Kalkulationsart wird in der Kalkulationsvariante hinterlegt.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_KALKULATIONSART PRIMARY KEY (mandant_id, kalkulationsart_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookup der Kalkulationsart - SAP P21 TCK02';

