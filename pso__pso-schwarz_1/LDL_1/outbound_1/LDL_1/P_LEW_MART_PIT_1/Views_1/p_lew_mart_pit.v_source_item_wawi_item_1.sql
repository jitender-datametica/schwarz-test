/*
#-------------------------------------------------------------------------------
# Copyright  LIDL Stiftung & Co. KG - PITonCloud Application 2022
#-------------------------------------------------------------------------------
# Interface : VIEW fOR V_SOURCE_ITEM_WAWI_ITEM_1
#-------------------------------------------------------------------------------
# Description: CREATE VIEW fOR V_SOURCE_ITEM_WAWI_ITEM_1
#-------------------------------------------------------------------------------
# Encoding. UTF8noBom
#-------------------------------------------------------------------------------
# History:
#  1.0  2021-08-16 Massimo Morelli     Initial version
#  1.1  2021-09-07 Mike Davis          Refinement
#  1.2  2021-09-17 Mike Davis          Formatting
#  1.3  2021-09-29 Dirk Hering         Use example role added, data types added, column order, formatting
#  1.4  2021-10-12 Dirk Hering         Deduplication from source (Qualify Row Number = 1)
#  1.5  2022-02-10 Mike Davis          Add dat_valid_from
#  1.6  2024-02-01 Andreas Kurz		   added additional PV logic SORTIMENT_ARTICLE_FG
#  1.7	2024-09-23 Nikolai Toknov	   Add schema name for f_CleanValidToDate
#-------------------------------------------------------------------------------
*/

/*
USE ROLE		R_LDL_D_PIT_ETL;
USE WAREHOUSE	WH_LDL_D_PIT_ETL_S;
USE DATABASE 	LDL_PRODUCTION_CLONE_PIT_R60001;
USE SCHEMA 		P_LEW_MART_PIT_1;
 */
 
/*
---------------------------------------------------------------------
0.   CREATE VIEW in V_SOURCE_ITEM_WAWI_ITEM_1
     Merge the coure sources: t_wawi_itm_item_1
------------------------------------------------------------------------
*/



CREATE OR REPLACE VIEW ldl_p_lew_mart_pit.v_source_item_wawi_item_1 OPTIONS(DESCRIPTION = `V_SOURCE_ITEM_WAWI_ITEM_1`) AS
SELECT CAST(client_id AS BIGNUMERIC) AS client_id,
 CAST(item_sid AS BIGNUMERIC) AS item_sid,
 DATE(COALESCE(DATE(dat_valid_from), DATE('8888-12-31'))) AS dat_valid_from,
 CAST(buying_list_type_id AS BIGNUMERIC) AS buying_list_type_id,
 CAST(COALESCE(buying_list_type_desc, 'N/A') AS STRING) AS buying_list_type_descr,
 CAST(COALESCE(buying_list_type_desc, 'N/A') AS STRING) AS buying_list_type_int_descr,
 IF(buying_list_type_id NOT IN (7, 8), 1, 0) AS sortiment_article_fg,
 DATE(COALESCE(dat_rec_start, DATE('1900-01-01'))) AS valid_from_dt,
 DATE(ldl_p_lew_mart_pit.f_cleanvalidtodate(dat_rec_end)) AS valid_to_dt,
 0 AS deleted_fg,
 CAST(CURRENT_TIMESTAMP() AS DATETIME) AS dwh_updated_ts
FROM ldl_p_lew_core.t_wawi_itm_item_1
WHERE client_id IN (SELECT client_id
   FROM ldl_p_lew_mart_pit.t_dim_client_1
   WHERE pit_country_fg = 1
    AND deleted_fg = 0
    AND reject_fg = 0
    AND current_fg = 1
   GROUP BY client_id)
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(client_id AS STRING), CAST(item_sid AS STRING), dat_rec_start ORDER BY
      dat_valid_from IS NULL DESC, dat_valid_from DESC)) = 1;


