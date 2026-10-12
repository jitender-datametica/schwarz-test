CREATE TABLE P_LEW_CORE.T_REF_MODEL_AREA (
MODEL_AREA_CD                       VARCHAR(100)    NOT NULL COMMENT 'sprechender Code, CX, LDL+,AP',
MODEL_AREA_DESCR                    VARCHAR(250)    COMMENT 'description of the model area',
DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
DWH_CREATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
DWH_UPDATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
CONSTRAINT PK_REF_MODEL_AREA PRIMARY KEY (MODEL_AREA_CD)
NOT ENFORCED
)
COMMENT = 'top level of model classification for analytical models, for example LDL+ or CX, one model area includes all model groups relatad to certain specific data like Lidl+ customer data, customer experience data, assortment scoring /  prediction data
          ';