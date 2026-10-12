/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_DIM_WAREHOUSE_1
   GENERATED FROM POWERDESIGNER ON Montag, 26. September 2022 16:30:55
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_WAREHOUSE_1 (
   WH_SID                              NUMBER          NOT NULL COMMENT 'The unique identifier (surrogate key) for the warehouse',
   DWH_VALID_FROM_TMSP                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   DWH_VALID_TO_TMSP                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   DWH_VALID_FG                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record in history.',
   WH_CD                               VARCHAR(5)      NOT NULL COMMENT 'A short unique code for the warehouses which receives the deliveries',
   WH_NAME                             VARCHAR(100)    COMMENT 'The name by which the warehouse is known.',
   WH_TYPE_CD                          VARCHAR(5)      COMMENT 'The code forthe type for the warehouse (Außenlager, Versandlager, Zwischenlager)',
   WH_STORAGE_TYPE_CD                  VARCHAR(5)      COMMENT 'The code for the type of warehouse storage ((KK,GT ...)',
   IS_RUN_BY_EXT_COMPANY               BOOLEAN         COMMENT 'Flag shows is warehouse run by external company  (there is no difference between internal / external run companies, only necessary for top mgmt reporting)',
   IS_WINE_STORAGE_FG                  BOOLEAN         COMMENT 'Flag shows if the warehouse stores wine&spirits(Großbeeren currently is GT + Wein)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    NOT NULL COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',
   SRC_TABLE_NAME                      VARCHAR(100)    COMMENT 'The name of the source tables',
   CONSTRAINT PK_T_DIM_WAREHOUSE PRIMARY KEY (WH_SID, DWH_VALID_FROM_TMSP) NOT ENFORCED
 )  COMMENT= 'A warehouse is a physical building which is used for storing and trans-shipping goods. In many cases it is also the home of the associated sales_1 organization';
