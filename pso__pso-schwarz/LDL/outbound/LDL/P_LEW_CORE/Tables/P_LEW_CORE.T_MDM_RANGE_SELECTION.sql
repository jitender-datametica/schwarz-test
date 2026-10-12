CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_range_selection (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
mdm_range_sel_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key NFPO range selection            CBX: CNT_PROGRAM.REF_NO'),
src_prog_doc_ref STRING(20) COLLATE 'und:ci' NOT NULL
OPTIONS(description='identifier of the NFPO range selection            CBX: CNT_PROGRAM.REF_NO'),
range_plan_cd STRING(20) COLLATE 'und:ci'
OPTIONS(description='logical  identifier of the NFPO range selection: sometimes technically 2 records for a logical range selection exist, but only one is active            CBX: CNT_PROGRAM.PROGRAM_NO'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_range_sel_sid) NOT ENFORCED
) OPTIONS(description='NFPO quarterly waves to define and order items             CBX: CNT_PROGRAM');