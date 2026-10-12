/* --------------------------------------------------------------------------------
   DDL for table: T_SHIPMENT_1
   generated from Powerdesigner on Mittwoch, 21. Mai 2025 13:12:54
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_SHIPMENT_1 (
   SHIPMENT_NR                         VARCHAR(250)    NOT NULL COMMENT 'The unique identifier of the shipment.',
   EVENT_DT                            DATE            NOT NULL COMMENT 'The date of a change event.',
   SHIPMENT_STAGE_ID                   NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the shipment stage.',
   HAULER_PARTY_SID                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the hauler company.',
   EXTERNAL_IDENTIFICATION_NR          VARCHAR(250)    COMMENT 'The external identification number (for example from a system of the external carrier).',
   SHIPMENT_TRANSPORT_TMSP             TIMESTAMP_TZ(9) COMMENT 'The timestamp when the transport of the shipment has ended.',
   CREATED_TMSP                        TIMESTAMP_TZ(9) NOT NULL COMMENT 'The timestamp when the record was created in the source system.',
   UPDATED_TMSP                        TIMESTAMP_TZ(9) COMMENT 'The timestamp when the record was last updated in the source system.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BLOG storage or the shortened file path',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The extraction timestamp of the record from the source',   
   CONSTRAINT PK_SHIPMENT PRIMARY KEY (SHIPMENT_NR, EVENT_DT) NOT ENFORCED 
)  COMMENT = 'Entity - Transactional - Transaction - Stores detailed information about a shipment. - Source - LExIS';
