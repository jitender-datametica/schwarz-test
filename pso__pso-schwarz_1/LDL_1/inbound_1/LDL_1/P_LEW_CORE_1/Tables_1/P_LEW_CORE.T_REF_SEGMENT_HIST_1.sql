CREATE TABLE P_LEW_CORE.T_REF_SEGMENT_HIST_1 (
CLIENT_ID                           NUMBER(38,0)    NOT NULL COMMENT 'The ID of the client (Lidl-Country_1). This column is always set to the ID 7, because it''s a technical column used by the core loader.',
SEGMENT_SID                         NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key SEGMENT',
LOWER_BOUND_MEAS                    NUMBER(38,5)    COMMENT 'THe value of the lower bound of this segment. The lower bound is optional and only applicable for segmentations that support lower and upper bounds for segmentation.',
UPPER_BOUND_MEAS                    NUMBER(38,5)    COMMENT 'THe value of the upper bound of this segment. The lower bound is optional and only applicable for segmentations that support lower and upper bounds for segmentation.',
MODEL_SID                           NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key MODEL',
MODEL_AREA_CD                       VARCHAR(100)    NOT NULL COMMENT 'sprechender Code, CX, LDL+,AP',
MODEL_GROUP_CD                      VARCHAR(100)    NOT NULL COMMENT 'eindeutiger code, der mit dem area_cd beginnt z.b. AP_bakeoff or CX_store_rating',
DELETED_FG                          NUMBER(38,0)    NOT NULL COMMENT 'A flag indicating that this row is deleted or marked as deleted in the source system.',
DWH_VALID_FROM                      DATE            NOT NULL COMMENT 'The begin date of the period of validity_1 of this row.',
DWH_VALID_TO                        DATE            NOT NULL COMMENT 'The end date of the period of validity_1 of this row.',
DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier of the last run that inserted or updated this row.',
DWH_CREATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the insertion of this row.',
DWH_UPDATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of this row.',
CONSTRAINT PK_REF_SEGMENT_HIST PRIMARY KEY (SEGMENT_SID, DWH_VALID_FROM)
NOT ENFORCED
)
COMMENT = 'This table contains historized information about segments.';