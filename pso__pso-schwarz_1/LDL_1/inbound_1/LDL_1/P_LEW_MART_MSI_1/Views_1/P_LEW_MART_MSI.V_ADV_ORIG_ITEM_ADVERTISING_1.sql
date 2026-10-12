CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_ADV_ORIG_ITEM_ADVERTISING_1
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
                 a.client_id,
           a.wh_id,
           a.orig_item_nr,
           a.dat_valid_from,
           a.dat_adv,
           a.repeat_fg,
           a.currency_iso_cd,
           a.rec_src_fg_std,
           a.rec_src_fg_apt
 FROM p_lew_bil_ac.v_adv_orig_item_advertising_1 a
;