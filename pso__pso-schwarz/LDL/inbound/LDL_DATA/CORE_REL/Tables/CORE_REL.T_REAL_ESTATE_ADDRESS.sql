CREATE TABLE core_rel.T_REAL_ESTATE_ADDRESS (
   real_estate_sid                     NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the real estate object.',
   addr_sid                            NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the address of the real estate object. This may be a street address, a phone number or an email address.',
   addr_usg_type_cd                    VARCHAR(20)      NOT NULL COMMENT 'The code for the way how an address is used. E.g. an address may be used for the customer entrance for a store, and another one for the deliveries.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   addr_type_cd                        VARCHAR(20)      NOT NULL COMMENT 'The code identifying the discriminator for addresses.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_REAL_ESTATE_ADDRESS PRIMARY KEY (addr_usg_type_cd, addr_sid, real_estate_sid, dwh_valid_from_tmsp) NOT ENFORCED
)  COMMENT= 'This entity stores the address(es) of a real estate object. An object might have more than one address, e.g. an official address, the customer entrance and the delivery entrance. The type of address is defined by the address usage type.';
