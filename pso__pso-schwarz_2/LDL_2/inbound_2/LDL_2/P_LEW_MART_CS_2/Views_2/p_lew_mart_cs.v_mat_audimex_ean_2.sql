/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for .
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_cs_v_mat_audimex_ean.sql 16127 2020-10-19 12:53:17Z uross $
# $Revision: 16127 $
# $LastChangedBy: uross $
# $LastChangedDate: 2020-10-19 14:53:17 +0200 (Mon, 19 Oct 2020) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_cs/lew_mart_cs_v_mat_audimex_ean.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#  1.0  12.08.2020    Wachauf, Christian            Initial Version
#  1.1  14.08.2020    Wachauf, Christian            In Window-Function: Added ordering by ean_code
#  1.2  17.08.2020    Ross, Ulrich                  Add Client_ID, change Attribute order
#  1.3  19.10.2020    Ross, Ulrich                  Remove Qualify rule
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW P_LEW_MART_CS.v_mat_audimex_ean_2
(
   client_id
  ,country_iso_cd
  ,orig_item_nr
  ,case_size
  ,ean_code
  ,dwh_updated
  ,dwh_created
  ,rel_load_id 
)
AS
 SELECT
    ean.client_id      AS client_id
    ,ean.country_iso_cd   AS country_iso_cd
    ,ean.orig_item_nr      AS orig_item_nr
    ,ean.case_size        AS case_size  
    ,ean.ean_code         AS ean_code
    ,ean.dwh_updated      AS dwh_updated
    ,ean.dwh_created      AS dwh_created
    ,CASE 
      WHEN ean.src_id = 1 THEN ean.load_id
      ELSE ean.dwh_load_id 
    END AS rel_load_id
  FROM P_LEW_MART_CS.v_cs_ean_item_2 AS ean_2
  ;
 