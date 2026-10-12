/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_STORE_DAY_FA_PRCLC_2
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-05-05 Tris Bayliff            Initial version
#                                         20200309_2424_QuickView_remove_dum
#
#----------------------------------------------------------------------------
*/

/*
#-------------------------------------------------------------------------------
#  Table DDL
#-------------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_qv_agg_store_day_fa_prclc_2 (
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
aspect_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Gesellschaftsform (1 = Betriebs- 2 = Vertriebsgesellschaft)'),
aspect_desc STRING(4) COLLATE 'und:ci' OPTIONS(description='Gesellschaftsform Bezeichnung'),
currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Iso-Code Waehrung'),
curr_tot_id BIGNUMERIC(38,0) OPTIONS(description='Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'),
dat_formdate DATE NOT NULL OPTIONS(description='\u00C3\u201Enderungsdatum'),
mis_store_active_fg BIGNUMERIC(38,0) OPTIONS(description='MIS Flag zur Kennzeichnung aktiver Filialen'),
val_retail_net_fa_ejr NUMERIC(19,5) OPTIONS(description='Umsatz Food Aktion_2 EJR (net value)'),
val_retail_net_fa_ejr_py NUMERIC(19,5) OPTIONS(description='Umsatz Food Aktion_2 EJR (net value), Vorjahr'),
val_retail_net_ejr NUMERIC(19,5) OPTIONS(description='Umsatz EJR (net value)'),
val_retail_net_ejr_py NUMERIC(19,5) OPTIONS(description='Umsatz EJR (net value), Vorjahr'),
val_retail_gross_fa_ejr NUMERIC(19,5) OPTIONS(description='Umsatz Food Aktion_2 EJR (gross value)'),
val_retail_gross_fa_ejr_py NUMERIC(19,5) OPTIONS(description='Umsatz Food Aktion_2 EJR (gross value), Vorjahr'),
val_retail_gross_ejr NUMERIC(19,5) OPTIONS(description='Umsatz EJR (gross value)'),
val_retail_gross_ejr_py NUMERIC(19,5) OPTIONS(description='Umsatz EJR (gross value), Vorjahr'),
val_pr_diff_gross_fa_del NUMERIC(19,5) OPTIONS(description='PV-Preisdifferenzen ALM Food Aktion_2 Basis (gross value)'),
val_pr_diff_gross_fa_del_py NUMERIC(19,5)
OPTIONS(description='PV-Preisdifferenzen ALM Food Aktion_2 Basis (gross value), Vorjahr'),
val_pr_diff_net_fa_del NUMERIC(19,5) OPTIONS(description='PV-Preisdifferenzen ALM Food Aktion_2 Basis (net value)'),
val_pr_diff_net_fa_del_py NUMERIC(19,5)
OPTIONS(description='PV-Preisdifferenzen ALM Food Aktion_2 Basis (net value), Vorjahr'),
val_pr_diff_gross_fa_sfo NUMERIC(19,5) OPTIONS(description='PV-Preisdifferenzen SFO Food Aktion_2 Basis (gross value)'),
val_pr_diff_gross_fa_sfo_py NUMERIC(19,5)
OPTIONS(description='PV-Preisdifferenzen SFO Food Aktion_2 Basis (gross value), Vorjahr'),
val_pr_diff_net_fa_sfo NUMERIC(19,5) OPTIONS(description='PV-Preisdifferenzen SFO Food Aktion_2 Basis (net value)'),
val_pr_diff_net_fa_sfo_py NUMERIC(19,5)
OPTIONS(description='PV-Preisdifferenzen SFO Food Aktion_2 Basis (net value), Vorjahr'),
val_rtl_rl_gro_fa_sfo_asis NUMERIC(19,5) OPTIONS(description='PVs Wert Basismetrik Food Aktion_2 (gross value)'),
val_rtl_rl_gro_fa_sfo_asis_py NUMERIC(19,5)
OPTIONS(description='PVs Wert Basismetrik Food Aktion_2 (gross value), Vorjahr'),
val_rtl_rl_net_fa_sfo_asis NUMERIC(19,5) OPTIONS(description='PVs Wert Basismetrik Food Aktion_2 (net value)'),
val_rtl_rl_net_fa_sfo_asis_py NUMERIC(19,5) OPTIONS(description='PVs Wert Basismetrik Food Aktion_2 (net value), Vorjahr'),
val_prdff_rtrn_gro_fa_sfo NUMERIC(19,5)
OPTIONS(description='BNL Preisdifferenzen Ruecksendungen (NF) Food Aktion_2 |Sfo| (gross value)'),
val_prdff_rtrn_gro_fa_sfo_py NUMERIC(19,5)
OPTIONS(description='BNL Preisdifferenzen Ruecksendungen (NF) Food Aktion_2 |Sfo| (gross value), Vorjahr'),
val_prdff_rtrn_net_fa_sfo NUMERIC(19,5)
OPTIONS(description='BNL Preisdifferenzen Ruecksendungen (NF) Food Aktion_2 |Sfo| (net value)'),
val_prdff_rtrn_net_fa_sfo_py NUMERIC(19,5)
OPTIONS(description='BNL Preisdifferenzen Ruecksendungen (NF) Food Aktion_2 |Sfo| (net value), Vorjahr'),
val_adj_gro_fa_sfo_store NUMERIC(19,5) OPTIONS(description='Abschriften_2 Filiale Food Aktion_2 (gross value)'),
val_adj_gro_fa_sfo_store_py NUMERIC(19,5) OPTIONS(description='Abschriften_2 Filiale Food Aktion_2 (gross value), Vorjahr'),
val_adj_net_fa_sfo_store NUMERIC(19,5) OPTIONS(description='Abschriften_2 Filiale Food Aktion_2 (net value)'),
val_adj_net_fa_sfo_store_py NUMERIC(19,5) OPTIONS(description='Abschriften_2 Filiale Food Aktion_2 (net value), Vorjahr'),
qty_sales_fa_ejr NUMERIC(19,5) OPTIONS(description='Abverkauf Stk./kg nur Food Action'),
qty_sales_fa_ejr_py NUMERIC(19,5) OPTIONS(description='Abverkauf Stk./kg nur Food Action, Vorjahr'),
cnt_day_store BIGNUMERIC(38,0) OPTIONS(description='Anzahl Fililale Tage'),
cnt_day_store_py BIGNUMERIC(38,0) OPTIONS(description='Anzahl Fililale Tage, Vorjahr'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load identifier'),
dwh_created DATETIME NOT NULL OPTIONS(description='Record created timestamp'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Record updated timestamp')
) CLUSTER BY client_id, dat_formdate
OPTIONS(description='Table contains the base data for the QuickView cube Foodaction. Data is provided by store and day.');