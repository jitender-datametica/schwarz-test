/* AW check 2021-05-17*/
UPDATE DBP_DATA.werbewoche_kl SET akt_kjwo_ww_komplett = -1
WHERE akt_kjwo_ww = -1 AND
      mandant_id IN (8)
;

UPDATE DBP_DATA.werbewoche_kl SET akt_kjwo_ww_komplett = 0
WHERE akt_kjwo_ww = 1 AND
      mandant_id IN (8) AND
      dat IN (SELECT dat 
              FROM DBP_DATA.tag 
              WHERE dat = CURRENT_DATE AND 
                    wtag_id = 1)
;
