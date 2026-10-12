CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_tf_z_ds_zmmx_eks_2_supplier_eks_hist (
client_id BIGNUMERIC(38),
lidl_country STRING(40),
z_ds_zmmx_eks_eksnr INTEGER,
z_ds_zmmx_eks_lifnr STRING(20),
src_lifnr STRING(40),
eks_no BIGNUMERIC(38),
deleted_fg BIGNUMERIC(38),
extraction_dt DATE,
dwh_mapping_dt DATE,
tf_error_fg INTEGER,
record_id INTEGER,
filename STRING(1000)
);