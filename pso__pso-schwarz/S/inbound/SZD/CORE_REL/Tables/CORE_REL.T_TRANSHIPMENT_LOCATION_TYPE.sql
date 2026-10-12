/* --------------------------------------------------------------------------------
   DDL for table: T_TRANSHIPMENT_LOCATION_TYPE
   generated from Powerdesigner on Montag, 22. April 2024 11:13:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_TRANSHIPMENT_LOCATION_TYPE (
   TRANSHIPMENT_LOCATION_TYPE_CD       VARCHAR(50)     NOT NULL COMMENT 'The unique code of the transhipment location type.',
   TRANSHIPMENT_LOCATION_TYPE_DESCR    VARCHAR(250)    COMMENT 'A brief description of the transhipment location type.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_TRANSHIPMENT_LOCATION_TYPE PRIMARY KEY (TRANSHIPMENT_LOCATION_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - The transhipment location type defines which kind of transport vehicles are supported. For example a port serves ships and an airport serves planes. - Source - Manual';
