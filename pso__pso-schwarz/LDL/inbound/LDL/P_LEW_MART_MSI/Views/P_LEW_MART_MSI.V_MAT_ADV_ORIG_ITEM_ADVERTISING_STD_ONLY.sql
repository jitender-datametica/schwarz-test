CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_ADV_ORIG_ITEM_ADVERTISING_STD_ONLY
AS
SELECT
adv.client_id,
Coalesce(l.src_orig_wh_nr,adv.wh_loc_sid )  AS wh_id,
iis.orig_item_nr,
iis.dat_valid_from,
adv.dat_adv,
adv.week_adv,
adv.repeat_fg,
cry.currency_iso_cd,
CAST(1 AS SMALLINT) AS rec_src_fg_std,
CAST(0 AS SMALLINT) AS rec_src_fg_apt
FROM p_lew_core_ac.v_wawi_adv_item_advertising AS adv

INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry
ON     adv.client_id = cry.client_id
   AND Current_Date BETWEEN cry.dat_rec_start AND cry.dat_rec_end

INNER JOIN p_lew_core_ac.v_wawi_itm_item_act iis
ON     adv.item_sid  = iis.item_sid
   AND adv.client_id = iis.client_id

INNER JOIN p_lew_core_ac.v_location AS l
ON l.loc_sid =  adv.wh_loc_sid
AND l.client_id = adv.client_id
QUALIFY ROW_NUMBER() OVER
(PARTITION BY adv.client_id, wh_id, iis.orig_item_nr, iis.dat_valid_from, adv.dat_adv, cry.currency_iso_cd
 ORDER BY adv.dat_dayend DESC NULLS LAST
) = 1
;




