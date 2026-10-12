/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_cs_v_mat_lago_itemfamily.sql 16465 2020-12-16 13:56:20Z cwachauf $
# $Revision: 16465 $
# $LastChangedBy: cwachauf $
# $LastChangedDate: 2020-12-16 14:56:20 +0100 (Mi, 16 Dez 2020) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_cs/lew_mart_cs_v_mat_lago_itemfamily.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  29.09.2020    Ulrich, Ross            First Version
#----------------------------------------------------------------------------
*/

/*
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_CS.v_mat_lago_itemfamily_2
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
  , dwh_updated
  , dwh_created
  , dwh_load_id
  , load_id
  , src_id
)
AS
SELECT
    a.client_id
    , a.src_country_lidl_cd AS country_iso_cd
    , a.dat_rec_start
    , a.dat_rec_end
    , a.item_familygroup_id
    , a.itemfamily_cd
    , a.desc_short
    , a.desc_long
    , a.language_id    
    , a.dwh_updated
    , a.dwh_created
    , a.dwh_load_id
    , a.load_id
    , a.src_id
   FROM P_LEW_MART_CS.v_gen_item_family_2 AS a 
    WHERE a.item_familygroup_id > 0
      AND CURRENT_DATE BETWEEN a.dat_rec_start AND a.dat_rec_end
    GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;
