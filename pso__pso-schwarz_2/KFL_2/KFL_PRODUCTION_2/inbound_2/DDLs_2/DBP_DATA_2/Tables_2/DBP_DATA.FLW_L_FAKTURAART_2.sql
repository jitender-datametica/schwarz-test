--==============================================================
-- Table: flw_l_fakturaart_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_fakturaart_2
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM_2
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_FAKTURAART_2 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_2 im DWH. In der Regel länderbezogen',
   fakturaart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Fakturaart aus fkart',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_FAKTURAART PRIMARY KEY (mandant_id, fakturaart_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookup-Tabelle der Fakturaarten aus tvfkt';

