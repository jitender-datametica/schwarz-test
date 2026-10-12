UPDATE DBP_DATA.besch_bestaetigung_1

SET     kj_lief_beleg = kj_

FROM
(	SELECT
	  a.mandant_id          AS mandant_id_
	, a.lief_beleg_id       AS lief_beleg_id_
	, a.lief_beleg_pos_id   AS lief_beleg_pos_id_
        , c.kj                    AS kj_

	FROM ${TEMP_TABLE} a

        INNER JOIN DBP_DATA.besch_lief_1 b
           ON   a.mandant_id       = b.mandant_id
          AND   a.lief_beleg_id    = b.lief_beleg_id
          AND   b.dat_lief_soll    > CURRENT_DATE - 365
        
        INNER JOIN DBP_DATA.besch_lief_det_1 c
           ON   b.mandant_id            = c.mandant_id
	  AND   b.lief_beleg_id         = c.lief_beleg_id
          AND   a.lief_beleg_pos_id     = c.lief_beleg_pos_id
	  AND   b.dat_lief_soll         = c.dat_lief_soll
		
        WHERE   a.lief_beleg_id <> -1
	GROUP BY 1,2,3,4
) x
 WHERE   mandant_id              = mandant_id_
AND     lief_beleg_id           = lief_beleg_id_
AND     lief_beleg_pos_id       = lief_beleg_pos_id_
;

UPDATE DBP_DATA.besch_bestaetigung_1

SET     kj_lief_beleg = kj_

FROM
(	SELECT
	  a.mandant_id          AS mandant_id_
	, a.lief_beleg_id       AS lief_beleg_id_
	, a.lief_beleg_pos_id   AS lief_beleg_pos_id_
        , c.kj                    AS kj_

	FROM DBP_DATA.besch_bestaetigung_1 a

        INNER JOIN DBP_DATA.besch_lief_1 b
           ON   a.mandant_id       = b.mandant_id
          AND   a.lief_beleg_id    = b.lief_beleg_id
          AND   b.dat_lief_soll    > CURRENT_DATE - 365
        
        INNER JOIN DBP_DATA.besch_lief_det_1 c
           ON   b.mandant_id            = c.mandant_id
	  AND   b.lief_beleg_id         = c.lief_beleg_id
          AND   a.lief_beleg_pos_id     = c.lief_beleg_pos_id
	  AND   b.dat_lief_soll         = c.dat_lief_soll
		
        WHERE   a.lief_beleg_id <> -1
          AND   a.kj_lief_beleg = -1
	GROUP BY 1,2,3,4
) x
 WHERE   mandant_id              = mandant_id_
AND     lief_beleg_id           = lief_beleg_id_
AND     lief_beleg_pos_id       = lief_beleg_pos_id_
;

