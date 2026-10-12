/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_WH_DAY_BUY_PRCLC_1
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
#----------------------------------------------------------------------------
# Table DDL
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_qv_agg_wh_day_buy_prclc_1 (
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
dat_formdate DATE NOT NULL OPTIONS(description='Aenderungsdatum'),
mis_store_active_fg BIGNUMERIC(38,0) OPTIONS(description='MIS Flag zur Kennzeichnung aktiver Filialen'),
val_pr_diff_gross_sfo_asis NUMERIC(19,5) OPTIONS(description='SQL PV-Preisdifferenzen SFO Basis (gross value)'),
val_pr_diff_gross_sfo_asis_py NUMERIC(19,5)
OPTIONS(description='SQL PV-Preisdifferenzen SFO Basis (gross value), Vorjahr'),
val_pr_diff_net_sfo_asis NUMERIC(19,5) OPTIONS(description='SQL PV-Preisdifferenzen SFO Basis (net value)'),
val_pr_diff_net_sfo_asis_py NUMERIC(19,5) OPTIONS(description='SQL PV-Preisdifferenzen SFO Basis (net value), Vorjahr'),
val_pr_diff_gross_del_asis NUMERIC(19,5) OPTIONS(description='PV-Preisdifferenzen ALM Basis (gross value)'),
val_pr_diff_gross_del_asis_py NUMERIC(19,5) OPTIONS(description='PV-Preisdifferenzen ALM Basis (gross value), Vorjahr'),
val_pr_diff_net_del_asis NUMERIC(19,5) OPTIONS(description='PV-Preisdifferenzen ALM Basis (net value)'),
val_pr_diff_net_del_asis_py NUMERIC(19,5) OPTIONS(description='PV-Preisdifferenzen ALM Basis (net value), Vorjahr'),
val_pr_adj_gross_sfo_asis NUMERIC(19,5)
OPTIONS(description='Preisveraenderungen ohne Preisgebietsdifferenzen (gross value)'),
val_pr_adj_gross_sfo_asis_py NUMERIC(19,5)
OPTIONS(description='Preisveraenderungen ohne Preisgebietsdifferenzen (gross value), Vorjahr'),
val_pr_adj_net_sfo_asis NUMERIC(19,5)
OPTIONS(description='Preisveraenderungen ohne Preisgebietsdifferenzen (net value)'),
val_pr_adj_net_sfo_asis_py NUMERIC(19,5)
OPTIONS(description='Preisveraenderungen ohne Preisgebietsdifferenzen (net value), Vorjahr'),
val_retail_gross_asis NUMERIC(19,5) OPTIONS(description='Umsatz (gross value)'),
val_retail_gross_asis_py NUMERIC(19,5) OPTIONS(description='Umsatz (gross value), Vorjahr'),
val_retail_net_asis NUMERIC(19,5) OPTIONS(description='Umsatz (net value)'),
val_retail_net_asis_py NUMERIC(19,5) OPTIONS(description='Umsatz (net value), Vorjahr'),
val_retail_net_rcv NUMERIC(19,5) OPTIONS(description='VK_1 netto'),
val_retail_net_rcv_py NUMERIC(19,5) OPTIONS(description='VK_1 netto, Vorjahr'),
val_buying_net_rcv NUMERIC(19,5) OPTIONS(description='EK netto inkl. Sonderkonditionen'),
val_buying_net_rcv_py NUMERIC(19,5) OPTIONS(description='EK netto inkl. Sonderkonditionen, Vorjahr'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load Identification'),
dwh_created DATETIME NOT NULL OPTIONS(description='Insert record timestamp'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Update record timestamp')
) CLUSTER BY client_id, dat_formdate
OPTIONS(description='Table contains the base data for the QuickView cube Ware Einkaufen Data is provided by wh and day.');