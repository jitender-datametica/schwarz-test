--[OK] statement is translated correctly (syntax and type checks are fine)


UPDATE dbp_data.gp_2 AS gp0 SET
    wewa_fg = 1 FROM (
    SELECT
        mandant_id AS upd_mandant_id,
        gp_id AS upd_gp_id
    FROM dbp_data.gp_2
    WHERE
        wewa_fg = 1
        AND mandant_id = 1
) AS up
WHERE gp0.hgp_id = up.upd_gp_id AND gp0.mandant_id = up.upd_mandant_id;
