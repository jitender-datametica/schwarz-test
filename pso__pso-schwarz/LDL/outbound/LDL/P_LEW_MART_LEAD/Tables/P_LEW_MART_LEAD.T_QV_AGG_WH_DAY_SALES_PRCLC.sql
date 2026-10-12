/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_WH_DAY_SALES_PRCLC
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-06-23 Rodrigo Cione           20200309_2424_QuickView_remove_dum
#
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
# Table DDL
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_qv_agg_wh_day_sales_prclc (
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
currency_iso_cd STRING(3) COLLATE 'und:ci' NOT NULL OPTIONS(description='Iso-Code Waehrung'),
curr_tot_id BIGNUMERIC(38,0) OPTIONS(description='Fixe Werte fuer EUR=0, GBP=40 sonst Client_Id'),
dat_formdate DATE NOT NULL OPTIONS(description='Aenderungsdatum'),
mis_store_active_fg BIGNUMERIC(38,0) OPTIONS(description='MIS Flag zur Kennzeichnung aktiver Filialen'),
val_retail_net_asis NUMERIC(19,5) OPTIONS(description='Umsatz (net value)'),
val_retail_net_asis_py NUMERIC(19,5) OPTIONS(description='Umsatz (net value), Vorjahr'),
cnt_customer_asis NUMERIC(19,5) OPTIONS(description='Anzahl der aktuellen Kunden'),
cnt_customer_asis_py NUMERIC(19,5) OPTIONS(description='Anzahl der aktuellen Kunden, Vorjahr'),
val_retail_gross_asis NUMERIC(19,5) OPTIONS(description='Umsatz (gross value)'),
val_retail_gross_asis_py NUMERIC(19,5) OPTIONS(description='Umsatz (gross value), Vorjahr'),
cnt_customer_adj_asis NUMERIC(19,5) OPTIONS(description='Anzahl der aktuellen Kunden bereinigt'),
cnt_customer_adj_asis_py NUMERIC(19,5) OPTIONS(description='Anzahl der aktuellen Kunden bereinigt, Vorjahr'),
cnt_customer_adj_asis_ppy NUMERIC(19,5) OPTIONS(description='Anzahl der aktuellen Kunden bereinigt, Vorvorjahr'),
val_retail_net_adj_asis NUMERIC(19,5) OPTIONS(description='Umsatz bereinigt (net value)'),
val_retail_net_adj_asis_py NUMERIC(19,5) OPTIONS(description='Umsatz bereinigt (net value), Vorjahr'),
val_retail_net_adj_asis_ppy NUMERIC(19,5) OPTIONS(description='Umsatz bereinigt (net value), Vorvorjahr'),
val_retail_gross_adj_asis NUMERIC(19,5) OPTIONS(description='Umsatz bereinigt (gross value)'),
val_retail_gross_adj_asis_py NUMERIC(19,5) OPTIONS(description='Umsatz bereinigt (gross value), Vorjahr'),
val_retail_gross_adj_asis_ppy NUMERIC(19,5) OPTIONS(description='Umsatz bereinigt (gross value), Vorvorjahr'),
val_rtl_gro_extrapol_asis NUMERIC(19,5) OPTIONS(description='Umsatz vorausgerechnet (gross value)'),
val_rtl_net_extrapol_asis NUMERIC(19,5) OPTIONS(description='Umsatz vorausgerechnet (net value)'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load Identification'),
dwh_created DATETIME NOT NULL OPTIONS(description='Insert record timestamp'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Update record timestamp')
) CLUSTER BY client_id, dat_formdate
OPTIONS(description='Table');