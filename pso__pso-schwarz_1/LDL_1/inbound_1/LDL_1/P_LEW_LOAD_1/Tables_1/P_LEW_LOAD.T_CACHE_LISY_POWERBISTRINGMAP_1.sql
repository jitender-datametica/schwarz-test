CREATE TABLE p_lew_load.t_cache_lisy_powerbistringmap_1 (
  client_id NUMBER(38,0),
  src_deleted VARCHAR(10),
  src_id VARCHAR(250) NOT NULL,
  src_sinkcreatedon TIMESTAMP_NTZ(6),
  src_sinkmodifiedon TIMESTAMP_NTZ(6),
  src_statecode NUMBER(38,0),
  src_orb_objecttypecode NUMBER(38,0),
  src_orb_entitytypename VARCHAR(100),
  src_orb_attributename VARCHAR(100),
  src_orb_attributevalue NUMBER(38,0),
  src_orb_label VARCHAR(400),
  src_langid_iso VARCHAR(50),
  tgt_ref_code NUMBER(38,0),
  tgt_ref_text VARCHAR(1000),
  dwh_load_id NUMBER(38,0) NOT NULL,
  dwh_created TIMESTAMP_NTZ(9) NOT NULL,
  dwh_updated TIMESTAMP_NTZ(9) NOT NULL
);