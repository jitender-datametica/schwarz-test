/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_cs_v_mat_lago_item_descr.sql 16462 2020-12-14 14:28:56Z uross $
# $Revision: 16462 $
# $LastChangedBy: uross $
# $LastChangedDate: 2020-12-14 15:28:56 +0100 (Mo, 14 Dez 2020) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_cs/lew_mart_cs_v_mat_lago_item_descr.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  23.10.2020    Wachauf, Christian            First Version
#  1.1  07.01.2022    Ao, Lin                       Change column item_familygroup_id to use value from item_familygroup_id_lago
#  1.2  26.04.2023    Ross, Ulrich                  Remove column item_familygroup_id_lago add QUALIFY ROW_NUMBER to remove duplicate key error
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_mat_lago_item_descr_1
(
    client_id
  , item_id
  , orig_item_nr
  , item_descr
  , language_id
  , valid_from
  , valid_until
  , dwh_updated
  , dwh_created
  , dwh_load_id
)
AS
  SELECT
    giai.client_id
    , giai.item_sid     AS item_id
    , giai.orig_item_nr AS orig_item_nr
    , itdesc.item_descr
    , itdesc.language_id
    , giai.valid_from 
    , giai.valid_until
    , itdesc.dwh_updated
    , itdesc.dwh_created
    , itdesc.dwh_load_id
  FROM P_LEW_MART_CS.v_gen_item_asis_1 AS giai   -- gen_item_as_is 
   
  INNER JOIN P_LEW_MART_CS.v_cs_item_descr_1 AS itdesc
    ON  giai.client_id = itdesc.client_id
    AND giai.item_sid  = itdesc.item_id
   
  WHERE CURRENT_DATE BETWEEN giai.valid_from AND giai.valid_until
    AND (giai.client_id = itdesc.language_id OR itdesc.language_id = 7) --nur Landessprache und International
  GROUP BY 1,2,3,4,5,6,7,8,9,10
  QUALIFY ROW_NUMBER() OVER (PARTITION BY giai.client_id, giai.item_sid, giai.orig_item_nr, itdesc.item_descr, itdesc.language_id, giai.valid_from, giai.valid_until ORDER BY itdesc.dwh_load_id DESC) = 1
  ;