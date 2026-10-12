/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.M_UPD_T_SYS_REVISION_LOG
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2017    Michael Ueding           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  04.11.2021    Wandtke,Andrzej          AP0089687 "EXECUTE AS CALLER" replaced by "EXECUTE AS OWNER" : this enables access to P_LEW_CORE_AC layer. Otherwise, when called by MSTR will give an error as MSTR user has no rights to access core layer
#                                              AP0089687 Set condition ORIG_STORE_NR IS NULL AND ? =0 instead of ? IS NULL (caused problems by binding). When passing argument, zeroifnull has to be used
#  1.3  28.06.2022    Wandtke,Andrzej          BS0011299_ZKP_CLEAN Apply date conversion on DAT_FORMDATE_FROM, DAT_FORMDATE_UNTIL
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE p_lew_mart_msi.m_upd_t_sys_revision_log(
    CLIENT_ID FLOAT64,
    WH_ID FLOAT64,
    ORIG_STORE_NR FLOAT64,
    DAT_FORMDATE_FROM DATE,
    DAT_FORMDATE_UNTIL DATE,
    REVISION_FG FLOAT64,
    REVISION_USER STRING,
    REVISION_REASON_CD STRING
)
BEGIN
  BEGIN TRANSACTION;
-- USER mit CURRENT_USER substituiert
-- https://docs.teradata.com/r/1DcoER_KpnGTfgPinRAFUw/HkJNyJR2i~MjMP7bMbOZ1g
  EXECUTE IMMEDIATE """
    UPDATE p_lew_mart_msi.t_msi_sys_revision_log_2 
       SET revision_fg = CAST(COALESCE(@REVISION_FG, 1)AS INT64),
           revision_user = COALESCE(@REVISION_USER, SESSION_USER()),
           timestamp_revision_start = CAST(CURRENT_TIMESTAMP() AS DATETIME),
           revision_reason_cd = @REVISION_REASON_CD
    WHERE client_id = @CLIENT_ID
      AND wh_loc_sid = (
           SELECT loc_sid
           FROM p_lew_core_ac.v_loc_map_key_2 
           WHERE client_id = @CLIENT_ID 
             AND wawi_dwh_wh_id = @WH_ID
      )
      AND dat_formdate_from = @DAT_FORMDATE_FROM
      AND dat_formdate_until = @DAT_FORMDATE_UNTIL
      AND (
           orig_store_nr = @ORIG_STORE_NR
           OR (orig_store_nr IS NULL AND @ORIG_STORE_NR = 0)
      )
      AND revision_fg = 0
      AND timestamp_delete IS NULL
  """
  USING 
    REVISION_FG AS REVISION_FG,
    REVISION_USER AS REVISION_USER,
    REVISION_REASON_CD AS REVISION_REASON_CD,
    CLIENT_ID AS CLIENT_ID,
    WH_ID AS WH_ID,
    DAT_FORMDATE_FROM AS DAT_FORMDATE_FROM,
    DAT_FORMDATE_UNTIL AS DAT_FORMDATE_UNTIL,
    ORIG_STORE_NR AS ORIG_STORE_NR;

  COMMIT TRANSACTION;
END;