/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for lew_mart_cs_v_lago_item_descr.
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_cs_v_lago_item_descr.sql 16462 2020-12-14 14:28:56Z uross $
# $Revision: 16462 $
# $LastChangedBy: uross $
# $LastChangedDate: 2020-12-14 15:28:56 +0100 (Mo, 14 Dez 2020) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_cs/lew_mart_cs_v_lago_item_descr.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  02.11.2020    Wachauf, Christian               Initial version
#----------------------------------------------------------------------------

*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.v_lago_item_descr_1
(
    client_id
  , item_id
  , orig_item_nr
  , item_descr
  , language_id
  , valid_from
  , valid_until
  , cs_updated
  , cs_created
  , cs_load_id
)
AS
  SELECT
      a.client_id
    , a.item_id
    , a.orig_item_nr
    , a.item_descr
    , a.language_id
    , a.valid_from
    , a.valid_until
    , a.cs_updated
    , a.cs_created
    , a.cs_load_id
  FROM P_LEW_MART_CS.t_lago_item_descr_1 a
;
