/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: sql for daily load of table P_LEW_MART_LEAD.t_agg_mo_item_wgi_store_day_flop20_1
#----------------------------------------------------------------------------
# History:
#  1.0  22.05.2023     Marvin Rekovsky       Initial Version of script
#  1.1  28.06.2023     Stefan Sockel         Added cumulative calculations
#----------------------------------------------------------------------------
*/


/* #-----------------------------------------------------------------------------
# Description:
# This view provides a list of the Flop20 items with the granularity of store/item_1/day
#
#-----------------------------------------------------------------------------
# History:
#  1.0     13.03.2023      Marvin Rekovsky           Initial Version
#  1.1	   27.06.2023	   Stefan Sockel			 Update cumulated values
#  1.2	   05.07.2023	   Stefan Sockel			 Added partial week in row number over partition to avoid double rows
#----------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_mo_item_wgi_store_day_flop20_1 (client_id
OPTIONS(description='MIS Client ID'), wh_id OPTIONS(description='Gesellschaft ID'), move_to_store_id
OPTIONS(description='S-Key der Location_1, hier der Filiale'), orig_store_nr OPTIONS(description='Fachliche Store ID'),
aspect_id OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), dat_formdate
OPTIONS(description='Bezugsdatum'), cy_week OPTIONS(description='Geschäftsjahr - Woche_1 Id - Format \"JJJJWW\"'),
cy_month OPTIONS(description='Monat_1 des Geschäftsjahres im Format \"JJJJMM\"'), busyear
OPTIONS(description='Geschäftsjahr'), currency_iso_cd OPTIONS(description='3 stelliger ISO-Währungs-Code'), orig_item_nr
OPTIONS(description='Ursprüngliche Artikelnummer (fachlicher Schlüssel)'), itemgroup_int_id
OPTIONS(description='Warengruppe ID'), sales_net_val_day OPTIONS(description='Umsatz Tagesebene'), sales_net_val_day_py
OPTIONS(description='Umsatz Tagesebene VJ'), val_rtl_net_sfo_store_day
OPTIONS(description='Tagessumme der Abschriften_1 in Landeswährung'), val_rtl_net_sfo_store_day_py
OPTIONS(description='Tagessumme der Abschriften_1 in Landeswährung VJ'), val_rtl_net_sfo_qty_day
OPTIONS(description='Tagessumme der Abschriften_1 in Stk/kg'), val_rtl_net_sfo_pct_day
OPTIONS(description='Tagessumme der Abschriften_1 in %'), rank_item
OPTIONS(description='Artikelrang basierend auf Abschriftenwert'), dat_valid_from
OPTIONS(description='Startdatum der Validität für Artikel_1'), dat_valid_to
OPTIONS(description='Enddatum der Validität für Artikel_1'), dwh_updated OPTIONS(description='Technischer Zeitstempel'))
OPTIONS(DESCRIPTION = `Aggregierte Abschriften_1 - Schlüssel: client_id/store_id/dat_formdate`) AS SELECT *
FROM (SELECT DISTINCT AGG.client_id,
   ASM.wh_id,
   ASM.move_to_store_id,
   ASM.orig_store_nr,
   ASM.aspect_id,
   AGG.dat_formdate,
   AGG.cy_week,
   AGG.cy_month,
   AGG.busyear,
   AGG.currency_iso_cd,
   AGG.orig_item_nr,
   AGG.itemgroup_int_id,
   AGG.sales_net_val_day,
   AGG.sales_net_val_day_py,
   AGG.val_rtl_net_sfo_store_day,
   AGG.val_rtl_net_sfo_store_day_py,
   AGG.val_rtl_net_sfo_qty_day,
   AGG.val_rtl_net_sfo_pct_day,
   ROW_NUMBER() OVER (PARTITION BY CAST(AGG.client_id AS STRING), ASM.wh_id, CAST(ASM.orig_store_nr AS STRING), CAST(ASM.move_to_store_id AS STRING)
      , AGG.dat_formdate, CAST(AGG.itemgroup_int_id AS STRING), AGG.currency_iso_cd, CAST(AGG.cy_week_partial_week_id AS STRING)
      ORDER BY AGG.val_rtl_net_sfo_store_day IS NULL, AGG.val_rtl_net_sfo_store_day, AGG.val_rtl_net_sfo_pct_day IS NULL
      , AGG.val_rtl_net_sfo_pct_day, AGG.orig_item_nr IS NULL, AGG.orig_item_nr) AS rank_item,
   AGG.dwh_valid_from AS dat_valid_from,
   AGG.dwh_valid_to AS dat_valid_to,
   AGG.dwh_updated
  FROM ldl_p_lew_mart_lead.t_agg_mo_item_wgi_store_day_flop20_1 AS AGG
   INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge_1 AS ASM ON AGG.client_id = ASM.client_id AND AGG.loc_sid_store =
     ASM.move_to_store_id
  WHERE AGG.val_rtl_net_sfo_store_day IS NOT NULL
   AND ASM.mis_store_active_fg = 1
   AND ASM.aspect_id = 2) AS t1_1
WHERE t1.rank_item <= 20;