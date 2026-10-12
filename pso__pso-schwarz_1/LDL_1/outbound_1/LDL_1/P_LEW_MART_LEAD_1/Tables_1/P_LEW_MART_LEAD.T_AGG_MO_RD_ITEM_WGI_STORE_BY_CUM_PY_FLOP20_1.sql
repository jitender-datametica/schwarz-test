/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: sql for daily load of table P_LEW_MART_LEAD.T_AGG_MO_RD_ITEM_WGI_STORE_DAY_FLOP20_1
#----------------------------------------------------------------------------
# History:
#  1.0  20-09-2023     Stefan Sockel         Initial version of Redesign
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_agg_mo_rd_item_wgi_store_by_cum_py_flop20_1 (
client_id INTEGER NOT NULL OPTIONS(description='MIS CLIENT ID'),
move_to_store_id INTEGER NOT NULL OPTIONS(description='S-KEY DER LOCATION_1, HIER DER FILIALE'),
aspect_id INTEGER NOT NULL OPTIONS(description='GESELLSCHAFTSFORM (1 = BETRIEBS- 2 = VERTRIEBSGESELLSCHAFT)'),
orig_item_nr INTEGER NOT NULL OPTIONS(description='URSPRÜNGLICHE ARTIKELNUMMER (FACHLICHER SCHLÜSSEL)'),
dat_valid_from DATE NOT NULL OPTIONS(description='STARTDATUM DER VALIDITÄT FÜR ARTIKEL_1'),
cy_week_partial_week_id INTEGER NOT NULL OPTIONS(description='BEZUGSDATUM'),
currency_iso_cd STRING(3) COLLATE 'und:ci' OPTIONS(description='3 STELLIGER ISO-WÄHRUNGS-CODE'),
val_rtl_net_sfo_store_by_cum_py BIGNUMERIC(38,5) OPTIONS(description='TAGESSUMME DER ABSCHRIFTEN_1 IN LANDESWÄHRUNG'),
val_rtl_net_sfo_qty_by_cum_py BIGNUMERIC(38,5) OPTIONS(description='TAGESSUMME DER ABSCHRIFTEN_1 IN STK/KG'),
sales_net_val_by_cum_py BIGNUMERIC(38,5) OPTIONS(description='UMSATZ TAGESEBENE'),
val_rtl_net_sfo_pct_by_cum_py BIGNUMERIC(38,5) OPTIONS(description='TAGESSUMME DER ABSCHRIFTEN_1 IN %'),
rank_itm_total INTEGER OPTIONS(description='RANG DES ARTIKELS OHNE WG-EBENE'),
dwh_updated DATETIME OPTIONS(description='TECHNISCHER ZEITSTEMPEL')
) CLUSTER BY client_id, cy_week_partial_week_id
OPTIONS(description='Aggregierte Abschriften_1 - Schlüssel: client_id/orig_store_nr/dat_formdate');