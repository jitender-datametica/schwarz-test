UPDATE DBP_DATA.werbewoche_kl_1 SET akt_kjwo_ww_komplett = akt_kjwo_ww
WHERE akt_kjwo_ww <= -1 AND
      mandant_id IN (7,2,6)
;
