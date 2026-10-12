/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface : (HERE YOU HAVE TO WRITE DOWN THE INTERFACE. FOR EXAMPLE: HQ MOVE)
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_lead_ac_v_adv_int.sql 17523 2021-11-03 13:34:53Z mmurtenthaler $
# $Revision: 17523 $
# $LastChangedBy: mmurtenthaler $
# $LastChangedDate: 2021-11-03 14:34:53 +0100 (Mi, 03 Nov 2021) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_lead_ac/lew_mart_lead_ac_v_adv_int.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0   28-03-2019   Rolf Barten        Patch_Number: 2015
#                                       INITIAL VERSION
# 2     03-11-2021   Martin Murtenthaler   AP0106584 VTWG-463 New month column
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_lead_ac.v_adv_int_2
AS
SELECT
  cy
 ,cy_month
 ,adv_week_int
 ,adv_wt_nr_int
 ,cy_week
 ,client_id
 ,country_iso_cd
 ,wh_id
 ,loc_sid_wh
 ,week_adv
 ,dat_adv
 ,dwh_updated
FROM p_lew_mart_lead.t_adv_int_2
;