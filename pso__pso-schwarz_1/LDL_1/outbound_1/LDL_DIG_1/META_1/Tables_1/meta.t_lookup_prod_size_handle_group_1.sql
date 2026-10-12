CREATE TABLE IF NOT EXISTS ldl_dig_meta.t_lookup_prod_size_handle_group_1 (
wshop_cd STRING(10) NOT NULL,
length_uom_cd STRING(10),
weight_uom_cd STRING(10),
maxsize_kt_limit BIGNUMERIC(38,5),
minsize_kt_limit BIGNUMERIC(38,5),
midsize_kt_limit BIGNUMERIC(38,5),
maxsize_gt_limit BIGNUMERIC(38,5),
minsize_gt_limit BIGNUMERIC(38,5),
midsize_gt_limit BIGNUMERIC(38,5),
weight_kt_limit BIGNUMERIC(38,5),
weight_gt_limit BIGNUMERIC(38,5),
girth_kt_limit BIGNUMERIC(38,5),
girth_gt_limit BIGNUMERIC(38,5),
tmsp_insert TIMESTAMP,
tmsp_update TIMESTAMP,
PRIMARY KEY (wshop_cd) NOT ENFORCED
);