CREATE TABLE P_LEW_CORE.T_REF_OPTIMIZATION_GOAL_DESCRIPTION_2 (
CLIENT_ID                           NUMBER(38,0)    NOT NULL COMMENT 'The ID of the client (Lidl-Country_2).',
OPT_GOAL_SID                        NUMBER(38,0)    NOT NULL COMMENT 'Surrogate key of the optimization goal.',
OPT_GOAL_DESCR                      VARCHAR(250)    COMMENT 'The country_2 dependent description of the optimization goal.',
DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier of the last run that inserted or updated this row.',
DWH_CREATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the insertion of this row.',
DWH_UPDATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of this row.',
CONSTRAINT PK_REF_OPTIMIZATION_GOAL_DES PRIMARY KEY (OPT_GOAL_SID, CLIENT_ID)
NOT ENFORCED
)
COMMENT = 'This reference table contains country_2 specific descriptions of optimization goals.';