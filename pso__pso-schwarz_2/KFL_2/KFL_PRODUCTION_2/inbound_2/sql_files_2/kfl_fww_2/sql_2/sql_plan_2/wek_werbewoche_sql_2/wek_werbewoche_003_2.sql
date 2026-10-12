/* AW check 2021-05-17*/
UPDATE DBP_DATA.werbewoche_kl_2 SET akt_kjwo_ww_komplett = -1
WHERE akt_kjwo_ww = -1 AND
      mandant_id IN (8)
;
