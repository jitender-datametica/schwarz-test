/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.v_cs_item_supplier_1
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.9  30.06.2021    Ross,Ulrich              Change orig_supplier_nr to data sup.sup_sid
#  2.0  30.06.2021    Ross,Ulrich              Change view v_supplier_1 to v_supplier_hist_1
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW p_lew_mart_cs.v_cs_item_supplier_1
(
client_id
, src_supplier_id
, orig_supplier_nr
, sup_name
, wh_id
, item_id
, orig_item_nr
, case_size
, country_iso_cd
, valid_from
, valid_until
, man_valid_from
, man_valid_until
, dwh_updated
, dwh_created
, dwh_load_id
, load_id
, src_id
, last_refresh
)
AS
   SELECT
   basis.client_id,
   NULL         AS src_supplier_id,
   sup.sup_sid  AS orig_supplier_nr,
   sup.name_1   AS  sup_name,
   basis.wh_id,
   basis.item_sid          AS item_id,
   i.orig_item_nr,
   i.case_size,
   i.src_country_lidl_cd   AS country_iso_cd,
   basis.valid_from,
   basis.valid_until,
   basis.man_valid_from,
   basis.man_valid_until,
   basis.dwh_updated,
   basis.dwh_created,
   basis.dwh_load_id,
   basis.load_id,
   basis.src_id,
   CURRENT_TIME AS last_refresh
   FROM (SELECT
   rnk.client_id,
   rnk.sup_sid,
   rnk.item_sid,
   rnk.wh_id,
   rnk.valid_from,
   rnk.valid_until,
   rnk.man_valid_from,
   rnk.man_valid_until,
   rnk.dwh_updated,
   rnk.dwh_created,
   rnk.dwh_load_id,
   rnk.load_id,
   rnk.src_id
   FROM (SELECT
   raw.client_id,
   raw.sup_sid,
   raw.item_sid,
   raw.wh_id,
   raw.valid_from,
   raw.valid_until,
   raw.man_valid_from,
   raw.man_valid_until,
   raw.dwh_updated,
   raw.dwh_created,
   raw.dwh_load_id,
   raw.load_id,
   raw.src_id,
   RANK() OVER (PARTITION BY raw.client_id, raw.sup_sid, raw.item_sid, raw.wh_id ORDER BY raw.src_id DESC NULLS LAST) AS rank_src
   FROM (SELECT
   a.client_id                       AS client_id,
   a.sup_sid                         AS sup_sid,
   a.item_sid                        AS item_sid,
   COALESCE(c.src_wh_id, c.loc_sid)  AS wh_id,
   CASE
                      WHEN b.dwh_valid_from > a.dwh_valid_from
                      THEN b.dwh_valid_from
                      ELSE a.dwh_valid_from
                    END                               AS valid_from,
   CASE
                      WHEN b.dwh_valid_to < a.dwh_valid_to
                      THEN b.dwh_valid_to
                      ELSE a.dwh_valid_to
                    END                               AS valid_until,
   COALESCE(a.deliverable_from_dt, DATE '1900-01-01')    AS man_valid_from,
   a.deliverable_to_dt                                   AS man_valid_until,
   a.dwh_updated,
   a.dwh_created,
   a.dwh_load_id,
   CAST(-1 AS INTEGER)               AS load_id,
   2                                 AS src_id
   FROM p_lew_core_ac.v_pinfo_header_hist_1 AS a
   INNER JOIN p_lew_core_ac.v_pinfo_detail_hist_1 AS b
   ON a.client_id = b.client_id
   AND b.pinfo_sid = a.pinfo_sid
   AND CURRENT_DATE BETWEEN b.dwh_valid_from AND b.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_location_1 AS c
   ON c.client_id = b.client_id
   AND c.loc_sid = b.loc_sid
   AND c.wh_store_mark = 'B'

   WHERE a.sup_sid IS NOT NULL
   -- Remove records completely in the future.
   AND CURRENT_DATE BETWEEN valid_from AND valid_until
   AND (a.deleted_fg = 0 OR b.deleted_fg = 0)

   UNION

   -- Wawi
   SELECT
   a.client_id                                      AS client_id,
   a.sup_sid                                      AS sup_sid,
   a.item_sid                                     AS item_sid,
   COALESCE(b.src_wh_id, b.loc_sid)               AS wh_id,
   a.dat_rec_start                                AS valid_from,
   a.dat_rec_end                                  AS valid_until,
   a.dat_valid_from                               AS man_valid_from,
   a.dat_valid_until                              AS man_valid_until,
   TIMESTAMP '1900-01-01 00:00:00'                AS dwh_updated,
   TIMESTAMP '1900-01-01 00:00:00'                AS dwh_created,
   CAST(-1 AS INTEGER)                            AS dwh_load_id,
   a.load_id,
   1 AS src_id
   FROM p_lew_core_ac.v_wawi_itm_sup_wh_data_1 AS a
   INNER JOIN p_lew_core_ac.v_location_1 AS b
   ON b.client_id = a.client_id
   AND b.loc_sid = a.wh_loc_sid
   LEFT OUTER JOIN p_lew_core_ac.v_wawi_ref_wawi_currency_1 AS c
   ON c.client_id = a.client_id
   AND c.currency_nr = a.currency_nr

   WHERE CURRENT_DATE BETWEEN valid_from AND valid_until
   AND a.delete_fg = 0
   ) raw
) rnk
WHERE rnk.rank_src = 1
) basis
   INNER JOIN p_lew_core_ac.v_supplier_hist_1 sup
   ON basis.client_id = sup.client_id
   AND basis.sup_sid = sup.sup_sid
   AND CURRENT_DATE  BETWEEN sup.dwh_valid_from AND sup.dwh_valid_to
   INNER JOIN p_lew_mart_cs.v_gen_item_asis_1 i
   ON basis.client_id = i.client_id
   AND basis.item_sid = i.item_sid


   GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18
   ;


