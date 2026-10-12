CREATE TABLE P_LEW_CORE.T_REF_OPTIMIZATION_GOAL (
OPT_GOAL_SID                        NUMBER(38,0)    NOT NULL COMMENT 'Surrogate key of the optimization goal.',
OPT_GOAL_TYPE_CD                    VARCHAR(100)    NOT NULL COMMENT 'The code of the optimization goal (reference to t_ref_optimization_goal_type).',
OPT_GOAL_VALUE                      NUMBER(38,5)    NOT NULL COMMENT 'The value of the optimization goal dependent on the type.',
DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier of the last run that inserted or updated this row.',
DWH_CREATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the insertion of this row.',
DWH_UPDATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of this row.',
CONSTRAINT PK_REF_OPTIMIZATION_GOAL PRIMARY KEY (OPT_GOAL_SID)
NOT ENFORCED
)
COMMENT = 'This reference table contains the possible optimization goals.';