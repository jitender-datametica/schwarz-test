/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_gen_vat_hist_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_gen_vat_hist_1
AS
   -- New VAT table
   SELECT
   t1.client_id,
   t1.vat_id,
   CAST(t1.pct_vat AS DECIMAL(18,4)) AS pct_vat,
   t1.vat_desc,
   t1.dat_rec_start,
   t1.dat_rec_end,
   7                                 AS language_id,
   TIMESTAMP '1900-01-01 00:00:00'   AS dwh_updated,
   TIMESTAMP '1900-01-01 00:00:00'   AS dwh_created,
   CAST(-1 AS INTEGER)               AS dwh_load_id,
   t1.load_id                        AS load_id,
   1                                 AS src_id
   FROM p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 AS t1_1

   UNION

   -- Old VAT table
   SELECT
   t2.client_id,
   t2.vat_id,
   t2.pct_vat,
   t2.vat_desc,
   t2.dat_rec_start,
   t2.dat_rec_end,
   t2.language_id,
   TIMESTAMP '1900-01-01 00:00:00'   AS dwh_updated,
   TIMESTAMP '1900-01-01 00:00:00'   AS dwh_created,
   CAST(-1 AS INTEGER)               AS dwh_load_id,
   t2.load_id                        AS load_id,
   1                                 AS src_id
   FROM p_lew_core_ac.v_wawi_ref_vat_1 AS t2
   LEFT OUTER JOIN
   (SELECT
   tck1.client_id
   FROM p_lew_core_ac.v_wawi_ref_wawi_vat_values_1 tck1
   WHERE tck1.vat_id > 0
   GROUP BY
      tck1.client_id
  ) tck2
   ON t2.client_id = tck2.client_id

   WHERE 1=1
   AND   t2.client_id = t2.language_id
   -- Display data from ref_vat only, if ref_wawi_vat_values has no real data for that client_id
   AND   tck2.client_id IS NULL

   ;


