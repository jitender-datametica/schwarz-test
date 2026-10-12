DROP TABLE IF EXISTS DBP_ETL.mseg_likp_tmp_2;

CREATE TABLE DBP_ETL.mseg_likp_tmp_2  (
mandant_id            BYTEINT NOT NULL,
lagerbew_beleg_id     DECIMAL(18,0) NOT NULL,
kj                    SMALLINT NOT NULL ,
vorgangsart_id        CHAR(2) COLLATE 'en-ci' NOT NULL ,
dat_buch              DATE NOT NULL,
ref_lagerbew_beleg_id DECIMAL(18,0),
lief_pal_typ_id       CHAR(1)
)
;

INSERT INTO DBP_ETL.mseg_likp_tmp_2
(
 mandant_id
,lagerbew_beleg_id
,kj
,vorgangsart_id
,dat_buch
,ref_lagerbew_beleg_id
)

SELECT
 t.mandant_id
,t.lagerbew_beleg_id
,t.kj
,t.vorgangsart_id
,t.dat_buch
,CASE 	WHEN t.ref_lagerbew_beleg_id_num = -2 THEN NULL
	ELSE t.ref_lagerbew_beleg_id_num END 		AS ref_lagerbew_beleg_id

FROM  DBP_DATA.lagerbew_2 t

INNER JOIN (SELECT mandant_id,
                   dat_buch
            FROM DBP_ETL.kmo_mseg_dat_2
            GROUP BY 1,2) d

ON   t.dat_buch = d.dat_buch
AND  t.mandant_id = d.mandant_id
;

UPDATE DBP_ETL.mseg_likp_tmp_2
SET lief_pal_typ_id = lief_pal_typ_id_

FROM
(SELECT
m.mandant_id                  AS mandant_id_
,m.dat_buch                    AS dat_buch_
,m.kj                          AS kj_
,m.vorgangsart_id              AS vorgangsart_id_
,m.lagerbew_beleg_id           AS lagerbew_beleg_id_
,COALESCE(l.lief_pal_typ_id,'0') AS lief_pal_typ_id_
,m.ref_lagerbew_beleg_id       AS ref_lagerbew_beleg_id_
FROM DBP_ETL.mseg_likp_tmp_2 m

LEFT OUTER JOIN DBP_DATA.besch_lief_2 l

ON  m.mandant_id            = l.mandant_id
AND m.ref_lagerbew_beleg_id = l.lief_beleg_id
AND l.dat_lief_soll         > m.dat_buch -500
WHERE m.ref_lagerbew_beleg_id IS NOT NULL

GROUP BY 1,2,3,4,5,6,7
)x
 WHERE mandant_id            = mandant_id_
AND   dat_buch              = dat_buch_
AND   kj                    = kj_
AND   vorgangsart_id        = vorgangsart_id_
AND   lagerbew_beleg_id     = lagerbew_beleg_id_
AND   ref_lagerbew_beleg_id = ref_lagerbew_beleg_id_
AND   ref_lagerbew_beleg_id IS NOT NULL
;

DELETE FROM DBP_DATA.lagerbew_lgort_grund_wup_2
WHERE (dat_buch, mandant_id) IN
(
SELECT
dat_buch ,mandant_id
FROM DBP_ETL.kmo_mseg_dat_2
)
;

INSERT INTO DBP_DATA.lagerbew_lgort_grund_wup_2
(
mandant_id
, lagerort_id
, grund_id
, wup_id
, nb_id
, auto_fg
, dat_buch
, vorgangsart_id
, lager_bewart_id
, wg_id
, arthiertyp_id
, empfaenger_id
, mandant_id_empfaenger
, betrag_lagerbew
, betrag_verkauf
, menge_lagerbew_bme
, menge_lief
, menge_lieferschein
, menge_lagerbew_kolli
, menge_lagerbew_palette
, menge_erf
, wrg_id
, betrag_vk_netto_vz
, lief_pal_typ_id

)
SELECT
d.mandant_id
, d.lagerort_id
, d.grund_id
, d.wup_id
, d.nb_id
, d.auto_fg
, d.dat_buch
, k.vorgangsart_id
, d.lager_bewart_id
, awzp.wg_id
, awzp.arthiertyp_id
, d.empfaenger_id
, d.mandant_id_empfaenger
--, SUM(betrag_lagerbew) AS betrag_lagerbew
, SUM(CAST((betrag_lagerbew ) AS DECIMAL(18,2))) AS betrag_lagerbew
, SUM(betrag_verkauf) AS betrag_verkauf
, SUM(menge_lagerbew_bme) AS menge_lagerbew_bme
, SUM(menge_lief) AS menge_lief
, SUM(menge_lieferschein) AS menge_lieferschein
, SUM(menge_lagerbew_kolli) AS menge_lagerbew_kolli
, SUM(menge_lagerbew_palette) AS menge_lagerbew_palette
, SUM(menge_erf) AS menge_erf
, wrg_id
, SUM(betrag_vk_netto_vz) AS betrag_vk_netto_vz
, COALESCE(k.lief_pal_typ_id,'0')

FROM DBP_DATA.lagerbew_det_2 d

INNER JOIN DBP_ETL.mseg_likp_tmp_2 k
ON k.mandant_id = d.mandant_id AND k.lagerbew_beleg_id = d.lagerbew_beleg_id AND k.kj = d.kj

INNER JOIN DBP_DATA.art_wg_zu_per_2 awzp
ON d.art_id           = awzp.art_id
AND awzp.arthiertyp_id = 2
AND d.mandant_id       = awzp.mandant_id
AND awzp.dat_bis       = to_date('9999-12-31','YYYY-MM_2-DD')

WHERE d.lager_bewart_id NOT IN ('251', '252') AND
     (d.mandant_id,d.dat_buch) IN (SELECT mandant_id,dat_buch FROM DBP_ETL.kmo_mseg_dat_2)

GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 22, 24
;

DROP TABLE IF EXISTS DBP_ETL.kmo_mseg_dat_2
;
