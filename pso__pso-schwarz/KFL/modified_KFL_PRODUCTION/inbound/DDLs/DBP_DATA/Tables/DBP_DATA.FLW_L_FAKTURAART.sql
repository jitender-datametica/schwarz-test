--==============================================================
-- Table: flw_l_fakturaart
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_fakturaart
   generated from Powerdesigner on Monday, March 4, 2024 12:59:40 PM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_FAKTURAART (
   mandant_id                          INTEGER     NOT NULL COMMENT 'Mandant im DWH. In der Regel länderbezogen',
   fakturaart_id                       VARCHAR(4)       NOT NULL COLLATE 'en-ci' COMMENT 'ID der Fakturaart aus fkart',
   system_id                           INTEGER     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_FAKTURAART PRIMARY KEY (mandant_id, fakturaart_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookup-Tabelle der Fakturaarten aus tvfkt';

