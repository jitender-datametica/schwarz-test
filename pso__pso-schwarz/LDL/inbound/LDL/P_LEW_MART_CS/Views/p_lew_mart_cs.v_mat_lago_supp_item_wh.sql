/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_cs_v_mat_lago_supp_item_wh.sql 16462 2020-12-14 14:28:56Z uross $
# $Revision: 16462 $
# $LastChangedBy: uross $
# $LastChangedDate: 2020-12-14 15:28:56 +0100 (Mo, 14 Dez 2020) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_cs/lew_mart_cs_v_mat_lago_supp_item_wh.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  26.10.2020    Ulrich, Ross            First Version
#----------------------------------------------------------------------------
*/


/*
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_CS.v_mat_lago_supp_item_wh
(
  client_id
  , country_iso_cd
  , wh_id
  , supplier_id
  , item_id
  , valid_from
  , valid_until
  , dwh_updated
  , dwh_created
  , dwh_load_id
  , load_id
  , src_id 
)
AS
SELECT
  sup.client_id
  , sup.country_iso_cd
  , sup.wh_id
  , sup.supplier_id
  , sup.item_id
  , sup.valid_from
  , sup.valid_until
  , sup.dwh_updated
  , sup.dwh_created
  , sup.dwh_load_id
  , sup.load_id
  , sup.src_id
FROM P_LEW_MART_CS.v_cs_item_brand AS sup    
WHERE sup.supplier_id > 0
  AND CURRENT_DATE BETWEEN sup.valid_from AND sup.valid_until
QUALIFY ROW_NUMBER() OVER (PARTITION BY sup.client_id, sup.wh_id, sup.supplier_id, item_id ORDER BY sup.valid_from asc ) = 1 -- Eindeutige Identifizierung
;
