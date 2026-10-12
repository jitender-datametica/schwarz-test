
CREATE TABLE CORE.T_DIM_GOODS_MOVEMENT_CATEGORY_GROUP_2 (
   GOODS_MOV_CAT_GROUP_CD              VARCHAR(10)     NOT NULL COMMENT 'The code which identifies the type of the warehouse movement (IN , OUT or RET (return) )',
   GOODS_MOV_CAT_GROUP_DESCR           VARCHAR(250)    NOT NULL COMMENT 'A textual description for the type of the warehouse movement (IN , OUT or RET (return) )',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_GOODS_MOVEMENT_CATEGORY_GROUP PRIMARY KEY (GOODS_MOV_CAT_GROUP_CD)
       NOT ENFORCED
)COMMENT = 'This minor dimension defines the type of the warehouse movement (IN , OUT or RET (return) )';
