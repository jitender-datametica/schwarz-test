/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for M_UPD_T_SYS_REVISION_REQUEST
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2017    Michael Ueding           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  27.06.2022    Wandtke,Andrzej          BS0011299_ZKP_CLEAN "EXECUTE AS CALLER" replaced by "EXECUTE AS OWNER"
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE p_lew_mart_msi.m_upd_t_sys_revision_request(
  APPROVAL_USER STRING, 
  WH_OR_STORE_FG FLOAT64
)
BEGIN
  BEGIN TRANSACTION;

  EXECUTE IMMEDIATE '''
    UPDATE p_lew_mart_msi.t_msi_sys_revision_request_1 
    SET  approval_fg         = 1
         ,approval_user      = @APPROVAL_USER
         ,timestamp_approval = CAST(CURRENT_TIMESTAMP() AS DATETIME)
    WHERE approval_fg        = 0
    AND @APPROVAL_USER_1 <> requesting_user
    AND (
         (orig_store_nr IS NULL     AND @WH_OR_STORE_FG = 1) -- 1    => WH
      OR (orig_store_nr IS NOT NULL AND @WH_OR_STORE_FG_1 = 2) -- 2    => Store
      OR @WH_OR_STORE_FG_2 = 0                                -- 0    => All
      OR @WH_OR_STORE_FG_3 IS NULL                            -- Null => All
    )
  ''' USING 
      APPROVAL_USER AS APPROVAL_USER, 
      APPROVAL_USER AS APPROVAL_USER_1, 
      WH_OR_STORE_FG AS WH_OR_STORE_FG, 
      WH_OR_STORE_FG AS WH_OR_STORE_FG_1, 
      WH_OR_STORE_FG AS WH_OR_STORE_FG_2, 
      WH_OR_STORE_FG AS WH_OR_STORE_FG_3;

  COMMIT TRANSACTION;
END;