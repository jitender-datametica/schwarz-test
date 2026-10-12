/* --------------------------------------------------------------------------------
   DDL for table: t_ref_counting_reason
   generated from Powerdesigner on Wednesday, February 28, 2024 11:38:16 AM
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_ref_counting_reason (
cnt_reason_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='id of the counting reason for stock correction requests'),
cnt_reason_descr STRING(100) OPTIONS(description='description of the counting reason for stock correction requests'),
cnt_reason_descr_en STRING(100)
OPTIONS(description='english description of the counting reason for stock correction requests'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='Identifier of the last run which inserted or updated the record. -1 means manually inserted.'),
dwh_created DATETIME NOT NULL OPTIONS(description='Creation timestamp of the record in the DWH.'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Timestamp of the last update of the record in the DWH.'),
PRIMARY KEY (cnt_reason_id) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. table contains known reasons for counting requests             Source: static');