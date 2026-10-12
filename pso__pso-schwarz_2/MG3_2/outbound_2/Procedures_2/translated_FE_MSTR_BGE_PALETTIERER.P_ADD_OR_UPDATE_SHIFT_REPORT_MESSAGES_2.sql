CREATE OR REPLACE PROCEDURE production_production_fe_mstr_bge_palettierer.p_add_or_update_shift_report_messages(
    IN ALERTS_DAY_SHIFT_ID FLOAT64,
    IN ALERTS_SHIFT_REPORT_AGREEMENT_TXT STRING,
    IN ALERTS_SHIFT_REPORT_NEXT_SHIFT_TXT STRING,
    IN ALERTS_SHIFT_REPORT_OUT_OF_ORDER_TXT STRING,
    IN ALERTS_SHIFT_REPORT_SECURITY_ISSUES STRING
)
BEGIN

DECLARE sql_command STRING;
DECLARE sql_commit STRING;
BEGIN TRANSACTION;
SET sql_command  =  '''
MERGE INTO production_production_core.t_fact_alerts_shift_report_per_shift_2 as tgt1 
USING (
    SELECT
        alerts_day_shift_id as alerts_day_shift_id,
        max(alerts_shift_report_agreement_txt) as alerts_shift_report_agreement_txt,
        max(alerts_shift_report_next_shift_txt) as alerts_shift_report_next_shift_txt,
        max(alerts_shift_report_out_of_order_txt) as alerts_shift_report_out_of_order_txt,
        max(alerts_shift_report_security_issues) as alerts_shift_report_security_issues,
        current_timestamp() as dwh_created_tmsp,
        current_timestamp() as dwh_updated_tmsp
    FROM (
        SELECT
            ''' || CAST(ALERTS_DAY_SHIFT_ID AS STRING) || ''' as alerts_day_shift_id,
            ''' || ALERTS_SHIFT_REPORT_AGREEMENT_TXT || ''' AS alerts_shift_report_agreement_txt,
            ''' || ALERTS_SHIFT_REPORT_NEXT_SHIFT_TXT || ''' AS alerts_shift_report_next_shift_txt,
            ''' || ALERTS_SHIFT_REPORT_OUT_OF_ORDER_TXT || ''' AS alerts_shift_report_out_of_order_txt,
            ''' || ALERTS_SHIFT_REPORT_SECURITY_ISSUES || ''' AS alerts_shift_report_security_issues
    )
    GROUP BY alerts_day_shift_id
) AS SRC1
ON tgt1.alerts_day_shift_id = src1.alerts_day_shift_id 
WHEN MATCHED THEN 
UPDATE SET 
    tgt1.alerts_shift_report_agreement_txt = src1.alerts_shift_report_agreement_txt, 
    tgt1.alerts_shift_report_next_shift_txt = src1.alerts_shift_report_next_shift_txt, 
    tgt1.alerts_shift_report_out_of_order_txt = src1.alerts_shift_report_out_of_order_txt, 
    tgt1.alerts_shift_report_security_issues = src1.alerts_shift_report_security_issues, 
    tgt1.dwh_updated_tmsp = src1.dwh_updated_tmsp 
WHEN NOT MATCHED THEN 
INSERT (
    alerts_day_shift_id,
    alerts_shift_report_agreement_txt,
    alerts_shift_report_next_shift_txt,
    alerts_shift_report_out_of_order_txt,
    alerts_shift_report_security_issues,
    dwh_created_tmsp,
    dwh_updated_tmsp
) 
VALUES (
    src1.alerts_day_shift_id,
    src1.alerts_shift_report_agreement_txt,
    src1.alerts_shift_report_next_shift_txt,
    src1.alerts_shift_report_out_of_order_txt,
    src1.alerts_shift_report_security_issues,
    src1.dwh_created_tmsp,
    src1.dwh_updated_tmsp
);
''';

EXECUTE IMMEDIATE (sql_command);

SET sql_commit  =  'COMMIT TRANSACTION';

EXECUTE IMMEDIATE (sql_commit);
END;
