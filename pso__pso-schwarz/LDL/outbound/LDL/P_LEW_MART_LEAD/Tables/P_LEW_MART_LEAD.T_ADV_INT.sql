/*
#----------------------------------------------------------------------------
# © LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface : (HERE YOU HAVE TO WRITE DOWN THE INTERFACE. FOR EXAMPLE: HQ MOVE)
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_lead_t_adv_int.sql 17522 2021-11-03 12:17:42Z mmurtenthaler $
# $Revision: 17522 $
# $LastChangedBy: mmurtenthaler $
# $LastChangedDate: 2021-11-03 13:17:42 +0100 (Mi, 03 Nov 2021) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_lead/lew_mart_lead_t_adv_int.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
# NR  | DATE       | 1st AND 2nd NAME | DESCRIPTION OF CHANGES
#
# 1.0   28-03-2019   Rolf Barten        Patch_Number: 2015
#                                       INITIAL VERSION
# 2     22-10-2021   Martin Murtenthaler   AP0106584 VTWG-463 New month column
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_lead.t_adv_int (
cy BIGNUMERIC(38,0),
cy_month BIGNUMERIC(38,0),
adv_week_int BIGNUMERIC(38,0),
adv_wt_nr_int BIGNUMERIC(38,0),
cy_week BIGNUMERIC(38,0),
client_id BIGNUMERIC(38,0) NOT NULL,
country_iso_cd STRING(20),
wh_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_wh BIGNUMERIC(38,0),
week_adv STRING(34) COLLATE 'und:ci',
dat_adv DATE NOT NULL,
dwh_updated DATETIME NOT NULL
) CLUSTER BY dat_adv, client_id;