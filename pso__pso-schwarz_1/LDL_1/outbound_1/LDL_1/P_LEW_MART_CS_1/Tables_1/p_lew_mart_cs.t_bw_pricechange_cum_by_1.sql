/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS.T_BW_PRICECHANGE_CUM_BY_1
#----------------------------------------------------------------------------
# History:
#   1.0      14.11.2023      Ulrich Ross              Init
#                                                     User Story 532005
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_bw_pricechange_cum_by_1 (
client_id BIGNUMERIC(38) NOT NULL OPTIONS(description='Client ID'),
wh_id BIGNUMERIC(38) NOT NULL OPTIONS(description='Lager ID'),
cy_month BIGNUMERIC(38) NOT NULL OPTIONS(description='BY Monat_1'),
aspect_id BIGNUMERIC(38) NOT NULL OPTIONS(description='Aspect ID'),
item_familygroup_id BIGNUMERIC(38) NOT NULL OPTIONS(description='Artikelfamilie'),
subitemgroup_id BIGNUMERIC(38) NOT NULL OPTIONS(description='Unterwarengruppe'),
subitemgroup_id0 BIGNUMERIC(38) NOT NULL OPTIONS(description='Unterwarengruppe'),
buying_list_type_id BIGNUMERIC(38) NOT NULL OPTIONS(description='Listungs Typ'),
curr_tot_id BIGNUMERIC(38) NOT NULL OPTIONS(description='Währung ID'),
currency_iso_cd STRING(3) NOT NULL OPTIONS(description='Länderwährung'),
val_pricechange_cum_by NUMERIC(18,5) OPTIONS(description='Preisänderungen kummuliert akt. Business Year')
);