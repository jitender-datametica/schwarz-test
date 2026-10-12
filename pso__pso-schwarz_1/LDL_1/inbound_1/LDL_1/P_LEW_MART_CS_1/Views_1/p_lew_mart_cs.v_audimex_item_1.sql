/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_cs_v_audimex_item.sql 15893 2020-09-14 10:20:35Z uross $
# $Revision: 15893 $
# $LastChangedBy: uross $
# $LastChangedDate: 2020-09-14 12:20:35 +0200 (Mon, 14 Sep 2020) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_cs/lew_mart_cs_v_audimex_item.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  14.08.2020    Ulrich, Ross            First Version
#  1.1  14.09.2020    Ulrich, Ross            Add descr_short 
#----------------------------------------------------------------------------

*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.v_audimex_item_1
(
    client_id
  , country_iso_cd
  , orig_item_nr
  , item_descr
  , plu_nr
  , subitemgroup_id
  , descr_short
  , ag_reserve
  , cs_updated
  , cs_created
  , cs_load_id
)
AS
SELECT  
    client_id
  , country_iso_cd
  , orig_item_nr
  , item_descr
  , plu_nr
  , subitemgroup_id
  , descr_short
  , ag_reserve
  , cs_updated
  , cs_created
  , cs_load_id
FROM    P_LEW_MART_CS.t_audimex_item_1
;

