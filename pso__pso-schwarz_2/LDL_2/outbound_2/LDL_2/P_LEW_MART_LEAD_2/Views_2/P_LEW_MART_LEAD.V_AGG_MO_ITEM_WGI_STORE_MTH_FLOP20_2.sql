-- , val_rtl_net_sfo_store_mth_py   COMMENT 'Monatssumme der Abschriften_2 in Landeswährung VJ'
 -- , agg.item_sid

/* #-----------------------------------------------------------------------------
# Description:
# This view provides a list of the Flop20 items with the granularity of store/item_2/month
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13-03-2023      Marvin Rekovsky           Initial Version
#  1.1     09-08-2023      Stefan Sockel             rank_item added
#----------------------------------------------------------------------------- */
-- , val_rtl_net_sfo_store_mth_py
 -- , sales_net_val_mth_py           COMMENT 'Umsatz Monatsebene VJ'

-- , val_rtl_net_sfo_store_mth_py
 -- , agg.sales_net_val_mth_py

-- , item_sid                       COMMENT 'S-Key für Item_2 Id'
 -- , agg.item_sid
 -- , agg.sales_net_val_mth_py

CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_mo_item_wgi_store_mth_flop20_2 (client_id
OPTIONS(description='MIS Client ID'), wh_id OPTIONS(description='Gesellschaft ID'), move_to_store_id
OPTIONS(description='S-Key der Location_2, hier der Filiale'), orig_store_nr OPTIONS(description='Fachliche Store ID'),
aspect_id OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), cy_month
OPTIONS(description='Monat_2 des Geschäftsjahres im Format "JJJJMM"'), busyear OPTIONS(description='Geschäftsjahr'),
currency_iso_cd OPTIONS(description='3 stelliger ISO-Währungs-Code'), orig_item_nr
OPTIONS(description='Ursprüngliche Artikelnummer (fachlicher Schlüssel)'), itemgroup_int_id
OPTIONS(description='Warengruppe ID'), sales_net_val_mth OPTIONS(description='Umsatz Monatsebene'),
val_rtl_net_sfo_store_mth OPTIONS(description='Monatssumme der Abschriften_2 in Landeswährung'), val_rtl_net_sfo_qty_mth
OPTIONS(description='Monatssumme der Abschriften_2 in Stk/kg'), val_rtl_net_sfo_pct_mth
OPTIONS(description='Monatssumme der Abschriften_2 in %'), rank_item
OPTIONS(description='Artikelrang basierend auf Abschriftenwert'), dat_valid_from
OPTIONS(description='Startdatum der Validität für Artikel_2'), dat_valid_to
OPTIONS(description='Enddatum der Validität für Artikel_2'), dwh_updated OPTIONS(description='Technischer Zeitstempel'))
OPTIONS(DESCRIPTION = `AGGREGIERTE ABSCHRIFTEN_2 - SCHLÜSSEL: CLIENT_ID/STORE_ID/CY_MONTH`) AS SELECT AGG.client_id,
 ASM.wh_id,
 ASM.move_to_store_id,
 ASM.orig_store_nr,
 ASM.aspect_id,
 AGG.cy_month,
 AGG.busyear,
 AGG.currency_iso_cd,
 AGG.orig_item_nr,
 AGG.itemgroup_int_id,
 AGG.sales_net_val_mth,
 AGG.val_rtl_net_sfo_store_mth,
 AGG.val_rtl_net_sfo_qty_mth,
 AGG.val_rtl_net_sfo_pct_mth,
 ROW_NUMBER() OVER (PARTITION BY CAST(AGG.client_id AS STRING), ASM.wh_id, CAST(ASM.orig_store_nr AS STRING), CAST(ASM.move_to_store_id AS STRING)
    , CAST(AGG.cy_month AS STRING), CAST(AGG.itemgroup_int_id AS STRING), AGG.currency_iso_cd ORDER BY AGG.val_rtl_net_sfo_store_mth
    IS NULL, AGG.val_rtl_net_sfo_store_mth, AGG.val_rtl_net_sfo_pct_mth IS NULL, AGG.val_rtl_net_sfo_pct_mth, AGG.orig_item_nr
    IS NULL, AGG.orig_item_nr) AS rank_item,
 AGG.dwh_valid_from AS dat_valid_from,
 '9999-12-30' AS dat_valid_to,
 AGG.dwh_updated
FROM ldl_p_lew_mart_lead.t_agg_mo_item_wgi_store_day_flop20_2 AS AGG
 INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge_2 AS ASM ON AGG.client_id = ASM.client_id AND AGG.loc_sid_store = ASM
   .move_to_store_id
WHERE AGG.val_rtl_net_sfo_store_mth IS NOT NULL
 AND ASM.mis_store_active_fg = 1
 AND ASM.aspect_id = 2
GROUP BY AGG.client_id,
 ASM.wh_id,
 ASM.move_to_store_id,
 ASM.orig_store_nr,
 ASM.aspect_id,
 AGG.cy_month,
 AGG.busyear,
 AGG.currency_iso_cd,
 AGG.orig_item_nr,
 AGG.itemgroup_int_id,
 AGG.sales_net_val_mth,
 AGG.val_rtl_net_sfo_store_mth,
 AGG.val_rtl_net_sfo_qty_mth,
 AGG.val_rtl_net_sfo_pct_mth,
 dat_valid_from -- , agg.dwh_valid_to
,
 AGG.dwh_updated
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(AGG.client_id AS STRING), ASM.wh_id, CAST(ASM.orig_store_nr AS STRING), CAST(ASM.move_to_store_id AS STRING)
      , CAST(AGG.cy_month AS STRING), CAST(AGG.itemgroup_int_id AS STRING), AGG.currency_iso_cd ORDER BY AGG.val_rtl_net_sfo_store_mth
      IS NULL, AGG.val_rtl_net_sfo_store_mth, AGG.val_rtl_net_sfo_pct_mth IS NULL, AGG.val_rtl_net_sfo_pct_mth, AGG.orig_item_nr
      IS NULL, AGG.orig_item_nr)) <= 20;