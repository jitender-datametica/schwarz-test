UPDATE dbp_etl.art_gp_nm_zu_per_dat_relevant SET
    dat_relevant
    = DATE_ADD(art_gp_nm_zu_per_dat_relevant.dat_relevant, INTERVAL 1 DAY)
WHERE TRUE;


/*** Luecken in der art_gp_verhandlung_zu Tabelle per default Werte schliessen */


INSERT INTO dbp_data.art_gp_verhandlung_zu (
    mandant_id, art_id, gp_id, ivn_gruppe_id,
    ivn_verhandlungs_cluster_id,
    ivn_sortimentsgruppe_id,
    quellsystem_id,
    td_insert
)
(
    SELECT
        A.mandant_id,
        A.art_id,
        A.gp_id,
        -1,
        -1,
        -1,
        1,
        CURRENT_TIMESTAMP()
    FROM dbp_data.art_gp_nm_zu_per AS A
    LEFT JOIN dbp_data.art_gp_verhandlung_zu AS G
        ON
            A.mandant_id = G.mandant_id AND A.art_id = G.art_id
            AND A.gp_id = G.gp_id
    WHERE G.mandant_id IS NULL
    GROUP BY
        A.mandant_id,
        A.art_id,
        A.gp_id
);
