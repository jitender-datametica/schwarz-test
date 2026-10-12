/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for t_itm_item_foodaction_aswas.
#----------------------------------------------------------------------------
# History:
#  1.0  02.08.2021    Bachmann, Torsten        Init, Materialize view
#                                              REP3-9070, PatchNo 2899
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.t_itm_item_foodaction_aswas_2 (
client_id INTEGER NOT NULL OPTIONS(description='Client des Datawarehous - aktuell synonym für LIDL-Land_2'),
item_id INTEGER NOT NULL OPTIONS(description='Surrogate Key Item_2 (item_sid) bzw Artikelnummer (item_id)'),
dat_valid DATE NOT NULL OPTIONS(description='Valid date')
) CLUSTER BY client_id, dat_valid
OPTIONS(description='Foodaction items for Wawi + eLWIS! $Revision: 17188 $.');