CREATE OR REPLACE TABLE ldl_data_production_core_rel.t_wawi_item_variant_tax_exception_1 (
wawi_item_variant_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) of the Wawi item_1 variant.'),
int_org_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the internal organization to which non-standard taxation rules apply.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
geo_area_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the geographical area to which the tax class applies.'),
tax_class_cd STRING(20) NOT NULL OPTIONS(description='The code for the tax class, e.g. Reduced VAT Rate.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id INTEGER NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (wawi_item_variant_sid, int_org_sid, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Different tax rules may apply to specific internal organizations, e.g. because a store is located in a tax enclave. In this case a different VAT rate applies. This entity lists all internal organizations together with their related tax classes, which deviate from the standard taxation rules defined in the Wawi Item_1 Variant Tax entity.');