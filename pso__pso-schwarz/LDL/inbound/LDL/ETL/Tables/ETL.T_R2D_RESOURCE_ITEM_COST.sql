CREATE TABLE ETL.T_R2D_RESOURCE_ITEM_COST
(
    REAL_ESTATE_SID                NUMBER(38,0),
    DWH_VALID_FROM_TMSP           TIMESTAMP_LTZ(9),
    DWH_VALID_TO_TMSP             TIMESTAMP_LTZ(9),
    COST_TYPE_CD                  VARCHAR(20),
    RESOURCE_ITEM_TYPE_CD         VARCHAR(20),
    CURR_CD                       VARCHAR(20),
    COST_VAL                      NUMBER(38,5),
    COST_EUR_VAL                  NUMBER(38,5)
)
DATA_RETENTION_TIME_IN_DAYS = 1
;
