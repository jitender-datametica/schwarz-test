CREATE TABLE p_lew_core.t_ref_customer_complaint_metric_type (
cust_complaint_metric_type_cd       VARCHAR(20)     NOT NULL COMMENT 'Type of the measure for customer compaint case ( for example Total Number Of Calls )',
cust_complaint_metric_type_desc     VARCHAR(100)    NOT NULL COMMENT 'Type of the measure for customer compaint case ( for example Total Number Of Calls )',
dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'Identifier des letzten Ladelaufs, der den Datensatz eingfuegt oder veraendert hat',
dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfuegung des Datensatzes ins DWH',
dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH',
CONSTRAINT model_run_metric_pk PRIMARY KEY (cust_complaint_metric_type_cd) NOT ENFORCED
) COMMENT = 'A reference table to store the description of available customer complaint metrics.'
;