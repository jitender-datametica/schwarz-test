/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_DANGEROUS_GOOD_TYPE_2
   generated from Powerdesigner on Montag, 22. April 2024 11:13:50
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_DANGEROUS_GOOD_TYPE_2 (
   DANGEROUS_GOOD_TYPE_CD              VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - The classification of transported good as Dangerous Goods (SDB (Gefahrgut), Kein SDB )',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_DIM_DANGEROUS_GOOD_TYPE PRIMARY KEY (DANGEROUS_GOOD_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - Contains the classification of transported good as Dangerous Goods or not (are batteries contained for example). - Source - VMT';
