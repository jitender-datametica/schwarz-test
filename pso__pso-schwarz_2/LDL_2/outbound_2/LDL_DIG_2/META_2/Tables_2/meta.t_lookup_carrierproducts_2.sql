CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_lookup_carrierproducts_2 (
carrier STRING(100),
product STRING(100),
weight_min BIGNUMERIC(38,5),
weight_max BIGNUMERIC(38,5),
size_min1 BIGNUMERIC(38,5),
size_min2 BIGNUMERIC(38,5),
size_min3 BIGNUMERIC(38,5),
size_max1 BIGNUMERIC(38,5),
size_max2 BIGNUMERIC(38,5),
size_max3 BIGNUMERIC(38,5),
girth_min BIGNUMERIC(38,5),
girth_max BIGNUMERIC(38,5),
volume_min BIGNUMERIC(38,5),
volume_max BIGNUMERIC(38,5),
gultig_ab DATE,
tmsp_insert TIMESTAMP,
tmsp_update TIMESTAMP
);