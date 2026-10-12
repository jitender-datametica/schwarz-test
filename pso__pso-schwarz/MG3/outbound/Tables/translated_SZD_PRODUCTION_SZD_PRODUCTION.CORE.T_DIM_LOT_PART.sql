CREATE OR REPLACE TABLE szd_production_core.t_dim_lot_part (
product_instance_group_sid INTEGER NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the lot.'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL
OPTIONS(description='An indicator showing the current record, i.e. where the current date is between dwh_valid_from and dwh_valid_to.'),
lot_part_status_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The status code for the lot part'),
lot_product_instance_group_sid INTEGER NOT NULL
OPTIONS(description='Natural Key/Business Key - The unique identifier (surrogate key) for the lot.'),
shipping_destination_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The code identifying a political country according to ISO 3166.'),
lob_cd STRING(50) NOT NULL
OPTIONS(description='The code for the line of business within the Schwarz Group, i.e.Lidl or Kaufland\n            lob=line os business'),
gtin_nr STRING(50) OPTIONS(description='Descriptive Attribute - GTIN'),
spare_unit_fg BOOL NOT NULL OPTIONS(description='Indication if spare unit or not'),
shipped_carton_qty NUMERIC(29,5)
OPTIONS(description='Fact - additive - Amount of cartons that were shipped ( same as produced )'),
piece_per_carton_qty NUMERIC(29,5)
OPTIONS(description='Fact - additive - Units / pieces per carton. For example there can be 20 T-Shirts in a box -> PCS/Carton = 20'),
length_m_meas NUMERIC(29,5) OPTIONS(description='Measure - Length dimensions of a shipped carton '),
width_m_meas NUMERIC(29,5) OPTIONS(description='Measure - Width dimensions of a shipped carton '),
height_m_meas NUMERIC(29,5) OPTIONS(description='Measure - Height dimensions of a shipped carton '),
net_weight_kg_qty NUMERIC(29,5)
OPTIONS(description='Fact - additive - Cartons are measured and weightened in the warehouse. Net weight is the goods without the carton'),
gross_weight_kg_qty NUMERIC(29,5)
OPTIONS(description='Fact - additive -Weight of a complete carton as it will be put in a container'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (product_instance_group_sid, dwh_valid_from_tmsp) NOT ENFORCED
) OPTIONS(description='Major Dimension - A shipment of particular product variant. - Source - VMT');