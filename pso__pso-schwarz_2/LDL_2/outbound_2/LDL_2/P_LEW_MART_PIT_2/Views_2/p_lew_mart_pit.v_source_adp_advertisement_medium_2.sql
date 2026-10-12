/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : View for ADVERTISEMENT_MEDIUM
#-------------------------------------------------------------------------------
# Describtion: Create View for ADVERTISEMENT_MEDIUM
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-09-01 Aparna Rayanki      	Initial version
#  1.1  2021-09-29 Dirk Hering         	Use example role added, data types added, column order, formatting
#  1.2  2021-10-11 Dirk Hering         	Deduplication from source (Qualify Row Number = 1); 
#                                      	Changed to select from source: ch.dwh_updated
#  1.3  2022-03-23 Mike Davis          	Use MD5 for the MEDIUM_SID.
#  1.4  2022-05-27 Andreas Kurz			Reworked View
#  1.5	2024-09-23 Nikolai Toknov		Add schema name for f_CleanString
#-------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_adp_advertisement_medium_2
OPTIONS(DESCRIPTION = 'V_SOURCE_ADP_ADVERTISEMENT_MEDIUM_2') AS SELECT CAST(client_id AS BIGNUMERIC) AS client_id,
 CAST(adv_channel_sid AS BIGNUMERIC) AS medium_sid,
 CAST(ldl_p_lew_mart_pit.f_cleanstring(COALESCE("adv_channel_name",'')) AS STRING) AS medium_name,
    ldl_p_lew_mart_pit.f_cleanstring(COALESCE("adv_channel_name",'')) || ' (' || COALESCE(adv_channel_cd, 'n/A') || ')' AS
 medium_name_ldescr,
 CAST(ldl_p_lew_mart_pit.f_cleanstring(COALESCE("adv_channel_descr", '')) AS STRING) AS medium_descr,
 DATE('1900-01-01') AS valid_from_dt,
 DATE('9999-12-31') AS valid_to_dt,
 0 AS deleted_fg,
 dwh_updated AS dwh_updated_ts
FROM ldl_p_lew_core.t_advertisement_channel_2
WHERE client_id IN (SELECT client_id
   FROM ldl_p_lew_mart_pit.t_dim_client_2
   WHERE pit_country_fg = 1
    AND deleted_fg = 0
    AND reject_fg = 0
    AND current_fg = 1
   GROUP BY client_id)
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(CAST(client_id AS BIGNUMERIC) AS STRING), adv_channel_sid ORDER BY
      dwh_updated IS NULL DESC, dwh_updated DESC)) = 1;
