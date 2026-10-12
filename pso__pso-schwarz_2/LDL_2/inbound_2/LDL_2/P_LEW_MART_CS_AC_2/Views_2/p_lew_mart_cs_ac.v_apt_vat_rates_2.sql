/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.v_apt_vat_rates_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs_ac.v_apt_vat_rates_2
(
  client_id
  , country_iso_cd
  , vat_id
  , pct_vat
  , dat_rec_start
  , dat_rec_end
  , cs_updated
  , cs_created
  , cs_load_id
)
AS
   SELECT
   client_id,
   country_iso_cd,
   vat_id,
   pct_vat,
   dat_rec_start,
   dat_rec_end,
   cs_updated,
   cs_created,
   cs_load_id
   FROM p_lew_mart_cs.v_apt_vat_rates_2
   ;


