/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for m_ins_t_sys_revision_request
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2017    Michael Ueding           Initial
#  1.1  17.01.2018    Wieber,Harald            Release 2.2
#  1.2  22.03.2018    Andrzej Wandtke          20180315_1616_Change_Time_Range_Macro_Team1 - modify the fields x_dat_formdate_from, x_dat_formdate_until
#  1.3  05.03.2021    Andrzej Wandtke          20210305_2774_ZKP_Rabatt_PrufThema AP0056021 - new column for discount (Rabatt) metrics
#  1.4  05.11.2021    Wandtke,Andrzej          AP0089687  "EXECUTE AS CALLER" replaced by "EXECUTE AS OWNER" : this enables access to P_LEW_CORE_AC layer. Otherwise, when called by MSTR will give an error as MSTR user has no rights to access core layer
#  1.5  08.03.2023    Wandtke,Andrzej          AP0163973 - NSR3520115 - Prüfungszeitraum (proofing period) on test_2 environment changed from 4 to 8, calculation of x_dat_formdate_until
#  1.6  11.12.2023    Wandtke,Andrzej          AP0191702 - Prüfungszeitraum (proofing period): set it to 8 weeks for warehouses, 12 weeks for stores, same on Q and P
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE PROCEDURE `p_lew_mart_msi.m_ins_t_sys_revision_request`(
  CLIENT_ID FLOAT64,
  WH_ID FLOAT64,
  ORIG_STORE_NR FLOAT64,
  REQUESTING_USER STRING,
  DAT_FORMDATE_FROM DATE,
  DAT_FORMDATE_UNTIL DATE,
  VOID_FG FLOAT64,
  DEPOSIT_FG FLOAT64,
  RETURN_FG FLOAT64,
  ABORTED_SUSPENDED_FG FLOAT64,
  DISCOUNT_FG FLOAT64,
  OTHER_FG FLOAT64,
  REVISION_TEST_FG FLOAT64
)
BEGIN

  EXECUTE IMMEDIATE """
    INSERT INTO `p_lew_mart_msi.t_msi_sys_revision_request_2` (
      client_id, wh_loc_sid, orig_store_nr, requesting_user, dat_formdate_until,
      dat_formdate_from, void_fg, deposit_fg, return_fg, aborted_suspended_fg,
      discount_fg, other_fg, revision_test_fg
    )
    WITH date_logic AS (
      SELECT 
        @orig_store_nr AS x_orig_store_nr,
        CASE 
          WHEN @revision_test_fg IN (0, 1)
          THEN DATE_ADD(DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL MOD(DATE_DIFF(CURRENT_DATE("Europe/Berlin"), DATE '0001-01-01', DAY), 7) DAY), INTERVAL 4 DAY)
          WHEN @dat_until IS NOT NULL AND @dat_until <> DATE '1900-01-01'
          THEN @dat_until
        END AS x_dat_formdate_until
    )
    SELECT 
      @client_id,
      (SELECT loc_sid FROM `p_lew_core_ac.v_loc_map_key_2` WHERE client_id = @client_id AND wawi_dwh_wh_id = @wh_id),
      x_orig_store_nr,
      @requesting_user,
      x_dat_formdate_until,
      CASE 
        WHEN @revision_test_fg IN (0, 1) 
        THEN 
          CASE 
            WHEN x_orig_store_nr IS NULL THEN DATE_ADD(DATE_SUB(x_dat_formdate_until, INTERVAL 56 DAY), INTERVAL 3 DAY)
            ELSE DATE_ADD(DATE_SUB(x_dat_formdate_until, INTERVAL 84 DAY), INTERVAL 3 DAY)
          END
        WHEN @dat_from IS NOT NULL AND @dat_from <> DATE '1900-01-01'
        THEN @dat_from
      END AS x_dat_formdate_from,
      @void_fg,
      @deposit_fg,
      @return_fg,
      @aborted_fg,
      @discount_fg,
      @other_fg,
      @revision_test_fg
    FROM date_logic
    WHERE EXISTS (
      SELECT 1
      FROM `p_lew_core_ac.v_wawi_org_store_skey_2` a
      WHERE STRUCT(@client_id AS client_id, (SELECT loc_sid FROM `p_lew_core_ac.v_loc_map_key_2` WHERE client_id = @client_id AND wawi_dwh_wh_id = @wh_id) AS loc_sid) 
      IN (
        SELECT AS STRUCT client_id, loc_sid
        FROM `p_lew_core_ac.v_loc_map_key_2`
        WHERE client_id = @client_id
        AND wawi_dwh_wh_id = @wh_id
      )
    )
  """ USING 
    CAST(CLIENT_ID AS INT64) AS client_id,
    WH_ID AS wh_id,
    CAST(ORIG_STORE_NR AS INT64) AS orig_store_nr,
    REQUESTING_USER AS requesting_user,
    CAST(REVISION_TEST_FG AS INT64) AS revision_test_fg,
    DAT_FORMDATE_UNTIL AS dat_until,
    DAT_FORMDATE_FROM AS dat_from,
    CAST(VOID_FG AS INT64) AS void_fg,
    CAST(DEPOSIT_FG AS INT64) AS deposit_fg,
    CAST(RETURN_FG AS INT64) AS return_fg,
    CAST(ABORTED_SUSPENDED_FG AS INT64) AS aborted_fg,
    CAST(DISCOUNT_FG AS INT64) AS discount_fg,
    CAST(OTHER_FG AS INT64) AS other_fg;

END;