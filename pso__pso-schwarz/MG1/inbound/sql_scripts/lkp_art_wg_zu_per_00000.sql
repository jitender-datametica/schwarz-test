--[OK] statement is translated correctly (syntax and type checks are fine)
Select mandant_id, art_id, wg_id from DBP_DATA.art_wg_zu_per where arthiertyp_id = 2 and dat_bis = to_date('9999-12-31','YYYY-MM-DD');

