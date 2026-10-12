/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_cs_v_lago_supp_item_wh.sql 16462 2020-12-14 14:28:56Z uross $
# $Revision: 16462 $
# $LastChangedBy: uross $
# $LastChangedDate: 2020-12-14 15:28:56 +0100 (Mo, 14 Dez 2020) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_cs/lew_mart_cs_v_lago_supp_item_wh.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  26.10.2020    Ross, Ulrich               Initial version
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.v_lago_supp_item_wh
(
  client_id
  , country_iso_cd
  , wh_id
  , supplier_id
  , item_id
  , valid_from
  , valid_until
  , cs_updated
  , cs_created
  , cs_load_id
)
AS
SELECT
  client_id
  , country_iso_cd
  , wh_id
  , supplier_id
  , item_id
  , valid_from
  , valid_until
  , cs_updated
  , cs_created
  , cs_load_id
FROM P_LEW_MART_CS.t_lago_supp_item_wh
;