/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_TRANSPORT_ROUTE_TYPE
   generated from Powerdesigner on Montag, 22. April 2024 11:13:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_TRANSPORT_ROUTE_TYPE (
   TRANSPORT_ROUTE_TYPE_CD             VARCHAR(50)     NOT NULL COMMENT 'Natural Key/Business Key - Type of transport that is used deliver the goods from harbor EU to OWIM warehouse',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_DIM_TRANSPORT_ROUTE_TYPE PRIMARY KEY (TRANSPORT_ROUTE_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Dimension - Type of transport that is used deliver the goods. - Source - VMT';
