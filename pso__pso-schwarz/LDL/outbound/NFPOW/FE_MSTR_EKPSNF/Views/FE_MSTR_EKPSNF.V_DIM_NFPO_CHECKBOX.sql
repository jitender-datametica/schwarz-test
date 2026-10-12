CREATE OR REPLACE VIEW nfpow_fe_mstr_ekpsnf.v_dim_nfpo_checkbox (checkbox_fg, checkbox_cd, checkbox_descr) AS SELECT
 'FALSE' AS checkbox_fg,
 'O' AS checkbox_cd,
 'Checkbox ist nicht ausgewählt' AS checkbox_descr
UNION ALL
SELECT 'FALSE' AS checkbox_fg,
 'O' AS checkbox_cd,
 'Checkbox ist nicht ausgewählt' AS checkbox_descr;