--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.wg_hierarchie_spr_zu
WHERE mandant_id = 5 AND spr_id = 124;


--[OK] statement is translated correctly (syntax and type checks are fine)


DELETE FROM dbp_data.wg_hierarchie_spr_zu
WHERE spr_id = 24;


UPDATE dbp_data.wg_hierarchie_spr_zu SET
    wg_hierarchie_bez = s.ro_wg_hierarchie_bez,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        A.wg_hierarchie_ebene_id,
        A.wg_hierarchie_id,
        A.arthiertyp_id,
        A.spr_id,
        B.wg_hierarchie_bez AS ro_wg_hierarchie_bez
    FROM dbp_data.wg_hierarchie_spr_zu AS A
    INNER JOIN dbp_data.wg_hierarchie_spr_zu AS B
        ON
            A.wg_hierarchie_ebene_id = B.wg_hierarchie_ebene_id
            AND A.wg_hierarchie_id = B.wg_hierarchie_id
            AND A.arthiertyp_id = B.arthiertyp_id
            AND A.spr_id = B.spr_id
    WHERE
        A.mandant_id = 4
        AND A.spr_id <> 22
        AND B.mandant_id = 7
        AND B.spr_id <> 22
        AND A.wg_hierarchie_bez <> B.wg_hierarchie_bez
    GROUP BY
        A.wg_hierarchie_ebene_id,
        A.wg_hierarchie_id,
        A.arthiertyp_id,
        A.spr_id,
        ro_wg_hierarchie_bez
) AS s
WHERE
    wg_hierarchie_spr_zu.mandant_id = 4
    AND wg_hierarchie_spr_zu.wg_hierarchie_ebene_id = s.wg_hierarchie_ebene_id
    AND wg_hierarchie_spr_zu.wg_hierarchie_id = s.wg_hierarchie_id AND wg_hierarchie_spr_zu.arthiertyp_id = s.arthiertyp_id
    AND wg_hierarchie_spr_zu.spr_id = s.spr_id AND wg_hierarchie_spr_zu.wg_hierarchie_bez <> s.ro_wg_hierarchie_bez;
