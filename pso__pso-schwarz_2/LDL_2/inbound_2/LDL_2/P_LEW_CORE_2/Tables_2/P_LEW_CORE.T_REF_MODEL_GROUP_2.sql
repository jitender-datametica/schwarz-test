CREATE TABLE P_LEW_CORE.T_REF_MODEL_GROUP_2 (
MODEL_GROUP_CD                      VARCHAR(100)    NOT NULL COMMENT 'eindeutiger code, der mit dem area_cd beginnt z.b. AP_bakeoff or CX_store_rating',
MODEL_AREA_CD                       VARCHAR(100)    NOT NULL COMMENT 'sprechender Code, CX, LDL+,AP',
MODEL_GROUP_DESCR                   VARCHAR(250)    COMMENT 'description of the model group',
DWH_LOAD_ID                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
DWH_CREATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
DWH_UPDATED                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
CONSTRAINT PK_REF_MODEL_GROUP PRIMARY KEY (MODEL_GROUP_CD)
NOT ENFORCED
)
COMMENT = 'second level of model classificartion, for example store rating or segmented coupon';