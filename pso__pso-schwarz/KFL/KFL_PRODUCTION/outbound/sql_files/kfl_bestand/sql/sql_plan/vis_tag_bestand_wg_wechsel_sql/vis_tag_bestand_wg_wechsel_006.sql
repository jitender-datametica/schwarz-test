--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'T1' does not exist or not authorized.


UPDATE dbp_msi_data.vis_tag_bestand_wg AS T1 SET
    abt_id = tmp.abt_id FROM (
    SELECT
        mandant_id,
        wg_id,
        abt_id,
        arthiertyp_id
    FROM dbp_data.wg_per
    WHERE
        dat_bis = PARSE_DATE('%F', '9999-12-31')
        AND arthiertyp_id = 2
) AS tmp
WHERE
    T1.mandant_id = tmp.mandant_id AND T1.wg_id = tmp.wg_id AND T1.arthiertyp_id = tmp.arthiertyp_id AND T1.abt_id <>
    tmp.abt_id;
