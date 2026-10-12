CREATE TABLE core_rel.T_ADDRESS_DEMOGRAPHICS_2 (
   addr_sid                            NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the postal address.',
   demographics_type_cd                VARCHAR(20)     NOT NULL COMMENT 'The code identifying the type of statistical information.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   demographic_meas                    NUMBER(38, 5)   NOT NULL COMMENT 'The value of the statistical information which has been collected for this address.',
   uom_cd                              VARCHAR(20)      COMMENT 'The code identifying the unit_2 of measure.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_ADDRESS_DEMOGRAPHICS PRIMARY KEY (demographics_type_cd, addr_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'Several statistical informations can be collected on an address_2, such as the number of inhabitants in its vicinity. The type of information is defined by the demographic type';