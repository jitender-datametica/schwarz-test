/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #_lew_mart_cs_ac.v_audimex_ean
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_cs_ac_v_audimex_ean.sql 15779 2020-08-17 09:38:38Z uross $
# $Revision: 15779 $
# $LastChangedBy: uross $
# $LastChangedDate: 2020-08-17 11:38:38 +0200 (Mon, 17 Aug 2020) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_cs_ac/lew_mart_cs_ac_v_audimex_ean.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  12.08.2020    Wachauf, Christian            Initial Version
#  1.01 17.08.2020    Wachauf, Christian            Removed row that existed for testing purposes only.
#  1.2  17.08.2020    Ross, Ulrich                  Add Client_ID, change Attribute order 
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_CS_AC.v_audimex_ean
(
  client_id
  ,country_iso_cd
  ,orig_item_nr
  ,case_size
  ,ean_code
  ,cs_updated
  ,cs_created
  ,cs_load_id
  
)
AS
SELECT
    ean.client_id        AS client_id
    ,ean.country_iso_cd     AS country_iso_cd
    ,ean.orig_item_nr        AS orig_item_nr
    ,ean.case_size          AS case_size  
    ,ean.ean_code           AS ean_code
    ,ean.cs_updated         AS cs_updated
    ,ean.cs_created         AS cs_created
    ,ean.cs_load_id         AS cs_load_id
  FROM P_LEW_MART_CS.v_audimex_ean AS ean
 ;