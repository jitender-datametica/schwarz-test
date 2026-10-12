/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_WFM.T_STORE_STORAGE_REAL_STOCK_NF_ASIS_2 
#----------------------------------------------------------------------------
# History:
#  1.0  06.07.2023    Ulrich Ross        User Story 490502, Init 
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_wfm.t_store_storage_real_stock_nf_asis_2 (
client_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Landeskennung'),
country_lidl_cd STRING(20) NOT NULL OPTIONS(description='ISO-Code Land_2'),
orig_store_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filiale Nr'),
loc_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Filiale ID'),
wh_id BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Lager Nr'),
orig_item_nr BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_2 Nr'),
item_sid BIGNUMERIC(38,0) NOT NULL OPTIONS(description='Artikel_2 ID'),
stock_real_qty BIGNUMERIC(38,5) OPTIONS(description='Bestand der Filiale'),
valid_from_stockreal DATE OPTIONS(description='Datum von aktueller Bestand'),
valid_to_stockreal DATE OPTIONS(description='Datum bis aktueller Bestand'),
store_storage_qty BIGNUMERIC(38,5) OPTIONS(description='Bestand Lager der Filiale'),
valid_from_storestorage DATE OPTIONS(description='Datum von Lager Filiale'),
valid_to_storestorage DATE OPTIONS(description='Datum bis Lager Filiale'),
update_date DATETIME OPTIONS(description='Datum Datensatz eingefuegt'),
insert_date DATETIME OPTIONS(description='Datum Datensatz update')
) OPTIONS(description='Bestand Filiale NF (verkaufsflaeche)');