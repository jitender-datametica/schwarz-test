
UPDATE  DBP_ETL.de_ekbe
FROM    DBP_DATA.best_belegfluss_1 bbd
SET     dat_buch_orig = bbd.dat_buch

WHERE   1 =  bbd.mandant_id
AND     DBP_ETL.de_ekbe.best_beleg_pos_id        = bbd.best_beleg_pos_id
AND     DBP_ETL.de_ekbe.best_beleg_id            = bbd.best_beleg_id
AND     DBP_ETL.de_ekbe.kontierung_pos_id        = bbd.kontierung_pos_id
AND     DBP_ETL.de_ekbe.vorgart_best_entw_id     = bbd.vorgart_best_entw_id
AND     DBP_ETL.de_ekbe.folge_beleg_id           = bbd.folge_beleg_id
AND     DBP_ETL.de_ekbe.folge_beleg_pos_id       = bbd.folge_beleg_pos_id
AND     DBP_ETL.de_ekbe.kj                       = bbd.kj
;

DELETE 
FROM    DBP_DATA.best_belegfluss_1
WHERE (  mandant_id
        ,best_beleg_pos_id
        ,best_beleg_id
        ,kontierung_pos_id
        ,vorgart_best_entw_id
        ,folge_beleg_id
        ,folge_beleg_pos_id
        ,kj
        ,dat_buch
)
IN(     SELECT
         mandant_id
        ,best_beleg_pos_id
        ,best_beleg_id
        ,kontierung_pos_id
        ,vorgart_best_entw_id
        ,folge_beleg_id
        ,folge_beleg_pos_id
        ,kj
        ,dat_buch_orig
        FROM    DBP_ETL.de_ekbe
        WHERE   dat_buch_orig IS NOT NULL
 )
;

INSERT INTO DBP_DATA.best_belegfluss_1
( mandant_id
, best_beleg_pos_id
, best_beleg_id
, kontierung_pos_id
, vorgart_best_entw_id
, folge_beleg_id
, folge_beleg_pos_id
, kj
, wup_id
, nb_id
, bestaetigung_lfd_nr
, best_entw_typ_id
, menge_anteil
, menge_best
, lager_bewart_id
, dat_buch
, menge_basis
, betrag_ek_netto
, wrg_id
, soll_haben_kz
, ref_beleg_id
, ref_beleg_pos_id
, ref_gj
, system_id
, betrag_wrbtr
, wrg_id_beleg
, td_insert
, td_update
)
SELECT
  mandant_id
, best_beleg_pos_id
, best_beleg_id
, kontierung_pos_id
, vorgart_best_entw_id
, folge_beleg_id
, folge_beleg_pos_id
, kj
, wup_id
, nb_id
, bestaetigung_lfd_nr
, best_entw_typ_id
, menge_anteil
, menge_best
, lager_bewart_id
, dat_buch
, menge_basis
, betrag
, wrg_id
, soll_haben_kz
, ref_beleg_id
, ref_beleg_pos_id
, ref_gj
, system_id
, betrag_wrbtr
, wrg_id_beleg
, td_insert
, td_update
FROM DBP_ETL.de_ekbe
;

INSERT INTO DBP_DATA.l_vorgart_best_entw_1
(
          mandant_id
        , vorgart_best_entw_id
)
SELECT DISTINCT
          mandant_id
        , vorgart_best_entw_id
FROM DBP_ETL.de_ekbe
WHERE vorgart_best_entw_id
NOT IN( SELECT DISTINCT vorgart_best_entw_id
        FROM DBP_DATA.l_vorgart_best_entw_1
        WHERE mandant_id = 1
       );

INSERT INTO DBP_DATA.vorgart_best_entw_spr_zu_1
(
          mandant_id
        , vorgart_best_entw_id
        , spr_id
        , vorgart_best_entw_bez
)
SELECT DISTINCT
          1
        , vorgart_best_entw_id
        , 22
        , 'system generated'
FROM DBP_DATA.l_vorgart_best_entw_1 a
WHERE (1,vorgart_best_entw_id,22)
NOT IN( SELECT DISTINCT 1, vorgart_best_entw_id, spr_id
        FROM DBP_DATA.vorgart_best_entw_spr_zu_1
        WHERE mandant_id = 1
       );

INSERT INTO DBP_DATA.l_best_entw_typ_1
(
          mandant_id
        , best_entw_typ_id
        , nachbelastung_fg
        , preis_pruefen_fg
)
SELECT DISTINCT
          mandant_id
        , best_entw_typ_id
        , 0
        , 0
FROM DBP_ETL.de_ekbe
WHERE best_entw_typ_id
NOT IN( SELECT DISTINCT best_entw_typ_id
        FROM DBP_DATA.l_best_entw_typ_1
        WHERE mandant_id = 1
       );

INSERT INTO DBP_DATA.best_entw_typ_spr_zu_1
(
  mandant_id
, best_entw_typ_id
, spr_id
, best_entw_typ_bez
, best_entw_typ_kbez
)
SELECT DISTINCT
          1
        , best_entw_typ_id
        , 22
        , 'system generated'
        , ''
FROM DBP_DATA.l_best_entw_typ_1 a
WHERE (1,best_entw_typ_id,22)
NOT IN( SELECT DISTINCT mandant_id, best_entw_typ_id, spr_id
        FROM DBP_DATA.best_entw_typ_spr_zu_1
        WHERE mandant_id = 1
       );

DROP TABLE IF EXISTS DBP_ETL.de_ekbe_betrag_1;

CREATE TABLE DBP_ETL.de_ekbe_betrag_1  (
        mandant_id                      BYTEINT       NOT NULL,
        lagerbew_beleg_id               DECIMAL(18,0) NOT NULL,
        lagerbew_beleg_pos_id           DECIMAL(18,0) NOT NULL,
        kj                              SMALLINT NOT NULL,
        dat_buch                        DATE     NOT NULL,
        betrag_belegfluss_wg_art        DECIMAL(18,2)
)
;

INSERT INTO  DBP_ETL.de_ekbe_betrag_1
(
        mandant_id,
        lagerbew_beleg_id,
        lagerbew_beleg_pos_id,
        kj,
        dat_buch,
        betrag_belegfluss_wg_art
)
SELECT
        a.mandant_id,
        a.folge_beleg_id,
        a.folge_beleg_pos_id,
        a.kj,
        a.dat_buch,
        SUM(CAST((a.betrag ) AS DECIMAL (18,4)) - ZEROIFNULL(CAST((bbd.betrag_ek_netto ) AS DECIMAL (18,4))))

FROM    DBP_ETL.de_ekbe a
LEFT OUTER JOIN DBP_DATA.best_belegfluss_1 bbd
ON      a.vorgart_best_entw_id  =  '1'                  
AND     a.mandant_id            = bbd.mandant_id             
AND     a.folge_beleg_id        = bbd.folge_beleg_id     
AND     a.folge_beleg_pos_id    = bbd.folge_beleg_pos_id
AND     a.kj                    = bbd.kj             
AND     a.best_beleg_id         = bbd.best_beleg_id
AND     a.dat_buch_orig         = bbd.dat_buch

GROUP BY 1,2,3,4,5
;

UPDATE  DBP_DATA.lagerbew_det_1

SET     betrag_belegfluss_wg_art = ZEROIFNULL(DBP_DATA.lagerbew_det.betrag_belegfluss_wg_art) + ZEROIFNULL(x.betrag_belegfluss_wg_art)

FROM (SELECT a.mandant_id,
             a.lagerbew_beleg_id,
             a.lagerbew_beleg_pos_id,
             a.kj,
             a.dat_buch,
             a.betrag_belegfluss_wg_art
      FROM DBP_ETL.de_ekbe_betrag_1 a
      JOIN DBP_DATA.lagerbew_det_1 c
        ON a.mandant_id = c.mandant_id AND
           a.lagerbew_beleg_id = c.lagerbew_beleg_id AND
           a.lagerbew_beleg_pos_id = c.lagerbew_beleg_pos_id AND
           a.dat_buch = c.dat_buch
      JOIN DBP_DATA.art_1 b
        ON c.mandant_id = b.mandant_id AND
           c.art_id = b.art_id and
           b.wg_art_fg = 1) x

WHERE DBP_DATA.lagerbew_det.mandant_id = x.mandant_id AND
      DBP_DATA.lagerbew_det.lagerbew_beleg_id = x.lagerbew_beleg_id AND
      DBP_DATA.lagerbew_det.lagerbew_beleg_pos_id = x.lagerbew_beleg_pos_id AND 
      DBP_DATA.lagerbew_det.dat_buch = x.dat_buch AND
      DBP_DATA.lagerbew_det.kj = x.kj
;

