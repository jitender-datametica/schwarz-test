CREATE OR REPLACE PROCEDURE p_lew_process_mstr.m_update_saule_request_approve(
  USERLOGIN STRING
)
BEGIN
  BEGIN TRANSACTION;

  EXECUTE IMMEDIATE '''
    UPDATE p_lew_process_mstr.t_saule_config_requests_1
    SET status_id = 4
      , status_desc = 'Alte Konfiguration'
    WHERE status_id = 3
  ''';

  -- ** MSC-WARNING - MSCEWI1022 - ONE OR MORE IDENTIFIERS IN THIS STATEMENT WERE CONSIDERED PARAMETERS BY DEFAULT. REFERENCED TABLE NOT FOUND. **
  EXECUTE IMMEDIATE '''
    UPDATE p_lew_process_mstr.t_saule_config_requests_1
    SET status_id = 3
     , status_desc = 'Genehmigt - Aktiv'
     , approver = @USERLOGIN
    WHERE status_id = 1
  ''' USING USERLOGIN AS USERLOGIN;

  COMMIT TRANSACTION;
END;