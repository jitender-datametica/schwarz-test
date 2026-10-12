/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #_lew_mart_cs_ac.v_audimex_ean_1
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


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_audimex_ean_1 (client_id, country_iso_cd, orig_item_nr, case_size, ean_code
, cs_updated, cs_created, cs_load_id) AS SELECT *
FROM ldl_p_lew_mart_cs.v_audimex_ean_1 AS EAN_1;