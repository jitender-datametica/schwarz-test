CREATE OR REPLACE TABLE ldl_data_production_core_dim.t_dim_logistic_variant (
logistic_variant_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for a logistic variant of a product.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
logistic_variant_nr STRING(20) OPTIONS(description='The number by which the logistic variant is known to business.'),
logistic_variant_name STRING(500) NOT NULL OPTIONS(description='The name of the logistic variant.'),
logistic_variant_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the subtype discriminator for logistic variants.'),
logistic_variant_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the subtype discriminator for logistic variants. (Description in group language, i.e. in German)'),
prod_variant_status_cd STRING(20) NOT NULL
OPTIONS(description='A code that defines the lifecycle status of the logistic variant,'),
prod_variant_status_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the status code of a product variant in group language, i.e. in German.'),
case_size_cnt INTEGER NOT NULL
OPTIONS(description='The number of individual items that are contained in the logistic variant. (Note that the individual item represents the smallest sellable unit. E.g. if a packed try of meat contains two slices, the entire tray is considered one sellable unit.)'),
weight_based_fg BOOL NOT NULL
OPTIONS(description='An indicator showing, if the product variant is delivered by weight instead of count.'),
length_meas NUMERIC(29,5)
OPTIONS(description='The length of the logistic variant, expressed in the indicated unit of measure.'),
width_meas NUMERIC(29,5)
OPTIONS(description='The width of the logistic variant, expressed in the indicated unit of measure.'),
height_meas NUMERIC(29,5)
OPTIONS(description='The height of the logistic variant, expressed in the indicated unit of measure.'),
size_uom_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the unit of measure for the length, width and height.'),
net_weight_meas NUMERIC(29,5)
OPTIONS(description='The net weight (i.e. excluding packing material) of the logistic variant, expressed in the indicated unit of measure.'),
gross_weight_meas NUMERIC(29,5)
OPTIONS(description='The gross weight (i.e. including packing material) of the logistic variant, expressed in the indicated unit of measure.'),
weight_uom_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the unit of measure.'),
units_per_pallet_cnt INTEGER
OPTIONS(description='The number of logistic variants which can be packed on a pallet. (The type of pallet is indicated by the Pallet Type Code.)'),
units_per_pallet_layer_cnt INTEGER
OPTIONS(description='The number of logistic variants which can be packed on one layer of a pallet. (The type of pallet is indicated by the Pallet Type Code.)'),
pallet_type_cd STRING(20) NOT NULL
OPTIONS(description='The code identifying the kind of pallet. (Euro-pallet vs. Duesseldorfer pallet)'),
pallet_type_descr STRING(250) NOT NULL
OPTIONS(description='A textual description for the kind of pallet. (Description in group language, i.e. in German)'),
prod_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the product, which is the base for this logistic variant.'),
prod_nr STRING(20)
OPTIONS(description='The number which (globally) identifies the product which is the base for this logistic variant, within the organization. (Note that the product number is unique for a certain point in time, but may be re-used later on.)'),
prod_name STRING(250) NOT NULL
OPTIONS(description='The name of the global product, which is the base for this logistic variant.'),
item_fam_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the item family, which contains this logistic variant.'),
item_fam_nr STRING(100) OPTIONS(description='The number by which the related item family is known to business.'),
item_fam_name STRING(100) NOT NULL
OPTIONS(description='The name of the related item family in group language, i.e. in German.'),
sub_item_grp_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the sub item group, which contains this logistic variant.'),
sub_item_grp_nr STRING(100) OPTIONS(description='The number by which the related sub item group is known to business.'),
sub_item_grp_name STRING(100) NOT NULL
OPTIONS(description='The name of the related sub item group in group language, i.e. in German.'),
int_item_grp_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the international item group, which contains this logistic variant.'),
int_item_grp_nr STRING(100)
OPTIONS(description='The number by which the related international item group is known to business.'),
int_item_grp_name STRING(100) NOT NULL
OPTIONS(description='The name of the related international item group in group language, i.e. in German.'),
pillar_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the pillar, which contains this logistic variant.'),
pillar_nr STRING(100) OPTIONS(description='The number by which the related pillar is known to business.'),
pillar_name STRING(100) NOT NULL
OPTIONS(description='The name of the related pillar in group language, i.e. in German.'),
main_pillar_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the main pillar, which contains this logistic variant.'),
main_pillar_nr STRING(100) OPTIONS(description='The number by which the related main pillar is known to business.'),
main_pillar_name STRING(100) NOT NULL
OPTIONS(description='The name of the related main pillar in group language, i.e. in German.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (logistic_variant_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='A logistic variant describes how a product is packed and transported. Typically it is not individual items that are shipped from the supplier to the warehouse and from the warehouse to the store, but larger quantities of identical items are bundled into packets, e.g. cardboard boxes.The case size determines, how many items are contained in such a box.');