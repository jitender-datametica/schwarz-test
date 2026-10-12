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
#  1.6  08.03.2018    Martin Murtenthaler      Data for WAWI-clients taken from LDL.lew_core.t_wawi_mov_item_supplier_act_2
#  1.7  08.03.2018    Martin Murtenthaler      WAWI-table instead BIL-view
#  1.8  12.03.2018    Martin Murtenthaler      "WAWI-Item_2 if possible" removed
#  1.9  24.04.2018    Marose,Christian         WHERE sup_sid IS NOT NULL added
#  2.0  25.07.2019    Michael Ueding           Abgrenzung Daten aufgrund AT Wawi Rollback
#  2.1  10.10.2019    Wieber, Harald           Code Review
#  2.2  10.11.2020    Torsten Bachmann         CROSS JOIN to v_supplier_map_key_2 added
#                                              PatchNo: 2652, REP3-7579
#  2.3  10.11.2020    Michal Malinowski        Use of v_itm_item_2 to add to view
#                                              dummmy records with -1 supplier_id and '9999-12-31' dat_formdate
#                                              PatchNo: 2705, REP3-7970
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_mov_item_supplier_act_2
OPTIONS(DESCRIPTION = '$Revision: 16589 $ ', ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90)
AS
SELECT asis.client_id,
 asis.item_id,
  CASE
  WHEN act.item_sid IS NULL
  THEN CAST(- 1 AS BIGNUMERIC)
  ELSE act.sup_sid
  END AS supplier_id,
 MAX(CASE
   WHEN act.dwh_cal_dt IS NULL
   THEN asis.dat_formdate
   ELSE act.dwh_cal_dt
   END) AS dat_formdate
FROM (SELECT client_id,
   item_id,
   DATE('9999-12-31') AS dat_formdate
  FROM ldl_p_lew_mart_msi.v_itm_item_2) AS asis
 LEFT JOIN (SELECT client_id,
    item_sid,
    sup_sid,
    dwh_cal_dt
   FROM ldl_p_lew_core_ac.v_location_item_receipt_2 AS A
   WHERE ledger_account_cd <> '326010-R'
    AND sup_sid IS NOT NULL
   UNION ALL
   SELECT A.client_id,
    A.item_sid,
    A.sup_sid,
    A.dat_formdate AS dwh_cal_dt
   FROM ldl_p_lew_core_ac.v_wawi_mov_item_supplier_act_2 AS A
    INNER JOIN ldl_p_lew_core_ac.v_client_migration_per_2 AS M ON A.client_id = M.client_id AND (A.dat_formdate < M.migration_dat_valid_from
        /* Wawi Laender */ OR A.dat_formdate > M.migration_dat_valid_to /* eLWIS rollback Laender */)) AS act ON asis.client_id
    = act.client_id AND asis.item_id = act.item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_supplier_map_key_2 AS SUPMAP ON act.client_id = SUPMAP.client_id AND act.sup_sid = SUPMAP.sup_sid
   
GROUP BY asis.client_id,
 asis.item_id,
 supplier_id;
