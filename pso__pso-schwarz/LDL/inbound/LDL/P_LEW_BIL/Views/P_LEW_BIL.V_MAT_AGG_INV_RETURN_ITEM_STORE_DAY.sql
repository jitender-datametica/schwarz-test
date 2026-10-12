/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_MAT_AGG_INV_RETURN_ITEM_STORE_DAY
#----------------------------------------------------------------------------
# History:
#  1.0  06.12.2017    Patrick Mittler          Change name of Object (itm to item) and
#  1.1  28.02.2018    Taubkin, Slavik          Umstellung auf last_known Views
#  1.2  28.02.2018    Wieber,Harald            Entfernen falscher Zeilen
#  1.3  02.03.2018    Meister,Ulrich           Spaltenkommentare wieder hinzugefuegt
#  1.4  19.02.2021    Prasanna Ranjan          REP2-9080 - Include item types ZKM and ZVM from USA and Serbia
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_BIL.V_MAT_AGG_INV_RETURN_ITEM_STORE_DAY COMMENT = 'View'
(
   client_id                COMMENT 'Landeskennzeichen'
  ,loc_sid_store            COMMENT 'enthaelt surrogate Key des Stores'
  ,src_orig_store_nr        COMMENT 'WAWI Quellsystemschluessel Filiale'
  ,src_wh_id                COMMENT 'natural Key des dem Store zugeordneten Warehouses'
  ,item_sid                 COMMENT 'Surrogate Key Item'
  ,dwh_cal_dt               COMMENT 'Bezugsdatum'
  ,cy_month                 COMMENT 'Monat des Geschaeftsjahres im Format "JJJJMM"'
  ,ship_qty                 COMMENT 'Menge in Erfassungsmengeneinheit'
  ,gross_val                COMMENT 'GROSS final SFO amount mapped, according to column sfo_type_cd'
  ,sales_net_val            COMMENT '#N-A'

) 

AS

SELECT
   mov.client_id
  ,lc_str.loc_sid_store
  ,lc_str.src_orig_store_nr
  ,org_wh.src_wh_id
  ,d.item_sid
  ,mov.dwh_cal_dt
  ,to_number(to_char(mov.dwh_cal_dt,'YYYYMM')) AS cy_month
  ,Sum(mov.ship_qty)                AS ship_qty
  ,Sum(mov.ship_qty * Coalesce(prc.cond_val_eff_calc, 0)) AS gross_val
  ,Sum(to_number(mov.ship_qty * Coalesce(prc.cond_val_eff_calc, 0) * 100 /
       (100 + Coalesce(prc.tax_rate_calc, 0)),18,2)) AS sales_net_val

FROM  P_LEW_CORE_AC.v_item_movement_record_pos AS mov

/* Take the sales price from Sales condition table */
LEFT OUTER JOIN P_LEW_BIL.v_item_loc_sales_cond_denorm AS prc
ON  prc.client_id   = mov.client_id
  AND prc.item_sid = mov.item_sid
  AND prc.loc_sid = mov.loc_sid
  AND prc.uom_sid_cond = mov.uom_sid_base
  AND mov.dwh_cal_dt BETWEEN  prc.dwh_valid_from AND prc.dwh_valid_to

/* Zuordnung der  */
INNER JOIN P_LEW_BIL.v_store AS lc_str
ON mov.client_id = lc_str.client_id
  AND mov.loc_sid = lc_str.loc_sid_store
  AND lc_str.dwh_actual_fg = 1        /* Aktueller Datensatz*/
  AND lc_str.test_store_fg = 0        /* Keine Testfiliale*/
  AND lc_str.pseudo_store_fg = 0

/* Zuordnung Store zu Niederlassung/BGes */
INNER JOIN P_LEW_BIL.v_store_to_warehouse_lastknown AS s_to_wh
ON mov.client_id = s_to_wh.client_id
  AND mov.loc_sid = s_to_wh.loc_sid_store

/* Es werden auf die echten Lager eingeschraenkt*/
INNER JOIN P_LEW_BIL.v_warehouse AS org_wh
ON s_to_wh.client_id = org_wh.client_id
  AND s_to_wh.loc_sid_wh = org_wh.loc_sid_wh
  AND org_wh.dwh_actual_fg = 1
  AND org_wh.active_fg = 1
  AND org_wh.bges_active_fg = 1

/* Zuordnung um die v_item_type zu joinen */
INNER JOIN P_LEW_CORE_AC.v_item_hist AS d
ON mov.client_id = d.client_id
  AND mov.item_sid = d.item_sid
  AND CURRENT_DATE BETWEEN d.dwh_valid_from AND d.dwh_valid_to
  AND d.deleted_fg = 0

/* Attribut src_mtart benoetigt zum Filtern von bestimmten Artikelarten in der v_itm_type_ignore*/
LEFT JOIN P_LEW_CORE_AC.v_item_type AS e
ON e.client_id = d.client_id
  AND e.item_type_sid = d.item_type_sid

/* Zu ignorierende Artikelarten */
LEFT OUTER JOIN P_LEW_PROCESS_AC.v_item_type_ignore AS ig
ON  d.client_id = ig.client_id
  AND e.src_mtart = ig.item_type_cd
  AND 
    (
      (
       ig.client_id IN (33, 34) 
       AND ig.item_type_cd  NOT IN ('ZKM', 'ZVM')
      )
      OR ig.client_id NOT IN (33, 34)
    ) 
  AND ig.item_type_grp_cd IN ('BAGLEVY', 'INV')

/* 921/922 - Mindermenge bei Retourenpruefung im Lager / Storno;
   923/924 - Mehrmenge bei Retourenpruefung im Lager / Storno;
   925/926 - Nach Retoure Buchung des Sollbestand auf Null (Mindermenge) / Storno;
   927/928 - Nach Retoure Buchung des Sollbestand auf Null (Mehrmenge) / Storno;
   911/912 - Ablehnung Minderlieferung Reklamation, Bestand Filiale wird nicht zurueck korrigiert / Storno;
   913/914 - Ablehnung Mehrlieferung Reklamation, Bestand Filiale wird nicht zurueck korrigiert / Storno; */
WHERE mov.move_type_cd IN  ('911', '912', '913', '914', '921', '922', '923', '924', '925', '926', '927', '928')
  AND mov.ledger_account_cd IS NOT NULL
  AND ig.item_type_cd IS NULL  /* Ungefilterte Artikelarten */

GROUP BY 1,2,3,4,5,6,7
;