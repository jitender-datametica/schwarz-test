CREATE TABLE IF NOT EXISTS ldl_dig_core.t_dim_packaging_material_component_1 (
pack_material_nr STRING(20) NOT NULL OPTIONS(description='The packaging material number (e..g 420000026,  420000028)'),
dwh_valid_from_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record became valid.'),
dwh_valid_to_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was no longer valid.'),
dwh_valid_fg BOOL NOT NULL OPTIONS(description='An indicator showing the current record in history.'),
pack_compos_group_name STRING(100) NOT NULL OPTIONS(description='Verpackung II'),
pack_compos_type_name STRING(100) NOT NULL OPTIONS(description='Verpackung III'),
ldpcr_compos_kg BIGNUMERIC(38,5)
OPTIONS(description='Weight of used LDPCR (Low Density Post-Consumer-Recycled) in kg (Unit_1).'),
ldpe_compos_kg BIGNUMERIC(38,5) OPTIONS(description='Weight of used LDPE (Low Density Polyethylene) in kg (Unit_1).'),
pp_compos_kg BIGNUMERIC(38,5) OPTIONS(description='Weight of used PP (Polypropylene) in kg (Unit_1).'),
pe_compos_kg BIGNUMERIC(38,5) OPTIONS(description='Weight of used PE (Polyethylene) in kg (Unit_1).'),
thermo_eco_compos_kg BIGNUMERIC(38,5) OPTIONS(description='Weight of used Thermo-Eco-Labels in kg (Unit_1).'),
paper_compos_kg BIGNUMERIC(38,5) OPTIONS(description='Weight of used paper in kg (Unit_1).'),
corrugated_cardboard_kg BIGNUMERIC(38,5)
OPTIONS(description='Weight of used recycelt corrugated fiberboard in kg (Unit_1).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
dwh_src_file_name STRING(255) NOT NULL
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
src_file_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
src_table_name STRING(100) OPTIONS(description='The name of the source tables'),
PRIMARY KEY (pack_material_nr, pack_compos_group_name, pack_compos_type_name) NOT ENFORCED
)
OPTIONS(description='This dimension defines the packaging material information (sourced from the product master data starting with 400..)');