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


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_mat_audimex_ean (client_id, country_iso_cd, orig_item_nr, case_size, ean_code
, dwh_updated, dwh_created, rel_load_id) AS SELECT client_id,
 country_iso_cd,
 orig_item_nr,
 case_size,
 ean_code,
 dwh_updated,
 dwh_created,
  CASE
  WHEN src_id = 1
  THEN load_id
  ELSE dwh_load_id
  END AS rel_load_id
FROM ldl_p_lew_mart_cs.v_cs_ean_item AS EAN;