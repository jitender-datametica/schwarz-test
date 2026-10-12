CREATE TABLE meta.t_lookup_general_mapping_1 (
  target_core_field VARCHAR(50) NOT NULL,
  target_core_value VARCHAR(200),
  source_System     VARCHAR(30) NOT NULL,
  source_Client     VARCHAR(5) NOT NULL,
  source_field_1    VARCHAR(50) NOT NULL,
  source_value_1    VARCHAR(200) NOT NULL,
  source_field_2    VARCHAR(50),
  source_value_2    VARCHAR(200),
  source_field_3    VARCHAR(50),
  source_value_3    VARCHAR(200),
  check_Key         VARCHAR(1000),
  check_Count       NUMBER(38, 0),
  TMSP_INSERT       TIMESTAMP_LTZ(9),
  TMSP_UPDATE       TIMESTAMP_LTZ(9),
CONSTRAINT pk_t_lookup_general_mapping PRIMARY KEY ( target_core_field, source_System, source_Client, source_field_1, source_value_1 )     
);