CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_lookup_prod_pack_size_group (
wshop_cd STRING(5) NOT NULL,
length_uom_cd STRING(5) NOT NULL,
weight_uom_cd STRING(5) NOT NULL,
longest_length_meas_2mh BIGNUMERIC(38,5),
girth_meas_2mh BIGNUMERIC(38,5),
weight_meas_2mh BIGNUMERIC(38,5),
side_1_2mh BIGNUMERIC(38,5),
side_2_2mh BIGNUMERIC(38,5),
side_3_2mh BIGNUMERIC(38,5),
tmsp_insert TIMESTAMP,
tmsp_update TIMESTAMP,
PRIMARY KEY (wshop_cd, length_uom_cd, weight_uom_cd) NOT ENFORCED
);