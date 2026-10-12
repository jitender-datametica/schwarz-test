/* --------------------------------------------------------------------------------
   DDL for table: t_pallet_type_1
   generated from Powerdesigner on Montag, 8. Juli 2024 09:18:59
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_PALLET_TYPE_1 (
   pallet_type_cd                      VARCHAR(20)     NOT NULL COMMENT 'The code identifying the kind of pallet. (Euro-pallet vs. Duesseldorfer pallet)',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   pallet_type_descr                   VARCHAR(250)    NOT NULL COMMENT 'A textual description for the kind of pallet.',
   pallet_space_factor                 NUMBER(38, 5)   COMMENT 'The ratio of the floor space consumed by this palett type compared with the floor space of a Euro palett. E.g. 0,5 für a Duesseldorfer palett.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_PALLET_TYPE PRIMARY KEY (pallet_type_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the various types of pallets, E.g. Euro-pallets and Duesseldorfer pallets.';
