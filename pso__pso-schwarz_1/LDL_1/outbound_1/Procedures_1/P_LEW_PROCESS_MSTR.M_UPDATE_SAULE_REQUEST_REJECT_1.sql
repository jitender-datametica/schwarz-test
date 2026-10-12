CREATE OR REPLACE PROCEDURE p_lew_process_mstr.m_update_saule_request_reject(
  USERLOGIN STRING
)
BEGIN
  BEGIN TRANSACTION;

  -- ** MSC-WARNING - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
  EXECUTE IMMEDIATE '''
    UPDATE p_lew_process_mstr.t_saule_config_requests_1
    SET status_id = 2
      , status_desc = 'Abgelehnt'
      , approver = @USERLOGIN
    WHERE status_id = 1
  ''' USING USERLOGIN AS USERLOGIN;

  COMMIT TRANSACTION;
END;
