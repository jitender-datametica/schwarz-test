CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_ITEM_WH_STORAGE
AS
   SELECT
       client_id,
   wh_id,
   orig_item_nr,
   wh_slot_case
   FROM (
       SELECT
            iws.client_id          AS client_id,
   loc.src_wh_id          AS wh_id,
   CASE WHEN itm.src_orig_item_nr IS NULL
                                   THEN CAST(COALESCE (TRY_CAST(itm.config_item_cd AS BIGINT), TRY_CAST(itm.src_matnr AS BIGINT), itm.src_orig_item_nr) AS  BIGINT)
   ELSE CAST(itm.src_orig_item_nr AS BIGINT)
END AS orig_item_nr,
   itm.src_dat_valid_from AS dat_valid_from,
   iws.wh_slot_case
       FROM p_lew_core_ac.v_wawi_itm_wh_slot iws
   INNER JOIN p_lew_core_ac.v_item itm
   ON iws.client_id = itm.client_id
   AND iws.item_sid  = itm.item_sid
   INNER JOIN p_lew_core_ac.v_wawi_itm_item_skey_act  itm_sk
   ON itm_sk.client_id = iws.client_id
   AND itm_sk.item_sid  = iws.item_sid
   AND itm_sk.dat_deleted >= CURRENT_DATE
   INNER JOIN p_lew_core_ac.v_location loc
   ON iws.client_id  = loc.client_id
   AND iws.wh_loc_sid = loc.loc_sid

   WHERE CURRENT_DATE BETWEEN iws.dat_rec_start AND iws.dat_rec_end
   AND iws.wh_slot_case IS NOT NULL
   AND iws.wh_slot_case > 0

   /* In case there are two different dat_valid_from dates available in mis due to item renumeration get the the latest information */
   /* There are still more than 1 record for 2 different item_sid/item_id (same orig_item_nr) */
   /* but it's not important which wh_slot_case we take. */
     QUALIFY ROW_NUMBER() OVER (
       PARTITION BY iws.client_id, loc.src_wh_id, itm.src_orig_item_nr
       ORDER BY itm.src_dat_valid_from DESC NULLS LAST
     )=1
)details

GROUP BY client_id, wh_id, orig_item_nr, wh_slot_case
;