/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_STORE_DAY_BUY_PRCLC
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


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_qv_agg_store_day_buy_prclc (
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
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='Iso-Code Waehrung'),
curr_tot_id BIGNUMERIC(38,0) OPTIONS(description='Fixe Werte fuer sonst Client_Id'),
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
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load Identification'),
dwh_created DATETIME NOT NULL OPTIONS(description='Insert record timestamp'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Update record timestamp')
) CLUSTER BY client_id, dat_formdate
OPTIONS(description='Table contains the base data for the QuickView cube Ware Einkaufen. Data is provided by store and day.');