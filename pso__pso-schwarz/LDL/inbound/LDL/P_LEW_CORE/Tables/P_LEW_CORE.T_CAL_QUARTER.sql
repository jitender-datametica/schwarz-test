CREATE TABLE P_LEW_CORE.T_CAL_QUARTER (
CY_QTR                              NUMBER(38,0)    NOT NULL COMMENT 'The ID of the calendar year quarter in form of YYYYQ',
CY                                  NUMBER(38,0)    NOT NULL COMMENT 'Calendar Year',
QTR_OF_CY                           NUMBER(38,0)    NOT NULL COMMENT 'Number of the quarter within the calendar year (1-4)',
CY_QTR_NAME                         VARCHAR(100)    NOT NULL COMMENT 'The name of the calendar year quarter.',
CY_QTR_BEGIN_MONTH                  NUMBER(38,0)    NOT NULL COMMENT 'The month ID of the begin of the calendar year quarter.',
CY_QTR_END_MONTH                    NUMBER(38,0)    NOT NULL COMMENT 'The month ID of the end of the calendar year quarter.',
CY_QTR_SEQ                          NUMBER(38,0)    NOT NULL COMMENT 'The offset of the calendar year quarter from the point of view of the last loaded day.',
CY_QTR_PREV_1Q                      NUMBER(38,0)    NOT NULL COMMENT 'The ID of the calendar year quarter of the previous quarter.',
CY_QTR_PREV_1Y                      NUMBER(38,0)    NOT NULL COMMENT 'The ID of the calendar year quarter of the previous year.',
CY_QTR_PREV_2Y                      NUMBER(38,0)    NOT NULL COMMENT 'The ID of the calendar year quarter two years ago.',
DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier of the last run that inserted or updated this row.',
DWH_CREATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the insertion of this row.',
DWH_UPDATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Timestamp of the last update of this row.',
CONSTRAINT PK_CAL_QUARTER PRIMARY KEY (CY_QTR)
NOT ENFORCED
)
COMMENT = 'Calendar Quarter Table';
