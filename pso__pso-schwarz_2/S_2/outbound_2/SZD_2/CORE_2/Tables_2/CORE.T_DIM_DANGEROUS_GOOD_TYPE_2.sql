/* --------------------------------------------------------------------------------
   DDL for table: T_DIM_DANGEROUS_GOOD_TYPE_2
   generated from Powerdesigner on Montag, 22. April 2024 11:13:50
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core.t_dim_dangerous_good_type_2 (
dangerous_good_type_cd STRING(50) NOT NULL
OPTIONS(description='Natural Key/Business Key - The classification of transported good as Dangerous Goods (SDB (Gefahrgut), Kein SDB )'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created or last updated.'),
dwh_src_file_name STRING(500)
OPTIONS(description='The path and the name of the file(s) from which this record was loaded.'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was extracted from the source.'),
PRIMARY KEY (dangerous_good_type_cd) NOT ENFORCED
)
OPTIONS(description='Minor Dimension - Contains the classification of transported good as Dangerous Goods or not (are batteries contained for example). - Source - VMT');