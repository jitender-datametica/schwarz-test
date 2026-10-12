--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT mandant_id, wg_id FROM DBP_DATA.wg_per WHERE dat_bis = to_date('9999-12-31','YYYY-MM-DD') AND owg_id <> -1;

