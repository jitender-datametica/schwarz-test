CREATE TABLE P_LEW_CORE.T_REF_OPTIMIZATION_GOAL_TYPE (
OPT_GOAL_TYPE_CD                    VARCHAR(100)    NOT NULL COMMENT 'The code of the optimization goal.',
OPT_GOAL_TYPE_DESCR                 VARCHAR(250)    COMMENT 'Detailed description of the purpose of this optimization goal type.',
DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier of the last run that inserted or updated this row.',
DWH_CREATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the insertion of this row.',
DWH_UPDATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of this row.',
CONSTRAINT PK_REF_OPTIMIZATION_GOAL_TYP PRIMARY KEY (OPT_GOAL_TYPE_CD)
NOT ENFORCED
)
COMMENT = 'This reference table contains the possible types of optimization goals and their descriptions.';
