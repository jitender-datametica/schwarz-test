CREATE OR REPLACE TABLE szd_production_core_rel.t_lot_destination_metric (
lot_product_instance_group_sid INTEGER NOT NULL
OPTIONS(description='The unique identifier (surrogate key) for the lot.'),
shipping_destination_cd STRING(50) NOT NULL
OPTIONS(description='The code identifying a political country according to ISO 3166.'),
metric_type_cd STRING(50) NOT NULL
OPTIONS(description='Type of the measure for lot ( for example BOOKED_PIECE_PER_CARTON, NOM_TOT_CARTON, ...)'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
uom_cd STRING(50) OPTIONS(description='The code identifying the unit of measure.'),
metric_meas NUMERIC(29,5) OPTIONS(description='Measure - Value of selected metrics for a lot'),
metric_qty NUMERIC(29,5) OPTIONS(description='Measure -Measure -Value of selected metrics for a lot (quantity)'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (lot_product_instance_group_sid, metric_type_cd, shipping_destination_cd, dwh_valid_from_tmsp) NOT ENFORCED
)
OPTIONS(description='Satellite entity - A table that contains different measures and metric associated with lot - Source - VMT');