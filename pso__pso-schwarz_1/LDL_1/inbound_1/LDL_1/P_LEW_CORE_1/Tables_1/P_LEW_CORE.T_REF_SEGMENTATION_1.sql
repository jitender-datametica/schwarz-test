CREATE TABLE P_LEW_CORE.T_REF_SEGMENTATION_1 (
SEGMENTATION_SID                    NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key SEGMENTATION',
MODEL_SID                           NUMBER(38,0)    NOT NULL COMMENT 'Surrogate Key MODEL',
SEGMENTATION_NAME                   VARCHAR(100)    COMMENT 'NAMe of the segmentation in the model',
SEGMENTATION_DESCR                  VARCHAR(250)    COMMENT 'DEScription of the segmentatzion in the model',
MODEL_AREA_CD                       VARCHAR(100)    NOT NULL COMMENT 'sprechender Code, CX, LDL+,AP',
MODEL_GROUP_CD                      VARCHAR(100)    NOT NULL COMMENT 'eindeutiger code, der mit dem area_cd beginnt z.b. AP_bakeoff or CX_store_rating',
DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
DWH_CREATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
DWH_UPDATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
CONSTRAINT PK_REF_SEGMENTATION PRIMARY KEY (SEGMENTATION_SID)
NOT ENFORCED
)
COMMENT = '$Revision: 0000 $. a segmentation is a set of rules and calculations to calculate scores and assign certain entities to certain segments.';

