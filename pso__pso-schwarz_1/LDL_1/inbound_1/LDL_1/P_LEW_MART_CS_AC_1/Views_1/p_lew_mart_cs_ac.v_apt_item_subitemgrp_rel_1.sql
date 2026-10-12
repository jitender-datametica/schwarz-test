/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.v_apt_item_subitemgrp_rel_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs_ac.v_apt_item_subitemgrp_rel_1
(
  client_id
, country_iso_cd
, org_item_nr
, valid_from
, case_size
, dat_rec_start
, dat_rec_end
, subitemgroup_no
, cs_updated
, cs_created
, cs_load_id
)
AS
   SELECT
   a.client_id,
   a.country_iso_cd,
   a.org_item_nr,
   a.valid_from,
   a.case_size,
   a.dat_rec_start,
   a.dat_rec_end,
   a.subitemgroup_no,
   a.cs_updated,
   a.cs_created,
   a.cs_load_id
   FROM p_lew_mart_cs.v_apt_item_subitemgrp_rel_1 a
   ;


