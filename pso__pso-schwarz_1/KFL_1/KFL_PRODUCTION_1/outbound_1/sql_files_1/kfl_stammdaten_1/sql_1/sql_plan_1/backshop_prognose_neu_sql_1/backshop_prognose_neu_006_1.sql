CREATE OR REPLACE TEMPORARY TABLE _update AS
SELECT
    b.mandant_id,
    b.wup_id,
    b.nb_id,
    b.art_id,
    b.dat,
    MAX(A.aktion_id) AS aktion_id_
FROM dbp_data.aktion_art_wup_zu_1 AS A
INNER JOIN (
    SELECT
        A0.art_id,
        A0.mandant_id,
        A0.wup_id,
        A0.nb_id,
        A0.dat,
        A0.menge_prognose,
        A0.menge_prognose_max,
        A0.menge_prognose_aktion,
        A0.listung_id_backshop,
        A0.menge_check,
        A0.anteil_01,
        A0.anteil_02,
        A0.anteil_03,
        A0.anteil_04,
        A0.menge,
        A0.wup_cluster_id,
        A0.wug_cluster_id,
        A0.back_drehklasse_id,
        A0.aktion_id,
        A0.menge_abschrift,
        A0.menge_tag,
        A0.menge_gff,
        A0.menge_gs,
        A0.menge_spaet,
        A0.menge_abend,
        A0.td_insert,
        A0.td_update,
        B.kjwo
    FROM dbp_msi_data.backshop_prognose_neu_1 AS A0
    INNER JOIN dbp_data.tag_1 AS B ON A0.dat = B.dat
    WHERE
        B.kjwo IN (
            SELECT MAX(B0.kjwo) AS a2079602280
            FROM dbp_msi_data.backshop_prognose_neu_1 AS A1
            INNER JOIN dbp_data.tag_1 AS B0 ON A1.dat = B0.dat
        )
) AS b
    ON
        A.art_id = b.art_id AND A.mandant_id = b
        .mandant_id AND A.wup_id = b.wup_id AND A.nb_id = b.nb_id
INNER JOIN dbp_data.aktion_1 AS C
    ON
        A.mandant_id = C.mandant_id AND A.aktion_id = C.aktion_id AND b.dat
        BETWEEN C.dat_von AND C.dat_bis
WHERE
    A.grund_sperrung IS NULL
    AND CASE
        WHEN C.mandant_id = 1
            THEN C.preisaktiviert_fg
        WHEN
            C.mandant_id > 1
            AND A.dat_preisaktiviert <> DATE '1900-01-01'
            AND (C.mandant_id, C.aktion_id) NOT IN (SELECT (
                mandant_id,
                aktion_id
            )
            FROM dbp_data.l_bonuskauf_1)
            THEN 1
        ELSE 0
    END = 1
GROUP BY
    b.art_id,
    b.mandant_id,
    b.wup_id,
    b.nb_id,
    b.dat;


UPDATE dbp_msi_data.backshop_prognose_neu_1 SET
    aktion_id = b.aktion_id_
FROM `_update` AS b
WHERE
    backshop_prognose_neu.mandant_id = b.mandant_id
    AND backshop_prognose_neu.wup_id = b.wup_id
    AND backshop_prognose_neu.nb_id = b.nb_id AND backshop_prognose_neu.art_id = b.art_id AND backshop_prognose_neu.dat = b
    .dat AND backshop_prognose_neu.aktion_id <> b.aktion_id_;
