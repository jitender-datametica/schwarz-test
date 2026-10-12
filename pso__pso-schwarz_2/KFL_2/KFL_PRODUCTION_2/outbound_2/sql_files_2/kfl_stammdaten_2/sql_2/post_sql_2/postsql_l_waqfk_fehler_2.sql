--[OK] statement is translated correctly (syntax and type checks are fine)


INSERT INTO dbp_data.l_waqfk_fehler_2 (mandant_id, system_id, waqfk_fehler_id)
(SELECT
    mandant_id,
    system_id,
    waqfk_fehler_id
FROM dbp_data.waqfk_fehler_spr_zu_2
WHERE (
    mandant_id, system_id, waqfk_fehler_id) NOT IN (
    SELECT (mandant_id, system_id, waqfk_fehler_id)
    FROM dbp_data.l_waqfk_fehler_2
));
