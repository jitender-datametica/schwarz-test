CREATE OR REPLACE VIEW P_LEW_BIL.V_ADV_ORIG_ITEM_ADVERTISING_1
(
      client_id
    , wh_id
    , orig_item_nr
    , dat_valid_from
    , dat_adv
    , repeat_fg
    , currency_iso_cd
    , rec_src_fg_std
    , rec_src_fg_apt
)
AS
SELECT
adv_union.client_id,
adv_union.wh_id,
adv_union.orig_item_nr,
adv_union.dat_valid_from,
adv_union.dat_adv,
adv_union.repeat_fg,
adv_union.currency_iso_cd,
Max(adv_union.rec_src_fg_std) AS rec_src_fg_std,
Max(adv_union.rec_src_fg_apt) AS rec_src_fg_apt
FROM (SELECT
adv.client_id,
Coalesce(l.src_orig_wh_nr,adv.wh_loc_sid )  AS wh_id,
iis.orig_item_nr,
iis.dat_valid_from,
adv.dat_adv,
adv.repeat_fg,
cry.currency_iso_cd,
adv.dat_dayend,
TO_NUMBER('1') AS rec_src_fg_std,
TO_NUMBER('0') AS rec_src_fg_apt
FROM p_lew_core_ac.v_wawi_adv_item_advertising_1 AS adv

INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS cry
ON     adv.client_id = cry.client_id
   AND Current_Date BETWEEN cry.dat_rec_start AND cry.dat_rec_end

INNER JOIN p_lew_core_ac.v_wawi_itm_item_act_1 iis
ON     adv.item_sid  = iis.item_sid
   AND adv.client_id = iis.client_id

INNER JOIN p_lew_core_ac.v_location_1 AS l
ON l.loc_sid =  adv.wh_loc_sid
QUALIFY Row_Number() Over
(PARTITION BY adv.client_id, wh_id,orig_item_nr,dat_valid_from, adv.dat_adv, currency_iso_cd
 ORDER BY dat_dayend DESC NULLS LAST
) = 1

UNION ALL
SELECT
apt.client_id,
Coalesce(l.src_orig_wh_nr,apt.wh_loc_sid )  AS wh_id,
iis.orig_item_nr AS orig_item_nr,
iis.dat_valid_from,
apt.dat_adv,
CAST(0 AS SMALLINT)  AS repeat_fg,
cry.currency_iso_cd,
Cast (NULL AS DATE) dat_dayend,
TO_NUMBER('0') AS rec_src_fg_std,
TO_NUMBER('1') AS rec_src_fg_apt
FROM p_lew_core_ac.v_wawi_adv_item_advertising_s_ap_1 AS apt

INNER JOIN p_lew_core_ac.v_wawi_itm_item_skey_1  AS sky
ON     apt.client_id = sky.client_id
   AND apt.orig_item_nr = sky.orig_item_nr
   AND apt.dat_adv < sky.dat_rec_end

INNER JOIN (SELECT
a.client_id,
Coalesce(wawi.dat_valid_from, a.src_dat_valid_from, dwf1.src_dat_valid_from, dwf2.src_dat_valid_from, TO_DATE('31.12.9999', 'dd.mm.yyyy')) AS dat_valid_from -- bevorzugt DAT_VALID_FROM aus T_WAWI_ITM_ITEM_ACT_1 nehmen, damit bei Dummy_1 Artikeln (CASE_SIZE = -1) der spätere, aktualisierte Fachschlüssel hochgereicht wird
,
a.item_sid,
TRY_CAST(Coalesce(a.src_orig_item_nr,a.config_item_cd,a.src_matnr) AS DECIMAL(18,0)) AS orig_item_nr
FROM p_lew_core_ac.v_item_1 a

INNER JOIN p_lew_core_ac.v_item_hist_1 b
ON b.client_id = a.client_id
AND b.item_sid = a.item_sid
AND Current_Date BETWEEN b.dwh_valid_from AND b.dwh_valid_to

LEFT OUTER JOIN p_lew_core_ac.v_wawi_itm_item_act_1 wawi
ON wawi.client_id = a.client_id
AND wawi.item_sid = a.item_sid

LEFT OUTER JOIN (SELECT
a.client_id,
a.item_sid,
b.src_dat_valid_from
FROM p_lew_core_ac.v_item_1 a

INNER JOIN p_lew_core_ac.v_item_1 b
ON b.client_id = a.client_id
AND b.item_sid_config = Coalesce(a.item_sid_config,a.item_sid)
AND b.src_dat_valid_from IS NOT NULL
AND NOT EXISTS (SELECT
1
FROM p_lew_core_ac.v_item_1 c
WHERE c.client_id = a.client_id
AND c.item_sid_config = Coalesce(a.item_sid_config,a.item_sid)
AND (c.src_dat_valid_from > b.src_dat_valid_from OR (c.src_dat_valid_from = b.src_dat_valid_from AND c.item_sid > b.item_sid))
)
) dwf1
ON dwf1.client_id = a.client_id
AND dwf1.item_sid = a.item_sid

LEFT OUTER JOIN (SELECT
client_id,
TRY_CAST(src_orig_item_nr AS INTEGER) AS origi,
Max(src_dat_valid_from) AS src_dat_valid_from
FROM p_lew_core_ac.v_item_1 c
WHERE src_dat_valid_from IS NOT NULL
AND origi IS NOT NULL
AND src_case_size >= 0
GROUP BY 1,2
) dwf2
ON dwf2.client_id = a.client_id
AND dwf2.origi = TRY_CAST(Coalesce(a.src_orig_item_nr,a.config_item_cd,a.src_matnr) AS DECIMAL(18,0))
AND a.log_var_cd IS NOT NULL

WHERE TRY_CAST(Coalesce(a.src_orig_item_nr,a.config_item_cd,a.src_matnr) AS DECIMAL(18,0)) IS NOT NULL
) AS iis
 ON  iis.client_id = sky.client_id
    AND iis.item_sid = sky.item_sid
    AND apt.dat_adv BETWEEN iis.dat_valid_from AND sky.dat_rec_end

INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS cry
ON     apt.client_id = cry.client_id
   AND Current_Date BETWEEN cry.dat_rec_start AND cry.dat_rec_end

INNER JOIN p_lew_core_ac.v_location_1 AS l
ON l.loc_sid =  apt.wh_loc_sid

/* Double-Join to add latest (dat_valid_from) based on related (item_id) provided by X_VIEW (v_itm_item_act_1) */
WHERE Current_Date BETWEEN apt.dat_rec_start AND apt.dat_rec_end
QUALIFY  Row_Number() Over
(PARTITION BY apt.client_id, wh_id , sky.item_sid, apt.dat_adv, cry.currency_iso_cd
 ORDER BY sky.dat_rec_end DESC NULLS LAST
) = 1
) adv_union
GROUP BY  adv_union.client_id
, adv_union.wh_id
, adv_union.orig_item_nr
, adv_union.dat_valid_from
, adv_union.dat_adv
, adv_union.repeat_fg
, adv_union.currency_iso_cd
;



