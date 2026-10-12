/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: sql for daily load of table P_LEW_MART_LEAD.T_AGG_MO_RD_ITEM_WGI_STORE_MTH_FLOP20_1
#----------------------------------------------------------------------------
# History:
#  1.0  06.09.2023     Stefan Sockel         Initial version of Redesign
#  1.1  24.04.2024     Stefan Sockel         Added new ranks and identifier for VT and VL
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_mo_rd_item_wgi_store_mth_flop20_1 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='MIS CLIENT ID'),
move_to_store_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='S-KEY DER LOCATION_1, HIER DER FILIALE'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WAREHOUSE ID'),
wh_id_exp BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WAREHOUSE EXP ID'),
aspect_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='GESELLSCHAFTSFORM (1 = BETRIEBS- 2 = VERTRIEBSGESELLSCHAFT)'),
orig_item_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='URSPRÜNGLICHE ARTIKELNUMMER (FACHLICHER SCHLÜSSEL)'),
itemgroup_int_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='WARENGRUPPE ID'),
dat_valid_from DATE NOT NULL OPTIONS(description='STARTDATUM DER VALIDITÄT FÜR ARTIKEL_1'),
cy_month BIGNUMERIC(38,0) NOT NULL OPTIONS(description='MONAT_1 DES GESCHÄFTSJAHRES IM FORMAT\"JJJJMM\"'),
rep_mth_flag BIGNUMERIC(38,0) NOT NULL OPTIONS(description='FLAG FÜR MO-REPORTING'),
sales_manager_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='VERKAUFSLEITER'),
account_manager_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='VERTRIEBSLEITER'),
currency_iso_cd STRING(3) COLLATE 'und:ci' OPTIONS(description='3 STELLIGER ISO-WÄHRUNGS-CODE'),
val_rtl_net_sfo_store_mth BIGNUMERIC(38,5) OPTIONS(description='TAGESSUMME DER ABSCHRIFTEN_1 IN LANDESWÄHRUNG'),
val_rtl_net_sfo_qty_mth BIGNUMERIC(38,5) OPTIONS(description='TAGESSUMME DER ABSCHRIFTEN_1 IN STK/KG'),
sales_net_val_mth BIGNUMERIC(38,5) OPTIONS(description='UMSATZ TAGESEBENE'),
val_rtl_net_sfo_pct_mth BIGNUMERIC(38,5) OPTIONS(description='TAGESSUMME DER ABSCHRIFTEN_1 IN %'),
rank_itm_itmgroup BIGNUMERIC(38,0) OPTIONS(description='RANG DES ARTIKELS AUF WG-EBENE'),
rank_itm_total BIGNUMERIC(38,0) OPTIONS(description='RANG DES ARTIKELS OHNE WG-EBENE'),
rank_itm_sm BIGNUMERIC(38,0) OPTIONS(description='RANG DES ARTIKELS AUF VERKAUFSLEITER-EBENE'),
rank_itm_am BIGNUMERIC(38,0) OPTIONS(description='RANG DES ARTIKELS AUF VERTRIEBSLEITER-EBENE'),
dwh_updated DATETIME OPTIONS(description='TECHNISCHER ZEITSTEMPEL')
) CLUSTER BY client_id, cy_month
OPTIONS(description='Aggregierte Abschriften_1 - Schlüssel: client_id/orig_store_nr/dat_formdate');