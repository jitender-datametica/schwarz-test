/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for f_lew_mart_msi.n_mov_item_supplier_act
#----------------------------------------------------------------------------
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  17.01.2018    Murtenthaler.Martin      WAWI-Item_2 if possible
#  1.3  17.01.2018    Wieber.Harald            Release 2.2
#  1.4  18.01.2018    Martin Murtenthaler      group by syntax changed
#  1.5  31.01.2018    Wieber,Harald            Release 2.3
#  1.6  08.03.2018    Martin Murtenthaler      Data for WAWI-clients taken from lew_core.t_wawi_mov_item_supplier_act_2
#  1.7  08.03.2018    Martin Murtenthaler      WAWI-table instead BIL-view
#  1.8  12.03.2018    Martin Murtenthaler      "WAWI-Item_2 if possible" removed
#  1.9  24.04.2018    Marose,Christian         WHERE sup_sid IS NOT NULL added
#  2.0  25.07.2019    Michael Ueding           Abgrenzung Daten aufgrund AT Wawi Rollback
#  2.1  10.10.2019    Wieber, Harald           Code Review
#  2.2  10.11.2020    Torsten Bachmann         join to v_supplier_map_key_2 added
#                                              PatchNo: 2652, REP3-7579
#  2.3  10.11.2020    Michal Malinowski        Use of v_itm_item_2 to add to view
#                                              dummmy records with -1 supplier_id and '9999-12-31' dat_formdate
#                                              PatchNo: 2705, REP3-7970
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.v_mov_item_supplier_act_2
COMMENT = '$Revision: 16589 $ '

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS


SELECT 
       asis.client_id AS client_id
     , asis.item_id AS item_id
     , CASE WHEN act.item_sid IS NULL THEN -1 ELSE act.sup_sid END AS supplier_id
     , MAX(CASE WHEN act.dwh_cal_dt IS NULL THEN asis.dat_formdate ELSE act.dwh_cal_dt END) AS dat_formdate
     FROM 
     ( 
     SELECT  
          client_id
        , item_id
        , CAST('9999-12-31' AS DATE) AS dat_formdate 
          FROM P_LEW_MART_MSI.v_itm_item_2 ) AS asis

     LEFT OUTER JOIN 
    ( 
        SELECT
             a.client_id
           , a.item_sid
           , a.sup_sid
           , a.dwh_cal_dt AS dwh_cal_dt
             FROM P_LEW_CORE_AC.v_location_item_receipt_2 a
             WHERE (a.ledger_account_cd <> '326010-R' OR a.ledger_account_cd IS NULL)
             AND   a.sup_sid IS NOT NULL
  
        UNION ALL
  
        SELECT
           a.client_id
         , a.item_sid
         , a.sup_sid
         , a.dat_formdate AS dwh_cal_dt
        FROM P_LEW_CORE_AC.v_wawi_mov_item_supplier_act_2 a
  
        INNER JOIN P_LEW_CORE_AC.v_client_migration_per_2 m
         ON a.client_id = m.client_id 
        AND 
          (
           a.dat_formdate < m.migration_dat_valid_from /* Wawi Laender */
           OR a.dat_formdate > m.migration_dat_valid_to /* eLWIS rollback Laender */
           )
        ) act
    
      ON act.client_id = asis.client_id
     AND act.item_sid = asis.item_id

     LEFT OUTER JOIN P_LEW_CORE_AC.v_supplier_map_key_2 supmap
       ON act.client_id = supmap.client_id
      AND act.sup_sid   = supmap.sup_sid
     GROUP BY 1,2,3
;

