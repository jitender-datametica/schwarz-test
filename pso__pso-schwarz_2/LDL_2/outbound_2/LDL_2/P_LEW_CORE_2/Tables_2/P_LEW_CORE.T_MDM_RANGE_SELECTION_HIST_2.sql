CREATE TABLE IF NOT EXISTS ldl_p_lew_core.t_mdm_range_selection_hist_2 (
client_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical column required by the used ETL framework            static 7 for all rows'),
mdm_range_sel_sid BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='surrogate key NFPO range selection            CBX: CNT_PROGRAM.REF_NO'),
cbx_prog_version_nr BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='technical version of the NFPO range selection in the source system            CBX: CNT_PROGRAM.VERSION'),
cbx_prog_doc_status STRING(100) COLLATE 'und:ci'
OPTIONS(description='technical status_2 of the NFPO range selection in the source system (active,inactive,cancelled)            CBX: CNT_PROGRAM.DOC_STATUS'),
cbx_prog_change_tmsp DATETIME NOT NULL
OPTIONS(description='change timestamp of NFPO range selection record in the source system            CBX: CNT_PROGRAM.UPDATED_ON'),
range_selection_active_fg BIGNUMERIC(38,0)
OPTIONS(description='flag to mark the currently active range selection. Only one logical range selection can be active.            CBX: CTM_PROGRAM.CUST_CODELIST5'),
cy_month_range_selection BIGNUMERIC(38,0)
OPTIONS(description='range selection month            CBX: CNT_PROGRAM.YEAR, PERIOD'),
range_selection_end_dt DATE OPTIONS(description='end date of the range selection            CBX: CNT_PROGRAM.END_DATE'),
cy_week_range_deliver_from BIGNUMERIC(38,0)
OPTIONS(description='range deliver from calendar_2 week            CBX: CTM_PROGRAM.CUST_CODELIST1'),
cy_week_range_deliver_to BIGNUMERIC(38,0)
OPTIONS(description='range deliver to calendar_2 week            CBX: CTM_PROGRAM.CUST_CODELIST2'),
cy_week_range_advertise_from BIGNUMERIC(38,0)
OPTIONS(description='range advertise from calendar_2 week            CBX: CTM_PROGRAM.CUST_CODELIST3'),
cy_week_range_advertise_to BIGNUMERIC(38,0)
OPTIONS(description='range advertise to calendar_2 week            CBX: CTM_PROGRAM.CUST_CODELIST4'),
deleted_fg BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to '),
dwh_valid_from DATE NOT NULL
OPTIONS(description='begin of the validity_2 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)'),
dwh_valid_to DATE NOT NULL
OPTIONS(description='end of the validity_2 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='identifier of the last run which inserted or updated the record'),
dwh_created DATETIME NOT NULL OPTIONS(description='creation timestamp of the record in the DWH'),
dwh_updated DATETIME NOT NULL OPTIONS(description='timestamp of the last update of the record in the DWH'),
PRIMARY KEY (mdm_range_sel_sid, dwh_valid_from) NOT ENFORCED
) OPTIONS(description='NFPO quarterly waves to define and order items             CBX: CNT_PROGRAM');