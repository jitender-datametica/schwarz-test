CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_means_of_transport_2 (
means_of_transport_cd STRING(20) NOT NULL
OPTIONS(description='Means of transport of the delivery. e.g. (LKW, LKW_KL, LKW_KT...)'),
means_of_transport_descr STRING(100)
OPTIONS(description='A textual description for the means_of_transport_cd written out in group language (German).'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (means_of_transport_cd) NOT ENFORCED
)
OPTIONS(description='This table contains how the goods are transported. Either by a truck (LKW), Kühltrocken-LKW, Kühl_2-LKW, Waggon or Container. ');