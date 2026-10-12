/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_currexrate_2
#----------------------------------------------------------------------------
# History:
#   1.0            05.10.2022        Ulrich Ross              Init
#                                                             User Story 391252
#                                                             SAP BW Performance Issue - SF
#----------------------------------------------------------------------------
*/


CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_cs.t_bw_ejr_turnover_writeoff_pv_currexrate_2 (
curr_tot_id INTEGER NOT NULL,
country_id BIGNUMERIC(38) NOT NULL,
client_id BIGNUMERIC(38) NOT NULL,
currency_iso_cd STRING(3) NOT NULL,
currency_desc STRING(200) NOT NULL,
to_currency_iso_cd STRING(3) NOT NULL,
rate_currency_exchange NUMERIC(18,5) NOT NULL,
local_currency_fg INTEGER NOT NULL
);