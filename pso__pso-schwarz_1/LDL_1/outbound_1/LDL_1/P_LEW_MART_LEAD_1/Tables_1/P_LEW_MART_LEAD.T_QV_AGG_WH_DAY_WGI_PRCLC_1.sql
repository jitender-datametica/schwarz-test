/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_WH_DAY_WGI_PRCLC_1
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 04.05.2020 Rodrigo Cione           20200309_2424_QuickView_remove_dum
#
#----------------------------------------------------------------------------
*/

/*
#-------------------------------------------------------------------------------
# Table DDL
#-------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_qv_agg_wh_day_wgi_prclc_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Landeskennzeichen'),
client_desc STRING(35) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Landes'),
country_group_id BIGNUMERIC(38,0) OPTIONS(description='Landesgruppe Kennzeichen'),
country_group_desc STRING(60) COLLATE 'und:ci' OPTIONS(description='Landesgruppe Bezeichnung'),
gl_region_id BIGNUMERIC(38,0) OPTIONS(description='Geschaeftsleitungsregion ID'),
gl_region_desc STRING(60) COLLATE 'und:ci' OPTIONS(description='Beschreibung Geschaeftsleitungsregion'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesellschaftsnummer'),
wh_desc STRING(50) COLLATE 'und:ci' OPTIONS(description='Gesellschaftsbezeichnung'),
aspect_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
aspect_desc STRING(4) COLLATE 'und:ci' OPTIONS(description='Gesellschaftsform Bezeichnung'),
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='Iso-Code Waehrung'),
curr_tot_id BIGNUMERIC(38,0) OPTIONS(description='Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'),
itemgroup_int_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikelgruppe international - WAWI Code'),
itemgroup_int_desc STRING(40) COLLATE 'und:ci' OPTIONS(description='Artikelgruppe International - Bezeichnung'),
mis_store_active_fg BIGNUMERIC(38,0) OPTIONS(description='MIS Flag zur Kennzeichnung aktiver Filialen'),
dat_formdate DATE NOT NULL OPTIONS(description='Aenderungsdatum'),
cnt_miss_item BIGNUMERIC(38,0) OPTIONS(description='Anzahl Fehlartikel pro Gesellschaft und Tag_1'),
cnt_miss_item_py BIGNUMERIC(38,0) OPTIONS(description='Anzahl Fehlartikel pro Gesellschaft und Tag_1, Vorjahr'),
cnt_dat_miss_item BIGNUMERIC(38,0) OPTIONS(description='Anzahl Tage (Fehlartikel)'),
cnt_dat_miss_item_py BIGNUMERIC(38,0) OPTIONS(description='Anzahl Tage (Fehlartikel), Vorjahr'),
val_roc_prclc_wh FLOAT64 OPTIONS(description='Reichweite Lager - Nominator in EP'),
val_roc_prclc_wh_py FLOAT64 OPTIONS(description='Reichweite Lager - Nominator in EP, Vorjahr'),
avg_stc_wh FLOAT64 OPTIONS(description='durchschn.-Bestand des Artikles in EP'),
avg_stc_wh_py FLOAT64 OPTIONS(description='durchschn.-Bestand des Artikles in EP, Vorjahr'),
val_retail_gross_ejr NUMERIC(19,5) OPTIONS(description='Umsatz EJR (gross value)'),
val_retail_gross_ejr_py NUMERIC(19,5) OPTIONS(description='Umsatz EJR (gross value), Vorjahr'),
val_retail_gross_total_ejr NUMERIC(19,5) OPTIONS(description='Umsatz EJR uebergreifend (gross value)'),
val_retail_gross_total_ejr_py NUMERIC(19,5) OPTIONS(description='Umsatz EJR uebergreifend (gross value), Vorjahr'),
val_retail_net_ejr NUMERIC(19,5) OPTIONS(description='Umsatz EJR (net value)'),
val_retail_net_ejr_py NUMERIC(19,5) OPTIONS(description='Umsatz EJR (net value), Vorjahr'),
val_retail_net_total_ejr NUMERIC(19,5) OPTIONS(description='VK_1 netto uebergreifend'),
val_retail_net_total_ejr_py NUMERIC(19,5) OPTIONS(description='VK_1 netto uebergreifend, Vorjahr'),
val_pr_adj_gross_sfo_asis NUMERIC(19,5)
OPTIONS(description='Preisveraenderungen ohne Preisgebietsdifferenzen (gross value)'),
val_pr_adj_gross_sfo_asis_py NUMERIC(19,5)
OPTIONS(description='Preisveraenderungen ohne Preisgebietsdifferenzen (gross value), Vorjahr'),
val_pr_adj_net_sfo_asis NUMERIC(19,5)
OPTIONS(description='Preisveraenderungen ohne Preisgebietsdifferenzen (net value)'),
val_pr_adj_net_sfo_asis_py NUMERIC(19,5)
OPTIONS(description='Preisveraenderungen ohne Preisgebietsdifferenzen (net value), Vorjahr'),
val_pr_diff_gross_del NUMERIC(19,5) OPTIONS(description='PV-Preisdifferenzen ALM Basis (gross value)'),
val_pr_diff_gross_del_py NUMERIC(19,5) OPTIONS(description='PV-Preisdifferenzen ALM Basis (gross value), Vorjahr'),
val_pr_diff_net_del NUMERIC(19,5) OPTIONS(description='PV-Preisdifferenzen ALM Basis (net value)'),
val_pr_diff_net_del_py NUMERIC(19,5) OPTIONS(description='PV-Preisdifferenzen ALM Basis (net value), Vorjahr'),
val_pr_diff_gross_sfo NUMERIC(19,5) OPTIONS(description='SQL PV-Preisdifferenzen SFO Basis (gross value)'),
val_pr_diff_gross_sfo_py NUMERIC(19,5) OPTIONS(description='SQL PV-Preisdifferenzen SFO Basis (gross value), Vorjahr'),
val_pr_diff_net_sfo NUMERIC(19,5) OPTIONS(description='SQL PV-Preisdifferenzen SFO Basis (net value)'),
val_pr_diff_net_sfo_py NUMERIC(19,5) OPTIONS(description='SQL PV-Preisdifferenzen SFO Basis (net value), Vorjahr'),
val_buying_net_rcv NUMERIC(19,5) OPTIONS(description='EK netto inkl. Sonderkonditionen'),
val_buying_net_rcv_py NUMERIC(19,5) OPTIONS(description='EK netto inkl. Sonderkonditionen, Vorjahr'),
val_retail_net_rcv NUMERIC(19,5) OPTIONS(description='VK_1 netto'),
val_retail_net_rcv_py NUMERIC(19,5) OPTIONS(description='VK_1 netto, Vorjahr'),
val_adj_gross_sfo_wh NUMERIC(19,5) OPTIONS(description='Abschriften_1 Lager (gross value)'),
val_adj_gross_sfo_wh_py NUMERIC(19,5) OPTIONS(description='Abschriften_1 Lager (gross value), Vorjahr'),
val_adj_net_sfo_wh NUMERIC(19,5) OPTIONS(description='Abschriften_1 Lager (net value)'),
val_adj_net_sfo_wh_py NUMERIC(19,5) OPTIONS(description='Abschriften_1 Lager (net value), Vorjahr'),
val_prdff_rtrn_gro_sfo NUMERIC(19,5) OPTIONS(description='BNL Preisdifferenzen Ruecksendungen (NF) |Sfo| (gross value)'),
val_prdff_rtrn_gro_sfo_py NUMERIC(19,5)
OPTIONS(description='BNL Preisdifferenzen Ruecksendungen (NF) |Sfo| (gross value), Vorjahr'),
val_prdff_rtrn_net_sfo NUMERIC(19,5) OPTIONS(description='BNL Preisdifferenzen Ruecksendungen (NF) |Sfo| (net value)'),
val_prdff_rtrn_net_sfo_py NUMERIC(19,5)
OPTIONS(description='BNL Preisdifferenzen Ruecksendungen (NF) |Sfo| (net value), Vorjahr'),
val_adj_gross_sfo_store NUMERIC(19,5) OPTIONS(description='Abschriften_1 Filiale (gross value)'),
val_adj_gross_sfo_store_py NUMERIC(19,5) OPTIONS(description='Abschriften_1 Filiale (gross value), Vorjahr'),
val_adj_net_sfo_store NUMERIC(19,5) OPTIONS(description='Abschriften_1 Filiale (net value)'),
val_adj_net_sfo_store_py NUMERIC(19,5) OPTIONS(description='Abschriften_1 Filiale (net value), Vorjahr'),
qty_sales_ejr NUMERIC(19,5) OPTIONS(description='Abverkauf Stk./kg'),
qty_sales_ejr_py NUMERIC(19,5) OPTIONS(description='Abverkauf Stk./kg, Vorjahr'),
cnt_day_store BIGNUMERIC(38,0) OPTIONS(description='Anzahl Fililale Tage'),
cnt_day_store_py BIGNUMERIC(38,0) OPTIONS(description='Anzahl Fililale Tage, Vorjahr'),
val_retail_net_fa_ejr NUMERIC(19,5) OPTIONS(description='Umsatz Food Aktion_1 EJR (net value)'),
val_retail_net_fa_ejr_py NUMERIC(19,5) OPTIONS(description='Umsatz Food Aktion_1 EJR (net value), Vorjahr'),
val_retail_net_total_fa_ejr NUMERIC(19,5) OPTIONS(description='VK_1 Food Aktion_1 netto uebergreifend'),
val_retail_net_total_fa_ejr_py NUMERIC(19,5) OPTIONS(description='VK_1 Food Aktion_1 netto uebergreifend, Vorjahr'),
val_pr_diff_net_fa_del NUMERIC(19,5) OPTIONS(description='PV-Preisdifferenzen ALM Food Aktion_1 Basis (net value)'),
val_pr_diff_net_fa_del_py NUMERIC(19,5)
OPTIONS(description='PV-Preisdifferenzen ALM Food Aktion_1 Basis (net value), Vorjahr'),
val_pr_diff_net_fa_sfo NUMERIC(19,5) OPTIONS(description='PV-Preisdifferenzen SFO Food Aktion_1 Basis (net value)'),
val_pr_diff_net_fa_sfo_py NUMERIC(19,5)
OPTIONS(description='PV-Preisdifferenzen SFO Food Aktion_1 Basis (net value), Vorjahr'),
val_rtl_rl_net_fa_sfo_asis NUMERIC(19,5) OPTIONS(description='PVs Wert Basismetrik Food Aktion_1 (net value)'),
val_rtl_rl_net_fa_sfo_asis_py NUMERIC(19,5) OPTIONS(description='PVs Wert Basismetrik Food Aktion_1 (net value), Vorjahr'),
val_buying_net_fa_rcv NUMERIC(19,5) OPTIONS(description='EK netto inkl. Sonderkonditionen Food Aktion_1'),
val_buying_net_fa_rcv_py NUMERIC(19,5) OPTIONS(description='EK netto inkl. Sonderkonditionen Food Aktion_1, Vorjahr'),
val_retail_net_fa_rcv NUMERIC(19,5) OPTIONS(description='VK_1 netto Food Aktion_1'),
val_retail_net_fa_rcv_py NUMERIC(19,5) OPTIONS(description='VK_1 netto Food Aktion_1, Vorjahr'),
qty_sales_fa_ejr NUMERIC(19,5) OPTIONS(description='Abverkauf Stk./kg nur Food Action'),
qty_sales_fa_ejr_py NUMERIC(19,5) OPTIONS(description='Abverkauf Stk./kg nur Food Action, Vorjahr'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load Identification'),
dwh_created DATETIME NOT NULL OPTIONS(description='Insert record timestamp'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Update record timestamp')
) CLUSTER BY client_id, dat_formdate
OPTIONS(description='Table');