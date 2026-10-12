/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.T_QV_AGG_WH_DAY_SELL_PRCLC_1
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2020-05-04 Rodrigo Cione           20200309_2424_QuickView_remove_dum
#
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
# Table DDL
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_qv_agg_wh_day_sell_prclc_1 (
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
val_adj_gross_sfo_store NUMERIC(19,5) OPTIONS(description='Abschriften_1 Filiale (gross value)'),
val_adj_gross_sfo_store_py NUMERIC(19,5) OPTIONS(description='Abschriften_1 Filiale (gross value), Vorjahr'),
val_adj_net_sfo_store NUMERIC(19,5) OPTIONS(description='Abschriften_1 Filiale (net value)'),
val_adj_net_sfo_store_py NUMERIC(19,5) OPTIONS(description='Abschriften_1 Filiale (net value), Vorjahr'),
val_rtl_gro_wt_hrs_net NUMERIC(19,5) OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden (gross value)'),
val_rtl_gro_wt_hrs_net_py NUMERIC(19,5)
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden (gross value), Vorjahr'),
val_rtl_net_wt_hrs_net NUMERIC(19,5) OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden (net value)'),
val_rtl_net_wt_hrs_net_py NUMERIC(19,5)
OPTIONS(description='Umsatz an Tagen mit effektiven Arbeitsstunden (net value), Vorjahr'),
val_retail_gross_asis NUMERIC(19,5) OPTIONS(description='Umsatz (gross value)'),
val_retail_gross_asis_py NUMERIC(19,5) OPTIONS(description='Umsatz (gross value), Vorjahr'),
val_retail_net_asis NUMERIC(19,5) OPTIONS(description='Umsatz (net value)'),
val_retail_net_asis_py NUMERIC(19,5) OPTIONS(description='Umsatz (net value), Vorjahr'),
wt_hrs_net NUMERIC(19,5) OPTIONS(description='Arbeitsstunden effektiv'),
wt_hrs_net_py NUMERIC(19,5) OPTIONS(description='Arbeitsstunden effektiv, Vorjahr'),
mt_hrs_net NUMERIC(19,5) OPTIONS(description='Schulungsstunden'),
mt_hrs_net_py NUMERIC(19,5) OPTIONS(description='Schulungsstunden, Vorjahr'),
dwh_load_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Load Identification'),
dwh_created DATETIME NOT NULL OPTIONS(description='Insert record timestamp'),
dwh_updated DATETIME NOT NULL OPTIONS(description='Update record timestamp')
) CLUSTER BY client_id, dat_formdate
OPTIONS(description='Table contains the base data for the QuickView cube Ware Verkaufen. Data is provided by wh and day.');