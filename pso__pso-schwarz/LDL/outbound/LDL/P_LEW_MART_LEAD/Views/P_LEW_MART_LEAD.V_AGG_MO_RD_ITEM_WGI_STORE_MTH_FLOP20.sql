CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_mo_rd_item_wgi_store_mth_flop20 (client_id
OPTIONS(description='MIS Client ID'), move_to_store_id OPTIONS(description='S-Key der Location, hier der Filiale'),
wh_id OPTIONS(description='WAREHOUSE ID'), wh_id_exp OPTIONS(description='WAREHOUSE EXP ID'), aspect_id
OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'), orig_item_nr
OPTIONS(description='Ursprüngliche Artikelnummer (fachlicher Schlüssel)'), itemgroup_int_id
OPTIONS(description='Warengruppe ID'), dat_valid_from OPTIONS(description='Startdatum der Validität für Artikel'),
cy_month OPTIONS(description='Bezugsdatum'), rep_mth_flag OPTIONS(description='Flag für MO-Reporting'), sales_manager_id
OPTIONS(description='VERKAUFSLEITER'), account_manager_id OPTIONS(description='VERTRIEBSLEITER'), currency_iso_cd
OPTIONS(description='3 stelliger ISO-Währungs-Code'), val_rtl_net_sfo_store_mth
OPTIONS(description='Tagessumme der Abschriften in Landeswährung'), val_rtl_net_sfo_qty_mth
OPTIONS(description='Tagessumme der Abschriften in Stk/kg'), sales_net_val_mth OPTIONS(description='Umsatz Tagesebene'),
val_rtl_net_sfo_pct_mth OPTIONS(description='Tagessumme der Abschriften in %'), rank_itm_itmgroup
OPTIONS(description='Artikelrang basierend auf Abschriftenwert je WG'), rank_itm_total
OPTIONS(description='Artikelrang basierend auf Abschriftenwert ohne WG'), rank_itm_sm
OPTIONS(description='RANG DES ARTIKELS AUF VERKAUFSLEITER-EBENE'), rank_itm_am
OPTIONS(description='RANG DES ARTIKELS AUF VERTRIEBSLEITER-EBENE'), dwh_updated
OPTIONS(description='Technischer Zeitstempel'))
OPTIONS(DESCRIPTION = `AGGREGIERTE ABSCHRIFTEN - SCHLÜSSEL: CLIENT_ID/ORIG_STORE_NR/DAT_FORMDATE`) AS SELECT DISTINCT *
FROM ldl_p_lew_mart_lead.t_agg_mo_rd_item_wgi_store_mth_flop20 AS AGG;