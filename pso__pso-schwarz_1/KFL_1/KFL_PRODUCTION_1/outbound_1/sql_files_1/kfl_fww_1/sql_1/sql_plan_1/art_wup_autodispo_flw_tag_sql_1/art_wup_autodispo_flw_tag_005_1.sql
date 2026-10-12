CREATE TABLE IF NOT EXISTS dbp_etl.art_wup_autodispo_flw_tag_staging_1 (
    mandant_id INTEGER NOT NULL,
    kunde_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id_kunde INTEGER NOT NULL,
    nb_id_lieferant INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    we_bearbeitungszeit INTEGER,
    planlieferzeit INTEGER,
    kdis INTEGER,
    verkaufslistung_fg INTEGER,
    sa_af_fg INTEGER,
    udf_prognose_menge_ungesteuert NUMERIC(29, 3),
    udf_prognose_menge_gesteuert NUMERIC(29, 3),
    fur_prognose_menge_ungesteuert NUMERIC(29, 3),
    fur_prognose_menge_gesteuert NUMERIC(29, 3),
    fur_prognose_menge_max NUMERIC(29, 3),
    menge_abverkauf NUMERIC(29, 3),
    ret_bestand NUMERIC(29, 3),
    fur_bestand NUMERIC(29, 3),
    menge_we_offen NUMERIC(29, 3),
    menge_bv NUMERIC(29, 3),
    menge_ofc NUMERIC(29, 3),
    nullbestand_fg INTEGER,
    menge_preisabschriften NUMERIC(29, 3),
    menge_totalabschriften NUMERIC(29, 3),
    kollifaktor NUMERIC(29, 3),
    egalisierungsfaktor NUMERIC(29, 3),
    menge_einh_id STRING(10) COLLATE 'und:ci',
    servicelevel NUMERIC(29, 2),
    optik NUMERIC(29, 6),
    menge_we NUMERIC(29, 3),
    nullbestand_exc_fg INTEGER DEFAULT 0,
    display_art_id INTEGER,
    komponentenmenge NUMERIC(29, 4),
    menge_we_geplant NUMERIC(29, 3)
);


-- mandant_id=1;
-- 13.02.2025
INSERT INTO dbp_etl.art_wup_autodispo_flw_tag_staging_1 (
    mandant_id,
    kunde_id,
    wup_id,
    nb_id_kunde,
    nb_id_lieferant,
    art_id,
    dat,
    we_bearbeitungszeit,
    planlieferzeit,
    kdis,
    verkaufslistung_fg,
    sa_af_fg,
    udf_prognose_menge_ungesteuert,
    udf_prognose_menge_gesteuert,
    fur_prognose_menge_ungesteuert,
    fur_prognose_menge_gesteuert,
    fur_prognose_menge_max,
    menge_abverkauf,
    ret_bestand,
    fur_bestand,
    menge_we_offen,
    menge_bv,
    menge_ofc,
    nullbestand_fg,
    menge_preisabschriften,
    menge_totalabschriften,
    kollifaktor,
    egalisierungsfaktor,
    menge_einh_id,
    servicelevel,
    optik,
    menge_we,
    nullbestand_exc_fg,
    display_art_id,
    komponentenmenge, menge_we_geplant
)
(SELECT
    mandant_id,
    kunde_id,
    wup_id,
    nb_id_kunde,
    nb_id_lieferant,
    art_id,
    dat,
    we_bearbeitungszeit,
    planlieferzeit,
    kdis,
    verkaufslistung_fg,
    sa_af_fg,
   CASE
        WHEN basismenge_einh_id = 'KG'
            THEN umrech_faktor_marm
        ELSE 1
    END * udf_prognose_menge_ungesteuert ,
   CASE
        WHEN basismenge_einh_id = 'KG'
            THEN umrech_faktor_marm
        ELSE 1
    END * udf_prognose_menge_gesteuert ,
   CASE
        WHEN basismenge_einh_id = 'KG'
            THEN umrech_faktor_marm
        ELSE 1
    END * fur_prognose_menge_ungesteuert ,
   CASE
        WHEN basismenge_einh_id = 'KG'
            THEN umrech_faktor_marm
        ELSE 1
    END * fur_prognose_menge_gesteuert ,
   CASE
        WHEN basismenge_einh_id = 'KG'
            THEN umrech_faktor_marm
        ELSE 1
    END * fur_prognose_menge_max ,
   CASE
        WHEN basismenge_einh_id = 'KG'
            THEN umrech_faktor_marm
        ELSE 1
    END * menge_abverkauf ,
   CASE
        WHEN basismenge_einh_id = 'KG'
            THEN umrech_faktor_marm
        ELSE 1
    END * ret_bestand ,
   CASE
        WHEN basismenge_einh_id = 'KG'
            THEN umrech_faktor_marm
        ELSE 1
    END * fur_bestand ,
   CASE
        WHEN basismenge_einh_id = 'KG'
            THEN umrech_faktor_marm
        ELSE 1
    END * menge_we_offen ,
   CASE
        WHEN basismenge_einh_id = 'KG'
            THEN umrech_faktor_marm
        ELSE 1
    END * menge_bv ,
   CASE
        WHEN basismenge_einh_id = 'KG'
            THEN umrech_faktor_marm
        ELSE 1
    END * menge_ofc ,
    nullbestand_fg,
   CASE
        WHEN basismenge_einh_id = 'KG'
            THEN umrech_faktor_marm
        ELSE 1
    END * menge_preisabschriften ,
   CASE
        WHEN basismenge_einh_id = 'KG'
            THEN umrech_faktor_marm
        ELSE 1
    END * menge_totalabschriften ,
    kollifaktor,
   CASE
        WHEN basismenge_einh_id = 'KG'
            THEN umrech_faktor_marm
        ELSE 1
    END  AS egalfaktor,
    'ST' AS menge_einh_id,
    servicelevel,
    optik,
   CASE
        WHEN basismenge_einh_id = 'KG'
            THEN umrech_faktor_marm
        ELSE 1
    END * menge_we ,
    nullbestand_exc_fg,
    art_id_display,
    komponentenmenge,
   CASE
        WHEN basismenge_einh_id = 'KG'
            THEN umrech_faktor_marm
        ELSE 1
    END * menge_we_geplant 
FROM dbp_etl.art_wup_autodispo_flw_tag_temp_1
WHERE (
    mandant_id, wup_id) IN (
    SELECT (mandant_id, gp_id)
    FROM dbp_etl.art_wup_autodispo_flw_gp_temp_1
));


-- 13.02.2025
-- mandant_id=1;
INSERT INTO dbp_etl.art_wup_autodispo_flw_tag_staging_1 (
    mandant_id,
    kunde_id,
    wup_id,
    nb_id_kunde,
    nb_id_lieferant,
    art_id,
    dat,
    we_bearbeitungszeit,
    planlieferzeit,
    kdis,
    verkaufslistung_fg,
    sa_af_fg,
    udf_prognose_menge_ungesteuert,
    udf_prognose_menge_gesteuert,
    fur_prognose_menge_ungesteuert,
    fur_prognose_menge_gesteuert,
    fur_prognose_menge_max,
    menge_abverkauf,
    ret_bestand,
    fur_bestand,
    menge_we_offen,
    menge_bv,
    menge_ofc,
    nullbestand_fg,
    menge_preisabschriften,
    menge_totalabschriften,
    kollifaktor,
    egalisierungsfaktor,
    menge_einh_id,
    servicelevel,
    optik,
    menge_we,
    nullbestand_exc_fg,
    display_art_id,
    komponentenmenge, menge_we_geplant
)
(SELECT
    mandant_id,
    kunde_id,
    wup_id,
    nb_id_kunde,
    nb_id_lieferant,
    art_id,
    dat,
    we_bearbeitungszeit,
    planlieferzeit,
    kdis,
    verkaufslistung_fg,
    sa_af_fg,
    CASE
        WHEN basismenge_einh_id = 'ST'
            THEN umrech_faktor_ef
        ELSE 1
    END * udf_prognose_menge_ungesteuert ,
    CASE
        WHEN basismenge_einh_id = 'ST'
            THEN umrech_faktor_ef
        ELSE 1
    END * udf_prognose_menge_gesteuert ,
    CASE
        WHEN basismenge_einh_id = 'ST'
            THEN umrech_faktor_ef
        ELSE 1
    END * fur_prognose_menge_ungesteuert ,
    CASE
        WHEN basismenge_einh_id = 'ST'
            THEN umrech_faktor_ef
        ELSE 1
    END * fur_prognose_menge_gesteuert ,
    CASE
        WHEN basismenge_einh_id = 'ST'
            THEN umrech_faktor_ef
        ELSE 1
    END * fur_prognose_menge_max ,
    CASE
        WHEN basismenge_einh_id = 'ST'
            THEN umrech_faktor_ef
        ELSE 1
    END * menge_abverkauf ,
    CASE
        WHEN basismenge_einh_id = 'ST'
            THEN umrech_faktor_ef
        ELSE 1
    END * ret_bestand ,
    CASE
        WHEN basismenge_einh_id = 'ST'
            THEN umrech_faktor_ef
        ELSE 1
    END * fur_bestand ,
    CASE
        WHEN basismenge_einh_id = 'ST'
            THEN umrech_faktor_ef
        ELSE 1
    END * menge_we_offen ,
    CASE
        WHEN basismenge_einh_id = 'ST'
            THEN umrech_faktor_ef
        ELSE 1
    END * menge_bv ,
    CASE
        WHEN basismenge_einh_id = 'ST'
            THEN umrech_faktor_ef
        ELSE 1
    END * menge_ofc ,
    nullbestand_fg,
    CASE
        WHEN basismenge_einh_id = 'ST'
            THEN umrech_faktor_ef
        ELSE 1
    END * menge_preisabschriften ,
    CASE
        WHEN basismenge_einh_id = 'ST'
            THEN umrech_faktor_ef
        ELSE 1
    END * menge_totalabschriften ,
    kollifaktor,
    CASE
        WHEN basismenge_einh_id = 'ST'
            THEN umrech_faktor_ef
        ELSE 1
    END  AS egalfaktor,
    'KG' AS menge_einh_id,
    servicelevel,
    optik,
    CASE
        WHEN basismenge_einh_id = 'ST'
            THEN umrech_faktor_ef
        ELSE 1
    END * menge_we ,
    nullbestand_exc_fg,
    art_id_display,
     komponentenmenge,
    CASE
        WHEN basismenge_einh_id = 'ST'
            THEN umrech_faktor_ef
        ELSE 1
    END * menge_we_geplant 
FROM dbp_etl.art_wup_autodispo_flw_tag_temp_1
WHERE (
    mandant_id, wup_id) IN (
    SELECT (mandant_id, gp_id)
    FROM dbp_etl.art_wup_autodispo_flw_gp_temp_1
));


-- mandant_id=1;
-- 13.02.2025
INSERT INTO dbp_etl.art_wup_autodispo_flw_tag_staging_1 (
    mandant_id,
    kunde_id,
    wup_id,
    nb_id_kunde,
    nb_id_lieferant,
    art_id,
    dat,
    we_bearbeitungszeit,
    planlieferzeit,
    kdis,
    verkaufslistung_fg,
    sa_af_fg,
    udf_prognose_menge_ungesteuert,
    udf_prognose_menge_gesteuert,
    fur_prognose_menge_ungesteuert,
    fur_prognose_menge_gesteuert,
    fur_prognose_menge_max,
    menge_abverkauf,
    ret_bestand,
    fur_bestand,
    menge_we_offen,
    menge_bv,
    menge_ofc,
    nullbestand_fg,
    menge_preisabschriften,
    menge_totalabschriften,
    kollifaktor,
    egalisierungsfaktor,
    menge_einh_id,
    servicelevel,
    optik,
    menge_we,
    nullbestand_exc_fg,
    display_art_id,
    komponentenmenge, menge_we_geplant
)
(SELECT
    mandant_id,
    kunde_id,
    wup_id,
    nb_id_kunde,
    nb_id_lieferant,
    art_id,
    dat,
    we_bearbeitungszeit,
    planlieferzeit,
    kdis,
    verkaufslistung_fg,
    sa_af_fg,
    vk_brutto * udf_prognose_menge_ungesteuert,
    vk_brutto * udf_prognose_menge_gesteuert,
    vk_brutto * fur_prognose_menge_ungesteuert,
    vk_brutto * fur_prognose_menge_gesteuert,
    vk_brutto * fur_prognose_menge_max,
    vk_brutto * menge_abverkauf,
    vk_brutto * ret_bestand,
    vk_brutto * fur_bestand,
    vk_brutto * menge_we_offen,
    vk_brutto * menge_bv,
    vk_brutto * menge_ofc,
    nullbestand_fg,
    vk_brutto * menge_preisabschriften,
    vk_brutto * menge_totalabschriften,
    kollifaktor,
    vk_brutto AS egalfaktor,
    'EUR' AS menge_einh_id,
    servicelevel,
    optik,
    vk_brutto * menge_we,
    nullbestand_exc_fg,
    art_id_display,
     komponentenmenge,
    vk_brutto * menge_we_geplant 
FROM dbp_etl.art_wup_autodispo_flw_tag_temp_1
WHERE (
    mandant_id, wup_id) IN (
    SELECT (mandant_id, gp_id)
    FROM dbp_etl.art_wup_autodispo_flw_gp_temp_1
));


-- mandant_id=1;
-- 13.02.2025
INSERT INTO dbp_etl.art_wup_autodispo_flw_tag_staging_1 (
    mandant_id,
    kunde_id,
    wup_id,
    nb_id_kunde,
    nb_id_lieferant,
    art_id,
    dat,
    we_bearbeitungszeit,
    planlieferzeit,
    kdis,
    verkaufslistung_fg,
    sa_af_fg,
    udf_prognose_menge_ungesteuert,
    udf_prognose_menge_gesteuert,
    fur_prognose_menge_ungesteuert,
    fur_prognose_menge_gesteuert,
    fur_prognose_menge_max,
    menge_abverkauf,
    ret_bestand,
    fur_bestand,
    menge_we_offen,
    menge_bv,
    menge_ofc,
    nullbestand_fg,
    menge_preisabschriften,
    menge_totalabschriften,
    kollifaktor,
    egalisierungsfaktor,
    menge_einh_id,
    servicelevel,
    optik,
    menge_we,
    nullbestand_exc_fg,
    display_art_id,
    komponentenmenge, menge_we_geplant
)
(SELECT
    mandant_id,
    kunde_id,
    wup_id,
    nb_id_kunde,
    nb_id_lieferant,
    art_id,
    dat,
    we_bearbeitungszeit,
    planlieferzeit,
    kdis,
    verkaufslistung_fg,
    sa_af_fg,
    CASE
        WHEN COALESCE(kollifaktor, 0) > 0
            THEN 1 / kollifaktor 
        ELSE 1
    END * udf_prognose_menge_ungesteuert ,
    CASE
        WHEN COALESCE(kollifaktor, 0) > 0
            THEN 1 / kollifaktor 
        ELSE 1
    END * udf_prognose_menge_gesteuert ,
    CASE
        WHEN COALESCE(kollifaktor, 0) > 0
            THEN 1 / kollifaktor 
        ELSE 1
    END * fur_prognose_menge_ungesteuert ,
    CASE
        WHEN COALESCE(kollifaktor, 0) > 0
            THEN 1 / kollifaktor 
        ELSE 1
    END * fur_prognose_menge_gesteuert ,
    CASE
        WHEN COALESCE(kollifaktor, 0) > 0
            THEN 1 / kollifaktor 
        ELSE 1
    END * fur_prognose_menge_max ,
    CASE
        WHEN COALESCE(kollifaktor, 0) > 0
            THEN 1 / kollifaktor 
        ELSE 1
    END * menge_abverkauf ,
    CASE
        WHEN COALESCE(kollifaktor, 0) > 0
            THEN 1 / kollifaktor 
        ELSE 1
    END * ret_bestand ,
    CASE
        WHEN COALESCE(kollifaktor, 0) > 0
            THEN 1 / kollifaktor 
        ELSE 1
    END * fur_bestand ,
    CASE
        WHEN COALESCE(kollifaktor, 0) > 0
            THEN 1 / kollifaktor 
        ELSE 1
    END * menge_we_offen ,
    CASE
        WHEN COALESCE(kollifaktor, 0) > 0
            THEN 1 / kollifaktor 
        ELSE 1
    END * menge_bv ,
    CASE
        WHEN COALESCE(kollifaktor, 0) > 0
            THEN 1 / kollifaktor 
        ELSE 1
    END * menge_ofc ,
    nullbestand_fg,
    CASE
        WHEN COALESCE(kollifaktor, 0) > 0
            THEN 1 / kollifaktor 
        ELSE 1
    END * menge_preisabschriften ,
    CASE
        WHEN COALESCE(kollifaktor, 0) > 0
            THEN 1 / kollifaktor 
        ELSE 1
    END * menge_totalabschriften ,
    kollifaktor,
    CASE
        WHEN COALESCE(kollifaktor, 0) > 0
            THEN 1 / kollifaktor 
        ELSE 1
    END  AS egalfaktor,
    'KOLLI' AS menge_einh_id,
    servicelevel,
    optik,
    CASE
        WHEN COALESCE(kollifaktor, 0) > 0
            THEN 1 / kollifaktor 
        ELSE 1
    END * menge_we ,
    nullbestand_exc_fg,
    art_id_display,
     komponentenmenge,
    CASE
        WHEN COALESCE(kollifaktor, 0) > 0
            THEN 1 / kollifaktor 
        ELSE 1
    END * menge_we_geplant 
FROM dbp_etl.art_wup_autodispo_flw_tag_temp_1
WHERE (
    mandant_id, wup_id) IN (
    SELECT (mandant_id, gp_id)
    FROM dbp_etl.art_wup_autodispo_flw_gp_temp_1
));


INSERT INTO dbp_etl.art_wup_autodispo_flw_tag_staging_1 (
    mandant_id, kunde_id, wup_id, nb_id_kunde,
    nb_id_lieferant,
    art_id,
    dat,
    we_bearbeitungszeit,
    planlieferzeit,
    kdis,
    verkaufslistung_fg,
    sa_af_fg,
    udf_prognose_menge_ungesteuert,
    udf_prognose_menge_gesteuert,
    fur_prognose_menge_ungesteuert,
    fur_prognose_menge_gesteuert,
    fur_prognose_menge_max,
    menge_abverkauf,
    ret_bestand,
    fur_bestand,
    menge_we_offen,
    menge_bv,
    menge_ofc,
    nullbestand_fg,
    menge_preisabschriften,
    menge_totalabschriften,
    kollifaktor,
    egalisierungsfaktor,
    menge_einh_id,
    servicelevel,
    optik,
    menge_we,
    nullbestand_exc_fg,
    display_art_id,
    komponentenmenge,
    menge_we_geplant
)
(SELECT
    mandant_id,
    kunde_id,
    wup_id,
    nb_id_kunde,
    nb_id_lieferant,
    art_id,
    dat,
    we_bearbeitungszeit,
    planlieferzeit,
    kdis,
    verkaufslistung_fg,
    sa_af_fg,
    udf_prognose_menge_ungesteuert,
    udf_prognose_menge_gesteuert,
    fur_prognose_menge_ungesteuert,
    fur_prognose_menge_gesteuert,
    fur_prognose_menge_max,
    menge_abverkauf,
    ret_bestand,
    fur_bestand,
    menge_we_offen,
    menge_bv,
    menge_ofc,
    nullbestand_fg,
    menge_preisabschriften,
    menge_totalabschriften,
    kollifaktor,
    1 AS egalfaktor,
    'BME' AS menge_einh_id,
    servicelevel,
    optik,
    menge_we,
    nullbestand_exc_fg,
    art_id_display,
     komponentenmenge,
    menge_we_geplant
FROM dbp_etl.art_wup_autodispo_flw_tag_temp_1);


/*
Please just skip all the statements referring DBP_ETL_DATA_CLOUD_SYNC, because
we don't need it in the dual load processing nor in the native data supply. :)
*/
/*
INSERT INTO KFL_PRODUCTION.DBP_ETL_DATA_CLOUD_SYNC.t_cdc_art_wup_autodispo_flw_tag
(mandant_id,kunde_id,wup_id,nb_id_kunde,nb_id_lieferant,art_id,dat, log_operation,log_ts )

SELECT  mandant_id,kunde_id,wup_id,nb_id_kunde,nb_id_lieferant,art_id,dat, 'D' as log_operation, CURRENT_TIMESTAMP as log_ts
FROM KFL_PRODUCTION.DBP_ETL.art_wup_autodispo_flw_tag_staging_1
GROUP BY 1,2,3,4,5,6,7,8,9

*/


DELETE FROM dbp_data.art_wup_autodispo_flw_tag_1
WHERE (
    mandant_id, kunde_id, nb_id_kunde, art_id, dat) IN (
    SELECT (mandant_id, kunde_id, nb_id_kunde, art_id, dat)
    FROM (SELECT DISTINCT
        mandant_id,
        kunde_id,
        nb_id_kunde,
        art_id,
        dat
    FROM dbp_etl.art_wup_autodispo_flw_tag_staging_1) AS t0
);


/*
Please just skip all the statements referring DBP_ETL_DATA_CLOUD_SYNC, because
we don't need it in the dual load processing nor in the native data supply. :)
*/
/*
INSERT INTO KFL_PRODUCTION.DBP_ETL_DATA_CLOUD_SYNC.t_cdc_art_wup_autodispo_flw_tag
(mandant_id,kunde_id,wup_id,nb_id_kunde,nb_id_lieferant,art_id,dat, log_operation,log_ts )

SELECT  mandant_id,kunde_id,wup_id,nb_id_kunde,nb_id_lieferant,art_id,dat, 'I' as log_operation, CURRENT_TIMESTAMP as log_ts
FROM KFL_PRODUCTION.DBP_ETL.art_wup_autodispo_flw_tag_staging_1
GROUP BY 1,2,3,4,5,6,7,8,9

*/


INSERT INTO dbp_data.art_wup_autodispo_flw_tag_1 (
    mandant_id, kunde_id, wup_id, nb_id_kunde,
    nb_id_lieferant,
    art_id,
    dat,
    menge_einh_id,
    we_bearbeitungszeit,
    planlieferzeit,
    kdis,
    verkaufslistung_fg,
    sa_af_fg,
    udf_prognose_menge_gesteuert,
    udf_prognose_menge_ungesteuert,
    fur_prognose_menge_ungesteuert,
    fur_prognose_menge_gesteuert,
    fur_prognose_menge_max,
    menge_abverkauf,
    ret_bestand,
    fur_bestand,
    menge_we_offen,
    menge_bv,
    menge_ofc,
    nullbestand_fg,
    menge_preisabschriften,
    menge_totalabschriften,
    kollifaktor,
    egalisierungsfaktor,
    servicelevel,
    optik,
    menge_we,
    nullbestand_exc_fg,
    menge_we_geplant,
    display_art_id,
    komponentenmenge,
    td_update,
    td_insert
)
(SELECT
    mandant_id,
    kunde_id,
    wup_id,
    nb_id_kunde,
    nb_id_lieferant,
    art_id,
    dat,
    LEFT(menge_einh_id, 3) AS menge_einh_id,
    we_bearbeitungszeit,
    planlieferzeit,
    kdis,
    verkaufslistung_fg,
    sa_af_fg,
    udf_prognose_menge_gesteuert,
    udf_prognose_menge_ungesteuert,
    fur_prognose_menge_ungesteuert,
    fur_prognose_menge_gesteuert,
    fur_prognose_menge_max,
    menge_abverkauf,
    ret_bestand,
    fur_bestand,
    menge_we_offen,
    menge_bv,
    menge_ofc,
    nullbestand_fg,
    menge_preisabschriften,
    menge_totalabschriften,
    kollifaktor,
    egalisierungsfaktor,
    servicelevel,
    optik,
    menge_we,
    nullbestand_exc_fg,
    menge_we_geplant,
    display_art_id,
    komponentenmenge,
    CURRENT_TIMESTAMP(),
    CURRENT_TIMESTAMP()
FROM dbp_etl.art_wup_autodispo_flw_tag_staging_1);


--SPEC0271440 delete data for new reclassified storeNr


DELETE FROM dbp_data.art_wup_autodispo_flw_tag_1 AS F
WHERE EXISTS (
    SELECT 1
    FROM dbp_etl_process.wup_transfer_per_1 AS UMGL
    WHERE
        wup_id <> wup_id_neu
        AND F.mandant_id = mandant_id
        AND (
            wup_id_neu = F.kunde_id AND F.dat < dat_von
            OR wup_id = F.kunde_id AND F.dat >= dat_von
        )
);
