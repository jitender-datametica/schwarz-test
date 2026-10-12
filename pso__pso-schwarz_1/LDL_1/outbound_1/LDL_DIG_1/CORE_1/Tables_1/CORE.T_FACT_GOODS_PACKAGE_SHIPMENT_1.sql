/* --------------------------------------------------------------------------------
   DDL FOR TABLE: T_FACT_GOODS_PACKAGE_SHIPMENT_1
   GENERATED FROM POWERDESIGNER ON Mittwoch, 16. Oktober 2024 15:50:44
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_dig_core.t_fact_goods_package_shipment_1 (
pack_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier(surrogate key) of the package_1'),
pack_order_nr STRING(20) NOT NULL
OPTIONS(description='Order number within warehouse system, which tells which articles are part of which package_1'),
pack_tracking_nr STRING(1000)
OPTIONS(description='ID, whcih links the shipment to customer with the actual package_1 and can also be searched for within the the carrier url'),
pack_tracking_url STRING(500)
OPTIONS(description='The URL which can be used in the browser to get all customer information which the carrier/hauler is providing to the customer'),
ewm_pack_sid BIGNUMERIC(38,0)
OPTIONS(description='The unique identifier (surrogate key) for the package_1 based on the EWM API data. This surrogate key is generated based on ewm_pack_nr and pack_tracking_nr.'),
ewm_pack_nr STRING(50)
OPTIONS(description='The warehouse (SAP EWM) system number which is being used to search within the EWM system'),
delivery_order_sid BIGNUMERIC OPTIONS(description='The unique identifier (surrogate key) for delivery order '),
pack_order_actual_create_tmsp TIMESTAMP
OPTIONS(description='Technical timestamp when the order has been created within EWM (warehouse system). This also indicates when the TrackingId has been created and is therefore the start of a Shipment'),
pack_material_nr STRING(20) OPTIONS(description='The packaging material number (e..g 420000026,  420000028)'),
pack_volume_uom_sid BIGNUMERIC OPTIONS(description='Package_1 volume unit_1 of measure'),
pack_volume_meas BIGNUMERIC(38,5) OPTIONS(description='Package_1 volume'),
pack_height_uom_sid BIGNUMERIC OPTIONS(description='Package_1 height unit_1 of measure'),
pack_height_meas BIGNUMERIC(38,5) OPTIONS(description='Package_1 height'),
pack_weight_uom_sid BIGNUMERIC OPTIONS(description='Package_1 weight unit_1 of measure'),
pack_weight_meas BIGNUMERIC(38,5) OPTIONS(description='Package_1 weight'),
pack_width_uom_sid BIGNUMERIC OPTIONS(description='Package_1 width unit_1 of measure'),
pack_width_meas BIGNUMERIC(38,5) OPTIONS(description='Package_1 width'),
pack_longest_length_meas BIGNUMERIC(38,5) OPTIONS(description='Package_1 length longest value'),
pack_shortest_length_meas BIGNUMERIC(38,5) OPTIONS(description='Package_1 length shortest value'),
pack_mean_length_meas BIGNUMERIC(38,5) OPTIONS(description='Package_1 length mean_1 value'),
pack_length_uom_sid BIGNUMERIC OPTIONS(description='Package_1 length unit_1 of measure'),
pack_length_meas BIGNUMERIC(38,5) OPTIONS(description='Package_1 length'),
pack_girth_uom_sid BIGNUMERIC OPTIONS(description='Package_1 girth unit_1 of measure'),
pack_girth_east_meas BIGNUMERIC(38,5) OPTIONS(description='Package_1 girth east'),
pack_girth_west_meas BIGNUMERIC(38,5) OPTIONS(description='Package_1 girth West'),
is_productsize_used_fg BOOL
OPTIONS(description='Discriminator which tells whether trackingId is using Article sizes or is within a Package_1 and therefore the package_1 size'),
delivery_order_nr STRING(20) OPTIONS(description='Delivery order number '),
pack_volume_uom_cd STRING(5) OPTIONS(description='A code for the unit_1 of measure for volume'),
pack_height_uom_cd STRING(5) OPTIONS(description='A code for the unit_1 of measure for height'),
pack_weight_uom_cd STRING(5) OPTIONS(description='A code for the unit_1 of measure for weight'),
pack_width_uom_cd STRING(5) OPTIONS(description='A code for the unit_1 of measure for width'),
pack_length_uom_cd STRING(5) OPTIONS(description='A code for the unit_1 of measure for length'),
pack_girth_uom_cd STRING(5) OPTIONS(description='A code for the unit_1 of measure for girth'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (pack_sid) NOT ENFORCED
)
OPTIONS(description='The transactional fact that holds the package_1 shipment details ( including dropshipments)             Same granularity and main source as T_FACT_SALES_PACKAGE_SHIPMENT_1, however this table contains less details (fewer cols) but for all package_1 shipments.             Delivery Order SID can be used to link this table to T_FACT_GOODS_MOVEMENT_1 ( Delivery Orders) and see additional details, like "is this dropshipment or not"                          Main Src - SAP ERP, table VEKP');