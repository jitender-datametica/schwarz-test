--[OK] statement is translated correctly (syntax and type checks are fine)
SELECT
   mandant_id
  ,TRIM(lager_bewart_id) AS lager_bewart_id
  ,TRIM(grund_id) AS grund_id
  ,spr_id
FROM DBP_DATA.lager_bewgrund_spr_zu
WHERE hist_fg = 0;

