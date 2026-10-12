UPDATE dbp_data.wupcal SET
    datenlieferung_bonanzahl = 1,
    bonanzahl = CAST(dt1.wert_ AS INTEGER),
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        DATE(buchzeit) AS dat_,
        marktnummer AS wup_id_,
        schluessel,
        MAX(ROUND(CAST(info1 AS BIGNUMERIC), 0)) AS wert_
    FROM dbp_etl.gastro_finanz
    WHERE schluessel = '902'
    GROUP BY
        dat_,
        wup_id_,
        schluessel
) AS dt1
WHERE
    wupcal.wup_id = dt1.wup_id_ AND wupcal.dat = dt1.dat_ AND wupcal.mandant_id = 1 AND wupcal.nb_id = 2;
