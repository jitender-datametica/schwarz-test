/* --------------------------------------------------------------------------------
   DDL for table: t_post_box_address_1
   generated from Powerdesigner on Dienstag, 17. Januar 2023 11:08:08
*/ --------------------------------------------------------------------------------

CREATE TABLE core_rel.T_POST_BOX_ADDRESS_1 (
   po_box_addr_sid                     NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the post office box address.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   country_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the country.',
   iso_country_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code identifying the country_1 according to ISO 3166.',
   postal_cd_area_sid                  NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the postal code area, in which the post office box is located.',
   zip                                 VARCHAR(15)     NOT NULL COMMENT 'A code used by the postal service to identify a geographical area. E.g. 74072 for Heilbronn in Germany',
   po_box_nr                           VARCHAR(20)     NOT NULL COMMENT 'The number of a post office box, i.e. of a place managed by a post office where mail can be collected.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT AK_ALTERNATE_KEY_T_POST_B UNIQUE (iso_country_cd, zip, po_box_nr)
       NOT enforced,
   CONSTRAINT PK_T_POST_BOX_ADDRESS PRIMARY KEY (po_box_addr_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'A post office box is a place managed by a post office where mail can be collected.';