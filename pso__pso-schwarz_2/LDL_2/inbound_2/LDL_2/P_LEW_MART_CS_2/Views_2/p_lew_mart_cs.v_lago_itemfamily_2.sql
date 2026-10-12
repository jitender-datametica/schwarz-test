/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_cs_v_lago_itemfamily.sql 16462 2020-12-14 14:28:56Z uross $
# $Revision: 16462 $
# $LastChangedBy: uross $
# $LastChangedDate: 2020-12-14 15:28:56 +0100 (Mo, 14 Dez 2020) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_cs/lew_mart_cs_v_lago_itemfamily.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  29.09.2020    Ross, Ulrich               Initial version
#----------------------------------------------------------------------------

*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.v_lago_itemfamily_2
(
    client_id
  , country_iso_cd
  , dat_rec_start
  , dat_rec_end
  , item_familygroup_id
  , itemfamily_cd
  , desc_short
  , desc_long
  , language_id  
  , cs_updated
  , cs_created
  , cs_load_id
)
AS
  SELECT
      a.client_id
    , a.country_iso_cd
    , a.dat_rec_start
    , a.dat_rec_end
    , a.item_familygroup_id
    , a.itemfamily_cd
    , a.desc_short
    , a.desc_long
    , a.language_id    
    , a.cs_updated
    , a.cs_created
    , a.cs_load_id
  FROM P_LEW_MART_CS.t_lago_itemfamily_2 a
;