/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_gen_apt_shelflive_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_gen_apt_shelflive_2 (client_id, shelflife_id, shelflife_mis_id,
shelflife_short_desc, shelflife_desc, language_id, dat_rec_start, dat_rec_end, factor_period) AS SELECT SL.client_id,
 SL.shelflife_id,
 SL.shelflife_id AS shelflife_mis_id,
 SL.shelflife_short_desc,
 SL.shelflife_desc,
 SL.language_id,
 SL.dat_rec_start,
 SL.dat_rec_end,
 SL.factor_period
FROM ldl_p_lew_core_ac.v_wawi_ref_shelflife_2 AS SL
 INNER JOIN ldl_p_lew_process_ac.v_sap_migration_client_2 AS C ON SL.client_id = C.client_id AND C.migrated_fg = 0
UNION ALL
SELECT COALESCE(x.client_id, y.client_id) AS client_id,
 COALESCE(x.shelflife_id, y.shelflife_id) AS shelflife_id,
 COALESCE(x.shelflife_mis_id, y.shelflife_mis_id) AS shelflife_mis_id,
 COALESCE(x.shelflife_short_desc, y.shelflife_short_desc) AS shelflife_short_desc,
 COALESCE(x.shelflife_desc, y.shelflife_desc) AS shelflife_desc,
 COALESCE(x.language_id, y.language_id) AS language_id,
 COALESCE(x.dat_rec_start, y.dat_rec_start) AS dat_rec_start,
 COALESCE(x.dat_rec_end, y.dat_rec_end) AS dat_rec_end,
 COALESCE(x.factor_period, y.factor_period) AS factor_period
FROM (SELECT SL.client_id,
   SL.shelflife_id,
   SL.shelflife_id AS shelflife_mis_id,
   SL.shelflife_short_desc,
   SL.shelflife_desc,
   SL.language_id,
   DATE '1900-01-01' AS dat_rec_start,
   DATE '9999-12-31' AS dat_rec_end,
   SL.factor_period
  FROM ldl_p_lew_core_ac.v_wawi_ref_shelflife_2 AS SL
   INNER JOIN ldl_p_lew_process_ac.v_sap_migration_client_2 AS C ON SL.client_id = C.client_id AND C.migrated_fg = 1 AND
     CURRENT_DATE BETWEEN SL.dat_rec_start AND SL.dat_rec_end) AS x
 FULL JOIN (SELECT A.client_id,
   b.shelflife_mis_id AS shelflife_id,
   b.shelflife_mis_id,
   b.shelflife_short_desc,
   b.shelflife_short_desc AS shelflife_desc,
   7 AS language_id,
   DATE '1900-01-01' AS dat_rec_start,
   DATE '9999-12-31' AS dat_rec_end,
   b.factor_period
  FROM ldl_p_lew_process_ac.v_sap_migration_client_2 AS A
   INNER JOIN (SELECT 0 AS factor_period,
      0 AS shelflife_mis_id,
      '  ' AS shelflife_short_desc
     UNION ALL
     SELECT 1 AS factor_period,
      1 AS shelflife_mis_id,
      'T ' AS shelflife_short_desc
     UNION ALL
     SELECT 7 AS factor_period,
      2 AS shelflife_mis_id,
      'W ' AS shelflife_short_desc
     UNION ALL
     SELECT 30 AS factor_period,
      3 AS shelflife_mis_id,
      'M ' AS shelflife_short_desc
     UNION ALL
     SELECT 7 AS factor_period,
      4 AS shelflife_mis_id,
      'Wk' AS shelflife_short_desc) AS b ON TRUE
  WHERE A.migrated_fg = 1) AS y ON x.client_id = y.client_id AND x.shelflife_id = y.shelflife_id AND x.language_id = y.language_id;