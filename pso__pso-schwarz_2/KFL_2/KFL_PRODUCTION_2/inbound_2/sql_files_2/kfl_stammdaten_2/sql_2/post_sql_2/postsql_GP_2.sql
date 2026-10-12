--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_DATA.gp_2 
SET wewa_fg = 1
FROM
(
SELECT
mandant_id AS upd_mandant_id
,gp_id AS upd_gp_id
FROM DBP_DATA.gp_2
WHERE wewa_fg = 1
AND mandant_id = 1
) up WHERE hgp_id = upd_gp_id
AND mandant_id = upd_mandant_id
;

