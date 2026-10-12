CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_AGG_INT_DAY_ROC
/*
#----------------------------------------------------------------------------
# History:
#  1.0  18.07.2022    Oliver Haus         Initial DDL deployment - RWL aggregated values for Cockpits
#  1.1  10.07.2023    Chetana Patil       Added logic for RWL_WEIGHTED_VJ  
#----------------------------------------------------------------------------
*/
(
     INT_ID
   , CLIENT_ID
   , DAT_FORMDATE
   , CURRENCY_ISO_CD
   , QTY_PIECE_STC_WH
   , RWL_NOMINATOR
   , RWL_WEIGHTED
   , RWL_WEIGHTED_VJ
)
AS
   SELECT
     INT_ID
   , CLIENT_ID
   , DAT_FORMDATE
   , CURRENCY_ISO_CD
   , QTY_PIECE_STC_WH
   , RWL_NOMINATOR
   , RWL_WEIGHTED
   , RWL_WEIGHTED_VJ
   FROM P_LEW_MART_MSI.V_AGG_INT_DAY_ROC
;