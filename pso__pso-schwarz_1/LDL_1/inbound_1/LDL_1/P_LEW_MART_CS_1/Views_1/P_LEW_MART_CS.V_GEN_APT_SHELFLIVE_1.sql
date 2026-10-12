/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_gen_apt_shelflive_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_gen_apt_shelflive_1
(client_id
,shelflife_id
, shelflife_mis_id
,shelflife_short_desc
,shelflife_desc
,language_id
,dat_rec_start
,dat_rec_end
,factor_period
)
AS
   SELECT
   sl.client_id,
   sl.shelflife_id,
   sl.shelflife_id AS shelflife_mis_id,
   sl.shelflife_short_desc,
   sl.shelflife_desc,
   sl.language_id,
   sl.dat_rec_start,
   sl.dat_rec_end,
   sl.factor_period
   FROM p_lew_core_ac.v_wawi_ref_shelflife_1 sl
   INNER JOIN p_lew_process_ac.v_sap_migration_client_1 c
   ON sl.client_id = c.client_id
   AND c.migrated_fg = 0

   UNION ALL
   SELECT
   COALESCE(x.client_id,y.client_id) client_id,
   COALESCE(x.shelflife_id,y.shelflife_id) shelflife_id,
   COALESCE(x.shelflife_mis_id,y.shelflife_mis_id) shelflife_mis_id,
   COALESCE(x.shelflife_short_desc,y.shelflife_short_desc) shelflife_short_desc,
   COALESCE(x.shelflife_desc,y.shelflife_desc) shelflife_desc,
   COALESCE(x.language_id,y.language_id) language_id,
   COALESCE(x.dat_rec_start,y.dat_rec_start) dat_rec_start,
   COALESCE(x.dat_rec_end,y.dat_rec_end) dat_rec_end,
   COALESCE(x.factor_period,y.factor_period) factor_period
   FROM
   (SELECT
   sl.client_id,
   sl.shelflife_id,
   sl.shelflife_id AS shelflife_mis_id,
   sl.shelflife_short_desc,
   sl.shelflife_desc,
   sl.language_id,
   DATE'1900-01-01' AS dat_rec_start,
   DATE'9999-12-31' AS dat_rec_end,
   sl.factor_period
   FROM p_lew_core_ac.v_wawi_ref_shelflife_1 sl
   INNER JOIN p_lew_process_ac.v_sap_migration_client_1 c
   ON sl.client_id = c.client_id
   AND c.migrated_fg = 1
   AND CURRENT_DATE BETWEEN sl.dat_rec_start AND sl.dat_rec_end
   ) x
   FULL OUTER JOIN
   (SELECT
   a.client_id,
   b.shelflife_mis_id AS shelflife_id,
   b.shelflife_mis_id,
   b.shelflife_short_desc,
   b.shelflife_short_desc AS shelflife_desc,
   7 AS language_id,
   DATE'1900-01-01' AS dat_rec_start,
   DATE'9999-12-31' AS dat_rec_end,
   b.factor_period
   FROM p_lew_process_ac.v_sap_migration_client_1 a
   CROSS JOIN
   (SELECT
   factor_period,
   shelflife_mis_id,
   shelflife_short_desc
   FROM (SELECT
   0       AS shelflife_mis_id,
   '  '  AS shelflife_short_desc,
   0     AS factor_period ) x
   UNION ALL
   SELECT
   factor_period,
   shelflife_mis_id,
   shelflife_short_desc
   FROM (SELECT
   1       AS shelflife_mis_id,
   'T '  AS shelflife_short_desc,
   1     AS factor_period ) x
   UNION ALL
   SELECT
   factor_period,
   shelflife_mis_id,
   shelflife_short_desc
   FROM (SELECT
   2       AS shelflife_mis_id,
   'W '  AS shelflife_short_desc,
   7     AS factor_period ) x
   UNION ALL
   SELECT
   factor_period,
   shelflife_mis_id,
   shelflife_short_desc
   FROM (SELECT
   3       AS shelflife_mis_id,
   'M '  AS shelflife_short_desc,
   30    AS factor_period ) x
   UNION ALL
   SELECT
   factor_period,
   shelflife_mis_id,
   shelflife_short_desc
   FROM (SELECT
   4       AS shelflife_mis_id,
   'Wk'  AS shelflife_short_desc,
   7     AS factor_period ) x
          ) b
          WHERE a.migrated_fg = 1
      ) y
   ON x.client_id    = y.client_id
   AND x.shelflife_id = y.shelflife_id
   AND x.language_id  = y.language_id
   ;


