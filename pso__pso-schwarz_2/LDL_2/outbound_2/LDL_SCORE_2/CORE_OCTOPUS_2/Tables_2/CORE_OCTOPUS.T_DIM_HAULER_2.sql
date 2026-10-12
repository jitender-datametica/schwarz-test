CREATE TABLE IF NOT EXISTS ldl_score_core_octopus.t_dim_hauler_2 (
hauler_sid BIGNUMERIC NOT NULL OPTIONS(description='The unique identifier (surrogate key) for the hauler'),
hauler_nr STRING(20) OPTIONS(description='The number which identifies the hauler in '),
hauler_name STRING(100) OPTIONS(description='The name of the hauler'),
hauler_short_name STRING(100) OPTIONS(description='The short name of the hauler (Cargo: Kurzbezeichnung).'),
hauler_abbr_name STRING(100) OPTIONS(description='Shortcut for hauler_name'),
vat_nr STRING(20) OPTIONS(description='The vat number (Umsatzsteuer ID). '),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last updated.'),
PRIMARY KEY (hauler_sid) NOT ENFORCED
)
OPTIONS(description='Pickups products from one place to another via a vehicle (LKW, Schiff..).              A crossdock is run by one hauler but one hauler can run many crossdocks. ');