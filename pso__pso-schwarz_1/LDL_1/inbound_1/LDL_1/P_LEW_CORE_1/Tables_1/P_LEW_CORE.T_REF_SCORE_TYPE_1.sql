CREATE TABLE P_LEW_CORE.T_REF_SCORE_TYPE_1 (
SCORE_TYPE_SID                      NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key SCORE TYPE',
SCORE_TYPE_NAME                     VARCHAR(100)    COMMENT 'name of the score type',
SCORE_TYPE_DESCR                    VARCHAR(250)    COMMENT 'description of the score type',
DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
DWH_CREATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
DWH_UPDATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
CONSTRAINT PK_REF_SCORE_TYPE PRIMARY KEY (SCORE_TYPE_SID)
NOT ENFORCED
)
COMMENT = '$Revision: 0000 $. a score type is a certain well defined calculation result which will be calculated in a model run as intermediate or final result to allow the assignement of entities to segments';
