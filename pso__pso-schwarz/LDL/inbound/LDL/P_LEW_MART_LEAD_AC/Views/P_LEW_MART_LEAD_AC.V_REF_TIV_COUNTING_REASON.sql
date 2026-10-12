/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_REF_TIV_COUNTING_REASON
#----------------------------------------------------------------------------
# History:
#  --- ---------- ----------------------- --------------------------------
#  1.0  21.12.2023     MARVIN REKOVSKY     INITIAL VERSION OF SCRIPT                                        
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_TIV_COUNTING_REASON COMMENT = 'TIV - BEGRÜNDUNG ZUM ZÄHLERAUFTRAG'
(
  CNT_REASON_ID         COMMENT 'ID DER BEGRÜNDUNG DER INVENTURZÄHLUNG'
, CNT_REASON_DESCR      COMMENT 'BEGRÜNDUNG DER INVENTURZÄHLUNG'
, CNT_REASON_DESCR_EN   COMMENT 'BEGRÜNDUNG DER INVENTURZÄHLUNG - ENGLISCH'
)
AS
/*
#-----------------------------------------------------------------------------
# DESCRIPTION:
# THIS VIEW PROVIDES A LIST OF INVENTORY COUNTING REASONS.
#
#----------------------------------------------------------------------------
# HISTORY:
# 1.0  21.12.2023     MARVIN REKOVSKY     INITIAL VERSION OF SCRIPT
#
#----------------------------------------------------------------------------
*/
SELECT   CNT_REASON_ID
       , CNT_REASON_DESCR
       , CNT_REASON_DESCR_EN
  FROM P_LEW_CORE.T_REF_COUNTING_REASON
;