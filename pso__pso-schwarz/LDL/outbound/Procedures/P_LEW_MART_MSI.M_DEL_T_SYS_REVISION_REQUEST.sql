/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.M_DEL_T_SYS_REVISION_REQUEST
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2017    Michael Ueding           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  05.11.2021    Wandtke,Andrzej          AP0089687  "EXECUTE AS CALLER" replaced by "EXECUTE AS OWNER" : this enables access to P_LEW_CORE_AC layer. Otherwise, when called by MSTR will give an error as MSTR user has no rights to access core layer
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE PROCEDURE p_lew_mart_msi.m_del_t_sys_revision_request(
  CLIENT_ID FLOAT64, 
  WH_ID FLOAT64, 
  ORIG_STORE_NR FLOAT64
)
BEGIN
  BEGIN TRANSACTION;

  EXECUTE IMMEDIATE '''
    DELETE FROM p_lew_mart_msi.t_msi_sys_revision_request
    WHERE client_id = @CLIENT_ID
      AND
        (
          orig_store_nr = @ORIG_STORE_NR
          OR (orig_store_nr IS NULL AND @ORIG_STORE_NR IS NULL)
    )
    AND (client_id, wh_loc_sid) IN (
        SELECT
        (client_id,
        loc_sid)
        FROM p_lew_core_ac.v_loc_map_key
        WHERE client_id = @CLIENT_ID
        AND wawi_dwh_wh_id = @WH_ID
    )
  ''' USING CLIENT_ID AS CLIENT_ID, ORIG_STORE_NR AS ORIG_STORE_NR, WH_ID AS WH_ID;

  COMMIT TRANSACTION;
END;