/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_CS_AC.V_KZP_PLANUMSAETZE_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


/* #DescStart#
#$Revision: 13705 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_cs_ac.v_kzp_planumsaetze_2 (client_id, country_iso_cd, valid_from, valid_to,
currency_iso_cd, cry_valid_from, cry_valid_until, tovr_gross_plan, tovr_net_plan) AS SELECT *
FROM ldl_p_lew_mart_cs.v_kzp_planumsaetze_2;