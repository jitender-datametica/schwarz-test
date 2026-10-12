/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_MAT_AGG_SALES_RETAIL_ITEM_STORE_DAY_2
#----------------------------------------------------------------------------
# History:
#  1.0  06.12.2017    Patrick Mittler          Change name of Object (itm to item_2) and remove columnalias for the BIL-Object.
#  1.1  11.12.2017    Patrick Mittler          Adjust columns retail_val and retail_net_val
#  1.1  11.12.2017    Patrick Mittler          Adjust columns retail_val and retail_net_val
#  1.2  17.01.2018    Wieber,Harald            Update Release 2.2
#  1.3  28.02.2018    Taubkin, Slavik          Umstellung auf last_known Views
#  1.4  02.03.2018    Meister,Ulrich           Spaltenkommentare wieder hinzugefuegt
#  1.5  26.06.2018    Maria Gnech              Delta column dwh_updated added
#                                              20180615_1712_Sync_DPE_lew_bil_DM2 (IDMO-636)
#  1.6  22.02.2021    Prasanna Ranjan          REP2-9080 - Include item_2 types ZKM and ZVM from USA and Serbia
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_BIL.V_MAT_AGG_SALES_RETAIL_ITEM_STORE_DAY_2 COMMENT = 'View'
(
   client_id            COMMENT 'Landeskennzeichen'
  ,loc_sid_store        COMMENT 'enthaelt surrogate Key des Stores'
  ,src_orig_store_nr    COMMENT 'WAWI Quellsystemschluessel Filiale'
  ,src_wh_id            COMMENT 'natural Key des dem Store zugeordneten Warehouses'
  ,item_sid             COMMENT 'Surrogate Key Item_2'
  ,dwh_cal_dt           COMMENT 'Bezugsdatum'
  ,cy_month             COMMENT 'Monat_2 des Geschaeftsjahres im Format "JJJJMM"'
  ,retail_val           COMMENT ''
  ,retail_net_val       COMMENT ''
  ,qty_act              COMMENT 'Tatsaechlich fakturierte Menge; SAP-Retail: vbrp.fkimg; SAP-BW: t_bw_2lis_13_vditm.fkimg; ELWIS: t_s_retail_sales_record_pos.qty_act'
  ,dwh_updated          COMMENT 'Zeitstempel der letzten Aenderung des Datensatzes im DWH'
)

AS

SELECT
   a.client_id
  ,lc_str.loc_sid_store
  ,lc_str.src_orig_store_nr
  ,org_wh.src_wh_id
  ,d.item_sid
  ,a.dwh_cal_dt
  ,to_number(to_char(a.dwh_cal_dt,'YYYYMM')) AS cy_month
  ,SUM
   (
     CASE WHEN c.cond_type_cd IN ('ZPRA','ZPRP') AND e.src_mtart IN ('ZVM','ZKM') AND a.invoice_class_cd = 'ZFPU'
          THEN (b.cond_subtotal_2 - b.cond_subtotal_1)

           WHEN e.src_mtart IN ('ZVM','ZKM')
            AND a.invoice_class_cd = 'ZFPU'
           THEN 0
          ELSE (b.net_val + b.tax_val)
     END
   ) AS retail_val
  ,SUM
   (
     CASE WHEN c.cond_type_cd IN ('ZPRA','ZPRP') AND e.src_mtart IN ('ZVM','ZKM') AND a.invoice_class_cd = 'ZFPU'

          THEN (b.cond_subtotal_2 - b.cond_subtotal_1)

          WHEN e.src_mtart IN ('ZVM','ZKM')
            AND a.invoice_class_cd = 'ZFPU'
           THEN 0
          ELSE b.net_val
     END
   ) AS retail_net_val
  ,SUM(b.qty_act) AS qty_act
  ,CURRENT_TIMESTAMP(6) AS dwh_updated

FROM P_LEW_CORE_AC.v_retail_sales_record_2 AS a

INNER JOIN P_LEW_CORE_AC.v_retail_sales_record_pos_2 AS b
ON b.client_id = a.client_id
  AND b.retail_sales_record_id = a.retail_sales_record_id
  AND b.dwh_cal_dt = a.dwh_cal_dt

/* Zordnung der Filialen */
INNER JOIN P_LEW_BIL.v_store_2 AS lc_str
ON b.client_id = lc_str.client_id
  AND b.loc_sid = lc_str.loc_sid_store
  AND lc_str.dwh_actual_fg = 1        /* Aktueller Datensatz*/
  AND lc_str.test_store_fg = 0        /* Keine Testfiliale*/
  AND lc_str.pseudo_store_fg = 0

/* Zuordnung der Hauptlieferwerkbeziehungen Filiale zu Lager */
INNER JOIN P_LEW_BIL.v_store_to_warehouse_lastknown_2 s_to_wh
ON b.client_id = s_to_wh.client_id
  AND b.loc_sid = s_to_wh.loc_sid_store

/* Es werden auf die echten Lager eingeschraenkt */
INNER JOIN P_LEW_BIL.v_warehouse_2 AS org_wh
ON s_to_wh.client_id = org_wh.client_id
  AND s_to_wh.loc_sid_wh = org_wh.loc_sid_wh
  AND org_wh.dwh_actual_fg = 1
  AND org_wh.active_fg = 1
  AND org_wh.bges_active_fg = 1

/* Zuordnung der v_item_hist_2 zu v_item_type_2, um die Artikelarten e.src_mtart heranzuziehen.
 Die Artikelarten sind relevant fuer Filterkriterien
 v_item_2 bietet diese nicht an, sondern die src_matnr (Artikelnummer)*/
INNER JOIN P_LEW_CORE_AC.v_item_hist_2 AS d
ON b.client_id = d.client_id
  AND b.item_sid = d.item_sid
  AND d.deleted_fg = 0
  AND CURRENT_DATE BETWEEN d.dwh_valid_from AND d.dwh_valid_to

 /* src_mtart zum Filtern von bestimmten Artikelarten herangezogen fuer die Umsaetze*/
LEFT JOIN P_LEW_CORE_AC.v_item_type_2 AS e
ON  d.client_id = e.client_id
  AND d.item_type_sid = e.item_type_sid

/* Artikel_2 die zu ignorieren sind  */
LEFT JOIN P_LEW_PROCESS_AC.v_item_type_ignore_2 AS ig
ON     a.client_id = ig.client_id
  AND e.src_mtart =  ig.item_type_cd
  AND 
    (
      (
       ig.client_id IN (33, 34) 
       AND ig.item_type_cd  NOT IN ('ZKM', 'ZVM')
      )
      OR ig.client_id NOT IN (33, 34)
    ) 
  AND ig.item_type_grp_cd IN ('BAGLEVY')

/* Ermittlung der Provisionserloese */
LEFT JOIN P_LEW_CORE_AC.v_retail_sales_record_pos_cond_2 AS c
ON b.client_id =  c.client_id
  AND  b.retail_sales_record_id = c.retail_sales_record_id
  AND b.retail_sales_record_pos_id = c.retail_sales_record_pos_id
  AND c.cond_type_cd IN ('ZPRA', 'ZPRP')

 /* Filter auf Store nicht relevant, da die View v_store_2 Stammdatenview/tabelle
 und die Zuordnung der Hauptlieferwerkbeziehungen zu den Stores herangezogen wurden*/
WHERE a.invoice_class_cd NOT IN ('ZF91','ZS01') /* Inter-Company Umsaetze mussen ausgeschlossen werden */
  AND ig.item_type_cd IS NULL

GROUP BY 1,2,3,4,5,6,7
;