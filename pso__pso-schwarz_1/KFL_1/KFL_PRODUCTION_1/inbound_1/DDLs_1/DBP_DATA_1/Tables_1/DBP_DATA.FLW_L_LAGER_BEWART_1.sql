--==============================================================
-- Table: flw_l_lager_bewart_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: flw_l_lager_bewart_1
   generated from Powerdesigner on Tuesday, March 12, 2024 9:30:41 AM
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_DATA.FLW_L_LAGER_BEWART_1 (
   mandant_id                          NUMBER(38,0)     NOT NULL COMMENT 'Mandant_1 im DWH. In der Regel länderbezogen',
   lager_bewart_id                     VARCHAR(3)       NOT NULL COLLATE 'en-ci' COMMENT 'Lager Bewegungsart aus bwart',
   system_id                           NUMBER(38,0)     NOT NULL COMMENT 'Spezifiziert das Quellsystem, aus dem die Daten kommen.',
   TD_UPDATE                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT                           TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_FLW_L_LAGER_BEWART PRIMARY KEY (mandant_id, lager_bewart_id) NOT ENFORCED
)  COMMENT = 'FLW - Lookup-Tabelle der Lager-Bewegungsarten aus t156t';

