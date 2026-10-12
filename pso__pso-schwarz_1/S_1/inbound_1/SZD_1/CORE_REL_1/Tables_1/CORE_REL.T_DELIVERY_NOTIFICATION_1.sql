/* --------------------------------------------------------------------------------
   DDL for table: T_DELIVERY_NOTIFICATION_1
   generated from Powerdesigner on Dienstag, 13. Mai 2025 13:10:47
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_DELIVERY_NOTIFICATION_1 (
   INTERNAL_HANDLING_UNIT_NR           VARCHAR(250)    NOT NULL COMMENT 'Business / Natural Key - The unique identification number of the handling unit.',
   PACKAGING_MATERIAL_CD               VARCHAR(50)     NOT NULL COMMENT 'The unique code of the packaging material as used in the source system.',
   INTERNAL_GUID_NR                    VARCHAR(100)    NOT NULL COMMENT 'The internal global unique identifier of this delivery announcement.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_DELIVERY_NOTIFICATION PRIMARY KEY (INTERNAL_HANDLING_UNIT_NR) NOT ENFORCED 
)  COMMENT = 'Entity - Transactional - Transaction - Stores delivery notifications data related to handling units. A delivery notification is a notification of a supplier_1 to the recipient that a delivery will be made. - Source - LExIS';
