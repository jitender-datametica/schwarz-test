CREATE TABLE core_rel.T_PARTY_ADDRESS_1 (
   party_sid                           NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the party.',
   addr_sid                            NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier (surrogate key) for the address.',
   addr_usg_type_cd                    VARCHAR(20)     NOT NULL COMMENT 'The code for the way how an address_1 is used. E.g. an address_1 may be used for the customer entrance for a store, and another one for the deliveries.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   party_type_cd                       VARCHAR(20)     NOT NULL COMMENT 'The code identifying the discriminator for parties.',
   addr_type_cd                        VARCHAR(20)     NOT NULL COMMENT 'The code identifying the discriminator for addresses.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PARTY_ADDRESS PRIMARY KEY (addr_usg_type_cd, addr_sid, party_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'This entity stores the address_1(es) of a party. A party might have more than one address_1, e.g. an official street address_1, a primary telephone number or one or several mobile phone number. The type of address_1 is defined by the address_1 usage type.';
