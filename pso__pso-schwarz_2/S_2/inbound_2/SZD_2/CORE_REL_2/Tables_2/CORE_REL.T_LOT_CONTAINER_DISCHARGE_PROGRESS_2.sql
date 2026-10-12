/* --------------------------------------------------------------------------------
   DDL for table: T_LOT_CONTAINER_DISCHARGE_PROGRESS_2
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LOT_CONTAINER_DISCHARGE_PROGRESS_2 (
   LOT_PRODUCT_INSTANCE_GROUP_SID      NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the lot.',
   CONTAINER_RESOURCE_ITEM_SID         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the container.',
   DISCHARGE_DT                        DATE            NOT NULL COMMENT 'Timestamp of event',
   LOADED_CARTON_CNT                   NUMBER(38,0)    NOT NULL COMMENT 'Measure - Total amount of cartons loaded in the container',
   DISCHARGED_CARTON_CNT               NUMBER(38,0)    NOT NULL COMMENT 'Measure - Total amount of undamaged, non-sample cartons unloaded in the container',
   DAMAGED_CARTON_CNT                  NUMBER(38,0)    NOT NULL COMMENT 'Measure - Count of damaged cartons (usually some are squished, wet etc)',
   SAMPLE_CARTON_CNT                   NUMBER(38,0)    NOT NULL COMMENT 'Measure - Count of sample cartons: usually 2-5 cartons per container are used for quality sampling and are destroyed afterwards',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   DWH_SRC_FILE_NAME                   VARCHAR(500)    COMMENT 'The path and the name of the file(s) from which this record was loaded.',
   DWH_SRC_1_TMSP                      TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was extracted from the source.',   
   CONSTRAINT PK_LOT_CONTAINER_DISCHARGE_PROGRESS PRIMARY KEY (LOT_PRODUCT_INSTANCE_GROUP_SID, CONTAINER_RESOURCE_ITEM_SID, DISCHARGE_DT) NOT ENFORCED 
)  COMMENT = 'Entity - Transactional - Transaction - In the process of moving containers from Asia to the destination warehouse, where they are finally unloaded and palletized, the “unloading state” defines the “clusters” of unloading the contained cartons. 
             Some can be damaged, some can be marked as cancelled, so the entity contains the info about how many cartons are actually available for further processing. - Source - VMT';
