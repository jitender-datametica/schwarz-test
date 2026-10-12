/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for f_lew_mart_msi.v_ref_currency
#----------------------------------------------------------------------------

#----------------------------------------------------------------------------





#----------------------------------------------------------------------------

#----------------------------------------------------------------------------
# History:
#  1.0 2020-03-05 Pawel Wieczorek         Initial version
#                                         20200228_2413_Precalc_Lidl_Online IDMO-2753
#                                         The same view as x_lew_mart_msi_ac.v_ref_currency   
#
#
#----------------------------------------------------------------------------
*/



/*
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lidl_digital_ac.v_ref_currency (curr_tot_id, country_id, client_id,
currency_iso_cd, currency_desc, to_currency_iso_cd, rate_currency_exchange, local_currency_fg)
OPTIONS(DESCRIPTION = `CURRENCY RATE`) AS SELECT *
FROM ldl_p_lew_mart_lidl_digital.v_ref_currency;