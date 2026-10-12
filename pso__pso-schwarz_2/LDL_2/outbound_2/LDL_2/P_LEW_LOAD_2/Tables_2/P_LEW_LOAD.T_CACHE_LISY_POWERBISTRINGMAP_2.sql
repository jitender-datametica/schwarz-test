CREATE TABLE IF NOT EXISTS ldl_p_lew_load.t_cache_lisy_powerbistringmap_2 (
client_id BIGNUMERIC(38,0),
src_deleted STRING(10),
src_id STRING(250) NOT NULL,
src_sinkcreatedon DATETIME,
src_sinkmodifiedon DATETIME,
src_statecode BIGNUMERIC(38,0),
src_orb_objecttypecode BIGNUMERIC(38,0),
src_orb_entitytypename STRING(100),
src_orb_attributename STRING(100),
src_orb_attributevalue BIGNUMERIC(38,0),
src_orb_label STRING(400),
src_langid_iso STRING(50),
tgt_ref_code BIGNUMERIC(38,0),
tgt_ref_text STRING(1000),
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);