CREATE TABLE CORE.T_DIM_PRODUCT_RETURN_REASON_2 (
   PROD_RETURN_REASON_CD               VARCHAR(5)      NOT NULL COMMENT 'The code for the article return reason on position level  (101, 900, etc)',
   PROD_RETURN_REASON_DESCR            VARCHAR(250)    NOT NULL COMMENT 'The textual description  the article return reason (Artikel_2 defekt, Artikel_2 zu groß/weit, etc)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(255)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   SRC_FILE_TMSP                       TIMESTAMP_LTZ   COMMENT 'The point in time when this record was extracted from the source.',
   CONSTRAINT PK_T_DIM_PRODUCT_RETURN_REASON PRIMARY KEY (PROD_RETURN_REASON_CD)
       NOT ENFORCED
)
COMMENT = 'The minor dimension that describes return reason of returned article on return position level ( 101 - Falsch bestellt, 301-Annahmeverweigerung, etc)';
