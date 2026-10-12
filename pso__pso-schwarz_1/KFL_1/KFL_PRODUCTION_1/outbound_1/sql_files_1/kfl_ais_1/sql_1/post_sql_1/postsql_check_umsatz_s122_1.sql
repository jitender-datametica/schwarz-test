--[OK] statement is translated correctly (syntax and type checks are fine)


TRUNCATE TABLE dbp_msi_data.check_kunden_umsatz_1;


INSERT INTO dbp_msi_data.check_kunden_umsatz_1 (
    dat, mandant_id, wup_id, kassierer_nr, kasse_nr,
    anz_bon_sap,
    umsatz_wrg,
    umsatz_brutto_gesamt,
    umsatz_netto_gesamt,
    umsatz_brutto_kasse
)
(
    SELECT
        PARSE_DATE('%Y%m%d', L.dat_bon) AS dat,
        S.mandant_id,
        L.wup_id,
        CASE
            WHEN L.kassierer_id > 999999
                THEN 999999
            ELSE L.kassierer_id
        END AS kassierer_nr,
        CASE
            WHEN L.kasse_nr > 999999
                THEN 999999
            ELSE L.kasse_nr
        END AS kasse_nr,
        SUM(L.anz_bon_sap) AS anz_bon_sap,
        L.wrg_id AS umsatz_wrg,
        SUM(L.umsatz_brutto_sap) AS umsatz_brutto_gesamt,
        SUM(L.umsatz_netto_sap) AS umsatz_netto_gesamt,
        SUM(L.umsatz_brutto_kassennr_sap) AS umsatz_brutto_kasse
    FROM dbp_etl.check_umsatz_s122_1 AS L
    INNER JOIN dbp_data.l_system_1 AS S ON L.quellsystem = S.kl_system_id
    GROUP BY
        dat,
        S.mandant_id,
        L.wup_id,
        kassierer_nr,
        kasse_nr,
        umsatz_wrg
);
