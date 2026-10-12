UPDATE  DBP_DATA.wupcal
   SET  offen = dt1.offen,
        td_update = CURRENT_TIMESTAMP
  FROM
(
SELECT
wez.mandant_id
, wez.wup_id
, wez.nb_id
, wez.dat
, MAX(wez.offen) as offen
FROM DBP_DATA.wupcal_ereignis_zu wez
GROUP BY 1,2,3,4
) dt1
WHERE dt1.mandant_id = wupcal.mandant_id
AND dt1.wup_id = wupcal.wup_id
AND dt1.nb_id = wupcal.nb_id
AND dt1.dat = wupcal.dat
AND dt1.dat = CURRENT_DATE
;

UPDATE  DBP_DATA.wupcal
   SET  datenlieferung_bonanzahl = 4,
        td_update = CURRENT_TIMESTAMP

FROM
(
SELECT
wez.mandant_id
, wez.wup_id
, wez.nb_id
, wez.dat
FROM DBP_DATA.wupcal wez
WHERE
mandant_id =1
AND nb_id = 2
AND offen = 1
AND dat = CURRENT_DATE
) dt1
WHERE dt1.mandant_id = wupcal.mandant_id
AND dt1.wup_id = wupcal.wup_id
AND dt1.nb_id = wupcal.nb_id
AND dt1.dat = wupcal.dat
;
