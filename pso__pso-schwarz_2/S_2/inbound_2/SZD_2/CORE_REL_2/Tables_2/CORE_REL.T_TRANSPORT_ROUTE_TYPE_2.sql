/* --------------------------------------------------------------------------------
   DDL for table: T_TRANSPORT_ROUTE_TYPE_2
   generated from Powerdesigner on Montag, 22. April 2024 11:13:48
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_TRANSPORT_ROUTE_TYPE_2 (
   TRANSPORT_ROUTE_TYPE_CD             VARCHAR(50)     NOT NULL COMMENT 'The unique code of the transport route type.',
   TRANSPORT_ROUTE_TYPE_DESCR          VARCHAR(250)    COMMENT 'A brief description of the transport route type.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_TRANSPORT_ROUTE_TYPE PRIMARY KEY (TRANSPORT_ROUTE_TYPE_CD) NOT ENFORCED 
)  COMMENT = 'Minor Entity - Defines the types of routes for specific transport of goods.
             Wholesale uses BEFORE_IMPORT for its international transportation and AFTER_IMPORT for domestic transport at importing country.
             Foreign trade uses BEFORE_IMPORT only for transportation to the importing country. - Source - Manual';
