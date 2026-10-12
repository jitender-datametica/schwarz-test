/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_STORE_DAY_WGI_PRCLC
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-06-23 Prasanna Ranjan         20200309_2424_QuickView_remove_dum
#
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
# Table DDL
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_qv_agg_store_day_wgi_prclc (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Landeskennzeichen'),
client_desc STRING(35) COLLATE 'und:ci' OPTIONS(description='Bezeichnung des Landes'),
account_manager_id BIGNUMERIC(38,0) OPTIONS(description='Vertriebsleiter-Nr.'),
account_manager_name STRING(50) COLLATE 'und:ci' OPTIONS(description='Vertriebsleiter-Name'),
sales_manager_id BIGNUMERIC(38,0) OPTIONS(description='Bezirksleiter-Nr.'),
sales_manager_name STRING(50) COLLATE 'und:ci' OPTIONS(description='Bezirksleiter-Name'),
move_to_store_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filial-Nr. nach letztem Filialumzug'),
move_store_desc STRING(50) COLLATE 'und:ci' OPTIONS(description='Filialname nach letztem Filialumzug'),
wh_id BIGNUMERIC(38,0) OPTIONS(description='Gesellschaftsnummer'),
wh_desc STRING(50) COLLATE 'und:ci' OPTIONS(description='Gesellschaftsbezeichnung'),
wh_id_exp BIGNUMERIC(38,0) OPTIONS(description='Gesellschafts-Nr.-exp'),
aspect_id BIGNUMERIC(38,0) OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
aspect_desc STRING(4) COLLATE 'und:ci' OPTIONS(description='Gesellschaftsform Bezeichnung'),
currency_iso_cd STRING(3) COLLATE 'und:ci' OPTIONS(description='Iso-Code Waehrung'),
curr_tot_id BIGNUMERIC(38,0) OPTIONS(description='Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'),
itemgroup_int_id BIGNUMERIC(38,0) OPTIONS(description='Artikelgruppe international - WAWI Code'),
itemgroup_int_desc STRING(40) COLLATE 'und:ci' OPTIONS(description='Artikelgruppe International - Bezeichnung'),
dat_formdate DATE NOT NULL OPTIONS(description='\u00C4nderungsdatum'),
mis_store_active_fg BIGNUMERIC(38,0) OPTIONS(description='MIS Flag zur Kennzeichnung aktiver Filialen'),
val_retail_gross_ejr NUMERIC(19,5) OPTIONS(description='Umsatz EJR (gross value)'),
val_retail_gross_ejr_py NUMERIC(19,5) OPTIONS(description='Umsatz EJR (gross value), Vorjahr'),
val_retail_gross_total_ejr NUMERIC(19,5) OPTIONS(description='Umsatz EJR uebergreifend (gross value)'),
val_retail_gross_total_ejr_py NUMERIC(19,5) OPTIONS(description='Umsatz EJR uebergreifend (gross value), Vorjahr'),
val_retail_net_ejr NUMERIC(19,5) OPTIONS(description='Umsatz EJR (net value)'),
val_retail_net_ejr_py NUMERIC(19,5) OPTIONS(description='Umsatz EJR (net value), Vorjahr'),
val_retail_net_total_ejr NUMERIC(19,5) OPTIONS(description='VK netto uebergreifend'),
val_retail_net_total_ejr_py NUMERIC(19,5) OPTIONS(description='VK netto uebergreifend, Vorjahr'),
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
val_prdff_rtrn_gro_sfo NUMERIC(19,5) OPTIONS(description='BNL Preisdifferenzen Ruecksendungen (NF) |Sfo| (gross value)'),
val_prdff_rtrn_gro_sfo_py NUMERIC(19,5)
OPTIONS(description='BNL Preisdifferenzen Ruecksendungen (NF) |Sfo| (gross value), Vorjahr'),
val_prdff_rtrn_net_sfo NUMERIC(19,5) OPTIONS(description='BNL Preisdifferenzen Ruecksendungen (NF) |Sfo| (net value)'),
val_prdff_rtrn_net_sfo_py NUMERIC(19,5)
OPTIONS(description='BNL Preisdifferenzen Ruecksendungen (NF) |Sfo| (net value), Vorjahr'),
val_adj_gross_sfo_store NUMERIC(19,5) OPTIONS(description='Abschriften Filiale (gross value)'),
val_adj_gross_sfo_store_py NUMERIC(19,5) OPTIONS(description='Abschriften Filiale (gross value), Vorjahr'),
val_adj_net_sfo_store NUMERIC(19,5) OPTIONS(description='Abschriften Filiale (net value)'),
val_adj_net_sfo_store_py NUMERIC(19,5) OPTIONS(description='Abschriften Filiale (net value), Vorjahr'),
qty_sales_ejr NUMERIC(19,5) OPTIONS(description='Abverkauf Stk./kg'),
qty_sales_ejr_py NUMERIC(19,5) OPTIONS(description='Abverkauf Stk./kg, Vorjahr'),
cnt_day_store BIGNUMERIC(38,0) OPTIONS(description='Anzahl Fililale Tage'),
cnt_day_store_py BIGNUMERIC(38,0) OPTIONS(description='Anzahl Fililale Tage, Vorjahr'),
val_retail_net_fa_ejr NUMERIC(19,5) OPTIONS(description='Umsatz Food Aktion EJR (net value)'),
val_retail_net_fa_ejr_py NUMERIC(19,5) OPTIONS(description='Umsatz Food Aktion EJR (net value), Vorjahr'),
val_retail_net_total_fa_ejr NUMERIC(19,5) OPTIONS(description='VK Food Aktion netto uebergreifend'),
val_retail_net_total_fa_ejr_py NUMERIC(19,5) OPTIONS(description='VK Food Aktion netto uebergreifend, Vorjahr'),
val_pr_diff_net_fa_del NUMERIC(19,5) OPTIONS(description='PV-Preisdifferenzen ALM Food Aktion Basis (net value)'),
val_pr_diff_net_fa_del_py NUMERIC(19,5)
OPTIONS(description='PV-Preisdifferenzen ALM Food Aktion Basis (net value), Vorjahr'),
val_pr_diff_net_fa_sfo NUMERIC(19,5) OPTIONS(description='PV-Preisdifferenzen SFO Food Aktion Basis (net value)'),
val_pr_diff_net_fa_sfo_py NUMERIC(19,5)
OPTIONS(description='PV-Preisdifferenzen SFO Food Aktion Basis (net value), Vorjahr'),
val_rtl_rl_net_fa_sfo_asis NUMERIC(19,5) OPTIONS(description='PVs Wert Basismetrik Food Aktion (net value)'),
val_rtl_rl_net_fa_sfo_asis_py NUMERIC(19,5) OPTIONS(description='PVs Wert Basismetrik Food Aktion (net value), Vorjahr'),
qty_sales_fa_ejr NUMERIC(19,5) OPTIONS(description='Abverkauf Stk./kg nur Food Action'),
qty_sales_fa_ejr_py NUMERIC(19,5) OPTIONS(description='Abverkauf Stk./kg nur Food Action, Vorjahr'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created timestamp'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated timestamp')
) CLUSTER BY client_id, dat_formdate
OPTIONS(description='Table');