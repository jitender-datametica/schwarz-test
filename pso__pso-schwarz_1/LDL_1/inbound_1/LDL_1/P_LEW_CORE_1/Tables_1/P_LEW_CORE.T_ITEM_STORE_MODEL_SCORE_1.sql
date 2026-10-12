CREATE TABLE P_LEW_CORE.T_ITEM_STORE_MODEL_SCORE_1  CLUSTER BY (
CLIENT_ID,
MODEL_GROUP_CD
 )(
CLIENT_ID                           NUMBER(38,0)    NOT NULL COMMENT 'The ID of the client (Lidl-Country_1).',
MODEL_SID                           NUMBER(38,0)    NOT NULL COMMENT 'Surrogate key of the model (reference to t_ref_model_1).',
MODEL_RUN_DT                        DATE            NOT NULL COMMENT 'The date of the model run.',
LOC_SID                             NUMBER(38,0)    NOT NULL COMMENT 'Surrogate key of the store (reference to t_location_1).',
ITEM_SID                            NUMBER(38,0)    NOT NULL COMMENT 'Surrogate key of the item_1 (reference to t_item_1).',
SCORE_TYPE_SID                      NUMBER(38,0)    NOT NULL COMMENT 'Surrogate key of the score type (reference to t_ref_score_type_1).',
SCORE_MEAS                          NUMBER(38,6)    COMMENT 'The measure value for a specific score type as an output of the model run.',
MODEL_AREA_CD                       VARCHAR(100)    NOT NULL COMMENT 'Human readable code of the model area (e.g. CX, AP or LDL+)',
MODEL_GROUP_CD                      VARCHAR(100)    NOT NULL COMMENT 'Unique code of the model group starting with the parental model area code, e.g. AP_bakeoff or CX_store_rating.',
DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier of the last run that inserted or updated this row.',
DWH_CREATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the insertion of this row.',
DWH_UPDATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of this row.',
CONSTRAINT PK_ITEM_STORE_MODEL_SCORE PRIMARY KEY (MODEL_SID, MODEL_RUN_DT, ITEM_SID, LOC_SID, SCORE_TYPE_SID)
NOT ENFORCED
)
COMMENT = 'This table contains the results of a model run regarding to a specific item_1 and a specific store.';
