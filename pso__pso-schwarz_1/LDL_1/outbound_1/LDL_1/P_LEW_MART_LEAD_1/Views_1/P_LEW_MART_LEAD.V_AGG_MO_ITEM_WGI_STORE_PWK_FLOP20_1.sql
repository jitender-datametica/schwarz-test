/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: sql for daily load of table P_LEW_MART_LEAD.t_agg_mo_item_wgi_store_day_flop20_1
#----------------------------------------------------------------------------
# History:
#  1.0  22-05-2023     Marvin Rekovsky       Initial Version of script
#  1.1  28-06-2023     Stefan Sockel         Added cumulative calculations
#----------------------------------------------------------------------------
*/


/* #-----------------------------------------------------------------------------
# Description:
# This view provides a list of the Flop20 items with the granularity of store/item_1/partial_week
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13.03.2023      Marvin Rekovsky           Initial Version
#  1.1	   27.06.2023	   Stefan Sockel			 Update cumulated values
#----------------------------------------------------------------------------- */
-- , agg.item_sid
 -- , agg.item_sid
 -- , agg.cy_month
 -- , agg.cy_month

-- , item_sid                       COMMENT 'S-Key für Item_1 Id'

-- , cy_month                       COMMENT 'Monat_1 des Geschäftsjahres im Format "JJJJMM"'

CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_mo_item_wgi_store_pwk_flop20_1 (client_id
OPTIONS(description='MIS Client ID'), wh_id OPTIONS(description='Gesellschaft ID'), move_to_store_id
OPTIONS(description='S-Key der Location_1, hier der Filiale'), orig_store_nr OPTIONS(description='Fachliche Store ID'),
aspect_id OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), cy_week
OPTIONS(description='Geschäftsjahr - Woche_1 Id - Format "JJJJWW"'), cy_week_partial_week_id
OPTIONS(description='Teilwoche: Format yyyywwn, n in (1,2,9)'), busyear OPTIONS(description='Geschäftsjahr'),
currency_iso_cd OPTIONS(description='3 stelliger ISO-Währungs-Code'), orig_item_nr
OPTIONS(description='Ursprüngliche Artikelnummer (fachlicher Schlüssel)'), itemgroup_int_id
OPTIONS(description='Warengruppe ID'), sales_net_val_pw OPTIONS(description='Umsatz Teilwochenebene'),
sales_net_val_pw_py OPTIONS(description='Umsatz Teilwochenebene VJ'), val_rtl_net_sfo_store_pw
OPTIONS(description='Teilwochensumme der Abschriften_1 in Landeswährung'), val_rtl_net_sfo_store_wk_py
OPTIONS(description='Teilwochensumme der Abschriften_1 in Landeswährung VJ'), val_rtl_net_sfo_qty_pw
OPTIONS(description='Teilwochensumme der Abschriften_1 in Stk/kg'), val_rtl_net_sfo_qty_mth_cum
OPTIONS(description='Teilwochensumme Monat_1 aufgelaufen der Abschriften_1 in Stk/kg'), val_rtl_net_sfo_pct_pw
OPTIONS(description='Teilwochensumme der Abschriften_1 in %'), sales_net_val_mth_cum
OPTIONS(description='Umsatz Teilwochenebene Monat_1 aufgel. (für Berechnung Umsatz Monat_1 aufgel.)'), sales_net_val_by_cum
OPTIONS(description='Umsatz Teilwochenebene GJ aufgel. (für Berechnung Umsatz GJ aufgel.)'), sales_net_val_mth_cum_py
OPTIONS(description='Umsatz Teilwochenebene Monat_1 VJ aufgel. (für Berechnung Umsatz Monat_1 VJ aufgel.)'),
sales_net_val_by_cum_py
OPTIONS(description='Umsatz Teilwochenebene GJ VJ aufgel. (für Berechnung Umsatz GJ VJ aufgel.)'),
val_rtl_net_sfo_store_mth_cum
OPTIONS(description='Abschriften_1 Teilwochenebene Monat_1 aufgel. (für Berechnung Abschriften_1 Monat_1 aufgel.)'),
val_rtl_net_sfo_store_by_cum
OPTIONS(description='Abschriften_1 Teilwochenebene GJ aufgel. (für Berechnung Abschriften_1 GJ aufgel.)'),
val_rtl_net_sfo_store_mth_cum_py
OPTIONS(description='Abschriften_1 Teilwochenebene Monat_1 VJ aufgel. (für Berechnung Abschriften_1 Monat_1 VJ aufgel.)'),
val_rtl_net_sfo_store_by_cum_py
OPTIONS(description='Abschriften_1 Teilwochenebene GJ VJ aufgel. (für Berechnung Abschriften_1 GJ VJ aufgel.)'), rank_item
OPTIONS(description='Artikelrang basierend auf Abschriftenwert'), dat_valid_from
OPTIONS(description='Startdatum der Validität für Artikel_1'), dat_valid_to
OPTIONS(description='Enddatum der Validität für Artikel_1'), dwh_updated OPTIONS(description='Technischer Zeitstempel'))
OPTIONS(DESCRIPTION = `AGGREGIERTE ABSCHRIFTEN_1 - SCHLÜSSEL: CLIENT_ID/STORE_ID/CY_WEEK_PARTIAL_WEEK_ID`) AS SELECT AGG.client_id
 ,
 ASM.wh_id,
 ASM.move_to_store_id,
 ASM.orig_store_nr,
 ASM.aspect_id,
 AGG.cy_week,
 AGG.cy_week_partial_week_id,
 AGG.busyear,
 AGG.currency_iso_cd,
 AGG.orig_item_nr,
 AGG.itemgroup_int_id,
 AGG.sales_net_val_pw,
 AGG.sales_net_val_pw_py,
 AGG.val_rtl_net_sfo_store_pw,
 AGG.val_rtl_net_sfo_store_wk_py,
 AGG.val_rtl_net_sfo_qty_pw,
 AGG.val_rtl_net_sfo_qty_mth_cum,
 AGG.val_rtl_net_sfo_pct_pw,
 AGG.sales_net_val_mth_cum,
 AGG.sales_net_val_by_cum,
 AGG.sales_net_val_mth_cum_py,
 AGG.sales_net_val_by_cum_py,
 AGG.val_rtl_net_sfo_store_mth_cum,
 AGG.val_rtl_net_sfo_store_by_cum,
 AGG.val_rtl_net_sfo_store_mth_cum_py,
 AGG.val_rtl_net_sfo_store_by_cum_py,
 ROW_NUMBER() OVER (PARTITION BY CAST(AGG.client_id AS STRING), ASM.wh_id, CAST(ASM.orig_store_nr AS STRING), CAST(ASM.move_to_store_id AS STRING)
    , CAST(AGG.cy_week_partial_week_id AS STRING), CAST(AGG.itemgroup_int_id AS STRING), AGG.currency_iso_cd ORDER BY
    AGG.val_rtl_net_sfo_store_pw IS NULL, AGG.val_rtl_net_sfo_store_pw, AGG.val_rtl_net_sfo_pct_pw IS NULL, AGG.val_rtl_net_sfo_pct_pw
    , AGG.orig_item_nr IS NULL, AGG.orig_item_nr) AS rank_item,
 AGG.dwh_valid_from AS dat_valid_from,
 AGG.dwh_valid_to AS dat_valid_to,
 AGG.dwh_updated
FROM ldl_p_lew_mart_lead.t_agg_mo_item_wgi_store_day_flop20_1 AS AGG
 INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge_1 AS ASM ON AGG.client_id = ASM.client_id AND AGG.loc_sid_store = ASM
   .move_to_store_id
WHERE AGG.val_rtl_net_sfo_store_pw IS NOT NULL
 AND ASM.mis_store_active_fg = 1
 AND ASM.aspect_id = 2
GROUP BY AGG.client_id,
 ASM.wh_id,
 ASM.move_to_store_id,
 ASM.orig_store_nr,
 ASM.aspect_id,
 AGG.cy_week,
 AGG.cy_week_partial_week_id,
 AGG.busyear,
 AGG.currency_iso_cd,
 AGG.orig_item_nr,
 AGG.itemgroup_int_id,
 AGG.sales_net_val_pw,
 AGG.sales_net_val_pw_py,
 AGG.val_rtl_net_sfo_store_pw,
 AGG.val_rtl_net_sfo_store_wk_py,
 AGG.val_rtl_net_sfo_qty_pw,
 AGG.val_rtl_net_sfo_qty_mth_cum,
 AGG.val_rtl_net_sfo_pct_pw,
 AGG.sales_net_val_mth_cum,
 AGG.sales_net_val_by_cum,
 AGG.sales_net_val_mth_cum_py,
 AGG.sales_net_val_by_cum_py,
 AGG.val_rtl_net_sfo_store_mth_cum,
 AGG.val_rtl_net_sfo_store_by_cum,
 AGG.val_rtl_net_sfo_store_mth_cum_py,
 AGG.val_rtl_net_sfo_store_by_cum_py,
 dat_valid_from,
 dat_valid_to,
 AGG.dwh_updated
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(AGG.client_id AS STRING), ASM.wh_id, CAST(ASM.orig_store_nr AS STRING), CAST(ASM.move_to_store_id AS STRING)
      , CAST(AGG.cy_week_partial_week_id AS STRING), CAST(AGG.itemgroup_int_id AS STRING), AGG.currency_iso_cd ORDER BY
      AGG.val_rtl_net_sfo_store_pw IS NULL, AGG.val_rtl_net_sfo_store_pw, AGG.val_rtl_net_sfo_pct_pw IS NULL, AGG.val_rtl_net_sfo_pct_pw
      , AGG.orig_item_nr IS NULL, AGG.orig_item_nr)) <= 20;