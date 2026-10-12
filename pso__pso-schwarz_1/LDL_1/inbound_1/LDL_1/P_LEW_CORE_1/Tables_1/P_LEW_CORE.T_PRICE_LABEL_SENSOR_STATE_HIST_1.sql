CREATE TABLE P_LEW_CORE.T_PRICE_LABEL_SENSOR_STATE_HIST_1 (
   CLIENT_ID                           NUMBER(38,0)     COMMENT 'Surrogate Key CLIENT.',
   PRICE_LABEL_SID                     NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key PRICE LABEL.',
   PRICE_LABEL_SENSOR_NAME             VARCHAR(100)     NOT NULL COMMENT 'A name of the price label sensor.',
   PRICE_LABEL_METRIC_MEAS             NUMBER(38,5)     COMMENT 'A measure of a given price label sensor.',
   DELETED_FG                          NUMBER(38,0)     NOT NULL COMMENT 'Artikel_1 ist im Falle deleted_fg = 1 im Zeitraum dwh_valid_from / dwh_valid_to nicht im Quellsystem bekannt; Hinweis: auch bei gesetztem Loeschkz im Quellsystem wird dieser Status_1 angenommen',
   DWH_VALID_FROM                      DATE             NOT NULL COMMENT 'Gueltigkeitsbeginn; Teil der DWH-Historisierung; aeltester Satz der Historie erhaelt immer den Wert 01.01.1900 ("minus unendlich")',
   DWH_VALID_TO                        DATE             NOT NULL COMMENT 'Gueltigkeitsende; Teil der DWH-Historisierung; neuster Satz der Historie erhaelt immer den Wert 30.12.9999 ("plus unendlich")',
   DWH_LOAD_ID                         NUMBER(38,0)     NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingefügt oder verändert hat.',
   DWH_CREATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   DWH_UPDATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',   
   CONSTRAINT PK_T_PRICE_LABEL_SENSOR_STATE_HIST PRIMARY KEY (PRICE_LABEL_SID, PRICE_LABEL_SENSOR_NAME) NOT ENFORCED 
)  COMMENT = 'A table containing data of different electronic price label shield sensors states (for example signal strength level or battery charge level).
             Source: Solum, Imagotag (ESL)';
