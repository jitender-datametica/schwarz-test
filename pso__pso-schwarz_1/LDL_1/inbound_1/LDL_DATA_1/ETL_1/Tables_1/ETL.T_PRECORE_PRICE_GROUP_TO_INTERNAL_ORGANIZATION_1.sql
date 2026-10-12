CREATE TABLE ETL.T_PRECORE_PRICE_GROUP_TO_INTERNAL_ORGANIZATION_1 (
    INT_ORG_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization to which the price group applies',
    INT_ORG_TYPE_CD VARCHAR(20) NOT NULL COMMENT 'The code identifying the discriminators for internal organizations.',
    PRICE_GRP_SID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier (surrogate key) for the price level of a product.',
    PRICE_GRP_PRIO NUMBER(38,0) COMMENT 'In case several prices are defined for one product, the price originating from the price group is used, which has the highest priority for the given store or warehouse.',
    DATEFROM TIMESTAMP_NTZ(9) NOT NULL,
    DATETO TIMESTAMP_NTZ(9),
    OPEN_DT DATE COMMENT 'The date when this real estate object was opened.',
    CLOSE_DT DATE COMMENT 'The date when this real estate object was closed.',
    DWH_CREATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
    DWH_UPDATED_TMSP TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
    DWH_LOAD_ID NUMBER(38,0) NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
    DWH_NODE_CD VARCHAR(20) NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
    CONSTRAINT PK_T_PRICE_GROUP_TO_INTERNAL_ORGANIZATION PRIMARY KEY (INT_ORG_SID, PRICE_GRP_SID, DATEFROM)
)COMMENT='Prices in stores and warehouses (delivery companies) are defined based on price groups. This entity relates an internal organization to all applicable price groups. The priority defines which price group is used, in case several prices are defined for one product.'
;