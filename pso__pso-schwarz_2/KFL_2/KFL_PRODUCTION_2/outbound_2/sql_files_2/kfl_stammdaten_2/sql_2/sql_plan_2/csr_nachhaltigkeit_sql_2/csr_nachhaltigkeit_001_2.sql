CREATE TEMPORARY TABLE IF NOT EXISTS _art_prod_group AS
SELECT
    A.mandant_id,
    A.art_id,
    B.csr_produktgruppe_id
FROM dbp_data.art_wg_zu_per_2 AS A
INNER JOIN dbp_etl_process.csr_wg_produktgruppe_zu_2 AS B
    ON
        A.wg_id = B.wg_id AND A.arthiertyp_id = 2 AND
        A.dat_bis = PARSE_DATE('%F', '9999-12-31')
WHERE
    B.wug_id IS NULL
    AND B.csr_produktgruppe_bez NOT LIKE '%/EM'
GROUP BY
    A.mandant_id,
    A.art_id,
    B.csr_produktgruppe_id;


INSERT INTO `_art_prod_group`
(
    SELECT
        A.mandant_id,
        A.art_id,
        B.csr_produktgruppe_id
    FROM dbp_data.art_wg_zu_per_2 AS A
    INNER JOIN dbp_etl_process.csr_wg_produktgruppe_zu_2 AS B
        ON
            A.wg_id = B.wg_id AND A.wug_id = B.wug_id
            AND A.arthiertyp_id = 2 AND A.dat_bis = PARSE_DATE('%F', '9999-12-31')
    WHERE
        B.wug_id IS NOT NULL
        AND B.csr_produktgruppe_bez NOT LIKE '%/EM'
    GROUP BY
        A.mandant_id,
        A.art_id,
        B.csr_produktgruppe_id
);


INSERT INTO `_art_prod_group`
(
    SELECT
        A.mandant_id,
        A.art_id,
        B.csr_produktgruppe_id
    FROM dbp_data.art_wg_zu_per_2 AS A
    INNER JOIN dbp_etl_process.csr_wg_produktgruppe_zu_2 AS B
        ON
            A.wg_id = B.wg_id AND A.arthiertyp_id = 2
            AND A.dat_bis = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_data.art_2 AS C
        ON
            A.mandant_id = C.mandant_id AND A.art_id = C.art_id AND C.eigenmarke_id
            <> ''
    WHERE
        B.wug_id IS NULL
        AND B.csr_produktgruppe_bez LIKE '%/EM'
    GROUP BY
        A.mandant_id,
        A.art_id,
        B.csr_produktgruppe_id
);


INSERT INTO `_art_prod_group`
(
    SELECT
        A.mandant_id,
        A.art_id,
        B.csr_produktgruppe_id
    FROM dbp_data.art_wg_zu_per_2 AS A
    INNER JOIN dbp_etl_process.csr_wg_produktgruppe_zu_2 AS B
        ON
            A.wg_id = B.wg_id AND A.wug_id = B.wug_id
            AND A.arthiertyp_id = 2 AND A.dat_bis = PARSE_DATE('%F', '9999-12-31')
    INNER JOIN dbp_data.art_2 AS C
        ON
            A.mandant_id = C.mandant_id AND A.art_id = C.art_id AND C.eigenmarke_id
            <> ''
    WHERE
        B.wug_id IS NOT NULL
        AND B.csr_produktgruppe_bez LIKE '%/EM'
    GROUP BY
        A.mandant_id,
        A.art_id,
        B.csr_produktgruppe_id
);


TRUNCATE TABLE dbp_data.csr_produktgruppe_art_zu_2;


INSERT INTO dbp_data.csr_produktgruppe_art_zu_2 (mandant_id, art_id, csr_produktgruppe_id)
(
    SELECT *
    FROM `_art_prod_group`
);


CREATE TEMPORARY TABLE IF NOT EXISTS _step1 AS
SELECT
    A.mandant_id,
    A.art_id,
    B.nachhaltigkeitslogo_id
FROM dbp_data.art_2 AS A
INNER JOIN dbp_data.l_nachhaltigkeitslogo_2 AS B ON TRUE;


CREATE TEMPORARY TABLE IF NOT EXISTS _step2 AS
-- LEFT JOIN DBP_DATA.art_2 z49
-- ON a.mandant_id = z49.mandant_id AND
-- a.art_id = z49.art_id AND

-- a.nachhaltigkeitslogo_id = CASE WHEN z49.bev_fg = 1 THEN 1074 END
-- LEFT JOIN DBP_DATA.art_2 z63

-- ON a.mandant_id = z63.mandant_id      AND
-- a.art_id     = z63.art_id          AND

-- a.nachhaltigkeitslogo_id = CASE WHEN z63.nmw_fg = 1 THEN 1088 END
-- LEFT JOIN DBP_DATA.art_2 z65

-- ON a.mandant_id = z65.mandant_id      AND
-- a.art_id     = z65.art_id          AND

-- a.nachhaltigkeitslogo_id = CASE WHEN z65.bum_fg = 1 THEN 1090 END
-- LEFT JOIN DBP_DATA.art_2 z66

-- ON a.mandant_id = z66.mandant_id      AND
-- a.art_id     = z66.art_id          AND

-- a.nachhaltigkeitslogo_id = CASE WHEN z66.fim_fg = 1 THEN 1091 END
-- LEFT JOIN DBP_DATA.art_2 z67

-- ON a.mandant_id = z67.mandant_id      AND
-- a.art_id     = z67.art_id          AND

-- a.nachhaltigkeitslogo_id = CASE WHEN z67.gab_fg = 1 THEN 1092 END
SELECT
    A.mandant_id,
    A.art_id,
    A.nachhaltigkeitslogo_id
FROM `_step1` AS A
LEFT JOIN dbp_data.art_2 AS B
    ON
        A.mandant_id = B.mandant_id AND A.art_id = B.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN B.bio_fg = 1
                THEN 1001
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS C
    ON
        A.mandant_id = C.mandant_id AND A.art_id = C.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN C.fair_trade_fg = 1
                THEN 1002
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS D
    ON
        A.mandant_id = D.mandant_id AND A.art_id = D.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN D.fcp_fg = 1
                THEN 1003
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS E
    ON
        A.mandant_id = E.mandant_id AND A.art_id = E.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN E.rainforest_fg = 1
                THEN 1004
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS F
    ON
        A.mandant_id = F.mandant_id AND A.art_id = F.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN F.utz_certified_fg = 1
                THEN 1005
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS G
    ON
        A.mandant_id = G.mandant_id AND A.art_id = G.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN G.msc_fg = 1
                THEN 1006
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS H
    ON
        A.mandant_id = H.mandant_id AND A.art_id = H.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN H.asc_fg = 1
                THEN 1007
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS I
    ON
        A.mandant_id = I.mandant_id AND A.art_id = I.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN I.dolphin_safe_fg = 1
                THEN 1008
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS J
    ON
        A.mandant_id = J.mandant_id AND A.art_id = J.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN J.fos_fg = 1
                THEN 1009
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS K
    ON
        A.mandant_id = K.mandant_id AND A.art_id = K.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN K.fsc_fg = 1
                THEN 1010
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS L
    ON
        A.mandant_id = L.mandant_id AND A.art_id = L.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN L.pefc_fg = 1
                THEN 1011
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS M
    ON
        A.mandant_id = M.mandant_id AND A.art_id = M.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN M.blauer_engel_fg = 1
                THEN 1012
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS N
    ON
        A.mandant_id = N.mandant_id AND A.art_id = N.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN N.euro_blume_fg = 1
                THEN 1013
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS O
    ON
        A.mandant_id = O.mandant_id AND A.art_id = O.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN O.gots_fg = 1
                THEN 1014
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS P
    ON
        A.mandant_id = P.mandant_id AND A.art_id = P.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN P.gots_proz_fg = 1
                THEN 1015
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Q
    ON
        A.mandant_id = Q.mandant_id AND A.art_id = Q.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Q.gots_organ_fg = 1
                THEN 1016
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS R
    ON
        A.mandant_id = R.mandant_id AND A.art_id = R.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN R.green_brands_fg = 1
                THEN 1017
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS S
    ON
        A.mandant_id = S.mandant_id AND A.art_id = S.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN S.kon_nat_kosmetik_fg = 1
                THEN 1018
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS T
    ON
        A.mandant_id = T.mandant_id AND A.art_id = T.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN T.natrue_fg = 1
                THEN 1019
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS U
    ON
        A.mandant_id = U.mandant_id AND A.art_id = U.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN U.ohne_gentechnik_fg = 1
                THEN 1020
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS V
    ON
        A.mandant_id = V.mandant_id AND A.art_id = V.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN V.rspo_fg = 1
                THEN 1021
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS W
    ON
        A.mandant_id = W.mandant_id AND A.art_id = W.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN W.sustain_clean_fg = 1
                THEN 1022
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS X
    ON
        A.mandant_id = X.mandant_id AND A.art_id = X.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN X.bitrex_fg = 1
                THEN 1023
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Y
    ON
        A.mandant_id = Y.mandant_id AND A.art_id = Y.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Y.eier_bh_fh_fg = 1
                THEN 1024
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z
    ON
        A.mandant_id = Z.mandant_id AND A.art_id = Z.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z.halal_fg = 1
                THEN 1025
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1
    ON
        A.mandant_id = Z1.mandant_id AND A.art_id = Z1.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1.keimling_fg = 1
                THEN 1026
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z2
    ON
        A.mandant_id = Z2.mandant_id AND A.art_id = Z2.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z2.vegan_fg = 1
                THEN 1027
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z3
    ON
        A.mandant_id = Z3.mandant_id AND A.art_id = Z3.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z3.vegetarisch_fg = 1
                THEN 1028
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z4
    ON
        A.mandant_id = Z4.mandant_id AND A.art_id = Z4.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z4.bioland_fg = 1
                THEN 1029
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z5
    ON
        A.mandant_id = Z5.mandant_id AND A.art_id = Z5.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z5.demeter_fg = 1
                THEN 1030
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z6
    ON
        A.mandant_id = Z6.mandant_id AND A.art_id = Z6.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z6.dtb_einstieg_fg = 1
                THEN 1031
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z7
    ON
        A.mandant_id = Z7.mandant_id AND A.art_id = Z7.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z7.dtb_premium_fg = 1
                THEN 1032
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z8
    ON
        A.mandant_id = Z8.mandant_id AND A.art_id = Z8.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z8.freilandhaltung_fg = 1
                THEN 1033
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z9
    ON
        A.mandant_id = Z9.mandant_id AND A.art_id = Z9.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z9.gap_fg = 1
                THEN 1034
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z10
    ON
        A.mandant_id = Z10.mandant_id AND A.art_id = Z10.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z10.gluten_fg = 1
                THEN 1035
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z11
    ON
        A.mandant_id = Z11.mandant_id AND A.art_id = Z11.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z11.aquagap_fg = 1
                THEN 1036
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z12
    ON
        A.mandant_id = Z12.mandant_id AND A.art_id = Z12.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z12.kaninchen_bh_fg = 1
                THEN 1037
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z13
    ON
        A.mandant_id = Z13.mandant_id AND A.art_id = Z13.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z13.lactose_fg = 1
                THEN 1038
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z14
    ON
        A.mandant_id = Z14.mandant_id AND A.art_id = Z14.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z14.marktfrisch_fg = 1
                THEN 1039
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z15
    ON
        A.mandant_id = Z15.mandant_id AND A.art_id = Z15.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z15.naturland_fg = 1
                THEN 1040
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z16
    ON
        A.mandant_id = Z16.mandant_id AND A.art_id = Z16.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z16.fsc_verpackung_fg = 1
                THEN 1041
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z17
    ON
        A.mandant_id = Z17.mandant_id AND A.art_id = Z17.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z17.tierwohl_fg = 1
                THEN 1042
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z18
    ON
        A.mandant_id = Z18.mandant_id AND A.art_id = Z18.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z18.qs_fg = 1
                THEN 1043
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z19
    ON
        A.mandant_id = Z19.mandant_id AND A.art_id = Z19.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z19.gu_fg = 1
                THEN 1044
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z20
    ON
        A.mandant_id = Z20.mandant_id AND A.art_id = Z20.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z20.gts_fg = 1
                THEN 1045
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z21
    ON
        A.mandant_id = Z21.mandant_id AND A.art_id = Z21.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z21.gga_fg = 1
                THEN 1046
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z22
    ON
        A.mandant_id = Z22.mandant_id AND A.art_id = Z22.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z22.oeko_tex_fg = 1
                THEN 1047
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z23
    ON
        A.mandant_id = Z23.mandant_id AND A.art_id = Z23.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z23.oeko_tex_std_100_plus_fg = 1
                THEN 1048
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z24
    ON
        A.mandant_id = Z24.mandant_id AND A.art_id = Z24.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z24.rainf_kaffee_fg = 1
                THEN 1049
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z25
    ON
        A.mandant_id = Z25.mandant_id AND A.art_id = Z25.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z25.rainf_kakao_fg = 1
                THEN 1050
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z26
    ON
        A.mandant_id = Z26.mandant_id AND A.art_id = Z26.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z26.vier_pfoten_fg = 1
                THEN 1051
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z27
    ON
        A.mandant_id = Z27.mandant_id AND A.art_id = Z27.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z27.weidehaltung_fg = 1
                THEN 1052
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z28
    ON
        A.mandant_id = Z28.mandant_id AND A.art_id = Z28.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z28.unsere_region_fg = 1
                THEN 1053
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z29
    ON
        A.mandant_id = Z29.mandant_id AND A.art_id = Z29.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z29.lets_bbq_fg = 1
                THEN 1054
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z30
    ON
        A.mandant_id = Z30.mandant_id AND A.art_id = Z30.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z30.verpackungseinsparung_fg = 1
                THEN 1055
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z31
    ON
        A.mandant_id = Z31.mandant_id AND A.art_id = Z31.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z31.cz_norm_fg = 1
                THEN 1056
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z32
    ON
        A.mandant_id = Z32.mandant_id AND A.art_id = Z32.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z32.kl_exclusiv_fg = 1
                THEN 1057
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z33
    ON
        A.mandant_id = Z33.mandant_id AND A.art_id = Z33.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z33.zum_fasten_fg = 1
                THEN 1058
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z34
    ON
        A.mandant_id = Z34.mandant_id AND A.art_id = Z34.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z34.kl_besonderes_fg = 1
                THEN 1059
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z35
    ON
        A.mandant_id = Z35.mandant_id AND A.art_id = Z35.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z35.stahlhaltung_fg = 1
                THEN 1060
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z36
    ON
        A.mandant_id = Z36.mandant_id AND A.art_id = Z36.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z36.stahlhaltung_plus_fg = 1
                THEN 1061
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z37
    ON
        A.mandant_id = Z37.mandant_id AND A.art_id = Z37.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z37.aussenklima_haltung_fg = 1
                THEN 1062
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z38
    ON
        A.mandant_id = Z38.mandant_id AND A.art_id = Z38.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z38.premium_haltung_fg = 1
                THEN 1063
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z39
    ON
        A.mandant_id = Z39.mandant_id AND A.art_id = Z39.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z39.machen_macht_unterschied_fg = 1
                THEN 1064
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z40
    ON
        A.mandant_id = Z40.mandant_id AND A.art_id = Z40.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z40.premium_fg = 1
                THEN 1065
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z41
    ON
        A.mandant_id = Z41.mandant_id AND A.art_id = Z41.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z41.qafp_fg = 1
                THEN 1066
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z42
    ON
        A.mandant_id = Z42.mandant_id AND A.art_id = Z42.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z42.qudal_fg = 1
                THEN 1067
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z43
    ON
        A.mandant_id = Z43.mandant_id AND A.art_id = Z43.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z43.regionale_lebensmittel_fg = 1
                THEN 1068
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z44
    ON
        A.mandant_id = Z44.mandant_id AND A.art_id = Z44.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z44.startup_fg = 1
                THEN 1069
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z45
    ON
        A.mandant_id = Z45.mandant_id AND A.art_id = Z45.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z45.togo_fg = 1
                THEN 1070
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z46
    ON
        A.mandant_id = Z46.mandant_id AND A.art_id = Z46.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z46.ohne_microplastik_fg = 1
                THEN 1071
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z47
    ON
        A.mandant_id = Z47.mandant_id AND A.art_id = Z47.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z47.grk_fg = 1
                THEN 1072
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z48
    ON
        A.mandant_id = Z48.mandant_id AND A.art_id = Z48.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z48.ppl_fg = 1
                THEN 1073
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z50
    ON
        A.mandant_id = Z50.mandant_id AND A.art_id = Z50.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z50.rpp_fg = 1
                THEN 1075
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z51
    ON
        A.mandant_id = Z51.mandant_id AND A.art_id = Z51.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z51.rsc_fg = 1
                THEN 1076
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z52
    ON
        A.mandant_id = Z52.mandant_id AND A.art_id = Z52.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z52.wsi_fg = 1
                THEN 1077
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z53
    ON
        A.mandant_id = Z53.mandant_id AND A.art_id = Z53.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z53.vbe_fg = 1
                THEN 1078
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z54
    ON
        A.mandant_id = Z54.mandant_id AND A.art_id = Z54.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z54.fte_fg = 1
                THEN 1079
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z55
    ON
        A.mandant_id = Z55.mandant_id AND A.art_id = Z55.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z55.kni_fg = 1
                THEN 1080
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z56
    ON
        A.mandant_id = Z56.mandant_id AND A.art_id = Z56.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z56.nhi_fg = 1
                THEN 1081
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z57
    ON
        A.mandant_id = Z57.mandant_id AND A.art_id = Z57.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z57.vac_fg = 1
                THEN 1082
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z58
    ON
        A.mandant_id = Z58.mandant_id AND A.art_id = Z58.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z58.gbs_fg = 1
                THEN 1083
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z59
    ON
        A.mandant_id = Z59.mandant_id AND A.art_id = Z59.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z59.ggn_fg = 1
                THEN 1084
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z60
    ON
        A.mandant_id = Z60.mandant_id AND A.art_id = Z60.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z60.bap_fg = 1
                THEN 1085
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z61
    ON
        A.mandant_id = Z61.mandant_id AND A.art_id = Z61.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z61.okt_fg = 1
                THEN 1086
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z62
    ON
        A.mandant_id = Z62.mandant_id AND A.art_id = Z62.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z62.daa_fg = 1
                THEN 1087
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z64
    ON
        A.mandant_id = Z64.mandant_id AND A.art_id = Z64.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z64.dachlogo_fg = 1
                THEN 1089
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z68
    ON
        A.mandant_id = Z68.mandant_id AND A.art_id = Z68.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z68.nat_bio_siegel_fg = 1
                THEN 1093
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z69
    ON
        A.mandant_id = Z69.mandant_id AND A.art_id = Z69.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z69.fair_sugar_prog_fg = 1
                THEN 1094
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z70
    ON
        A.mandant_id = Z70.mandant_id AND A.art_id = Z70.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z70.fair_cotton_prog_fg = 1
                THEN 1095
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z71
    ON
        A.mandant_id = Z71.mandant_id AND A.art_id = Z71.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z71.sustainable_cleaning_fg = 1
                THEN 1096
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z72
    ON
        A.mandant_id = Z72.mandant_id AND A.art_id = Z72.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z72.rainforest_alliance_tee_fg = 1
                THEN 1097
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z73
    ON
        A.mandant_id = Z73.mandant_id AND A.art_id = Z73.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z73.heumilch_fg = 1
                THEN 1098
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z74
    ON
        A.mandant_id = Z74.mandant_id AND A.art_id = Z74.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z74.fairmast_fg = 1
                THEN 1099
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z75
    ON
        A.mandant_id = Z75.mandant_id AND A.art_id = Z75.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z75.kat_kontrolliert_fg = 1
                THEN 1100
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z76
    ON
        A.mandant_id = Z76.mandant_id AND A.art_id = Z76.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z76.kdk_kalb_fg = 1
                THEN 1101
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z77
    ON
        A.mandant_id = Z77.mandant_id AND A.art_id = Z77.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z77.organic_cont_std_fg = 1
                THEN 1102
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z78
    ON
        A.mandant_id = Z78.mandant_id AND A.art_id = Z78.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z78.global_rec_std_fg = 1
                THEN 1103
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z79
    ON
        A.mandant_id = Z79.mandant_id AND A.art_id = Z79.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z79.global_rec_std_50_fg = 1
                THEN 1104
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z80
    ON
        A.mandant_id = Z80.mandant_id AND A.art_id = Z80.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z80.global_rec_std_55_fg = 1
                THEN 1105
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z81
    ON
        A.mandant_id = Z81.mandant_id AND A.art_id = Z81.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z81.global_rec_std_60_fg = 1
                THEN 1106
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z82
    ON
        A.mandant_id = Z82.mandant_id AND A.art_id = Z82.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z82.global_rec_std_65_fg = 1
                THEN 1107
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z83
    ON
        A.mandant_id = Z83.mandant_id AND A.art_id = Z83.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z83.global_rec_std_70_fg = 1
                THEN 1108
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z84
    ON
        A.mandant_id = Z84.mandant_id AND A.art_id = Z84.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z84.global_rec_std_75_fg = 1
                THEN 1109
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z85
    ON
        A.mandant_id = Z85.mandant_id AND A.art_id = Z85.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z85.global_rec_std_80_fg = 1
                THEN 1110
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z86
    ON
        A.mandant_id = Z86.mandant_id AND A.art_id = Z86.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z86.global_rec_std_85_fg = 1
                THEN 1111
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z87
    ON
        A.mandant_id = Z87.mandant_id AND A.art_id = Z87.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z87.global_rec_std_90_fg = 1
                THEN 1112
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z88
    ON
        A.mandant_id = Z88.mandant_id AND A.art_id = Z88.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z88.institut_heidger_fg = 1
                THEN 1113
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z89
    ON
        A.mandant_id = Z89.mandant_id AND A.art_id = Z89.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z89.cotton_mia_fg = 1
                THEN 1114
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z90
    ON
        A.mandant_id = Z90.mandant_id AND A.art_id = Z90.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z90.downpass_fg = 1
                THEN 1115
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z91
    ON
        A.mandant_id = Z91.mandant_id AND A.art_id = Z91.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z91.junghahnaufzucht_fg = 1
                THEN 1116
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z92
    ON
        A.mandant_id = Z92.mandant_id AND A.art_id = Z92.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z92.bord_bia_fg = 1
                THEN 1117
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z93
    ON
        A.mandant_id = Z93.mandant_id AND A.art_id = Z93.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z93.gss_fg = 1
                THEN 1118
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z94
    ON
        A.mandant_id = Z94.mandant_id AND A.art_id = Z94.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z94.tuv_fg = 1
                THEN 1119
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z95
    ON
        A.mandant_id = Z95.mandant_id AND A.art_id = Z95.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z95.ces_fg = 1
                THEN 1120
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z97
    ON
        A.mandant_id = Z97.mandant_id AND A.art_id = Z97.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z97.aklasa_fg = 1
                THEN 1121
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z99
    ON
        A.mandant_id = Z99.mandant_id AND A.art_id = Z99.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z99.i_know_fg = 1
                THEN 1122
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z100
    ON
        A.mandant_id = Z100.mandant_id AND A.art_id = Z100.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z100.czech_guild_std_fg = 1
                THEN 1123
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z101
    ON
        A.mandant_id = Z101.mandant_id AND A.art_id = Z101.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z101.czech_food_fg = 1
                THEN 1124
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z102
    ON
        A.mandant_id = Z102.mandant_id AND A.art_id = Z102.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z102.organic_cotton_fg = 1
                THEN 1125
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z103
    ON
        A.mandant_id = Z103.mandant_id AND A.art_id = Z103.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z103.sephora_fg = 1
                THEN 1126
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z104
    ON
        A.mandant_id = Z104.mandant_id AND A.art_id = Z104.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z104.green_globe_fg = 1
                THEN 1127
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z105
    ON
        A.mandant_id = Z105.mandant_id AND A.art_id = Z105.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z105.certificare_fg = 1
                THEN 1128
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z106
    ON
        A.mandant_id = Z106.mandant_id AND A.art_id = Z106.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z106.bg_state_std_fg = 1
                THEN 1129
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z107
    ON
        A.mandant_id = Z107.mandant_id AND A.art_id = Z107.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z107.ayvar_quality_fg = 1
                THEN 1130
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z108
    ON
        A.mandant_id = Z108.mandant_id AND A.art_id = Z108.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z108.creekstone_farm_fg = 1
                THEN 1131
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z109
    ON
        A.mandant_id = Z109.mandant_id AND A.art_id = Z109.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z109.milchprodukte_fg = 1
                THEN 1132
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z110
    ON
        A.mandant_id = Z110.mandant_id AND A.art_id = Z110.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z110.stara_planina_fg = 1
                THEN 1133
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z111
    ON
        A.mandant_id = Z111.mandant_id AND A.art_id = Z111.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z111.bgi_fg = 1
                THEN 1134
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z112
    ON
        A.mandant_id = Z112.mandant_id AND A.art_id = Z112.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z112.bgs_fg = 1
                THEN 1135
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z113
    ON
        A.mandant_id = Z113.mandant_id AND A.art_id = Z113.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z113.brot_qual_fg = 1
                THEN 1136
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z114
    ON
        A.mandant_id = Z114.mandant_id AND A.art_id = Z114.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z114.dti_fg = 1
                THEN 1137
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z115
    ON
        A.mandant_id = Z115.mandant_id AND A.art_id = Z115.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z115.mfd_fg = 1
                THEN 1138
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z116
    ON
        A.mandant_id = Z116.mandant_id AND A.art_id = Z116.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z116.consumer_choice_fg = 1
                THEN 1139
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z117
    ON
        A.mandant_id = Z117.mandant_id AND A.art_id = Z117.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z117.flash_fg = 1
                THEN 1140
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z118
    ON
        A.mandant_id = Z118.mandant_id AND A.art_id = Z118.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z118.cz_appetizer_fg = 1
                THEN 1141
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z119
    ON
        A.mandant_id = Z119.mandant_id AND A.art_id = Z119.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z119.children_appetizer_fg = 1
                THEN 1142
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z120
    ON
        A.mandant_id = Z120.mandant_id AND A.art_id = Z120.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z120.natulon_fg = 1
                THEN 1143
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z121
    ON
        A.mandant_id = Z121.mandant_id AND A.art_id = Z121.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z121.laenderherz_5d_fg = 1
                THEN 1144
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z122
    ON
        A.mandant_id = Z122.mandant_id AND A.art_id = Z122.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z122.ohne_gentechnik_nicht_vlog_fg = 1
                THEN 1145
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1148
    ON
        A.mandant_id = Z1148.mandant_id AND A.art_id = Z1148.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1148.traditional_certified_product_fg = 1
                THEN 1148
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1149
    ON
        A.mandant_id = Z1149.mandant_id AND A.art_id = Z1149.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1149.herkunftskennzeichen_de_fg = 1
                THEN 1149
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1150
    ON
        A.mandant_id = Z1150.mandant_id AND A.art_id = Z1150.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1150.leather_working_group_fg = 1
                THEN 1150
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1151
    ON
        A.mandant_id = Z1151.mandant_id AND A.art_id = Z1151.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1151.silphie_fg = 1
                THEN 1151
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1152
    ON
        A.mandant_id = Z1152.mandant_id AND A.art_id = Z1152.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1152.rainforest_banane_fg = 1
                THEN 1152
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1153
    ON
        A.mandant_id = Z1153.mandant_id AND A.art_id = Z1153.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1153.rainforest_schwarztee_fg = 1
                THEN 1153
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1154
    ON
        A.mandant_id = Z1154.mandant_id AND A.art_id = Z1154.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1154.rainforest_orange_fg = 1
                THEN 1154
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1155
    ON
        A.mandant_id = Z1155.mandant_id AND A.art_id = Z1155.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1155.vlabel_fg = 1
                THEN 1155
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1156
    ON
        A.mandant_id = Z1156.mandant_id AND A.art_id = Z1156.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1156.qmilch_plus_fg = 1
                THEN 1156
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1157
    ON
        A.mandant_id = Z1157.mandant_id AND A.art_id = Z1157.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1157.global_rec_std_filling_fg = 1
                THEN 1157
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1158
    ON
        A.mandant_id = Z1158.mandant_id AND A.art_id = Z1158.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1158.organic_con_std_blended_fg = 1
                THEN 1158
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1159
    ON
        A.mandant_id = Z1159.mandant_id AND A.art_id = Z1159.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1159.gots_made_with_organic_fg = 1
                THEN 1159
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1160
    ON
        A.mandant_id = Z1160.mandant_id AND A.art_id = Z1160.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1160.rcs_fg = 1
                THEN 1160
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1161
    ON
        A.mandant_id = Z1161.mandant_id AND A.art_id = Z1161.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1161.rcs_blended_fg = 1
                THEN 1161
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1162
    ON
        A.mandant_id = Z1162.mandant_id AND A.art_id = Z1162.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1162.rcs_filling_fg = 1
                THEN 1162
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1163
    ON
        A.mandant_id = Z1163.mandant_id AND A.art_id = Z1163.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1163.rcs_filling_blended_fg = 1
                THEN 1163
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1164
    ON
        A.mandant_id = Z1164.mandant_id AND A.art_id = Z1164.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1164.made_in_germany_fg = 1
                THEN 1164
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1165
    ON
        A.mandant_id = Z1165.mandant_id AND A.art_id = Z1165.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1165.cyclos_fg = 1
                THEN 1165
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1166
    ON
        A.mandant_id = Z1166.mandant_id AND A.art_id = Z1166.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1166.rainforest_haselnuss_fg = 1
                THEN 1166
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1167
    ON
        A.mandant_id = Z1167.mandant_id AND A.art_id = Z1167.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1167.rmc_blue_fg = 1
                THEN 1167
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1168
    ON
        A.mandant_id = Z1168.mandant_id AND A.art_id = Z1168.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1168.rws_fg = 1
                THEN 1168
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1169
    ON
        A.mandant_id = Z1169.mandant_id AND A.art_id = Z1169.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1169.bio_haltung_fg = 1
                THEN 1169
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1170
    ON
        A.mandant_id = Z1170.mandant_id AND A.art_id = Z1170.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1170.vegan_kaufland_fg = 1
                THEN 1170
            ELSE NULL
        END
LEFT JOIN dbp_data.art_2 AS Z1171
    ON
        A.mandant_id = Z1171.mandant_id AND A.art_id = Z1171.art_id AND A.nachhaltigkeitslogo_id
        = CASE
            WHEN Z1171.sustainable_rice_platform_fg = 1
                THEN 1171
            ELSE NULL
        END
WHERE
    B.kl_art_id IS NOT NULL
    OR C.kl_art_id IS NOT NULL
    OR (D.kl_art_id IS NOT NULL OR (E.kl_art_id IS NOT NULL OR F.kl_art_id IS NOT NULL))
    OR (G.kl_art_id IS NOT NULL OR H.kl_art_id IS NOT NULL OR (I.kl_art_id IS NOT NULL OR (
        J.kl_art_id IS NOT NULL OR K.kl_art_id
        IS NOT NULL
    )))
    OR (L.kl_art_id IS NOT NULL OR M.kl_art_id IS NOT NULL OR (N.kl_art_id IS NOT NULL OR (
        O.kl_art_id IS NOT NULL OR P.kl_art_id
        IS NOT NULL)) OR (Q.kl_art_id IS NOT NULL OR R.kl_art_id IS NOT NULL OR (
        S.kl_art_id IS NOT NULL OR (
            T.kl_art_id
            IS NOT NULL OR U.kl_art_id IS NOT NULL
        )
    )))
    OR (V.kl_art_id IS NOT NULL OR W.kl_art_id IS NOT NULL OR (X.kl_art_id IS NOT NULL OR (
        Y.kl_art_id IS NOT NULL OR Z.kl_art_id
        IS NOT NULL)) OR (Z1.kl_art_id IS NOT NULL OR Z2.kl_art_id IS NOT NULL OR (
        Z3.kl_art_id IS NOT NULL OR (
            Z4.kl_art_id
            IS NOT NULL OR Z5.kl_art_id IS NOT NULL
        )
    )) OR (Z6.kl_art_id IS NOT NULL OR Z7.kl_art_id IS NOT NULL OR (
        Z8.kl_art_id
        IS NOT NULL OR (
            Z9.kl_art_id IS NOT NULL OR Z10.kl_art_id IS NOT NULL
        )
    ) OR (
        Z11.kl_art_id IS NOT NULL OR (
            Z12.kl_art_id
            IS NOT NULL OR Z13.kl_art_id IS NOT NULL) OR (
            Z14.kl_art_id IS NOT NULL OR (
                Z15.kl_art_id IS NOT NULL OR Z16.kl_art_id
                IS NOT NULL
            )
        )
    )))
    OR (Z17.kl_art_id IS NOT NULL OR Z18.kl_art_id IS NOT NULL OR (Z19.kl_art_id IS NOT NULL OR (
        Z20.kl_art_id IS NOT NULL
        OR Z21.kl_art_id IS NOT NULL)) OR (Z22.kl_art_id IS NOT NULL OR Z23.kl_art_id IS NOT NULL OR (
        Z24.kl_art_id
        IS NOT NULL OR (Z25.kl_art_id IS NOT NULL OR Z26.kl_art_id IS NOT NULL)
    )) OR (Z27.kl_art_id IS NOT NULL OR Z28.kl_art_id IS NOT NULL OR (
        Z29.kl_art_id IS NOT NULL OR (Z30.kl_art_id IS NOT NULL OR Z31.kl_art_id IS NOT NULL
        )) OR (
        Z32.kl_art_id IS NOT NULL OR Z33.kl_art_id IS NOT NULL OR (Z34.kl_art_id IS NOT NULL OR (
            Z35.kl_art_id
            IS NOT NULL OR Z36.kl_art_id IS NOT NULL
        ))
    )) OR (Z37.kl_art_id IS NOT NULL OR Z38.kl_art_id IS NOT NULL OR (
        Z39.kl_art_id IS NOT NULL OR (Z40.kl_art_id IS NOT NULL OR Z41.kl_art_id IS NOT NULL)) OR (
        Z42.kl_art_id
        IS NOT NULL OR Z43.kl_art_id IS NOT NULL OR (Z44.kl_art_id IS NOT NULL OR (
            Z45.kl_art_id IS NOT NULL OR Z46.kl_art_id
            IS NOT NULL
        ))
    ) OR (
        Z47.kl_art_id IS NOT NULL OR Z48.kl_art_id IS NOT NULL OR (-- z49.kl_art_id IS NOT NULL  OR

            Z50.kl_art_id IS NOT NULL OR (Z51.kl_art_id IS NOT NULL OR Z52.kl_art_id IS NOT NULL)) OR (Z53.kl_art_id
        IS NOT NULL OR (Z54.kl_art_id IS NOT NULL OR Z55.kl_art_id IS NOT NULL) OR (Z56.kl_art_id IS NOT NULL OR (
            Z57.kl_art_id IS NOT NULL OR Z58.kl_art_id IS NOT NULL
        )))
    )))
    OR (Z59.kl_art_id IS NOT NULL OR Z60.kl_art_id IS NOT NULL OR (Z61.kl_art_id IS NOT NULL OR (
        Z62.kl_art_id IS NOT NULL
        OR -- z63.kl_art_id IS NOT NULL  OR
        Z64.kl_art_id IS NOT NULL
    )) OR (-- z67.kl_art_id IS NOT NULL  OR

        -- z66.kl_art_id IS NOT NULL  OR
        -- z65.kl_art_id IS NOT NULL  OR
        Z68.kl_art_id IS NOT NULL OR Z69.kl_art_id
        IS NOT NULL OR (Z70.kl_art_id IS NOT NULL OR (Z71.kl_art_id IS NOT NULL OR Z72.kl_art_id IS NOT NULL))) OR (Z73.kl_art_id IS NOT NULL OR Z74.kl_art_id IS NOT NULL OR (Z75.kl_art_id IS NOT NULL OR (
        Z76.kl_art_id IS NOT NULL
        OR Z77.kl_art_id IS NOT NULL)) OR (Z78.kl_art_id IS NOT NULL OR Z79.kl_art_id IS NOT NULL OR (
        Z80.kl_art_id
        IS NOT NULL OR (Z81.kl_art_id IS NOT NULL OR Z82.kl_art_id IS NOT NULL)
    ))) OR (Z83.kl_art_id IS NOT NULL OR
    Z84.kl_art_id IS NOT NULL OR (Z85.kl_art_id IS NOT NULL OR (
        Z86.kl_art_id IS NOT NULL OR Z87.kl_art_id
        IS NOT NULL)) OR (Z88.kl_art_id IS NOT NULL OR Z89.kl_art_id IS NOT NULL OR (
        Z90.kl_art_id IS NOT NULL OR (
            Z91.kl_art_id IS NOT NULL OR Z92.kl_art_id IS NOT NULL
        )
    )) OR (Z93.kl_art_id IS NOT NULL OR Z94.kl_art_id
    IS NOT NULL OR (Z95.kl_art_id IS NOT NULL OR (-- z96.kl_art_id IS NOT NULL  OR
        Z97.kl_art_id IS NOT NULL OR
        -- z98.kl_art_id IS NOT NULL  OR
        Z99.kl_art_id IS NOT NULL)) OR (Z100.kl_art_id IS NOT NULL OR (Z101.kl_art_id
    IS NOT NULL OR Z102.kl_art_id IS NOT NULL) OR (Z103.kl_art_id IS NOT NULL OR (
        Z104.kl_art_id IS NOT NULL OR
        Z105.kl_art_id IS NOT NULL
    ))))) OR (Z106.kl_art_id IS NOT NULL OR Z107.kl_art_id IS NOT NULL OR (Z108.kl_art_id
    IS NOT NULL OR (Z109.kl_art_id IS NOT NULL OR Z110.kl_art_id IS NOT NULL)) OR (Z111.kl_art_id IS NOT NULL OR
    Z112.kl_art_id IS NOT NULL OR (Z113.kl_art_id IS NOT NULL OR (
        Z114.kl_art_id IS NOT NULL OR Z115.kl_art_id
        IS NOT NULL
    ))) OR (Z116.kl_art_id IS NOT NULL OR Z117.kl_art_id IS NOT NULL OR (Z118.kl_art_id IS NOT NULL
    OR (Z119.kl_art_id IS NOT NULL OR Z120.kl_art_id IS NOT NULL)) OR (
        Z121.kl_art_id IS NOT NULL OR Z122.kl_art_id
        IS NOT NULL OR (Z1148.kl_art_id IS NOT NULL OR (Z1149.kl_art_id IS NOT NULL OR Z1150.kl_art_id IS NOT NULL))
    )) OR (Z1151.kl_art_id IS NOT NULL OR Z1152.kl_art_id IS NOT NULL OR (Z1153.kl_art_id IS NOT NULL OR (
        Z1154.kl_art_id
        IS NOT NULL OR Z1155.kl_art_id IS NOT NULL
    )) OR (Z1156.kl_art_id IS NOT NULL OR Z1157.kl_art_id IS NOT NULL
    OR (Z1158.kl_art_id IS NOT NULL OR (Z1159.kl_art_id IS NOT NULL OR Z1160.kl_art_id IS NOT NULL))) OR (Z1161.kl_art_id IS NOT NULL OR Z1162.kl_art_id IS NOT NULL OR (Z1163.kl_art_id IS NOT NULL OR (
        Z1164.kl_art_id
        IS NOT NULL OR Z1165.kl_art_id IS NOT NULL)) OR (Z1166.kl_art_id IS NOT NULL OR (Z1167.kl_art_id
    IS NOT NULL OR Z1168.kl_art_id IS NOT NULL) OR (
        Z1169.kl_art_id IS NOT NULL OR (
            Z1170.kl_art_id
            IS NOT NULL OR Z1171.kl_art_id IS NOT NULL
        )
    ))))));


TRUNCATE TABLE dbp_data.nachhaltigkeitslogo_art_zu_2;


INSERT INTO dbp_data.nachhaltigkeitslogo_art_zu_2 (
    mandant_id, art_id, nachhaltigkeitslogo_id, td_insert,
    td_update
)
(SELECT
    mandant_id AS mandant_id,
    art_id AS art_id,
    nachhaltigkeitslogo_id,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM `_step2`);
