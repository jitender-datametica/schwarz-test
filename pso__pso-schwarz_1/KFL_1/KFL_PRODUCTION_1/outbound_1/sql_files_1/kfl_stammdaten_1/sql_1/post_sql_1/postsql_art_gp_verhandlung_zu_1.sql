/****************  QUELLSYSTEM_ID = 1: art_gp_nm_zu_per_1     ***************************/


INSERT INTO dbp_data.art_gp_verhandlung_zu_1 (
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
        L.quellsystem_id,
        CURRENT_TIMESTAMP()
    FROM dbp_data.art_gp_nm_zu_per_1 AS A
    INNER JOIN dbp_data.l_quellsystem_1 AS L ON A.mandant_id = L.mandant_id
    LEFT JOIN dbp_data.art_gp_verhandlung_zu_1 AS G
        ON
            A.mandant_id = G.mandant_id AND A.art_id = G.art_id
            AND A.gp_id = G.gp_id
    WHERE
        L.quellsystem_bez = 'DBP_DATA.ART_GP_NM_ZU_PER_1'
        AND G.mandant_id IS NULL
        AND A.gp_id IS NOT NULL
    GROUP BY
        A.mandant_id,
        A.art_id,
        A.gp_id,
        L.quellsystem_id
);


/****************  QUELLSYSTEM_BEZ: ART_GP_ZU_PER_1    ***************************/
/*INSERT  INTO KFL_PRODUCTION.DBP_DATA.art_gp_verhandlung_zu_1
(mandant_id,gp_id, art_id,IVN_GRUPPE_ID,IVN_VERHANDLUNGS_CLUSTER_ID,IVN_SORTIMENTSGRUPPE_ID,QUELLSYSTEM_ID, td_insert)

SELECT a.mandant_id, a.gp_id, a.art_id, -1,-1,-1,a.QUELLSYSTEM_ID, CURRENT_TIMESTAMP
  FROM (
        SELECT a.mandant_id, a.gp_id, a.art_id, l.QUELLSYSTEM_ID
          FROM KFL_PRODUCTION.DBP_DATA.ART_GP_ZU_PER_1 a
          JOIN KFL_PRODUCTION.DBP_DATA.l_QUELLSYSTEM_1 l
            ON a.mandant_id = l.mandant_id
          LEFT JOIN KFL_PRODUCTION.DBP_DATA.art_gp_verhandlung_zu_1 g
            ON a.mandant_id = g.mandant_id
           AND a.art_id= g.art_id
           AND a.gp_id= g.gp_id
         WHERE l.QUELLSYSTEM_BEZ='DBP_DATA.ART_GP_ZU_PER_1'
           AND g.mandant_id is null
           AND a.gp_id is not null
         GROUP BY 1,2,3,4
       ) a

*/
/****************  QUELLSYSTEM_BEZ: BESCH_RECH_DET_KONT_1  DE  ***************************/


INSERT INTO dbp_data.art_gp_verhandlung_zu_1 (
    mandant_id, art_id, gp_id, ivn_gruppe_id,
    ivn_verhandlungs_cluster_id,
    ivn_sortimentsgruppe_id,
    quellsystem_id,
    td_insert
)
(
    SELECT
        BRDK.mandant_id,
        AWZP.art_id,
        BR.gp_id,
        -1,
        -1,
        -1,
        L.quellsystem_id,
        CURRENT_TIMESTAMP()
    FROM dbp_data.besch_rech_det_kont_1 AS BRDK
    LEFT JOIN dbp_data.besch_rech_1 AS BR
        ON
            BRDK.mandant_id = BR.mandant_id
            AND BRDK.gj = BR.gj
            AND BRDK.rech_beleg_id
            = BR.rech_beleg_id
    LEFT JOIN dbp_data.art_wg_zu_per_1 AS AWZP
        ON
            BRDK.wg_id * -1000 = AWZP.art_id AND BRDK.mandant_id
            = AWZP.mandant_id AND BRDK.arthiertyp_id = AWZP.arthiertyp_id
    INNER JOIN dbp_data.l_quellsystem_1 AS L ON BRDK.mandant_id = L.mandant_id
    LEFT JOIN dbp_data.art_gp_verhandlung_zu_1 AS G
        ON
            BRDK.mandant_id = G.mandant_id AND AWZP.art_id = G.art_id
            AND BR.gp_id = G.gp_id
    WHERE
        L.quellsystem_bez = 'DBP_DATA.BESCH_RECH_DET_KONT_1'
        AND G.mandant_id IS NULL
        AND BRDK.mandant_id = 1
        AND AWZP.dat_bis = DATE '9999-12-31'
        AND RIGHT(
            BRDK.sachkonto_id, 6) IN (
            '314602',
            '314603',
            '314604',
            '314605',
            '314606',
            '314607',
            '314608',
            '314609',
            '314610',
            '314611',
            '314612',
            '314616',
            '314617',
            '314621',
            '314622',
            '314623',
            '314624'
        )
        AND BRDK.row_grund_id IN (
            '100',
            '101',
            '103',
            '104',
            '105',
            '106',
            '107',
            '108',
            '109',
            '110',
            '111',
            '112',
            '114',
            '116', '119', '120', '142', '160', '161', '199'
        )
        AND BR.gp_id IS NOT NULL
    GROUP BY
        BRDK.mandant_id,
        BR.gp_id,
        AWZP.art_id,
        L.quellsystem_id
);


/****************  QUELLSYSTEM_BEZ: BESCH_RECH_DET_KONT_1  KMO  ***************************/


INSERT INTO dbp_data.art_gp_verhandlung_zu_1 (
    mandant_id, art_id, gp_id, ivn_gruppe_id,
    ivn_verhandlungs_cluster_id,
    ivn_sortimentsgruppe_id,
    quellsystem_id,
    td_insert
)
(
    SELECT
        BRDK.mandant_id,
        -2 AS art_id,
        BR.gp_id,
        -1,
        -1,
        -1,
        L.quellsystem_id,
        CURRENT_TIMESTAMP()
    FROM dbp_data.besch_rech_det_kont_1 AS BRDK
    LEFT JOIN dbp_data.besch_rech_1 AS BR
        ON
            BRDK.mandant_id = BR.mandant_id
            AND BRDK.gj = BR.gj
            AND BRDK.rech_beleg_id
            = BR.rech_beleg_id
    LEFT JOIN dbp_data.art_per_1 AS AP
        ON BRDK.mandant_id = AP.mandant_id AND BR.dat_buch BETWEEN DATE_SUB(
            AP
            .dat_von, INTERVAL 1 DAY
        ) AND (DATE_SUB(AP.dat_bis, INTERVAL 1 DAY)
        )
        AND -2 = AP.art_id
    INNER JOIN dbp_data.mandant_1 AS M ON BRDK.mandant_id = M.mandant_id
    INNER JOIN dbp_data.l_quellsystem_1 AS L ON BRDK.mandant_id = L.mandant_id
    LEFT JOIN dbp_data.art_gp_verhandlung_zu_1 AS G
        ON
            BRDK.mandant_id = G.mandant_id AND G.art_id = -2
            AND BR.gp_id = G.gp_id
    WHERE
        L.quellsystem_bez = 'DBP_DATA.BESCH_RECH_DET_KONT_1'
        AND G.mandant_id IS NULL
        AND (
            BRDK.mandant_id IN (2, 3, 5, 6)
            AND BRDK.sachkonto_id IN ('R097761', 'R097762', 'R097763')
            OR BRDK.mandant_id IN
            (7, 8)
            AND BRDK.sachkonto_id IN (
                '0000097761', '0000097762', '0000097763'
            )
        )
        AND BR.gp_id IS NOT NULL
    GROUP BY
        BRDK.mandant_id,
        BR.gp_id,
        art_id,
        L.quellsystem_id
);


/****************  QUELLSYSTEM_BEZ: EK_INFOSATZ_1    ***************************/


INSERT INTO dbp_data.art_gp_verhandlung_zu_1 (
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
        L.quellsystem_id,
        CURRENT_TIMESTAMP()
    FROM dbp_data.ek_infosatz_1 AS A
    INNER JOIN dbp_data.l_quellsystem_1 AS L ON A.mandant_id = L.mandant_id
    LEFT JOIN dbp_data.art_gp_verhandlung_zu_1 AS G
        ON
            A.mandant_id = G.mandant_id AND A.art_id = G.art_id
            AND A.gp_id = G.gp_id
    WHERE
        L.quellsystem_bez = 'DBP_DATA.EK_INFOSATZ_1'
        AND G.mandant_id IS NULL
        AND A.gp_id IS NOT NULL
    GROUP BY
        A.mandant_id,
        A.art_id,
        A.gp_id,
        L.quellsystem_id
);


/****************  QUELLSYSTEM_BEZ: REKL_1    ***************************/


INSERT INTO dbp_data.art_gp_verhandlung_zu_1 (
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
        L.quellsystem_id,
        CURRENT_TIMESTAMP()
    FROM dbp_data.rekl_1 AS A
    INNER JOIN dbp_data.l_quellsystem_1 AS L ON A.mandant_id = L.mandant_id
    LEFT JOIN dbp_data.art_gp_verhandlung_zu_1 AS G
        ON
            A.mandant_id = G.mandant_id AND A.art_id = G.art_id
            AND A.gp_id = G.gp_id
    WHERE
        L.quellsystem_bez = 'DBP_DATA.REKL_1'
        AND G.mandant_id IS NULL
        AND A.gp_id IS NOT NULL
    GROUP BY
        A.mandant_id,
        A.art_id,
        A.gp_id,
        L.quellsystem_id
);


/****************  QUELLSYSTEM_BEZ: WEWA_1    ***************************/


INSERT INTO dbp_data.art_gp_verhandlung_zu_1 (
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
        L.quellsystem_id,
        CURRENT_TIMESTAMP()
    FROM dbp_data.wewa_1 AS A
    INNER JOIN dbp_data.l_quellsystem_1 AS L ON A.mandant_id = L.mandant_id
    LEFT JOIN dbp_data.art_gp_verhandlung_zu_1 AS G
        ON
            A.mandant_id = G.mandant_id AND A.art_id = G.art_id
            AND A.gp_id = G.gp_id
    WHERE
        L.quellsystem_bez = 'DBP_DATA.WEWA_1'
        AND G.mandant_id IS NULL
        AND A.gp_id IS NOT NULL
    GROUP BY
        A.mandant_id,
        A.art_id,
        A.gp_id,
        L.quellsystem_id
);


/****************  QUELLSYSTEM_BEZ: BSCH_RECH_DET_1    ***************************/


INSERT INTO dbp_data.art_gp_verhandlung_zu_1 (
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
        L.quellsystem_id,
        CURRENT_TIMESTAMP()
    FROM dbp_data.bsch_rech_det_1 AS A
    INNER JOIN dbp_data.l_quellsystem_1 AS L ON A.mandant_id = L.mandant_id
    LEFT JOIN dbp_data.art_gp_verhandlung_zu_1 AS G
        ON
            A.mandant_id = G.mandant_id AND A.art_id = G.art_id
            AND A.gp_id = G.gp_id
    WHERE
        L.quellsystem_bez = 'DBP_DATA.BSCH_RECH_DET_1'
        AND G.mandant_id IS NULL
        AND A.gp_id IS NOT NULL
    GROUP BY
        A.mandant_id,
        A.art_id,
        A.gp_id,
        L.quellsystem_id
);
