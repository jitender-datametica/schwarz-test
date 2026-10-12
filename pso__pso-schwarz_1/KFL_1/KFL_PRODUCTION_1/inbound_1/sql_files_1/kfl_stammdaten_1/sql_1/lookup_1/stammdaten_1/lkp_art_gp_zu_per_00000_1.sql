--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT mandant_id, art_id, gp_id, dat_von, mutter_ek_id FROM DBP_DATA.art_gp_zu_per_1 WHERE dat_bis = to_date('9999-12-31','YYYY-MM_1-DD');

