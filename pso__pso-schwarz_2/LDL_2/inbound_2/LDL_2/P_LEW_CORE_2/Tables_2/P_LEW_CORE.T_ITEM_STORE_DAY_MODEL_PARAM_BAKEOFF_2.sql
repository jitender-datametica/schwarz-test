
CREATE TABLE P_LEW_CORE.T_ITEM_STORE_DAY_MODEL_PARAM_BAKEOFF_2  CLUSTER BY (
CLIENT_ID,
MODEL_GROUP_CD
 )(
CLIENT_ID                           NUMBER(38,0)    NOT NULL COMMENT 'The ID of the client (Lidl-Country_2).',
MODEL_SID                           NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key MODEL',
MODEL_RUN_DT                        DATE            NOT NULL COMMENT 'The date of the model run.',
LOC_SID                             NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key LOCATION_2 (eindeutig ueber alle Laender/Mandanten hinweg)',
ITEM_SID                            NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key ITEM_2 (eindeutig ueber alle Laender/Mandanten hinweg)',
PREDICTION_DT                       DATE            NOT NULL COMMENT 'The date of the prediction itself.',
PRICE_CHANGE_FG                     NUMBER(38,0)    COMMENT 'The flag indicating a price change is applicable or not.',
ITEM_REFERENCE_SID                  NUMBER(38,0)    COMMENT 'Optional reference to another item_2 for items with not enough data coverage.',
MODEL_AREA_CD                       VARCHAR(100)    NOT NULL COMMENT 'Human readable code of the model area (e.g. CX, AP or LDL+)',
MODEL_GROUP_CD                      VARCHAR(100)    NOT NULL COMMENT 'Unique code of the model group starting with the parental model area code, e.g. AP_bakeoff or CX_store_rating.',
DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier of the last run that inserted or updated this row.',
DWH_CREATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the insertion of this row.',
DWH_UPDATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of this row.',
CONSTRAINT PK_ITEM_STORE_DAY_MODEL_PARA PRIMARY KEY (MODEL_SID, MODEL_RUN_DT, LOC_SID, ITEM_SID, PREDICTION_DT)
NOT ENFORCED
)
COMMENT = 'This table contains the parameter for a run of the "Bakeoff" model on the granularity of a item_2, a store and a day.';
