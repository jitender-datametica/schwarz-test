/* AW check 2021-05-17*/


TRUNCATE TABLE dbp_msi_data.ek_user_art_zu_2;


INSERT INTO dbp_msi_data.ek_user_art_zu_2 (mandant_id, art_id, user_id)
(SELECT
    mandant_id,
    art_id,
    user_id
FROM ((
    SELECT
        u_r.mandant_id,
        u_r.user_id,
        a_vhd.art_id
    FROM (SELECT
        mandant_id,
        user_id,
        rolle_id,
        rolle_bez,
        zek_id,
        wbl_id,
        gf_id
    FROM dbp_security.user_rolle_ek_int_zu_2) AS u_r
    INNER JOIN (
        SELECT
            A.mandant_id,
            A.art_id,
            A.zek_id,
            ekl.wbl_id,
            gf.gf_id
        FROM dbp_data.art_2 AS A
        LEFT JOIN (SELECT
            mandant_id,
            zek_id,
            wbl_id
        FROM dbp_security.zek_wbl_zu_2) AS ekl
            ON A.mandant_id = ekl.mandant_id AND A.zek_id = ekl.zek_id
        LEFT JOIN (SELECT
            mandant_id,
            wbl_id,
            gf_id
        FROM dbp_security.wbl_gf_zu_2) AS gf_2
            ON ekl.mandant_id = gf.mandant_id AND ekl.wbl_id = gf.wbl_id
    ) AS a_vhd
        ON
            u_r.mandant_id = a_vhd.mandant_id AND (
                u_r.zek_id = a_vhd.zek_id OR u_r.wbl_id = a_vhd.wbl_id
                OR u_r.gf_id = a_vhd.gf_id
            )
    WHERE u_r.rolle_id IN (1, 2, 3)
    UNION DISTINCT
    SELECT
        u_r.mandant_id,
        u_r.user_id,
        a_vat.art_id
    FROM (SELECT
        mandant_id,
        user_id,
        rolle_id,
        rolle_bez,
        zek_id,
        wbl_id,
        gf_id
    FROM dbp_security.user_rolle_ek_int_zu_2) AS u_r
    INNER JOIN (
        SELECT
            A.mandant_id,
            A.art_id,
            A.zek_vat_id AS zek_id,
            ekl.wbl_id,
            gf.gf_id
        FROM dbp_data.art_2 AS A
        LEFT JOIN (SELECT
            mandant_id,
            zek_id,
            wbl_id
        FROM dbp_security.zek_wbl_zu_2) AS ekl
            ON A.mandant_id = ekl.mandant_id AND A.zek_vat_id = ekl.zek_id

        LEFT JOIN (SELECT
            mandant_id,
            wbl_id,
            gf_id
        FROM dbp_security.wbl_gf_zu_2) AS gf_2
            ON ekl.mandant_id = gf.mandant_id AND ekl.wbl_id = gf.wbl_id
    ) AS a_vat
        ON
            u_r.mandant_id = a_vat.mandant_id AND (
                u_r.zek_id = a_vat.zek_id OR u_r.wbl_id = a_vat.wbl_id
                OR u_r.gf_id = a_vat.gf_id
            )
    WHERE u_r.rolle_id IN (1, 2, 3)
)
UNION DISTINCT
SELECT
    u_r.mandant_id,
    u_r.user_id,
    ART.art_id
FROM (SELECT
    mandant_id,
    user_id,
    rolle_id,
    rolle_bez,
    zek_id,
    wbl_id,
    gf_id
FROM dbp_security.user_rolle_ek_int_zu_2) AS u_r
INNER JOIN dbp_data.art_2 AS ART_2 ON u_r.mandant_id = ART.mandant_id
    WHERE u_r.rolle_id = 4
) AS t14);
