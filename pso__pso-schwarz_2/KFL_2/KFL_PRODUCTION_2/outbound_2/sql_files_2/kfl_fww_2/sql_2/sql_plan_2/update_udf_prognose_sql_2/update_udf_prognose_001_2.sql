--SPEC0312966


-- dat_prognoselauf,
-- diagnose_id,
CREATE OR REPLACE TABLE dbp_etl.pmr_tmp_2 AS
-- diagnose_id,
-- dat_prognoselauf,
-- a.dat_angebot_gueltig_von AS dat_von,

-- a.dat_angebot_gueltig_bis AS dat_bis,
SELECT
    AAWZ.mandant_id,
    AAWZ.wup_id,
    AAWZ.nb_id,
    AAWZ.art_id,
    T.dat,
    CASE
        WHEN
            MAX(CASE
                WHEN A.bonuskauf_fg = 0
                    THEN 1
                ELSE 0
            END) = 1
            THEN 'SA'
        WHEN
            MAX(CASE
                WHEN A.aktion_typ_id = 'KDP'
                    THEN 1
                ELSE 0
            END) = 1
            THEN 'AF'
        WHEN MAX(A.bonuskauf_fg) = 1
            THEN 'BBY'
        ELSE 'AF'
    END AS prognose_trennung_cd,
    CASE
        WHEN
            MAX(CASE
                WHEN A.bonuskauf_fg = 0
                    THEN 1
                ELSE 0
            END) = 1 AND MAX(A.bonuskauf_fg) = 0 AND MAX(CASE
                WHEN A.aktion_typ_id = 'KDN'
                    THEN 1
                ELSE 0
            END) = 0 AND MAX(CASE
                WHEN A.aktion_typ_id = 'KDP'
                    THEN 1
                ELSE 0
            END) = 0
            THEN 1
        WHEN
            MAX(CASE
                WHEN A.bonuskauf_fg = 0
                    THEN 1
                ELSE 0
            END) = 1 AND MAX(CASE
                WHEN A.aktion_typ_id = 'KDN'
                    THEN 1
                ELSE 0
            END) + MAX(CASE
                WHEN A.aktion_typ_id = 'KDP'
                    THEN 1
                ELSE 0
            END) > 0
            THEN 2
        WHEN
            MAX(CASE
                WHEN A.bonuskauf_fg = 0
                    THEN 1
                ELSE 0
            END) = 1 AND MAX(A.bonuskauf_fg) = 1
            THEN 6
        WHEN
            MAX(CASE
                WHEN A.aktion_typ_id = 'KDN'
                    THEN 1
                ELSE 0
            END) = 1
            THEN 3
        WHEN
            MAX(CASE
                WHEN A.aktion_typ_id = 'KDP'
                    THEN 1
                ELSE 0
            END) = 1
            THEN 4
        WHEN MAX(A.bonuskauf_fg) = 1
            THEN 5
        ELSE -1
    END AS prognose_feingliederung_id
FROM dbp_data.angebot_art_wup_zu_2 AS AAWZ
INNER JOIN
    dbp_data.angebot_2 AS A
    ON AAWZ.angebot_nr = A.angebot_nr AND AAWZ.mandant_id = A.mandant_id
INNER JOIN
    dbp_data.tag_2 AS T
    ON T.dat BETWEEN A.dat_angebot_gueltig_von AND A.dat_angebot_gueltig_bis
-- JOIN KFL_PRODUCTION.dbp_data.aktion_2 Ak ON a.aktion_id = ak.aktion_id AND a.mandant_id = ak.mandant_id

-- LEFT JOIN KFL_PRODUCTION.dbp_data.l_bonuskauf_2 bby ON a.aktion_id = bby.aktion_id AND a.mandant_id = bby.mandant_id

-- where bby.bonuskauf_id= 1000510
-- WHERE BONUSKAUF_BEDINGUNG_ID is not null

GROUP BY
    AAWZ.mandant_id,
    AAWZ.wup_id,
    AAWZ.nb_id,
    AAWZ.art_id,
    T.dat;


UPDATE dbp_data.udf_prognose_2 AS U SET
    prognose_trennung_cd = `_TMP`.prognose_trennung_cd,
    prognose_feingliederung_id = `_TMP`.prognose_feingliederung_id
FROM dbp_etl.pmr_tmp_2 AS `_TMP`
WHERE
    -- AND _tmp.nb_id = u.nb_id
    `_TMP`.mandant_id = U.mandant_id AND `_TMP`.wup_id = U.wup_id
    AND `_TMP`.art_id = U.art_id
    -- AND _tmp.diagnose_id = u.diagnose_id
    -- AND _tmp.dat_prognoselauf = u.dat_prognoselauf
    AND `_TMP`.dat = U.dat
    AND U.dat > CURRENT_DATE("Europe/Berlin") AND U.dat_prognoselauf = CURRENT_DATE("Europe/Berlin") AND `_TMP`.dat >= CURRENT_DATE("Europe/Berlin");
