CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_BUYPRICE_SAP_2
AS
SELECT
clnt.src_country_lidl_cd                                                                    AS land_2,
Coalesce (loc.src_wh_id, -1)                                                                 AS whid,
Cast(Coalesce(itm.config_item_cd,itm.src_orig_item_nr,itm.src_matnr) AS BIGINT)             AS orig_item_nr,
CASE WHEN supl.src_orig_supplier_nr IS NULL OR supl.src_orig_supplier_nr = -999
             THEN Cast(supl.src_lifnr AS BIGINT)
             ELSE Cast(supl.src_orig_supplier_nr AS BIGINT)
     END                                                                                         AS supplier_nr,
purch_info_hist_mod.dwh_valid_from                                                            AS valid_from,
purch_info_hist_mod.dwh_valid_to                                                            AS valid_until,
purch_cond_hist.condition_val / Coalesce(x_rate.corrected_x_rate,1)                                AS buyprice,
purch_cond_hist.condition_val                                                                AS buyprice_orig,
CASE WHEN LENGTH(purch_cond_hist.curr_cd) = 4
             THEN SUBSTR(purch_cond_hist.curr_cd,1, 3)
             ELSE purch_cond_hist.curr_cd
     END                                                                                        AS currency_iso

/* Base data is purchase info header */
FROM p_lew_core_ac.v_pinfo_header_2 head

/* Join for getting loc_sid, pur_org_sid and pinfo_type_cd */
INNER JOIN p_lew_core_ac.v_pinfo_detail_hist_2 dtl
ON head.client_id = dtl.client_id
AND head.pinfo_sid = dtl.pinfo_sid
AND Current_Date BETWEEN dtl.dwh_valid_from AND dtl.dwh_valid_to

/* Join for getting all warehouses of a country_2 if loc_sid in pinfo_detail_hist is negative (dummy_2) */
LEFT OUTER JOIN
    (SELECT
client_id,
loc_sid_wh,
src_werks,
src_wh_id
FROM p_lew_bil_ac.v_warehouse_2
               WHERE deleted_fg = 0
                   AND bges_active_fg = 1
                   AND Current_Date BETWEEN dwh_valid_from AND dwh_valid_to
           ) wh
       ON dtl.client_id = wh.client_id
       AND dtl.loc_sid < 0

/* Join for selecting pur_cond_sid and validity_2 period of condition; LEFT OUTER JOIN with v_warehouse_2 to resolve negative loc_sids */
INNER JOIN (SELECT
purch_info_hist.client_id,
purch_info_hist.sup_sid,
purch_info_hist.item_sid,
purch_info_hist.pur_org_sid,
purch_info_hist.loc_sid,
purch_info_hist.pur_cond_sid,
purch_info_hist.cond_type_cd,
purch_info_hist.einfo_type_cd,
purch_info_hist.application_cd,
purch_info_hist.general_purchase_info_fg,
purch_info_hist.active_from_dt,
purch_info_hist.active_to_dt,
purch_info_hist.deleted_fg,
purch_info_hist.dwh_valid_from,
purch_info_hist.dwh_valid_to,
purch_info_hist.dwh_load_id,
purch_info_hist.dwh_created,
purch_info_hist.dwh_updated,
Coalesce(wh_2.loc_sid_wh,purch_info_hist.loc_sid) AS loc_sid_mod
FROM p_lew_core_ac.v_purchase_info_hist_2 purch_info_hist
LEFT OUTER JOIN
(SELECT
client_id,
loc_sid_wh,
src_werks,
src_wh_id
FROM p_lew_bil_ac.v_warehouse_2
               WHERE deleted_fg = 0
                   AND bges_active_fg = 1
                   AND Current_Date BETWEEN dwh_valid_from AND dwh_valid_to
       ) wh_2
       ON purch_info_hist.client_id = wh_2.client_id
       AND purch_info_hist.loc_sid < 0

    ) purch_info_hist_mod
    ON head.client_id = purch_info_hist_mod.client_id
    AND head.item_sid = purch_info_hist_mod.item_sid
    AND head.sup_sid = purch_info_hist_mod.sup_sid
    AND dtl.pur_org_sid = purch_info_hist_mod.pur_org_sid
    AND dtl.pinfo_type_cd = purch_info_hist_mod.einfo_type_cd
    AND Coalesce(wh.loc_sid_wh,dtl.loc_sid) = purch_info_hist_mod.loc_sid_mod
    AND Current_Date BETWEEN purch_info_hist_mod.dwh_valid_from AND purch_info_hist_mod.dwh_valid_to

/* Join for selecting purchase price (condition_val) */
INNER JOIN p_lew_core_ac.v_purchase_condition_hist_2 purch_cond_hist
ON purch_info_hist_mod.client_id = purch_cond_hist.client_id
AND purch_info_hist_mod.pur_cond_sid = purch_cond_hist.pur_cond_sid
AND purch_cond_hist.condition_val IS NOT NULL
AND Current_Date BETWEEN purch_cond_hist.dwh_valid_from AND purch_cond_hist.dwh_valid_to

/* Join for selecting country_2 code */
INNER JOIN p_lew_core_ac.v_client_2 clnt
ON head.client_id = clnt.client_id

/* Join for determination of the exchange rate from currency of condition
   to currency of Lidl country_2 currency, i.e. currency from client record.
   Only those exchange rates are to be selected with a special rate flag
   in the corresponding exchange_rate_type - record.
   Without already deleted records only originally negative exchange rates
   are resulting.
   To get realistic exchange rates there is a select condition on
   technical and functional validity_2 period.
   Condidering this, normally not more than one actual valid result should
   exist per combination of client, source and target currency. Preventively
   a MAX() function is used to get only one result in this case.
*/
LEFT OUTER JOIN
 (SELECT
x_rate_hist.client_id            AS client_id,
x_rate_hist.curr_sid_from         AS orig_curr_sid,
x_rate_hist.curr_cd_from         AS orig_curr_cd,
x_rate_hist.curr_sid_to            AS target_curr_sid,
x_rate_hist.curr_cd_to            AS target_curr_cd,
Max(x_rate_hist.exchange_rate * (-1)) AS corrected_x_rate
FROM p_lew_core_ac.v_exchange_rate_known_hist_2 x_rate_hist
/* only exchange rates having set a special rate flag */
INNER JOIN p_lew_core_ac.v_exchange_rate_type_2 x_rate_type
ON x_rate_hist.client_id = x_rate_type.client_id
AND x_rate_hist.x_rate_type_sid = x_rate_type.x_rate_type_sid
AND x_rate_type.special_rate_fg = 1
/* only technical and functional valid exchange rates */
WHERE Current_Date BETWEEN x_rate_hist.dwh_valid_from AND x_rate_hist.dwh_valid_to
AND Current_Date BETWEEN x_rate_hist.active_from_dt AND x_rate_hist.active_to_dt
/* only non deleted records */
AND  x_rate_hist.deleted_fg = 0
/* only records with exchange_rate not equal to zero */
AND  x_rate_hist.exchange_rate <> 0
/* Determine the highest valid exchange rate (considering sign) respectively for the combination of client, target and source currency */
GROUP BY x_rate_hist.client_id, x_rate_hist.curr_sid_from, x_rate_hist.curr_cd_from, x_rate_hist.curr_sid_to, x_rate_hist.curr_cd_to

UNION

/* UNION part includes same currency pairs vice versa, because the definition of exchange rates
   is only defined in one direction and the underlying table contains not(!) a full definition.
   That means you will not find for every currency pair a vice versa definition with a reciprocal
   value for the exchange rate:
      - therefore curr_sid_from and curr_sid_to are switched as well as curr_cd_from and curr_cd_to
      - reciprocal (Kehrwert) of exchange_rate because from-currency and to-currency are switched
*/
SELECT
y_rate_hist.client_id            AS client_id,
y_rate_hist.curr_sid_to             AS orig_curr_sid,
y_rate_hist.curr_cd_to             AS orig_curr_cd,
y_rate_hist.curr_sid_from        AS target_curr_sid,
y_rate_hist.curr_cd_from            AS target_curr_cd,
Max(((1/y_rate_hist.exchange_rate) * (-1))) AS corrected_y_rate
FROM p_lew_core_ac.v_exchange_rate_known_hist_2 y_rate_hist
/* only exchange rates having set a special rate flag */
INNER JOIN p_lew_core_ac.v_exchange_rate_type_2 y_rate_type
ON y_rate_hist.client_id = y_rate_type.client_id
AND y_rate_hist.x_rate_type_sid = y_rate_type.x_rate_type_sid
AND y_rate_type.special_rate_fg = 1
/* only technical and functional valid exchange rates */
WHERE Current_Date BETWEEN y_rate_hist.dwh_valid_from AND y_rate_hist.dwh_valid_to
AND Current_Date BETWEEN y_rate_hist.active_from_dt AND y_rate_hist.active_to_dt
/* only non deleted records */
AND  y_rate_hist.deleted_fg = 0
/* only records with exchange_rate not equal to zero */
AND  y_rate_hist.exchange_rate <> 0
/* Determine the highest valid exchange rate (considering sign) respectively for the combination of client, target and source currency */
GROUP BY y_rate_hist.client_id, y_rate_hist.curr_sid_to, y_rate_hist.curr_cd_to, y_rate_hist.curr_sid_from, y_rate_hist.curr_cd_from

) x_rate
ON purch_cond_hist.client_id = x_rate.client_id
AND purch_cond_hist.curr_sid = x_rate.orig_curr_sid
AND clnt.curr_sid            = x_rate.target_curr_sid

/* Join for selecting item_2 information, filter for log_var_cd 3: only purchase items */
INNER JOIN p_lew_core_ac.v_item_2 itm
ON head.client_id = itm.client_id
AND head.item_sid = itm.item_sid
AND itm.log_var_cd = 3

/* Join for selecting item_grp_sid (see below) as groups plants, fruit and vegetables have to be ignored */
INNER JOIN p_lew_core_ac.v_item_hist_2 itm_hist
ON itm.client_id = itm_hist.client_id
AND itm.item_sid = itm_hist.item_sid
AND Current_Date BETWEEN itm_hist.dwh_valid_from AND itm_hist.dwh_valid_to

/* Join for selecting item_2 group as groups plants, fruit and vegetables have to be ignored */
INNER JOIN p_lew_core_ac.v_item_group_2 itm_grp
ON itm_hist.client_id = itm_grp.client_id
AND itm_hist.item_grp_sid = itm_grp.item_grp_sid
/* item_2 groups plants, fruit and vegetables have to be ignored for WFM */
AND itm_grp.src_matkl NOT IN ('10','11','12','13')

/* Join for selecting WH_ID, filter for wh_store_mark 'B': only warehouse data */
INNER JOIN p_lew_core_ac.v_location_2 loc
ON head.client_id = loc.client_id
AND Coalesce(wh.loc_sid_wh,dtl.loc_sid) = loc.loc_sid
AND loc.wh_store_mark = 'B'

/* Join for selecting supplier_nr */
INNER JOIN p_lew_core_ac.v_supplier_2 supl
ON head.client_id = supl.client_id
AND head.sup_sid = supl.sup_sid

/* Join for restriction to select data only from migrated countries (preventively) */
INNER JOIN p_lew_core_ac.v_client_migration_per_2  sap_migration_client
ON head.client_id = sap_migration_client.client_id
AND Current_Date BETWEEN sap_migration_client.migration_dat_valid_from AND sap_migration_client.migration_dat_valid_to
QUALIFY Row_Number() OVER(PARTITION BY  clnt.src_country_lidl_cd                                                         /* Land_2 */
, Coalesce (loc.src_wh_id, -1)                                                     /* WHID */
, Cast(Coalesce(itm.config_item_cd,itm.src_orig_item_nr,itm.src_matnr) AS BIGINT)  /* ORIG_ITEM_NR */
, CASE WHEN supl.src_orig_supplier_nr IS NULL OR supl.src_orig_supplier_nr = -999
       THEN Cast(supl.src_lifnr AS BIGINT)
       ELSE Cast(supl.src_orig_supplier_nr AS BIGINT)
  END                                                                              /* Supplier_nr */
, purch_info_hist_mod.dwh_valid_from                                               /* valid_from of condition */
ORDER BY purch_cond_hist.condition_val / Coalesce(x_rate.corrected_x_rate,1) DESC NULLS LAST
, purch_cond_hist.dwh_valid_from DESC NULLS LAST) = 1                                                                      /* ORDER BY Buyprice and technical valid_from */ /* ORDER BY Buyprice and technical valid_from */
;


