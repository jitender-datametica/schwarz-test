/* --------------------------------------------------------------------------------
   DDL for table: t_logistic_variant_size_2
   generated from Powerdesigner on Freitag, 17. November 2023 11:38:46
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LOGISTIC_VARIANT_SIZE_2 (
   prod_variant_sid                    NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for a logistic variant of a product.',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record became valid.',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was no longer valid.',
   dwh_valid_fg                        BOOLEAN         NOT NULL COMMENT 'An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.',
   length_meas                         NUMBER(38, 5)   COMMENT 'The length of the logistic variant, expressed in the indicated unit_2 of measure.',
   width_meas                          NUMBER(38, 5)   COMMENT 'The width of the logistic variant, expressed in the indicated unit_2 of measure.',
   height_meas                         NUMBER(38, 5)   COMMENT 'The height of the logistic variant, expressed in the indicated unit_2 of measure.',
   size_uom_cd                         VARCHAR(20)     COMMENT 'The code identifying the unit_2 of measure for the length, width and height.',
   net_weight_meas                     NUMBER(38, 5)   COMMENT 'The net weight (i.e. excluding packing material) of the logistic variant, expressed in the indicated unit_2 of measure.',
   gross_weight_meas                   NUMBER(38, 5)   COMMENT 'The gross weight (i.e. including packing material) of the logistic variant, expressed in the indicated unit_2 of measure.',
   weight_uom_cd                       VARCHAR(20)     COMMENT 'The code identifying the unit_2 of measure.',
   units_per_pallet_cnt                NUMBER(38, 0)   COMMENT 'The number of logistic variants which can be packed on a pallet. (The type of pallet is indicated by the Pallet Type Code.)',
   units_per_pallet_layer_cnt          NUMBER(38, 0)   COMMENT 'The number of logistic variants which can be packed on one layer of a pallet. (The type of pallet is indicated by the Pallet Type Code.)',
   pallet_type_cd                      VARCHAR(20)     COMMENT 'The code identifying the kind of pallet. (Euro-pallet vs. Duesseldorfer pallet)',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_LOGISTIC_VARIANT_SIZE PRIMARY KEY (prod_variant_sid, dwh_valid_from_tmsp) NOT ENFORCED
 )  COMMENT= 'This entity tracks the physical size and weight of a logistic variant.';

