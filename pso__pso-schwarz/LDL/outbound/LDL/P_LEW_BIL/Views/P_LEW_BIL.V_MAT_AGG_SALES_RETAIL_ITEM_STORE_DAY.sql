/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_MAT_AGG_SALES_RETAIL_ITEM_STORE_DAY
#----------------------------------------------------------------------------
# History:
#  1.0  06.12.2017    Patrick Mittler          Change name of Object (itm to item) and remove columnalias for the BIL-Object.
#  1.1  11.12.2017    Patrick Mittler          Adjust columns retail_val and retail_net_val
#  1.1  11.12.2017    Patrick Mittler          Adjust columns retail_val and retail_net_val
#  1.2  17.01.2018    Wieber,Harald            Update Release 2.2
#  1.3  28.02.2018    Taubkin, Slavik          Umstellung auf last_known Views
#  1.4  02.03.2018    Meister,Ulrich           Spaltenkommentare wieder hinzugefuegt
#  1.5  26.06.2018    Maria Gnech              Delta column dwh_updated added
#                                              20180615_1712_Sync_DPE_lew_bil_DM2 (IDMO-636)
#  1.6  22.02.2021    Prasanna Ranjan          REP2-9080 - Include item types ZKM and ZVM from USA and Serbia
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_agg_sales_retail_item_store_day (client_id
OPTIONS(description='Landeskennzeichen'), loc_sid_store OPTIONS(description='enthaelt surrogate Key des Stores'),
src_orig_store_nr OPTIONS(description='WAWI Quellsystemschluessel Filiale'), src_wh_id
OPTIONS(description='natural Key des dem Store zugeordneten Warehouses'), item_sid
OPTIONS(description='Surrogate Key Item'), dwh_cal_dt OPTIONS(description='Bezugsdatum'), cy_month
OPTIONS(description='Monat des Geschaeftsjahres im Format "JJJJMM"'), retail_val OPTIONS(description=''), retail_net_val
OPTIONS(description=''), qty_act
OPTIONS(description='Tatsaechlich fakturierte Menge; SAP-Retail: vbrp.fkimg; SAP-BW: t_bw_2lis_13_vditm.fkimg; ELWIS: t_s_retail_sales_record_pos.qty_act'),
dwh_updated OPTIONS(description='Zeitstempel der letzten Aenderung des Datensatzes im DWH'))
OPTIONS(DESCRIPTION = `VIEW`) AS /* Inter-Company Umsaetze mussen ausgeschlossen werden */ SELECT A.client_id,
 LC_STR.loc_sid_store,
 LC_STR.src_orig_store_nr,
 ORG_WH.src_wh_id,
 D.item_sid,
 ROUND(CAST(FORMAT_DATE('%Y%m', A.dwh_cal_dt) AS BIGNUMERIC), 0) AS dwh_cal_dt,
 ROUND(CAST(FORMAT_DATE('%Y%m', A.dwh_cal_dt) AS BIGNUMERIC), 0) AS cy_month,
 SUM(CASE
   WHEN C.cond_type_cd IN ('ZPRA', 'ZPRP') AND E.src_mtart IN ('ZVM', 'ZKM') AND A.invoice_class_cd = 'ZFPU'
   THEN B.cond_subtotal_2 - B.cond_subtotal_1
   WHEN E.src_mtart IN ('ZVM', 'ZKM') AND A.invoice_class_cd = 'ZFPU'
   THEN 0
   ELSE B.net_val + B.tax_val
   END) AS retail_val,
 SUM(CASE
   WHEN C.cond_type_cd IN ('ZPRA', 'ZPRP') AND E.src_mtart IN ('ZVM', 'ZKM') AND A.invoice_class_cd = 'ZFPU'
   THEN B.cond_subtotal_2 - B.cond_subtotal_1
   WHEN E.src_mtart IN ('ZVM', 'ZKM') AND A.invoice_class_cd = 'ZFPU'
   THEN 0
   ELSE B.net_val
   END) AS retail_net_val,
 SUM(B.qty_act) AS qty_act,
 CURRENT_TIMESTAMP() AS dwh_updated
FROM ldl_p_lew_core_ac.v_retail_sales_record AS A
 INNER JOIN ldl_p_lew_core_ac.v_retail_sales_record_pos AS B ON A.client_id = B.client_id AND A.retail_sales_record_id =
    B.retail_sales_record_id AND A.dwh_cal_dt /* Zordnung der Filialen */ = B.dwh_cal_dt
 INNER JOIN ldl_p_lew_bil.v_store AS LC_STR ON B.client_id = LC_STR.client_id AND B.loc_sid = LC_STR.loc_sid_store AND
     LC_STR.dwh_actual_fg = 1 /* Aktueller Datensatz */ AND LC_STR.test_store_fg = 0 /* Keine Testfiliale */ AND LC_STR
   .pseudo_store_fg = 0 /* Zuordnung der Hauptlieferwerkbeziehungen Filiale zu Lager */
 INNER JOIN ldl_p_lew_bil.v_store_to_warehouse_lastknown AS S_TO_WH ON B.client_id = S_TO_WH.client_id AND B.loc_sid =
   S_TO_WH.loc_sid_store /* Es werden auf die echten Lager eingeschraenkt */
 INNER JOIN ldl_p_lew_bil.v_warehouse AS ORG_WH ON S_TO_WH.client_id = ORG_WH.client_id AND S_TO_WH.loc_sid_wh = ORG_WH
      .loc_sid_wh AND ORG_WH.dwh_actual_fg = 1 AND ORG_WH.active_fg = 1 AND ORG_WH.bges_active_fg = 1
   /* Zuordnung der v_item_hist zu v_item_type, um die Artikelarten e.src_mtart heranzuziehen.
 Die Artikelarten sind relevant fuer Filterkriterien
 v_item bietet diese nicht an, sondern die src_matnr (Artikelnummer) */
   
 INNER JOIN ldl_p_lew_core_ac.v_item_hist AS D ON B.client_id = D.client_id AND B.item_sid = D.item_sid AND D.deleted_fg
     = 0 AND CURRENT_DATE BETWEEN D.dwh_valid_from AND D.dwh_valid_to
   /* src_mtart zum Filtern von bestimmten Artikelarten herangezogen fuer die Umsaetze */
 LEFT JOIN ldl_p_lew_core_ac.v_item_type AS E ON D.client_id = E.client_id AND D.item_type_sid = E.item_type_sid
   /* Artikel die zu ignorieren sind */
 LEFT JOIN ldl_p_lew_process_ac.v_item_type_ignore AS IG ON A.client_id = IG.client_id AND E.src_mtart = IG.item_type_cd
      AND (IG.client_id IN (33, 34) AND IG.item_type_cd NOT IN ('ZKM', 'ZVM') OR IG.client_id NOT IN (33, 34)) AND IG.item_type_grp_cd
    IN ('BAGLEVY') /* Ermittlung der Provisionserloese */
 LEFT JOIN ldl_p_lew_core_ac.v_retail_sales_record_pos_cond AS C ON B.client_id = C.client_id AND B.retail_sales_record_id
      = C.retail_sales_record_id AND B.retail_sales_record_pos_id = C.retail_sales_record_pos_id AND C.cond_type_cd IN ('ZPRA'
    , 'ZPRP')
  /* Filter auf Store nicht relevant, da die View v_store Stammdatenview/tabelle
 und die Zuordnung der Hauptlieferwerkbeziehungen zu den Stores herangezogen wurden */
  
WHERE IG.item_type_cd IS NULL
 AND A.invoice_class_cd NOT IN ('ZF91', 'ZS01')
GROUP BY A.client_id,
 LC_STR.loc_sid_store,
 LC_STR.src_orig_store_nr,
 ORG_WH.src_wh_id,
 D.item_sid,
 A.dwh_cal_dt,
 cy_month;