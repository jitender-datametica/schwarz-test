/* --------------------------------------------------------------------------------
   DDL for table: T_LOT_DESTINATION
   generated from Powerdesigner on Montag, 22. April 2024 11:13:49
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_lot_destination (
lot_product_instance_group_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the lot.'),
shipping_destination_cd STRING(50) NOT NULL
OPTIONS(description='The code identifying a political country according to ISO 3166.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
delivery_week_start_dt DATE OPTIONS(description='Descriptive Attribute - Delivery week of country (ODW)'),
shifted_delivery_week_start_dt DATE
OPTIONS(description='Descriptive Attribute - ODW (official delivery week) plus x weeks ("shifted" ODW)'),
shipping_mark_txt STRING(1000) OPTIONS(description='Descriptive Attribute - Logistics info code sent from SAP'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (lot_product_instance_group_sid, dwh_valid_from_tmsp, shipping_destination_cd) NOT ENFORCED
) OPTIONS(description='Satellite table  - A shipment of particular product to a particular destination  - Source - VMT');