DELETE FROM DBP_DATA.wupcal_1
WHERE (
        wup_id
        , mandant_id
        , nb_id
        , dat
        )
IN
(       SELECT
                  wc.wup_id
                , wc.mandant_id
                , wc.nb_id
                , wc.dat
          FROM  DBP_DATA.wupcal_1 wc
         INNER JOIN DBP_DATA.wup_1 w
            ON  wc.wup_id = w.wup_id
           AND  wc.mandant_id = w.mandant_id
           AND  wc.nb_id = w.nb_id
         WHERE (wc.dat < w.dat_von
            OR  wc.dat > COALESCE(w.dat_bis, to_date('9999-12-31','YYYY-MM_1-DD'))))
;

INSERT INTO DBP_DATA.wupcal_1
( wup_id
, mandant_id
, nb_id
, dat
, offen
, werbewoche
, datenlieferung_artbew_wg_sum
, bonanzahl
, datenlieferung_bonanzahl
, bonanzahl_misvier
, datenlieferung_misvier
, datenlieferung_artbew
, datenlieferung_qbm_status
, td_insert
, td_update
)
SELECT
  wup_id
, mandant_id
, nb_id
, dat
, 1     AS offen
, 0     AS werbewoche /* Nein */
, 0     AS datenlieferung_artbew_wg_sum /* unbekannt */
, 0     AS bonanzahl /* unbekannt */
, 0     AS datenlieferung_bonanzahl /* 0 = nein, es sind keine Tagesdaten da. */
, 0     AS bonanzahl_misvier /* unbekannt */
, 0     AS datenlieferung_misvier /* unbekannt */
, 0     AS datenlieferung_artbew
, 0     AS datenlieferung_qbm_status /* unbekannt */
, CURRENT_TIMESTAMP
, CURRENT_TIMESTAMP
  FROM DBP_DATA.wup_1 w
 CROSS JOIN DBP_DATA.tag_1 t
 WHERE w.dat_von <= t.dat
   AND (CASE    WHEN w.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
                THEN CURRENT_DATE
                ELSE w.dat_bis
        END) >= t.dat
   AND t.dat >= to_date('1998-01-01','YYYY-MM_1-DD')
   AND (w.mandant_id, w.wup_id, w.nb_id, t.dat) NOT IN
        (SELECT mandant_id, wup_id, nb_id, dat 
         FROM DBP_DATA.wupcal_1)
   AND t.dat <= CURRENT_DATE
;

