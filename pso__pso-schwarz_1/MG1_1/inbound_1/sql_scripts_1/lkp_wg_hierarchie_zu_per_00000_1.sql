--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT	mandant_id, wg_hierarchie_id, arthiertyp_id, wg_hierarchie_ebene_id,wg_hierarchie_mutter_id
FROM DBP_DATA.wg_hierarchie_zu_per_1
WHERE dat_bis = to_date('9999-12-31','YYYY-MM_1-DD');

