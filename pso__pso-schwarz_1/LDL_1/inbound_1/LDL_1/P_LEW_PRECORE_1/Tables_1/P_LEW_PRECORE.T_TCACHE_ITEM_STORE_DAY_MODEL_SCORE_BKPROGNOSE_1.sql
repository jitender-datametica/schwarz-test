CREATE TABLE P_LEW_PRECORE.T_TCACHE_ITEM_STORE_DAY_MODEL_SCORE_BKPROGNOSE_1  CLUSTER BY (
CLIENT_ID,
MODEL_GROUP_CD
 )(
CLIENT_ID                           NUMBER(38,0)    NOT NULL COMMENT 'The ID of the client (Lidl-Country_1).',
MODEL_SID                           NUMBER(38,0)    NOT NULL COMMENT 'Surrogate key of the model (reference to t_ref_model_1).',
MODEL_RUN_DT                        DATE            NOT NULL COMMENT 'The date of the model run.',
LOC_SID                             NUMBER(38,0)    NOT NULL COMMENT 'Surrogate key of the store (reference to t_location_1).',
ITEM_SID                            NUMBER(38,0)    NOT NULL COMMENT 'Surrogate key of the item_1 (reference to t_item_1).',
PREDICTION_DT                       DATE            NOT NULL COMMENT 'The date of the prediction. This date may be in the future of the model run.',
PROGNOSIS_PCE                       NUMBER(38,5)    NOT NULL, 
PROGNOSIS_PCE_BL                    NUMBER(38,5)    NOT NULL,  
MODEL_AREA_CD                       VARCHAR(100)    NOT NULL COMMENT 'Human readable code of the model area (e.g. CX, AP or LDL+)',
MODEL_GROUP_CD                      VARCHAR(100)    NOT NULL COMMENT 'Unique code of the model group starting with the parental model area code, e.g. AP_bakeoff or CX_store_rating.',
DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier of the last run that inserted or updated this row.',
DWH_CREATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the insertion of this row.',
DWH_UPDATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of this row.',
CONSTRAINT PK_ITEM_STORE_DAY_MODEL_SCOR PRIMARY KEY (MODEL_SID, MODEL_RUN_DT, ITEM_SID, LOC_SID, PREDICTION_DT)
NOT ENFORCED
);