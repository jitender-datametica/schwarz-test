/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_REF_TIV_INV_TYPE_2
#----------------------------------------------------------------------------
# History:
#  --- ---------- ----------------------- --------------------------------
#  1.0  21.12.2023     MARVIN REKOVSKY     INITIAL VERSION OF SCRIPT                                        
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_REF_TIV_INV_TYPE_2 COMMENT = 'TIV - INVENTURTYPEN'
(
  INV_TYPE_ID       COMMENT 'INVENTURTYPE ID'
, INV_TYPE_DESCR    COMMENT 'BESCHREIBUNG DES INVENTURTYPS'
, INV_TYPE_DESCR_EN COMMENT 'BESCHREIBUNG DES INVENTURTYPS - ENGLISCH'
)
AS
/*
#-----------------------------------------------------------------------------
# DESCRIPTION:
# THIS VIEW PROVIDES A LIST OF INVENTORY TYPES INCLUDING THEIR DESCRIPTION.
#
#----------------------------------------------------------------------------
# HISTORY:
# 1.0  21.12.2023     MARVIN REKOVSKY     INITIAL VERSION OF SCRIPT
#
#----------------------------------------------------------------------------
*/
SELECT   INV_TYPE_ID
       , INV_TYPE_DESCR
       , INV_TYPE_DESCR_EN
  FROM P_LEW_CORE.T_REF_INV_TYPE_2
;
