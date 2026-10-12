UPDATE DBP_ETL.lagerbestand_erp_1
SET     ek_netto_bnk    = x.ek_netto_bnk_,
        komponentenmenge= x.komponentenmenge_,
        td_update = CURRENT_TIMESTAMP
FROM
(
SELECT
a.mandant_id as mandant_id_,
a.wup_id as wup_id_,
a.art_id as art_id_,
a.lagerort_id as lagerort_id_,

(CASE   WHEN (a.nb_id IN (99,-111))
        THEN /* zentral */
        COALESCE(agw5.ek_netto_bnk,
        agw6.ek_netto_bnk,
        agw7.ek_netto_bnk,
        agw8.ek_netto_bnk,
        agw11.ek_netto_bnk,
        agw12.ek_netto_bnk,
        (0 )
        )
        ELSE /* dezentral (Lager kann nicht richtig sein) */
        COALESCE(agw11.ek_netto_bnk,
        agw12.ek_netto_bnk,
        agw6.ek_netto_bnk,
        agw8.ek_netto_bnk,
        (0 )
        ) 
END) AS ek_netto_bnk_,
(CASE   WHEN (a.nb_id IN (99,-111))
        THEN /* zentral */
        COALESCE(agw5.komponentenmenge,
        agw6.komponentenmenge,
        agw7.komponentenmenge,
        agw8.komponentenmenge,
        agw11.komponentenmenge,
        agw12.komponentenmenge,
        0)
        ELSE /* dezentral (Lager kann nicht richtig sein) */
        COALESCE(agw11.komponentenmenge,
        agw12.komponentenmenge,
        agw6.komponentenmenge,
        agw8.komponentenmenge,
        0)
END) AS komponentenmenge_

FROM DBP_ETL.lagerbestand_erp_1 a


/*
---------------------------------------------------------------------
--- Berechnung EK_NETTO
---------------------------------------------------------------------
*/

/*
zentral
lager       richtig
datum       richtig
lieferant   falsch
*/

LEFT OUTER JOIN DBP_ETL.ek05_1 agw5
ON a.art_id = agw5.art_id
AND a.dat_von BETWEEN agw5.dat_von AND agw5.dat_bis  /* richtiges Datum */
AND a.wup_id = agw5.wup_id                             /* richtiges Lager */

/*
zentral
lager       falsch
datum       richtig
lieferant   falsch
*/

LEFT OUTER JOIN DBP_ETL.ek06_1 agw6
ON a.art_id = agw6.art_id
AND a.dat_von BETWEEN agw6.dat_von AND agw6.dat_bis   /* richtiges Datum */

/*
zentral
lager       richtig
datum       falsch
lieferant   falsch
*/

LEFT OUTER JOIN DBP_ETL.ek07_1 agw7
ON a.art_id = agw7.art_id
AND a.wup_id = agw7.wup_id                     /* richtiges Lager */

/*
zentral
lager       falsch
datum       falsch
lieferant   falsch
*/

LEFT OUTER JOIN DBP_ETL.ek08_1 agw8
ON a.art_id = agw8.art_id

/*
dezentral
lager       -1
datum       richtig
lieferant   falsch
*/

LEFT OUTER JOIN DBP_ETL.ek11_1 agw11
ON a.art_id = agw11.art_id
AND a.dat_von BETWEEN agw11.dat_von AND agw11.dat_bis         /* richtiges Datum */


/*
dezentral
lager       -1
datum       falsch
lieferant   falsch
*/

LEFT OUTER JOIN DBP_ETL.ek12_1 agw12
ON a.art_id = agw12.art_id

--GROUP BY mandant_id_,art_id_,wup_id_,lagerort_id_

--QUALIFY CSUM(1,CAST((ek_netto_bnk_ )AS DECIMAL(18,4)) DESC,komponentenmenge_ DESC) = 1
QUALIFY row_number() over (PARTITION BY mandant_id_,art_id_,wup_id_,lagerort_id_ order by CAST((ek_netto_bnk_ )AS DECIMAL(18,4)) DESC,komponentenmenge_ DESC) = 1
) x 
 WHERE mandant_id = x.mandant_id_
and wup_id = x.wup_id_
and art_id = x.art_id_
and lagerort_id = x.lagerort_id_
;

UPDATE  DBP_ETL.lagerbestand_erp_1
SET     vk_netto = vk_netto_,
        td_update = CURRENT_TIMESTAMP

FROM
(
SELECT
a.mandant_id             AS mandant_id_
,a.dat_von                AS dat_von_
,a.dat_bis                AS dat_bis_
,a.art_id                 AS art_id_
,COALESCE(ap.vk_brutto,0) AS vk_brutto_
,CAST(vk_brutto_ / (CASE WHEN mwst.mwst_id IS NULL THEN 1 ELSE 1+(mwst.mwst/100) END) AS DECIMAL(9,3)) AS vk_netto_

FROM DBP_ETL.lagerbestand_erp_1 a


INNER JOIN DBP_DATA.art_1 art_1
ON   a.art_id      = art.art_id
AND  a.mandant_id  = art.mandant_id

INNER JOIN DBP_DATA.mwst_per_1 mwst
ON  mwst.mandant_id        = 1
AND mwst.mwst_id           = art.mwst_id
AND a.dat_von BETWEEN mwst.dat_von AND mwst.dat_bis

LEFT OUTER JOIN DBP_DATA.art_pm_vw_zu_per_1 ap
ON  ap.mandant_id = 1
AND a.art_id      = ap.art_id
AND a.dat_von BETWEEN ap.dat_von AND ap.dat_bis

AND preistyp_id = 0
AND pm_id       = 1
AND vw_id       = 6

QUALIFY row_number() over (PARTITION BY a.mandant_id, a.dat_von, a.dat_bis, a.art_id order by ABS(ap.vk_brutto) DESC) = 1

) x WHERE  mandant_id = mandant_id_
AND    dat_von    = dat_von_
AND    dat_bis    = dat_bis_
AND    art_id     = art_id_
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_ETL.lagerbestand_erp_1
WHERE
(
mandant_id
,wup_id
,nb_id
,lagerort_id
,art_id
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_qual_bme
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_ret_gesp_bme
) IN
(
SELECT
mandant_id
,wup_id
,nb_id
,lagerort_id
,art_id
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_qual_bme
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_ret_gesp_bme
FROM DBP_DATA.lagerbestand_erp_per_1

WHERE mandant_id = 1
AND dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.lagerbestand_erp_per_1
(
wup_id
, mandant_id
, nb_id
, lagerort_id
, art_id
, menge_lgbest_erp_frei_bme
, menge_lgbest_erp_umlag_bme
, menge_lgbest_erp_qual_bme
, menge_lgbest_erp_nf_charge_bme
, menge_lgbest_erp_gesp_bme
, menge_lgbest_erp_ret_gesp_bme
, sperr_id
, gjmo_buch
, lagerort_loesch_fg
, pflege_status
, dat_von
, dat_bis
, menge_lgbest_erp_kolli
, menge_lgbest_erp_palette
, betrag_lgbest_erp
, wrg_id
, vk_netto_lgbest_erp
, td_insert

)
SELECT
t.wup_id
, t.mandant_id
, t.nb_id
, t.lagerort_id
, t.art_id
, t.menge_lgbest_erp_frei_bme
, t.menge_lgbest_erp_umlag_bme
, t.menge_lgbest_erp_qual_bme
, t.menge_lgbest_erp_nf_charge_bme
, t.menge_lgbest_erp_gesp_bme
, t.menge_lgbest_erp_ret_gesp_bme
, t.sperr_id
, t.gjmo_buch
, t.lagerort_loesch_fg
, t.pflege_status
, t.dat_von
, t.dat_bis
, CAST(((t.menge_lgbest_erp_frei_bme + t.menge_lgbest_erp_umlag_bme + t.menge_lgbest_erp_qual_bme + t.menge_lgbest_erp_gesp_bme + t.menge_lgbest_erp_ret_gesp_bme)
* (CASE WHEN aukolli.umrech_faktor IS NULL
THEN 1
ELSE aukolli.umrech_faktor
END)) AS DECIMAL(18,3))
, (CASE WHEN aupalette.umrech_faktor IS NULL
THEN NULL
ELSE CAST(((t.menge_lgbest_erp_frei_bme + t.menge_lgbest_erp_umlag_bme + t.menge_lgbest_erp_qual_bme + t.menge_lgbest_erp_gesp_bme + t.menge_lgbest_erp_ret_gesp_bme)
* aupalette.umrech_faktor
) AS DECIMAL(18,3))
END)

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
t.menge_lgbest_erp_umlag_bme)
* CAST(CAST((t.ek_netto_bnk )AS DECIMAL(18,4))
* t.komponentenmenge AS FLOAT)) AS DECIMAL(18,2))) AS betrag_lgbest_erp
,t.wrg_id
,COALESCE (CAST((menge_lgbest_erp_frei_bme + menge_lgbest_erp_umlag_bme + menge_lgbest_erp_qual_bme + menge_lgbest_erp_nf_charge_bme
+ menge_lgbest_erp_gesp_bme + menge_lgbest_erp_ret_gesp_bme)
* CAST( vk_netto AS FLOAT ) AS DECIMAL(18,4)),0) AS vk_netto_lgbest_erp
, CURRENT_TIMESTAMP
FROM DBP_ETL.lagerbestand_erp_1 t


-- Palettenfaktor und Default Mengeneinheit holen
LEFT OUTER JOIN
(
SELECT
art_id
,paletten_faktor_einh_id
,ausg_menge_einh_id
,dat_von
,dat_bis
FROM DBP_DATA.art_vorschlagswert_per_1
WHERE mandant_id = 1
) av
ON t.art_id = av.art_id
AND t.dat_von BETWEEN av.dat_von AND av.dat_bis

-- Umrechnungsfaktor für Palettenfaktor holen
LEFT OUTER JOIN
(
SELECT
art_id
,umrech_faktor
,altnv_menge_einh_id
,dat_von, dat_bis
FROM DBP_DATA.art_umrechnung_faktor_per_1
WHERE mandant_id = 1
) aupalette
ON t.art_id = aupalette.art_id
AND av.paletten_faktor_einh_id = aupalette.altnv_menge_einh_id
AND t.dat_von BETWEEN aupalette.dat_von AND aupalette.dat_bis

-- Umrechnungsfaktor für Default Mengeneinheit holen
LEFT OUTER JOIN
(
SELECT
art_id
,altnv_menge_einh_id
,dat_von
,dat_bis
,umrech_faktor
FROM DBP_DATA.art_umrechnung_faktor_per_1
WHERE mandant_id = 1
) aukolli
ON t.art_id = aukolli.art_id
AND av.ausg_menge_einh_id = aukolli.altnv_menge_einh_id
AND t.dat_von BETWEEN aukolli.dat_von AND aukolli.dat_bis
;

INSERT INTO DBP_ETL.lagerbestand_erp_tmp2_1
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
,dat_bis
,menge_lgbest_erp_kolli
,menge_lgbest_erp_palette
,betrag_lgbest_erp
,wrg_id
,vk_netto_lgbest_erp
)
SELECT
a.wup_id
,a.mandant_id
,a.nb_id
,a.lagerort_id
,a.art_id
,a.menge_lgbest_erp_frei_bme
,a.menge_lgbest_erp_umlag_bme
,a.menge_lgbest_erp_qual_bme
,a.menge_lgbest_erp_nf_charge_bme
,a.menge_lgbest_erp_gesp_bme
,a.menge_lgbest_erp_ret_gesp_bme
,a.sperr_id
,a.gjmo_buch
,a.lagerort_loesch_fg
,a.pflege_status
,a.dat_von
,dt1.dat_bis
,a.menge_lgbest_erp_kolli
,a.menge_lgbest_erp_palette
,a.betrag_lgbest_erp
,a.wrg_id
,a.vk_netto_lgbest_erp
FROM DBP_DATA.lagerbestand_erp_per_1 a,
(
SELECT
mandant_id
,wup_id
,nb_id
,lagerort_id
,art_id
,dat_von
,CASE
   WHEN (SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id,wup_id,nb_id,lagerort_id,art_id ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(DAT_VON,'YYYYMMDD'))) = 0 THEN TO_DATE('9999-12-31','YYYY-MM_1-DD')
   ELSE dateadd(day,-1,to_date(to_char((SUM(to_number(to_char(DAT_VON,'YYYYMMDD'))) OVER (PARTITION BY mandant_id,wup_id,nb_id,lagerort_id,art_id ORDER BY DAT_VON DESC NULLS LAST ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) - to_number(to_char(DAT_VON,'YYYYMMDD')))),'YYYYMMDD'))
   END AS DAT_BIS
FROM DBP_DATA.lagerbestand_erp_per_1

WHERE dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
) dt1

WHERE a.mandant_id   = dt1.mandant_id
AND a.wup_id       = dt1.wup_id
AND a.nb_id        = dt1.nb_id
AND a.lagerort_id  = dt1.lagerort_id
AND a.art_id       = dt1.art_id
AND a.dat_von      = dt1.dat_von
AND a.dat_bis     <> dt1.dat_bis
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.lagerbestand_erp_per_1
WHERE
(
mandant_id
,wup_id
,nb_id
,lagerort_id
,art_id
,dat_von
) IN
(
SELECT
mandant_id
,wup_id
,nb_id
,lagerort_id
,art_id
,dat_von
FROM DBP_ETL.lagerbestand_erp_tmp2_1
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.lagerbestand_erp_per_1
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
,dat_bis
,menge_lgbest_erp_kolli
,menge_lgbest_erp_palette
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
,dat_bis
,menge_lgbest_erp_kolli
,menge_lgbest_erp_palette
,betrag_lgbest_erp
,wrg_id
,vk_netto_lgbest_erp
,CURRENT_TIMESTAMP
FROM DBP_ETL.lagerbestand_erp_tmp2_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.lagerbestand_erp_tmp2_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.bestand_mardh_mard_vz_log_1
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
FROM DBP_ETL.lagerbestand_erp_1
WHERE (art_id, mandant_id, wup_id, nb_id, lagerort_id, dat_von) NOT IN
(       SELECT art_id, mandant_id, wup_id, nb_id, lagerort_id, dat
        FROM DBP_ETL.bestand_mardh_mard_vz_log_1
)
GROUP BY 1,2,3,4,5,6
;

CREATE TABLE if not exists DBP_ETL.art_bestand_vw_sum_dat_1
(dat DATE  NOT NULL);

INSERT INTO DBP_ETL.art_bestand_vw_sum_dat_1 (dat)
SELECT dat_von
FROM DBP_ETL.lagerbestand_erp_1
GROUP BY 1
;

