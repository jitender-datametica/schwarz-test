/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT0_ZKP_ETL_EJR_PRICE_INFO
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  05.01.2018    Ueding.Michael           Initial
#  1.1  17.01.2018    Wieber.Harald            Release 2.2
#  1.2  21.06.2018    Michael Ueding           Neue Quelle CORE POS
#  1.3  04.07.2018    Wieber,Harald            Fiy Comment Failures
#  1.4  25.10.2018    Michael Ueding           Referenz auf pos_ctrl Tabelle umgelenkt.
#  1.5  24.08.2021    Wandtke,Andrzej          AP0091650_ZKP_BTEQ - Tech tests of BTEQ : use CAST(SUBSTRING(TO_VARCHAR(receipt_tmsp), 12, 8) AS TIME(0)) instead of Cast(SUBSTRING(TO_VARCHAR(receipt_tmsp, ''), 1, 8) AS TIME(0)) in field time_receipt_ejr
#  1.6  22.08.2025    Wandtke,Andrzej          761800_ZKP_SHOW_PRICE - filter out cases with empty cashier_id
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW p_lew_mart_msi.v_mat0_zkp_etl_ejr_price_info
AS
SELECT
 loc_sid                    AS store_id
,client_id                  AS client_id
,register_id                AS pos_terminal_id
,dwh_cal_dt                 AS dat_formdate
,CAST(SUBSTRING(TO_VARCHAR(receipt_tmsp), 12, 8) AS TIME(0)) AS time_receipt_ejr
,receipt_id                 AS orig_receipt_nr_ejr
,timezone_id                AS timezone_cd
,receipt_dt                 AS dat_dayend
,cashier_id                 AS checker_id
,transaction_type_cd        AS transactiontype_id
,Cast(SUBSTRING(Cast(transaction_begin_tmsp AS VARCHAR(50)), 1, 19) AS TIMESTAMP(3)) AS timestamp_begin_ejr
,Cast(SUBSTRING(Cast(transaction_end_tmsp AS VARCHAR(50)), 1, 19) AS TIMESTAMP(3)) AS timestamp_end_ejr
,authority_cd               AS authority_id
,item_sid                   AS item_id
,retail_price_val           AS price_retail_ejr
,NULL                       AS mainitemgroup_id
,item_takeover_fg           AS item_takeover_fg
,dwh_load_id                AS load_id
FROM p_lew_core_ac.v_pos_ctrl_item_price_info
WHERE cashier_id IS NOT NULL
;