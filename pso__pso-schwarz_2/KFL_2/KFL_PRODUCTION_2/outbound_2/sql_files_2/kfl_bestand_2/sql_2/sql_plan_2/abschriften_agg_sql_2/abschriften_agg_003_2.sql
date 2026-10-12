INSERT INTO dbp_etl.useg_agg_dat_2 (wup_id, nb_id, dat, mandant_id)
(
    SELECT
        T1.wup_id,
        T1.nb_id,
        T1.dat_umbew,
        T1.mandant_id
    FROM dbp_etl.art_umbewertung_temp_2 AS T1_2
    INNER JOIN dbp_data.abschriftart_abschriftgrp_zu_2 AS T2
        ON
            T1.mandant_id = T2.mandant_id AND T1.preis_aend_grund_id
            = T2.abschriftart_id AND T2.abschriftgruppe_id = 400
    GROUP BY
        T1.mandant_id,
        T1.wup_id,
        T1.nb_id,
        T1.dat_umbew
);
