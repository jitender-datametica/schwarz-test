CREATE OR REPLACE PROCEDURE fe_mstr_bge_palettierer.p_add_or_update_shift_report_messages(IN ALERTS_DAY_SHIFT_ID FLOAT64, IN ALERTS_SHIFT_REPORT_AGREEMENT_TXT STRING, IN ALERTS_SHIFT_REPORT_NEXT_SHIFT_TXT STRING, IN ALERTS_SHIFT_REPORT_OUT_OF_ORDER_TXT STRING, IN ALERTS_SHIFT_REPORT_SECURITY_ISSUES STRING)
BEGIN
DECLARE sql_command STRING;
DECLARE sql_commit STRING;
SET sql_command  =  '''MERGE INTO szd_core.t_fact_alerts_shift_report_per_shift_2 AS TGT1
USING (SELECT @ALERTS_DAY_SHIFT_ID AS alerts_day_shift_id,
  MAX(@ALERTS_SHIFT_REPORT_AGREEMENT_TXT) AS alerts_shift_report_agreement_txt,
  MAX(@ALERTS_SHIFT_REPORT_NEXT_SHIFT_TXT) AS alerts_shift_report_next_shift_txt,
  MAX(@ALERTS_SHIFT_REPORT_OUT_OF_ORDER_TXT) AS alerts_shift_report_out_of_order_txt,
  MAX(@ALERTS_SHIFT_REPORT_SECURITY_ISSUES) AS alerts_shift_report_security_issues,
  CURRENT_TIMESTAMP() AS dwh_created_tmsp,
  CURRENT_TIMESTAMP() AS dwh_updated_tmsp
 FROM (SELECT 1)
 GROUP BY alerts_day_shift_id,
  dwh_created_tmsp,
  dwh_updated_tmsp) AS SRC1
ON TGT1.alerts_day_shift_id = SRC1.alerts_day_shift_id
WHEN MATCHED THEN UPDATE SET
 alerts_shift_report_agreement_txt = SRC1.alerts_shift_report_agreement_txt,
 alerts_shift_report_next_shift_txt = SRC1.alerts_shift_report_next_shift_txt,
 alerts_shift_report_out_of_order_txt = SRC1.alerts_shift_report_out_of_order_txt,
 alerts_shift_report_security_issues = SRC1.alerts_shift_report_security_issues,
 dwh_updated_tmsp = SRC1.dwh_updated_tmsp
WHEN NOT MATCHED THEN INSERT (alerts_day_shift_id, alerts_shift_report_agreement_txt, alerts_shift_report_next_shift_txt
 , alerts_shift_report_out_of_order_txt, alerts_shift_report_security_issues, dwh_created_tmsp, dwh_updated_tmsp) VALUES(ROUND(CAST(SRC1.alerts_day_shift_id AS BIGNUMERIC)
  , 0), SRC1.alerts_shift_report_agreement_txt, SRC1.alerts_shift_report_next_shift_txt, SRC1.alerts_shift_report_out_of_order_txt
 , SRC1.alerts_shift_report_security_issues, SRC1.dwh_created_tmsp, SRC1.dwh_updated_tmsp) ''';

EXECUTE IMMEDIATE (sql_command) USING IF(ALERTS_DAY_SHIFT_ID = CAST(NULL AS FLOAT64), CAST(NULL AS FLOAT64), ALERTS_DAY_SHIFT_ID) AS ALERTS_DAY_SHIFT_ID,  IF(ALERTS_SHIFT_REPORT_AGREEMENT_TXT = CAST(NULL AS STRING), CAST(NULL AS STRING), ALERTS_SHIFT_REPORT_AGREEMENT_TXT) AS ALERTS_SHIFT_REPORT_AGREEMENT_TXT,  IF(ALERTS_SHIFT_REPORT_NEXT_SHIFT_TXT = CAST(NULL AS STRING), CAST(NULL AS STRING), ALERTS_SHIFT_REPORT_NEXT_SHIFT_TXT) AS ALERTS_SHIFT_REPORT_NEXT_SHIFT_TXT,  IF(ALERTS_SHIFT_REPORT_OUT_OF_ORDER_TXT = CAST(NULL AS STRING), CAST(NULL AS STRING), ALERTS_SHIFT_REPORT_OUT_OF_ORDER_TXT) AS ALERTS_SHIFT_REPORT_OUT_OF_ORDER_TXT,  IF(ALERTS_SHIFT_REPORT_SECURITY_ISSUES = CAST(NULL AS STRING), CAST(NULL AS STRING), ALERTS_SHIFT_REPORT_SECURITY_ISSUES) AS ALERTS_SHIFT_REPORT_SECURITY_ISSUES;


END;