/*
#------------------------------------------------------------------------------
# Skriptname   : artbew_scanning.btq
# Erstelldatum : 20.01.2016
#------------------------------------------------------------------------------
# Projekt      : AIS
# Kommentar    : Die Scanningqualitaet der EANs werden geprueft!
#
# Datenquellen : dbp_data.artbew, dbp_ods.ods_bon_kopf, dbp_ods.ods_bon_verkauf,
#                dbp_data.art, dbp_data.art_gp_zu_per
#
# Datenziele   : dbp_data.artbew_scanning
#------------------------------------------------------------------------------
# Historie:
# 20.01.2016  D.Bayraktar   Ersterstellung
# 10.08.2016  D.Bayraktar   PLUs ausschliessen
# 18.09.2019  D.Bayraktar   Performance!
# 21.01.2022  SPEC0142119   remove filter ean_kasse>9999
#------------------------------------------------------------------------------
# Verarbeitungsschritte
#  1)  Logon auf der Datenbank.
#  2)  Relevante Tage rausziehen.
#  3)  Die benoetigten Bon-Daten ziehen.
#  4)  Die benoetigten Artbew-Daten ziehen.
#  5)  Berechnung der Scanningtreffer.
#  6)  Promo-Flag aus Artbew uebertragen.
#  7)  Austausch der Daten.
#  8)  Bteq beenden.
#------------------------------------------------------------------------------
*/

/*
#-----------------------------------------------------------------------------------
# 2) Relevante Tage rausziehen.
#-----------------------------------------------------------------------------------
*/


CREATE OR REPLACE TABLE dbp_data.`_tage` AS
SELECT dat
FROM dbp_data.tag
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 4 DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
GROUP BY dat;


/*
#-----------------------------------------------------------------------------------
# 3) Die benoetigten Bon-Daten ziehen.
#-----------------------------------------------------------------------------------
*/


CREATE OR REPLACE TABLE dbp_data.`_snapshot1` AS
SELECT
    A.bon_id,
    A.bon_zeile,
    A.mandant_id,
    A.wup_id,
    A.bon_dat,
    A.kl_art_id,
    A.ean_kasse,
    A.wg_id,
    A.menge,
    A.einh_id,
    A.umsatz_brutto,
    A.mwst_id,
    A.erfassung_id,
    A.aktion_id,
    A.talon_id,
    A.start_bon_zeile,
    A.bon_nr_extern,
    A.kpos_erfassung_id,
    A.umsatz_brutto_norm,
    A.vk_brutto_obb,
    A.bon_vorgang_id,
    A.barcode_string,
    A.barcode_leergut,
    A.zeilenstorno_fg,
    A.td_update,
    A.td_insert,
    X.kasse_typ_id
FROM dbp_ods.ods_bon_kopf AS X
INNER JOIN dbp_ods.ods_bon_verkauf AS A
    ON
        X.mandant_id = A.mandant_id AND X.wup_id = A.wup_id AND X.bon_id
        = A.bon_id AND X.bon_dat = A.bon_dat
WHERE
    X.bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 4 DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY))
    AND X.kasse_typ_id IN (1, 8, 9)
    AND A.menge > 0
    AND A.einh_id NOT IN ('LGB', 'PND', 'LGK', 'LGF');


/*
#-----------------------------------------------------------------------------------
# 4) Die benoetigten Artbew-Daten ziehen.
#-----------------------------------------------------------------------------------
*/


CREATE OR REPLACE TABLE dbp_data.`_artbew` AS
SELECT *
FROM dbp_data.artbew
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 4 DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY));


/*
#-----------------------------------------------------------------------------------
# 5) Berechnung der Scanningtreffer.
#-----------------------------------------------------------------------------------
*/


CREATE OR REPLACE TABLE dbp_data.`_ergebnis` AS
SELECT
    A.mandant_id,
    A.wup_id,
    0 AS nb_id,
    CASE
        WHEN A.aktion_id NOT IN ('0', '0000000000', '')
            THEN 1002
        ELSE 1001
    END AS bewart_id,
    CAST(NULL AS INTEGER) AS gp_id,
    B.art_id,
    A.bon_dat AS dat,
    A.aktion_id,
    0 AS promo_fg,
    A.kasse_typ_id,
    COALESCE(CASE
        WHEN TRIM(A.barcode_string) = ''
            THEN A.ean_kasse
        WHEN LENGTH(A.barcode_string) > 26
            THEN 9999
        WHEN ROUND(SAFE_CAST(A.barcode_string AS BIGNUMERIC), 0) IS NOT NULL
            THEN CAST(ROUND(CAST(A.barcode_string AS BIGNUMERIC), 0) AS NUMERIC)
        ELSE A.ean_kasse
    END, A.ean_kasse) AS gtin_kasse,
    SUM(CASE
        WHEN A.erfassung_id = 'SC'
            THEN 1
        ELSE 0
    END) AS vorgang_scanned,
    SUM(CASE
        WHEN A.erfassung_id = 'KE'
            THEN 1
        ELSE 0
    END) AS vorgang_keyed,
    SUM(CASE
        WHEN A.erfassung_id = 'SC' AND (A.einh_id = 'ST' AND A.menge <> 1 OR A.einh_id = 'KGM')
            THEN 1
        ELSE 0
    END) AS vorgang_scanned_einzeln,
    SUM(CASE
        WHEN A.erfassung_id = 'KE' AND (A.einh_id = 'ST' AND A.menge <> 1 OR A.einh_id = 'KGM')
            THEN 1
        ELSE 0
    END) AS vorgang_keyed_einzeln,
    COUNT(DISTINCT A.bon_id) AS anzahl_bon,
    SUM(CASE
        WHEN A.einh_id = 'KGM'
            THEN 1
        ELSE A.menge
    END) AS anzahl_registriert
FROM dbp_data.`_snapshot1` AS A
INNER JOIN dbp_data.art AS B
    ON
        A.mandant_id = B.mandant_id AND A.kl_art_id = B.kl_art_id AND B.dat_bis
        = DATE '9999-12-31'
GROUP BY
    A.mandant_id,
    A.wup_id,
    nb_id,
    bewart_id,
    gp_id,
    B.art_id,
    dat,
    A.aktion_id,
    promo_fg,
    A.kasse_typ_id,
    gtin_kasse;


/*
#-----------------------------------------------------------------------------------
# 6) Promo-Flag aus Artbew uebertragen.
#-----------------------------------------------------------------------------------
*/


UPDATE dbp_data.`_ergebnis` SET
    promo_fg = t1.promo_fg FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id,
        aktion_id,
        ean_kasse,
        dat,
        promo_fg
    FROM dbp_data.`_artbew`
    WHERE promo_fg = 1
    GROUP BY
        mandant_id,
        wup_id,
        dat,
        art_id,
        aktion_id,
        promo_fg,
        ean_kasse
) AS t1
WHERE
    `_ergebnis`.mandant_id = t1.mandant_id AND `_ergebnis`.wup_id = t1.wup_id AND `_ergebnis`.art_id = t1.art_id AND
    `_ergebnis`.aktion_id = t1.aktion_id AND `_ergebnis`.gtin_kasse = t1.ean_kasse AND `_ergebnis`.dat = t1.dat;


-- (1) Update des GP aus der ARTBEW.


UPDATE dbp_data.`_ergebnis` SET
    gp_id = t0.gp_id FROM (
    SELECT
        mandant_id,
        wup_id,
        art_id,
        dat,
        MAX(gp_id) AS gp_id
    FROM dbp_data.`_artbew`
    GROUP BY
        mandant_id,
        wup_id,
        dat,
        art_id
) AS t0
WHERE
    `_ergebnis`.mandant_id = t0.mandant_id AND `_ergebnis`.wup_id = t0.wup_id AND `_ergebnis`.art_id = t0.art_id AND
    `_ergebnis`.dat = t0.dat;


-- (2) Uebrige NULLs werden durch ART_GP_NM_ZU_PER bereinigt.


UPDATE dbp_data.`_ergebnis` AS `_ergebnis0` SET
    gp_id = b.gp_id FROM (
    SELECT
        a.mandant_id,
        a.wup_id,
        a.art_id,
        a.dat,
        MAX(B.gp_id) AS gp_id
    FROM (
        SELECT *
        FROM dbp_data.`_ergebnis`
        WHERE gp_id IS NULL
    ) AS a
    INNER JOIN dbp_data.art_gp_nm_zu_per AS B
        ON
            a.mandant_id = B.mandant_id AND a.wup_id = B.wup_id AND a.art_id = B.art_id AND a.dat BETWEEN B.dat_von AND B.dat_bis
    GROUP BY
        a.mandant_id,
        a.wup_id,
        a.art_id,
        a.dat
) AS b
WHERE
    `_ergebnis0`.mandant_id = b.mandant_id AND `_ergebnis0`.wup_id = b.wup_id AND `_ergebnis0`.art_id = b.art_id AND
    `_ergebnis0`.dat = b.dat AND `_ergebnis0`.gp_id IS NULL;


DELETE FROM dbp_data.`_ergebnis`
WHERE gp_id IS NULL;


/*
#-----------------------------------------------------------------------------------
# 7) Austausch der Daten.
#-----------------------------------------------------------------------------------
*/


DELETE FROM dbp_data.artbew_scanning
WHERE dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 4 DAY) AND (DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 1 DAY));


INSERT INTO dbp_data.artbew_scanning (
    wup_id, mandant_id, bewart_id, gp_id, nb_id, art_id, dat, aktion_id,
    promo_fg, gtin_kasse, kasse_typ_id, vorgang_scanned, vorgang_keyed, vorgang_scanned_einzeln, vorgang_keyed_einzeln,
    anzahl_bon, anzahl_registriert
)
(SELECT
    wup_id,
    mandant_id,
    bewart_id,
    gp_id,
    nb_id,
    art_id,
    dat,
    aktion_id,
    promo_fg,
    CAST(COALESCE(gtin_kasse, -9999) AS NUMERIC) AS gtin_kasse,
    kasse_typ_id,
    vorgang_scanned,
    vorgang_keyed,
    vorgang_scanned_einzeln,
    vorgang_keyed_einzeln,
    anzahl_bon,
    CAST(anzahl_registriert AS INT64)
FROM dbp_data.`_ergebnis`);


/*
#------------------------------------------------------------------------------
# 8) Bteq beenden.
#------------------------------------------------------------------------------
*/
