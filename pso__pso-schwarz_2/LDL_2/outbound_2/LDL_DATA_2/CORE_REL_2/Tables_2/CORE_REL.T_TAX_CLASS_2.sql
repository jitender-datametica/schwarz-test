/* --------------------------------------------------------------------------------
   DDL for table: t_tax_class_2
   generated from Powerdesigner on Mittwoch, 22. Februar 2023 17:05:03
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_data_core_rel.t_tax_class_2 (
tax_class_cd STRING(20) NOT NULL OPTIONS(description='The code for the tax class, e.g. Reduced VAT Rate.'),
geo_area_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the geographical area to which the tax class applies.'),
tax_class_descr STRING(250) NOT NULL OPTIONS(description='A textual description for the tax class.'),
tax_type_cd STRING(20) NOT NULL OPTIONS(description='The code identifying the kind of tax. (E.g. VAT)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)'),
dwh_node_cd STRING(20) NOT NULL
OPTIONS(description='The code for the source system (or slice of source system) from which this record was loaded.'),
PRIMARY KEY (tax_class_cd, geo_area_sid) NOT ENFORCED
)
OPTIONS(description='For a given type of tax (e.g. VAT) the tax class defines the percentage. E.g. there is a standard VAT rate and a reduced rate for food. The tax class is specific to a geographical area, typically a country_2, but may also be related to other levels of the geographical hierarchie. E.g. city or county tax in the USA, or a reduced VAT rate which applies to some islands in Greece. The actual percentage value may change over time, therefore it is tracked in a separate entity.');