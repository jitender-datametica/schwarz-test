/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS.T_SPACEMAN_STORE_ITEM_PERFORMANCE
#----------------------------------------------------------------------------
# History:
#  1.0  09.11.2020    Morris, Michael               20201109_2650_spaceman (REP4-7909) - Initial version.
#                                                   https://jira.schwarz/browse/REP4-7909
#  1.1  29.01.2021    Morris, Michael               Transferred to Snowflake
#  1.2  17.08.2021    Morris, Michael               Additional columns added for transparency.
#                                                   REP4-8463
#  1.3  17.08.2022    Haus, Oliver                  Additional column item_status_id
#  1.7  22.02.2024    Raman Paneru                  Added Abverkauf woche and umsatz woche columns and changed data type for ob as INTEGER from NUMBER(9,2)
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_spaceman_store_item_performance (
export_cy_week BIGNUMERIC(38,0) NOT NULL OPTIONS(description='The last completed (closed) CW in the Export'),
export_version INTEGER NOT NULL OPTIONS(description='Version number of export data =0: Full, >0: Delta'),
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Internal client_id'),
filialnummer STRING(8) NOT NULL OPTIONS(description='Country Code (country_cd)'),
artikelnummer_lang STRING(21) NOT NULL OPTIONS(description='Store number (Business Key)'),
landeskurzel STRING(3) NOT NULL OPTIONS(description='Short Article Number (Business Key)'),
artikelnummer_kurz STRING(18) NOT NULL OPTIONS(description='Article Number including Case Size (Business Key)'),
artikelbezeichnung STRING(50) COLLATE 'und:ci' OPTIONS(description='Article description'),
vk_brutto NUMERIC(9,2) OPTIONS(description='Cuurent sales price'),
koliinhalt STRING(4) OPTIONS(description='Case Size'),
palletenfaktor STRING(8) OPTIONS(description='Pallet factor'),
marken STRING(50) COLLATE 'und:ci' OPTIONS(description='Brand name of article'),
wg_bezeichnung STRING(50) COLLATE 'und:ci' OPTIONS(description='Product group description'),
uwg STRING(5) OPTIONS(description='Product sub group'),
artikelfamilie STRING(10) OPTIONS(description='Product family'),
markenart STRING(3) OPTIONS(description='Brand type'),
ab1 NUMERIC(10,2) OPTIONS(description='Sales average last 9 weeks'),
ab2 NUMERIC(10,2) OPTIONS(description='Sales average last 12 weeks'),
ab3 NUMERIC(10,2) OPTIONS(description='Sales average last 24 weeks'),
ab4 NUMERIC(10,2) OPTIONS(description='Sales average last 52 weeks'),
ob NUMERIC(10,2) OPTIONS(description='Projected inventory requirement'),
abverkauf_woche NUMERIC(18,5) OPTIONS(description='Sales pieces with dependency to Net time worked flag'),
umsatz_woche NUMERIC(18,5) OPTIONS(description='worked flag'),
shelf_life_store BIGNUMERIC(38,0) OPTIONS(description='Shelf Life in store'),
shelf_life_cust BIGNUMERIC(38,0) OPTIONS(description='Shelf life after sale'),
store_days_open BIGNUMERIC(38,0) OPTIONS(description='Number of store open days per week'),
item_status_id BIGNUMERIC(38,0) OPTIONS(description='Item Status'),
export_tstmp DATETIME OPTIONS(description='Export Timestamp for this version of export_cy_week'),
export_full_tstmp DATETIME OPTIONS(description='Export Timestamp for version 0 of export_cy_week'),
exported_fg BIGNUMERIC(38,0)
OPTIONS(description='Feedback Flag for Export Reader to flag that the data has been successfully exported')
) CLUSTER BY client_id, export_cy_week, export_version
OPTIONS(description='Table for Spaceman Export Data');