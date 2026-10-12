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


CREATE OR REPLACE VIEW ldl_p_lew_bil.v_mat_agg_inv_return_item_store_day (client_id
OPTIONS(description='Landeskennzeichen'), loc_sid_store OPTIONS(description='enthaelt surrogate Key des Stores'),
src_orig_store_nr OPTIONS(description='WAWI Quellsystemschluessel Filiale'), src_wh_id
OPTIONS(description='natural Key des dem Store zugeordneten Warehouses'), item_sid
OPTIONS(description='Surrogate Key Item'), dwh_cal_dt OPTIONS(description='Bezugsdatum'), cy_month
OPTIONS(description='Monat des Geschaeftsjahres im Format "JJJJMM"'), ship_qty
OPTIONS(description='Menge in Erfassungsmengeneinheit'), gross_val
OPTIONS(description='GROSS final SFO amount mapped, according to column sfo_type_cd'), sales_net_val
OPTIONS(description='#N-A')) OPTIONS(DESCRIPTION = `VIEW`) AS /* Take the sales price from Sales condition table */
/* Ungefilterte Artikelarten */ SELECT MOV.client_id,
 LC_STR.loc_sid_store,
 LC_STR.src_orig_store_nr,
 ORG_WH.src_wh_id,
 D.item_sid,
 ROUND(CAST(FORMAT_DATE('%Y%m', MOV.dwh_cal_dt) AS BIGNUMERIC), 0) AS dwh_cal_dt,
 ROUND(CAST(FORMAT_DATE('%Y%m', MOV.dwh_cal_dt) AS BIGNUMERIC), 0) AS cy_month,
 SUM(MOV.ship_qty) AS ship_qty,
 SUM(MOV.ship_qty * COALESCE(PRC.cond_val_eff_calc, 0)) AS gross_val,
 SUM(CAST(MOV.ship_qty * COALESCE(PRC.cond_val_eff_calc, 0) * 100 / (100 + COALESCE(PRC.tax_rate_calc, 0)) AS NUMERIC))
 AS sales_net_val
FROM ldl_p_lew_core_ac.v_item_movement_record_pos AS MOV
 LEFT JOIN ldl_p_lew_bil.v_item_loc_sales_cond_denorm AS PRC ON MOV.client_id = PRC.client_id AND MOV.item_sid = PRC.item_sid
       AND MOV.loc_sid = PRC.loc_sid AND MOV.uom_sid_base = PRC.uom_sid_cond AND MOV.dwh_cal_dt BETWEEN PRC.dwh_valid_from
   AND PRC.dwh_valid_to /* Zuordnung der */
 INNER JOIN ldl_p_lew_bil.v_store AS LC_STR ON MOV.client_id = LC_STR.client_id AND MOV.loc_sid = LC_STR.loc_sid_store
    AND LC_STR.dwh_actual_fg = 1 /* Aktueller Datensatz */ AND LC_STR.test_store_fg = 0 /* Keine Testfiliale */ AND
   LC_STR.pseudo_store_fg = 0 /* Zuordnung Store zu Niederlassung/BGes */
 INNER JOIN ldl_p_lew_bil.v_store_to_warehouse_lastknown AS S_TO_WH ON MOV.client_id = S_TO_WH.client_id AND MOV.loc_sid
    = S_TO_WH.loc_sid_store /* Es werden auf die echten Lager eingeschraenkt */
 INNER JOIN ldl_p_lew_bil.v_warehouse AS ORG_WH ON S_TO_WH.client_id = ORG_WH.client_id AND S_TO_WH.loc_sid_wh = ORG_WH
      .loc_sid_wh AND ORG_WH.dwh_actual_fg = 1 AND ORG_WH.active_fg = 1 AND ORG_WH.bges_active_fg = 1
   /* Zuordnung um die v_item_type zu joinen */
 INNER JOIN ldl_p_lew_core_ac.v_item_hist AS D ON MOV.client_id = D.client_id AND MOV.item_sid = D.item_sid AND
    CURRENT_DATE BETWEEN D.dwh_valid_from AND D.dwh_valid_to AND D.deleted_fg = 0
   /* Attribut src_mtart benoetigt zum Filtern von bestimmten Artikelarten in der v_itm_type_ignore */
 LEFT JOIN ldl_p_lew_core_ac.v_item_type AS E ON D.client_id = E.client_id AND D.item_type_sid
   /* Zu ignorierende Artikelarten */ = E.item_type_sid
 LEFT JOIN ldl_p_lew_process_ac.v_item_type_ignore AS IG ON D.client_id = IG.client_id AND E.src_mtart = IG.item_type_cd
      AND (IG.client_id IN (33, 34) AND IG.item_type_cd NOT IN ('ZKM', 'ZVM') OR IG.client_id NOT IN (33, 34)) AND IG.item_type_grp_cd
    IN ('BAGLEVY', 'INV')
  /* 921/922 - Mindermenge bei Retourenpruefung im Lager / Storno;
   923/924 - Mehrmenge bei Retourenpruefung im Lager / Storno;
   925/926 - Nach Retoure Buchung des Sollbestand auf Null (Mindermenge) / Storno;
   927/928 - Nach Retoure Buchung des Sollbestand auf Null (Mehrmenge) / Storno;
   911/912 - Ablehnung Minderlieferung Reklamation, Bestand Filiale wird nicht zurueck korrigiert / Storno;
   913/914 - Ablehnung Mehrlieferung Reklamation, Bestand Filiale wird nicht zurueck korrigiert / Storno; */
  
WHERE MOV.move_type_cd IN ('911', '912', '913', '914', '921', '922', '923', '924', '925', '926', '927', '928')
 AND IG.item_type_cd IS NULL
 AND MOV.ledger_account_cd IS NOT NULL
GROUP BY MOV.client_id,
 LC_STR.loc_sid_store,
 LC_STR.src_orig_store_nr,
 ORG_WH.src_wh_id,
 D.item_sid,
 MOV.dwh_cal_dt,
 cy_month;