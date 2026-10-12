--[OK] statement is translated correctly (syntax and type checks are fine)


SELECT
    D.mandant_id,
    D.wup_id,
    D.gl_vertrieb_id,
    S.ma_vorname || ' ' || S.ma_name AS gl_name
FROM dbp_msi_data.wup_denorm_1 AS D
INNER JOIN dbp_data.ma_spr_zu_1 AS S ON D.gl_vertrieb_id = S.ma_id
WHERE
    D.mandant_id IN (3, 7)
    AND D.gl_vertrieb_id > 0
GROUP BY
    D.mandant_id,
    D.wup_id,
    D.gl_vertrieb_id,
    gl_name;
