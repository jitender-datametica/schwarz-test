--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.kmo_mard_dat
(   mandant_id
   ,dat_von
)
SELECT
    mandant_id
   ,dat_von
FROM DBP_ETL.lagerbestand_erp_tmpk
GROUP BY 1,2
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE  DBP_ETL.lagerbestand_erp_tmpk
   SET  wrg_id      = gld.wrg_id_,
        ek_netto_bnk= gld.gld_
  FROM
(
SELECT
 dt1.mandant_id         AS mandant_id_
,dt1.art_id             AS art_id_
,dt1.bewertungskreis_id AS bewertungskreis_id_
,dt1.dat_gld            AS dat_gld_
,dt1.wrg_id             AS wrg_id_
,dt1.gld                AS gld_

FROM DBP_DATA.art_bewertungskreis_tag dt1

INNER JOIN DBP_ETL.kmo_mard_dat dt2
ON dt2.dat_von       = dt1.dat_gld
AND dt2.mandant_id = dt1.mandant_id

GROUP BY 1,2,3,4,5,6
) gld
 WHERE art_id           = gld.art_id_
AND mandant_id         = gld.mandant_id_
AND dat_von            = gld.dat_gld_
AND bewertungskreis_id = gld.bewertungskreis_id_

;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.kmo_mard_dat;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.kmo_mard_dat
(mandant_id
,dat_von
)
SELECT
         mandant_id
        ,dat_von
FROM    DBP_ETL.lagerbestand_erp_tmpk
WHERE   ek_netto_bnk IS NULL
GROUP BY 1,2
;

UPDATE DBP_ETL.lagerbestand_erp_tmpk

SET wrg_id      = wrg_id_
,ek_netto_bnk = ek_netto_bnk_

FROM
(
SELECT
bld.mandant_id                  AS mandant_id_
,bld.lagerort_id                 AS lagerort_id_
,bld.wup_id                      AS wup_id_
,bld.dat_von                     AS dat_von_
,bld.art_id                      AS art_id_
,COALESCE(gld.wrg_id,bld.wrg_id) AS wrg_id_
,COALESCE(gld.gld , 0 )          AS ek_netto_bnk_
FROM DBP_ETL.lagerbestand_erp_tmpk bld

LEFT OUTER JOIN
(
SELECT
dt1.mandant_id AS mandant_id
,dt1.art_id     AS art_id
,dt1.dat_gld    AS dat_gld
,dt1.wrg_id     AS wrg_id
,dt1.gld        AS gld

FROM DBP_DATA.art_bewertungskreis_tag dt1

INNER JOIN DBP_ETL.kmo_mard_dat dt2
ON dt2.dat_von       = dt1.dat_gld
AND dt2.mandant_id = dt1.mandant_id
) gld
ON bld.art_id        = gld.art_id
AND bld.mandant_id = gld.mandant_id
AND bld.dat_von    = gld.dat_gld

WHERE bld.ek_netto_bnk IS NULL

QUALIFY row_number() over (PARTITION BY bld.mandant_id,bld.lagerort_id,bld.wup_id,bld.art_id,bld.dat_von order by ek_netto_bnk_ DESC) = 1
) xx
 WHERE mandant_id  = mandant_id_
AND dat_von     = dat_von_
AND lagerort_id = lagerort_id_
AND wup_id      = wup_id_
AND art_id      = art_id_
AND ek_netto_bnk IS NULL
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.kmo_mard_dat;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.kmo_mard_dat
(
mandant_id
,dat_von
)
SELECT
mandant_id
,dat_von - 1
FROM DBP_ETL.lagerbestand_erp_tmpk
WHERE ek_netto_bnk = 0
GROUP BY 1,2
;

UPDATE  DBP_ETL.lagerbestand_erp_tmpk
   SET   wrg_id      = wrg_id_
        ,ek_netto_bnk = ek_netto_bnk_
  FROM
(
SELECT
bld.mandant_id                  AS mandant_id_
,bld.lagerort_id                 AS lagerort_id_
,bld.wup_id                      AS wup_id_
,bld.dat_von                     AS dat_von_
,bld.dat_von - 1                 AS dat_von_1
,bld.art_id                      AS art_id_
,COALESCE(gld.wrg_id,bld.wrg_id) AS wrg_id_
,COALESCE(gld.gld, 0)            AS ek_netto_bnk_
FROM DBP_ETL.lagerbestand_erp_tmpk bld

LEFT OUTER JOIN
(
SELECT
dt1.mandant_id AS mandant_id
,dt1.art_id     AS art_id
,dt1.dat_gld    AS dat_gld
,dt1.wrg_id     AS wrg_id
,dt1.gld        AS gld
FROM DBP_DATA.art_bewertungskreis_tag dt1

INNER JOIN DBP_ETL.kmo_mard_dat dt2
ON dt2.dat_von       = dt1.dat_gld
AND dt2.mandant_id = dt1.mandant_id

) gld
ON bld.art_id        = gld.art_id
AND bld.mandant_id = gld.mandant_id
AND bld.dat_von - 1      = gld.dat_gld

WHERE bld.ek_netto_bnk = 0

QUALIFY row_number() over (PARTITION BY bld.mandant_id,bld.lagerort_id,bld.wup_id,bld.art_id,dat_von_1 order by ek_netto_bnk_ DESC) = 1
) xx
 WHERE mandant_id  = mandant_id_
AND dat_von     = dat_von_
AND lagerort_id = lagerort_id_
AND wup_id      = wup_id_
AND art_id      = art_id_
AND ek_netto_bnk = 0
;

UPDATE DBP_ETL.lagerbestand_erp_tmpk
SET  vk_netto = vk_netto_
FROM
(
SELECT
a.mandant_id             AS mandant_id_
,a.dat_von                AS dat_von_
,a.dat_bis                AS dat_bis_
,a.art_id                 AS art_id_
,COALESCE(ap.vk_brutto,0) AS vk_brutto_
,CAST((vk_brutto_ / (CASE WHEN mwst.mwst_id IS NULL THEN 1 ELSE 1+(mwst.mwst/100) END)) AS DECIMAL(18,4)) AS vk_netto_

FROM DBP_ETL.lagerbestand_erp_tmpk a

INNER JOIN DBP_DATA.art art
ON   a.art_id      = art.art_id
AND  a.mandant_id  = art.mandant_id

INNER JOIN DBP_DATA.mwst_per mwst
ON  mwst.mandant_id        = a.mandant_id
AND mwst.mwst_id           = art.mwst_id
AND a.dat_von BETWEEN mwst.dat_von AND mwst.dat_bis


LEFT OUTER JOIN DBP_DATA.art_pm_vw_zu_per ap
ON  ap.mandant_id = a.mandant_id
AND a.art_id      = ap.art_id
AND a.dat_von BETWEEN ap.dat_von AND ap.dat_bis

AND preistyp_id = 0
AND pm_id       = 1
AND vw_id IN (10,90)

QUALIFY row_number() over (PARTITION BY a.mandant_id, a.dat_von, a.dat_bis, a.art_id order by ABS( ap.vk_brutto) DESC) = 1 


) x WHERE  mandant_id = mandant_id_
AND    dat_von    = dat_von_
AND    dat_bis    = dat_bis_
AND    art_id     = art_id_
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.lagerbestand_erp_per
WHERE
(
mandant_id
,wup_id
,lagerort_id
,art_id
,dat_von
) IN
(
SELECT
mandant_id
,wup_id
,lagerort_id
,art_id
,dat_von
FROM DBP_ETL.lagerbestand_erp_tmpk
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.lagerbestand_erp_tmp3
(
wup_id
,mandant_id
,nb_id
,lagerort_id
,art_id
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_qual_bme
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_ret_gesp_bme
,sperr_id
,gjmo_buch
,lagerort_loesch_fg
,pflege_status
,dat_von
,menge_lgbest_erp_kolli
,menge_lgbest_erp_palette
,dat_bis
,betrag_lgbest_erp
,wrg_id
,vk_netto_lgbest_erp
)
SELECT
l.wup_id
,l.mandant_id
,l.nb_id
,l.lagerort_id
,l.art_id
,l.menge_lgbest_erp_frei_bme
,l.menge_lgbest_erp_umlag_bme
,l.menge_lgbest_erp_qual_bme
,l.menge_lgbest_erp_nf_charge_bme
,l.menge_lgbest_erp_gesp_bme
,l.menge_lgbest_erp_ret_gesp_bme
,l.sperr_id
,l.gjmo_buch
,l.lagerort_loesch_fg
,l.pflege_status
,l.dat_von
,l.menge_lgbest_erp_kolli
,l.menge_lgbest_erp_palette
-- das korrekte dat_bis ist dat_von des Nachfolgers - 1
,t.dat_von -1
,l.betrag_lgbest_erp
,l.wrg_id
,l.vk_netto_lgbest_erp
FROM DBP_DATA.lagerbestand_erp_per l

INNER JOIN DBP_ETL.lagerbestand_erp_tmpk t
ON l.wup_id = t.wup_id
AND l.mandant_id = t.mandant_id
AND l.nb_id = t.nb_id
AND l.lagerort_id = t.lagerort_id
AND l.art_id = t.art_id
-- das dat_von des neuen Satzes muss zwischen dem dat_von und dat_bis des alten liegen
AND t.dat_von BETWEEN l.dat_von AND l.dat_bis
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.lagerbestand_erp_per
WHERE
(
mandant_id
,wup_id
,lagerort_id
,art_id
,dat_von
) IN
(
SELECT
mandant_id
,wup_id
,lagerort_id
,art_id
,dat_von
FROM DBP_ETL.lagerbestand_erp_tmp3
)
;


--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.lagerbestand_erp_per
(
wup_id
,mandant_id
,nb_id
,lagerort_id
,art_id
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_qual_bme
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_ret_gesp_bme
,sperr_id
,gjmo_buch
,lagerort_loesch_fg
,pflege_status
,dat_von
,menge_lgbest_erp_kolli
,menge_lgbest_erp_palette
,dat_bis
,betrag_lgbest_erp
,wrg_id
,vk_netto_lgbest_erp
,td_insert
)
SELECT
wup_id
,mandant_id
,nb_id
,lagerort_id
,art_id
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_qual_bme
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_ret_gesp_bme
,sperr_id
,gjmo_buch
,lagerort_loesch_fg
,pflege_status
,dat_von
,menge_lgbest_erp_kolli
,menge_lgbest_erp_palette
,dat_bis
,betrag_lgbest_erp
,wrg_id
,vk_netto_lgbest_erp
,CURRENT_TIMESTAMP
FROM DBP_ETL.lagerbestand_erp_tmp3
;



--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.lagerbestand_erp_per
(
wup_id
,mandant_id
,wrg_id
,nb_id
,lagerort_id
,art_id
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_qual_bme
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_ret_gesp_bme
,sperr_id
,gjmo_buch
,lagerort_loesch_fg
,pflege_status
,dat_von
,dat_bis
,menge_lgbest_erp_kolli
,menge_lgbest_erp_palette
,betrag_lgbest_erp
,vk_netto_lgbest_erp
,td_insert
)
SELECT
t.wup_id
,t.mandant_id
,t.wrg_id
,t.nb_id
,t.lagerort_id
,t.art_id
,t.menge_lgbest_erp_frei_bme
,t.menge_lgbest_erp_umlag_bme
,t.menge_lgbest_erp_qual_bme
,t.menge_lgbest_erp_nf_charge_bme
,t.menge_lgbest_erp_gesp_bme
,t.menge_lgbest_erp_ret_gesp_bme
,t.sperr_id
,t.gjmo_buch
,t.lagerort_loesch_fg
,t.pflege_status
,t.dat_von
,t.dat_bis
,CAST
(
(
(
t.menge_lgbest_erp_frei_bme +
t.menge_lgbest_erp_umlag_bme +
t.menge_lgbest_erp_qual_bme +
t.menge_lgbest_erp_gesp_bme +
t.menge_lgbest_erp_ret_gesp_bme
) *
(
CASE WHEN aukolli.umrech_faktor IS NULL
THEN 1
ELSE aukolli.umrech_faktor
END
)
) AS DECIMAL(18,3)
) AS menge_lgbest_erp_kolli
,CASE WHEN aupalette.umrech_faktor IS NULL
THEN NULL
ELSE CAST
(
(
(
t.menge_lgbest_erp_frei_bme +
t.menge_lgbest_erp_umlag_bme +
t.menge_lgbest_erp_qual_bme +
t.menge_lgbest_erp_gesp_bme +
t.menge_lgbest_erp_ret_gesp_bme
) *
aupalette.umrech_faktor
) AS DECIMAL(18,3)
)
END AS menge_lgbest_erp_palette
,
(
CAST
(
(
(
t.menge_lgbest_erp_frei_bme +
t.menge_lgbest_erp_gesp_bme +
t.menge_lgbest_erp_qual_bme +
t.menge_lgbest_erp_ret_gesp_bme +
t.menge_lgbest_erp_umlag_bme
)
*
CAST(t.ek_netto_bnk AS FLOAT)
) AS DECIMAL(18,2)
)

) AS betrag_lgbest_erp

, COALESCE (CAST((t.menge_lgbest_erp_frei_bme      +
t.menge_lgbest_erp_umlag_bme     +
t.menge_lgbest_erp_qual_bme      +
t.menge_lgbest_erp_gesp_bme      +
t.menge_lgbest_erp_ret_gesp_bme
)
*
CAST( vk_netto AS FLOAT )
AS DECIMAL(18,4)
),0) AS vk_netto_lgbest_erp
,CURRENT_TIMESTAMP
FROM DBP_ETL.lagerbestand_erp_tmpk t

-- Palettenfaktor und Default Mengeneinheit holen
LEFT OUTER JOIN
(
SELECT
mandant_id
,art_id
,paletten_faktor_einh_id
,ausg_menge_einh_id
,dat_von
,dat_bis
FROM DBP_DATA.art_vorschlagswert_per
) av
ON t.art_id        = av.art_id
AND t.mandant_id = av.mandant_id
AND t.dat_von BETWEEN av.dat_von AND av.dat_bis

-- Umrechnungsfaktor für Palettenfaktor holen
LEFT OUTER JOIN
(
SELECT
mandant_id
,art_id
,umrech_faktor
,altnv_menge_einh_id
,dat_von, dat_bis
FROM DBP_DATA.art_umrechnung_faktor_per
) aupalette
ON t.art_id                      = aupalette.art_id
AND t.mandant_id               = aupalette.mandant_id
AND av.paletten_faktor_einh_id = aupalette.altnv_menge_einh_id
AND t.dat_von BETWEEN aupalette.dat_von AND aupalette.dat_bis

-- Umrechnungsfaktor für Default Mengeneinheit holen
LEFT OUTER JOIN
(
SELECT
mandant_id
,art_id
,altnv_menge_einh_id
,dat_von
,dat_bis
,umrech_faktor
FROM DBP_DATA.art_umrechnung_faktor_per
) aukolli
ON t.art_id                 = aukolli.art_id
AND t.mandant_id          = aukolli.mandant_id
AND av.ausg_menge_einh_id = aukolli.altnv_menge_einh_id
AND t.dat_von BETWEEN aukolli.dat_von AND aukolli.dat_bis

--Default Palettenfaktor und Mengeneinheit holen
LEFT OUTER JOIN
(
SELECT
mandant_id
,art_id
,paletten_faktor_einh_id
,ausg_menge_einh_id
,dat_von
,dat_bis
FROM DBP_DATA.art_vorschlagswert_per
) av_q
ON t.art_id        = av_q.art_id
AND t.mandant_id = av_q.mandant_id
AND t.dat_von BETWEEN av_q.dat_von AND av_q.dat_bis

--Umrechnungsfaktor für Palettenfaktor holen
LEFT OUTER JOIN
(
SELECT
mandant_id
,art_id
,umrech_faktor
,altnv_menge_einh_id
,dat_von
,dat_bis
FROM DBP_DATA.art_umrechnung_faktor_per
) aupalette_q
ON t.art_id                           = aupalette_q.art_id
AND t.mandant_id                    = aupalette_q.mandant_id
AND aupalette_q.altnv_menge_einh_id = 'PAL'
AND aupalette_q.dat_bis             = to_date('9999-12-31','YYYY-MM-DD')

-- Umrechnungsfaktor für Default Mengeneinheit holen
LEFT OUTER JOIN
(
SELECT
mandant_id
,art_id
,altnv_menge_einh_id
,dat_von
,dat_bis
,umrech_faktor
FROM DBP_DATA.art_umrechnung_faktor_per
) aukolli_q
ON t.art_id                   = aukolli_q.art_id
AND t.mandant_id            = aukolli_q.mandant_id
AND av_q.ausg_menge_einh_id = aukolli_q.altnv_menge_einh_id
AND aukolli_q.dat_bis       = to_date('9999-12-31','YYYY-MM-DD')

;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.bestand_mardh_mard_vz_log_kmo
(
art_id
,mandant_id
,wup_id
,nb_id
,lagerort_id
,dat
)
SELECT
art_id
,mandant_id
,wup_id
,nb_id
,lagerort_id
,dat_von
FROM DBP_ETL.lagerbestand_erp_tmpk
WHERE (art_id, mandant_id, wup_id, nb_id, lagerort_id, dat_von) NOT IN
(SELECT art_id, mandant_id, wup_id, nb_id, lagerort_id, dat
FROM DBP_ETL.bestand_mardh_mard_vz_log_kmo
)
GROUP BY 1,2,3,4,5,6
;

