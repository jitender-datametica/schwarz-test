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

CREATE TABLE P_LEW_MART_MSI.T_ITM_ITEM_FOODACTION_ASWAS CLUSTER BY (client_id, dat_valid) 
(
      client_id INTEGER NOT NULL COMMENT 'Client des Datawarehous - aktuell synonym für LIDL-Land',
      item_id INTEGER NOT NULL COMMENT 'Surrogate Key Item (item_sid) bzw Artikelnummer (item_id)',
      dat_valid DATE NOT NULL COMMENT 'Valid date'
) COMMENT='Foodaction items for Wawi + eLWIS! $Revision: 17188 $.'
;
