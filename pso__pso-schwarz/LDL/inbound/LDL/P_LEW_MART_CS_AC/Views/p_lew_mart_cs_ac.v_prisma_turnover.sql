/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs_ac.v_prisma_turnover
#----------------------------------------------------------------------------
# History:
#  1.0  01.03.2022    Ross, Ulrich            Init
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs_ac.v_prisma_turnover
(
  client_id
  , orig_store_nr
  , dat_formdate
  , currency_iso_cd
  , val_retail_asis
  , val_retail_net_asis
  , cs_updated
  , cs_created
  , cs_load_id
)
AS
SELECT  
  client_id
  , orig_store_nr
  , dat_formdate
  , currency_iso_cd
  , val_retail_asis
  , val_retail_net_asis
  , cs_updated
  , cs_created
  , cs_load_id
FROM    p_lew_mart_cs.v_prisma_turnover;