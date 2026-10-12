/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: 20211111_2971_st_open_mth_adj_hcal
#----------------------------------------------------------------------------
# Subversion Infostamp Start          (DO NOT EDIT INFOSTAMP)
#----------------------------------------------------------------------------
# $Id: lew_mart_lidl_digital_ac_v_open_store_mth_adjust_growth.sql 17579 2021-11-17 11:48:36Z pmittler $
# $Revision: 17579 $
# $LastChangedBy: pmittler $
# $LastChangedDate: 2021-11-17 12:48:36 +0100 (Mi, 17 Nov 2021) $
# $URL: svn://l-as616.asp.lidl.net/ddl/lew/lew_mart_lidl_digital_ac/lew_mart_lidl_digital_ac_v_open_store_mth_adjust_growth.sql $
#----------------------------------------------------------------------------
# Subversion Infostamp END
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.1 2019-05-17 Patrick Mittler         Initial version

#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_open_store_mth_adjust_growth_1 (client_id, cy_month, adj_growth_fg
, reporting_start_dt, adjust_growth_start_date, cm_open_store_cnt, cm_cnt_days_start_digital,
cm_open_store_days_multiplied, pm_open_store_cnt, pm_cnt_days_start_digital, pm_open_store_days_multiplied,
pym_open_store_cnt, pym_cnt_days_start_digital, pym_open_store_days_multiplied) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_open_store_mth_adjust_growth_1;