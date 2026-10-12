CREATE TABLE CORE.T_DIM_PRODUCT_AVAILABILITY_LEVEL (
   AVAIL_LVL_CD                        VARCHAR(5)      NOT NULL COMMENT 'Indicator code for availability (1, Online ausverkauft; 2, Online in Kürze; 3, Bestellbar; Null, Offline)',
   AVAIL_LVL_DESCR                     VARCHAR(20)     NOT NULL COMMENT 'A decription for availability code',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PRODUCT_AVAILABILITY_ PRIMARY KEY (AVAIL_LVL_CD)
       NOT ENFORCED
)
COMMENT = 'Indicator code for availability. In Shop Sys derived from multiple indicators, like stock, expected stock, promotion plan, manual blockers.';
