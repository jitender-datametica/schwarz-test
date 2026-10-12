/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_LIFECYCLE.V_L_LIFECYCLE_HGA_STORE_HIST
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  06.12.2024	SIMEON NIKOLAEV	INITIAL SETUP

#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW szd_fe_mstr_lifecycle.v_l_lifecycle_hga_store_hist (store_sid, lob_cd, lob_name, company_name,
company_id, store_nr, store_name, store_active_fg, street_name, house_nr, city_name, zip, country_pol_cd,
country_pol_name) AS SELECT store_sid,
 lob_cd,
 lob_name,
 company_name,
 company_id,
 store_nr,
 store_name,
 store_active_fg,
 street_name,
 house_nr,
 city_name,
 zip,
 country_pol_cd,
 country_pol_name
FROM szd_core.t_dim_store_hist
WHERE dwh_valid_fg;