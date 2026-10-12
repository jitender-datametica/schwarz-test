/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_REF_TIV_STOCK_CORR_REQ_STATUS_1
#----------------------------------------------------------------------------
# History:
#  --- ---------- ----------------------- --------------------------------
#  1.0  21.12.2023     MARVIN REKOVSKY     INITIAL VERSION OF SCRIPT                                        
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_TIV_STOCK_CORR_REQ_STATUS_1 COMMENT = 'TIV - STOCK KORREKTURANFORDERUNGEN STATUS_1'
(
  STOCK_CORR_REQ_STATUS_ID       COMMENT 'ID DES STATUS_1 DER KORREKTURANFORDERUNG'
, STOCK_CORR_REQ_STATUS_DESCR    COMMENT 'STATUS_1 BESCHREIBUNG'
, STOCK_CORR_REQ_STATUS_DESCR_EN COMMENT 'STATUS_1 BESCHREIBUNG - ENGLISCH'
)
AS
/*
#-----------------------------------------------------------------------------
# DESCRIPTION:
# THIS VIEW PROVIDES A LIST OF EVERY STOCK CORRECTION STATUS_1 AND THEIR DESCRIPTION.
#
#----------------------------------------------------------------------------
# HISTORY:
#  1.0  21.12.2023     MARVIN REKOVSKY     INITIAL VERSION OF SCRIPT
#
#----------------------------------------------------------------------------
*/
SELECT   STOCK_CORR_REQ_STATUS_ID      
       , STOCK_CORR_REQ_STATUS_DESCR   
       , STOCK_CORR_REQ_STATUS_DESCR_EN
FROM P_LEW_CORE.T_REF_STOCK_CORR_REQ_STATUS_1
;