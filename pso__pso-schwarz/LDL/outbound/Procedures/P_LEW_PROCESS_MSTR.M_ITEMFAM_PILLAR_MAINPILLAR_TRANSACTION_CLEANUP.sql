CREATE OR REPLACE PROCEDURE p_lew_process_mstr.m_itemfam_pillar_mainpillar_transaction_cleanup()
BEGIN
  BEGIN TRANSACTION;

  EXECUTE IMMEDIATE '''
    TRUNCATE TABLE p_lew_process_mstr.t_itemfam_pillar_mainpillar_transaction
  ''';

  COMMIT TRANSACTION;
END;