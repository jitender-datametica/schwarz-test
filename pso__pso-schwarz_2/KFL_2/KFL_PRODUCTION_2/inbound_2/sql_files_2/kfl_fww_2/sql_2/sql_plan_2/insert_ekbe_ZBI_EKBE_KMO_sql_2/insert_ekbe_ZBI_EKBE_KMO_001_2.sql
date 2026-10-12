
UPDATE  DBP_ETL.kmo_ekbe
FROM    DBP_DATA.best_belegfluss_2 bbd
SET     dat_buch_orig = bbd.dat_buch

WHERE   DBP_ETL.kmo_ekbe.mandant_id 		 = bbd.mandant_id
AND     DBP_ETL.kmo_ekbe.best_beleg_pos_id        = bbd.best_beleg_pos_id
AND     DBP_ETL.kmo_ekbe.best_beleg_id            = bbd.best_beleg_id
AND     DBP_ETL.kmo_ekbe.kontierung_pos_id        = bbd.kontierung_pos_id
AND     DBP_ETL.kmo_ekbe.vorgart_best_entw_id     = bbd.vorgart_best_entw_id
AND     DBP_ETL.kmo_ekbe.folge_beleg_id           = bbd.folge_beleg_id
AND     DBP_ETL.kmo_ekbe.folge_beleg_pos_id       = bbd.folge_beleg_pos_id
AND     DBP_ETL.kmo_ekbe.kj                       = bbd.kj
;

INSERT INTO DBP_DATA.l_vorgart_best_entw_2
(
          mandant_id
        , vorgart_best_entw_id
)
SELECT DISTINCT
          mandant_id
        , vorgart_best_entw_id
FROM DBP_ETL.kmo_ekbe
WHERE (mandant_id, vorgart_best_entw_id)
NOT IN( SELECT DISTINCT mandant_id,vorgart_best_entw_id
        FROM DBP_DATA.l_vorgart_best_entw_2
       )
AND vorgart_best_entw_id IS NOT NULL;

INSERT INTO DBP_DATA.vorgart_best_entw_spr_zu_2
(
          mandant_id
        , vorgart_best_entw_id
        , spr_id
        , vorgart_best_entw_bez
)
SELECT 
          a.mandant_id
        , a.vorgart_best_entw_id
        , b.spr_id
        , 'system generated'
FROM DBP_DATA.l_vorgart_best_entw_2 a

INNER JOIN DBP_DATA.mandant_spr_zu_2 man
ON 	a.mandant_id 	= man.mandant_id

INNER JOIN  DBP_DATA.spr_2 b
ON 	b.dwh_spr = 1
AND 	(b.spr_id = man.spr_id OR b.spr_id = 22)

WHERE (a.mandant_id, a.vorgart_best_entw_id, b.spr_id)
NOT IN (SELECT	mandant_id, 
		vorgart_best_entw_id, 
		spr_id
	FROM 	DBP_DATA.vorgart_best_entw_spr_zu_2
	)
;

INSERT INTO DBP_DATA.l_best_entw_typ_2
(         mandant_id
        , best_entw_typ_id
        , nachbelastung_fg
        , preis_pruefen_fg
)
SELECT DISTINCT
          mandant_id
        , best_entw_typ_id
        , 0
        , 0
FROM DBP_ETL.kmo_ekbe
WHERE (mandant_id, best_entw_typ_id)
NOT IN( SELECT DISTINCT mandant_id, best_entw_typ_id
        FROM DBP_DATA.l_best_entw_typ_2
       )
AND best_entw_typ_id IS NOT NULL;

INSERT INTO DBP_DATA.best_entw_typ_spr_zu_2
(
  mandant_id
, best_entw_typ_id
, spr_id
, best_entw_typ_bez
, best_entw_typ_kbez
)
SELECT 	  a.mandant_id
	, a.best_entw_typ_id AS best_entw_typ_id
	, b.spr_id AS spr_id
	, 'system generated' AS best_entw_typ_bez
	, '' AS best_entw_typ_kbez
FROM DBP_DATA.l_best_entw_typ_2 a

INNER JOIN DBP_DATA.mandant_spr_zu_2 man
ON 	a.mandant_id = man.mandant_id

INNER JOIN  DBP_DATA.spr_2 b
ON 	b.dwh_spr = 1
AND 	(b.spr_id = man.spr_id OR b.spr_id = 22)

WHERE  	(a.mandant_id, a.best_entw_typ_id, b.spr_id)
	NOT IN( SELECT mandant_id, best_entw_typ_id, spr_id
		FROM DBP_DATA.best_entw_typ_spr_zu_2
	      )
;

DROP TABLE IF EXISTS DBP_ETL.kmo_ekbe_betrag_2;

CREATE TABLE DBP_ETL.kmo_ekbe_betrag_2  (
        mandant_id                      BYTEINT       NOT NULL,
        lagerbew_beleg_id               DECIMAL(18,0) NOT NULL,
        lagerbew_beleg_pos_id           DECIMAL(18,0) NOT NULL,
        kj                              SMALLINT NOT NULL,
        dat_buch                        DATE     NOT NULL,
        betrag_belegfluss_wg_art        DECIMAL(18,2)
)
;

CREATE OR REPLACE TRANSIENT TABLE _get_dates_99
AS (	SELECT 	mandant_id,
		dat_buch_orig
	FROM DBP_ETL.kmo_ekbe
	WHERE dat_buch_orig IS NOT NULL
	GROUP BY 1,2
   );


INSERT INTO  DBP_ETL.kmo_ekbe_betrag_2
(
        mandant_id,
        lagerbew_beleg_id,
        lagerbew_beleg_pos_id,
        kj,
        dat_buch,
        betrag_belegfluss_wg_art
)
SELECT
        keb.mandant_id,
	keb.folge_beleg_id,
	keb.folge_beleg_pos_id,
        keb.kj,
        keb.dat_buch,
        SUM(CAST((keb.betrag ) AS DECIMAL (18,4)) - ZEROIFNULL(CAST((bbd.betrag_ek_netto ) AS DECIMAL (18,4))))

FROM    DBP_ETL.kmo_ekbe keb
LEFT OUTER JOIN 
	(SELECT a.*
	 FROM	DBP_DATA.best_belegfluss_2 a
	 JOIN 	_get_dates_99 b
	 ON 	a.mandant_id = b.mandant_id 
	 AND	a.dat_buch = b.dat_buch_orig
	) bbd
ON      keb.vorgart_best_entw_id=  '1'                  
AND     keb.mandant_id          = bbd.mandant_id             
AND     keb.folge_beleg_id      = bbd.folge_beleg_id     
AND     keb.folge_beleg_pos_id  = bbd.folge_beleg_pos_id
AND     keb.kj                  = bbd.kj             
AND     keb.best_beleg_id       = bbd.best_beleg_id
AND     keb.dat_buch_orig       = bbd.dat_buch

GROUP BY 1,2,3,4,5
;

UPDATE  DBP_DATA.lagerbew_det_2

SET     betrag_belegfluss_wg_art = ZEROIFNULL(DBP_DATA.lagerbew_det.betrag_belegfluss_wg_art) + ZEROIFNULL(x.betrag_belegfluss_wg_art)

FROM (SELECT a.mandant_id,
             a.lagerbew_beleg_id,
             a.lagerbew_beleg_pos_id,
             a.kj,
             a.dat_buch,
             a.betrag_belegfluss_wg_art
      FROM DBP_ETL.kmo_ekbe_betrag_2 a
      JOIN DBP_DATA.lagerbew_det_2 c
        ON a.mandant_id = c.mandant_id AND
           a.lagerbew_beleg_id = c.lagerbew_beleg_id AND
           a.lagerbew_beleg_pos_id = c.lagerbew_beleg_pos_id AND
           a.dat_buch = c.dat_buch
      JOIN DBP_DATA.art_2 b
        ON c.mandant_id = b.mandant_id AND
           c.art_id = b.art_id and
           b.wg_art_fg = 1) x

WHERE DBP_DATA.lagerbew_det.mandant_id = x.mandant_id AND
      DBP_DATA.lagerbew_det.lagerbew_beleg_id = x.lagerbew_beleg_id AND
      DBP_DATA.lagerbew_det.lagerbew_beleg_pos_id = x.lagerbew_beleg_pos_id AND 
      DBP_DATA.lagerbew_det.dat_buch = x.dat_buch AND
      DBP_DATA.lagerbew_det.kj = x.kj
;

DELETE 
FROM    DBP_DATA.best_belegfluss_2
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
        FROM    DBP_ETL.kmo_ekbe
        WHERE   dat_buch_orig IS NOT NULL
  )
AND	(mandant_id,dat_buch) IN (SELECT mandant_id,dat_buch_orig FROM _get_dates_99)
;

INSERT INTO DBP_DATA.best_belegfluss_2
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
FROM DBP_ETL.kmo_ekbe
;

