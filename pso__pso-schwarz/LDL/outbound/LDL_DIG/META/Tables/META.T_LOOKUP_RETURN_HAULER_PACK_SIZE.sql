CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_lookup_return_hauler_pack_size (
hauler_name STRING(100) NOT NULL,
hauler_country_cd STRING(5),
is_2mh_hauler_fg BOOL,
tmsp_insert TIMESTAMP,
tmsp_update TIMESTAMP,
PRIMARY KEY (hauler_name) NOT ENFORCED
);