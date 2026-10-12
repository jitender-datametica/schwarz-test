CREATE OR REPLACE PROCEDURE p_lew_process_mstr.m_log_new_config_sf(
  ROW_CNT FLOAT64, 
  USERLOGIN STRING
)
BEGIN
  BEGIN TRANSACTION;

  EXECUTE IMMEDIATE '''
    DELETE FROM p_lew_process_mstr.t_saule_config_requests 
    WHERE req_id = -99
  ''';

  EXECUTE IMMEDIATE '''
    INSERT INTO p_lew_process_mstr.t_saule_config_requests ( 
      req_id
    , status_id
    , req_date
    , requestor
    , approver
    , status_desc
    ) VALUES (
      -99
    ,CAST(@ROW_CNT AS INT64)
    , '1900-01-01'
    , @USERLOGIN
    , NULL
    , NULL
    ) 
  ''' USING ROW_CNT AS ROW_CNT, USERLOGIN AS USERLOGIN;

  COMMIT TRANSACTION;
END;