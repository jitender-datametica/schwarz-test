--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.art_wup_ek_zu_per
WHERE mandant_id > 1;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.art_wup_ek_zu_per (art_id,
                                         mandant_id,
                                         wup_id,
                                         nb_id,
                                         dat_von,
                                         dat_bis,
                                         ek_netto,
                                         ek_netto_bnk,
                                         ek_mep,
                                         einstandspreis,
                                         komponentenmenge,
                                         wrg_id,
                                         ek_nettonetto,
                                         kein_zekp_fg)
SELECT art_id,
       mandant_id,
       wup_id,
       nb_id,
       dat_von,
       dat_bis,
       ek_netto,
       ek_netto_bnk,
       ek_mep,
       einstandspreis,
       komponentenmenge,
       wrg_id,
       ek_nettonetto,
       kein_zekp_fg
FROM DBP_ETL.art_wup_ek_zu_per_rb_kmo
WHERE mandant_id > 1;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_wup_ek_zu_per_rb_kmo;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.art_wup_ek_datum_relevant_kmo;

