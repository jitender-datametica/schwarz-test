UPDATE dbp_data.ek_infosatz_2 SET
    konditionsgruppe_id = a.konditionsgruppe_id,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        mandant_id,
        ek_infosatz_id,
        MAX(konditionsgruppe_id) AS konditionsgruppe_id
    FROM dbp_etl.eine_ek_infosatz
    GROUP BY
        mandant_id,
        ek_infosatz_id
) AS a
WHERE ek_infosatz.mandant_id = a.mandant_id AND ek_infosatz.ek_infosatz_id = a.ek_infosatz_id AND COALESCE(
    ek_infosatz.konditionsgruppe_id,
    '-1'
) <> a.konditionsgruppe_id;


UPDATE dbp_data.ek_infosatz_2 SET
    konditionsgruppe_id = a.konditionsgruppe_id,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        mandant_id,
        ek_infosatz_id,
        konditionsgruppe_id
    FROM dbp_etl.eine_ek_infosatz
    WHERE
        wup_id = 0
        AND loesch_fg = 0
    GROUP BY
        mandant_id,
        ek_infosatz_id,
        konditionsgruppe_id
) AS a
WHERE ek_infosatz.mandant_id = a.mandant_id AND ek_infosatz.ek_infosatz_id = a.ek_infosatz_id AND COALESCE(
    ek_infosatz.konditionsgruppe_id,
    '-1'
) <> a.konditionsgruppe_id;
