CREATE OR REPLACE PROCEDURE dbp_msi_view_nfmd.sp_in_nfmd_selected_decision(p_mandant_id INT64, p_markdown_decision_id INT64, p_user_id STRING, OUT return_value STRING)
  BEGIN
    INSERT INTO kfl_production_dbp_msi_view_nfmd.ts_nfmd_selected_decision_2 (mandant_id, markdown_decision_id, user_id)
      VALUES (p_mandant_id, p_markdown_decision_id, p_user_id)
    ;
    SET return_value = 'Verwertungsentscheidung ausgewaehlt';
    RETURN;
  END;
