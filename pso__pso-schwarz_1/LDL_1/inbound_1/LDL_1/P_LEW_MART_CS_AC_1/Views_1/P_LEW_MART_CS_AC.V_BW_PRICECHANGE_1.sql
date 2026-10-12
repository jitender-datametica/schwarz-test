/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS_AC#.V_BW_PRICECHANGE_1
#----------------------------------------------------------------------------
# History:
#  1.0  16.08.2023    Ulrich Ross               Init
#                                               User Story 501417
#                                                                                
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.V_BW_PRICECHANGE_1
(
    client_id
  , client_desc
  , fiscyear
  , fiscper
  , wgi
  , perm_price_change_eur
  , perm_price_change_perc
  , remain_price_change_eur
  , remain_price_change_perc
  , adver_price_change_eur
  , adver_price_change_perc
 )
AS
SELECT  
    client_id
  , client_desc
  , fiscyear
  , fiscper
  , wgi
  , perm_price_change_eur
  , perm_price_change_perc
  , remain_price_change_eur
  , remain_price_change_perc
  , adver_price_change_eur
  , adver_price_change_perc
FROM P_LEW_MART_CS.V_BW_PRICECHANGE_1  
;