-- STEP 1
-- Korrekte neue Maerkte in der aktuellen Zeitreihe ermitteln. Nur von
-- Maerkten, die noch nicht angefasst worden sind.


CREATE OR REPLACE TEMPORARY TABLE _step1 AS
SELECT *
FROM dbp_etl_process.wup_transfer_per_2
WHERE
    mandant_id = 1
    AND wup_aenderung_grund_id <> 0
    AND (
        mandant_id, wup_id_neu) IN (
        SELECT (mandant_id, wup_id)
        FROM dbp_data.wup_2
        WHERE
            dat_von = DATE '2090-12-31'
            AND mandant_id = 1
    )
    AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis;


CREATE OR REPLACE TEMPORARY TABLE _step2 AS
SELECT
    A.adresse_id,
    B.wup_id_neu AS aktuell_wup_id,
    A.betriebsflaeche,
    A.bewertungskreis_id,
    A.breakevenumsatz,
    A.breitengrad,
    A.buchungskreis_id,
    DATE_SUB(B.dat_von, INTERVAL 1 DAY) AS dat_bis,
    A.dat_dayforce_ab,
    A.dat_eroeffnung,
    A.dat_eroeffnung_alt,
    A.dat_letzter_facelift,
    A.dat_letzter__facelift_von,
    A.dat_letzte_modernisierung_bis,
    A.dat_letzte_modernisierung_von,
    A.dat_qbm_umstellung,
    A.dat_umstellung_waage,
    A.dat_von,
    A.dat_von_alt,
    A.dat_wiedereroeffnung,
    A.eigentum_miete_kz,
    A.einwohner_anzahl,
    A.etagen_anz,
    A.filialtyp_id,
    A.fipo_pruef_objekt_id,
    A.fleischsystem,
    A.getraenkemarkt_fg,
    A.gf_id,
    A.gis_quali_id,
    A.gln_id,
    A.haupt_wup_id,
    A.hl_id,
    A.kassentyp,
    A.kreistyp_gruppe_id,
    A.kundenfaktor,
    A.laengengrad,
    A.land_id,
    A.lead_mwst,
    A.mandant_id,
    A.mandant_id_ursprung,
    A.nb_id,
    A.orig_wup_id,
    A.preiskategorie_food,
    A.preiskategorie_nonfood,
    A.qbm_id,
    A.ref_wup_id,
    A.region_id,
    A.sondermarkt,
    A.sortkategorie_food,
    A.sortkategorie_nonfood,
    A.systemrentabilitaet,
    A.td_insert,
    CURRENT_TIMESTAMP() AS td_update,
    A.uebernahme_von,
    A.umsatz_ea_eur,
    A.umsatz_ea_land,
    A.umsatz_erwartung_eur,
    A.umzugsfiliale_fg,
    A.verkaufsflaeche,
    A.verkaufsorganisation_id,
    A.vf_id,
    A.vkl_id,
    A.vs_id,
    A.vw_id,
    A.vz_wup_id,
    A.wm_id,
    B.wup_aenderung_grund_id,
    A.wup_id,
    A.wup_id_alt,
    A.wup_name_e,
    A.wup_name_v,
    A.wup_plz,
    A.wup_stadt,
    A.wup_standort,
    A.wup_str,
    A.wup_typ_id
FROM dbp_data.wup_2 AS A
INNER JOIN `_step1` AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id AND A.wup_id = A.aktuell_wup_id
WHERE B.wup_aenderung_grund_id IN (2, 3);


INSERT INTO `_step2`
(
    SELECT
        A.adresse_id,
        B.wup_id_neu AS aktuell_wup_id,
        A.betriebsflaeche,
        A.bewertungskreis_id,
        A.breakevenumsatz,
        A.breitengrad,
        B.buchungskreis_id_neu AS buchungskreis_id,
        B.dat_bis,
        A.dat_dayforce_ab,
        B.dat_von AS dat_eroeffnung,
        A.dat_von AS dat_eroeffnung_alt,
        A.dat_letzter_facelift,
        A.dat_letzter__facelift_von,
        A.dat_letzte_modernisierung_bis,
        A.dat_letzte_modernisierung_von,
        A.dat_qbm_umstellung,
        A.dat_umstellung_waage,
        B.dat_von,
        A.dat_von AS dat_von_alt,
        A.dat_wiedereroeffnung,
        A.eigentum_miete_kz,
        A.einwohner_anzahl,
        A.etagen_anz,
        A.filialtyp_id,
        A.fipo_pruef_objekt_id,
        A.fleischsystem,
        A.getraenkemarkt_fg,
        A.gf_id,
        A.gis_quali_id,
        A.gln_id,
        A.haupt_wup_id,
        A.hl_id,
        A.kassentyp,
        A.kreistyp_gruppe_id,
        A.kundenfaktor,
        A.laengengrad,
        A.land_id,
        A.lead_mwst,
        A.mandant_id,
        A.mandant_id_ursprung,
        A.nb_id,
        B.wup_id AS orig_wup_id,
        A.preiskategorie_food,
        A.preiskategorie_nonfood,
        A.qbm_id,
        A.ref_wup_id,
        A.region_id,
        A.sondermarkt,
        A.sortkategorie_food,
        A.sortkategorie_nonfood,
        A.systemrentabilitaet,
        CURRENT_TIMESTAMP() AS td_insert,
        CURRENT_TIMESTAMP() AS td_update,
        A.uebernahme_von,
        A.umsatz_ea_eur,
        A.umsatz_ea_land,
        A.umsatz_erwartung_eur,
        A.umzugsfiliale_fg,
        A.verkaufsflaeche,
        A.verkaufsorganisation_id,
        A.vf_id,
        A.vkl_id,
        A.vs_id,
        A.vw_id,
        A.vz_wup_id,
        A.wm_id,
        0 AS wup_aenderung_grund_id,
        B.wup_id_neu AS wup_id,
        A.wup_id_alt,
        A.wup_name_e,
        A.wup_name_v,
        A.wup_plz,
        A.wup_stadt,
        A.wup_standort,
        A.wup_str,
        A.wup_typ_id
    FROM dbp_data.wup_2 AS A
    INNER JOIN `_step1` AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.wup_id_neu
    WHERE B.wup_aenderung_grund_id IN (2, 3)
);


UPDATE `_step2` AS `_step20` SET
    wup_id_alt = CASE
        WHEN b.wup_aenderung_grund_id = 3
            THEN NULL
        ELSE b.wup_id
    END,
    dat_von_alt = b.dat_von,
    dat_eroeffnung_alt = b.dat_eroeffnung FROM (SELECT
    mandant_id,
    wup_id,
    dat_von,
    dat_eroeffnung,
    wup_aenderung_grund_id
FROM `_step2`
WHERE wup_aenderung_grund_id IN (2, 3)) AS b
WHERE `_step20`.mandant_id = b.mandant_id AND `_step20`.orig_wup_id = b.wup_id AND `_step20`.wup_aenderung_grund_id = 0;


UPDATE `_step2` AS `_step20` SET
    orig_wup_id = b.wup_id FROM (
    SELECT
        A.mandant_id,
        A.wup_id,
        t1.wup_id AS wup_id_upd
    FROM dbp_data.wup_2 AS A
    INNER JOIN (
        SELECT
            mandant_id,
            wup_id_alt,
            wup_id
        FROM `_step2`
        WHERE wup_id_alt IS NOT NULL
        GROUP BY
            mandant_id,
            wup_id,
            wup_id_alt
    ) AS t1_2 ON A.mandant_id = t1.mandant_id AND A.wup_id = t1.wup_id_alt
) AS b
WHERE `_step20`.mandant_id = b.mandant_id AND `_step20`.orig_wup_id = b.wup_id_upd;


-- Austausch!


DELETE FROM dbp_data.wup_2
WHERE (
    mandant_id, wup_id) IN (
    SELECT (mandant_id, wup_id)
    FROM `_step2`
);


INSERT INTO dbp_data.wup_2 (
    wup_id, nb_id, mandant_id, vw_id, vs_id, land_id, region_id, dat_von,
    wup_typ_id, wup_name_v, wup_name_e, wup_standort, wup_plz, wup_str, vf_id, vkl_id, hl_id, dat_bis, lead_mwst,
    uebernahme_von, breakevenumsatz, systemrentabilitaet, verkaufsflaeche, betriebsflaeche, fleischsystem,
    preiskategorie_food, preiskategorie_nonfood, sortkategorie_food, sortkategorie_nonfood, sondermarkt, ref_wup_id, wm_id,
    kassentyp, dat_qbm_umstellung, getraenkemarkt_fg, kundenfaktor, vz_wup_id, qbm_id, wup_id_alt,
    verkaufsorganisation_id, buchungskreis_id, dat_eroeffnung, bewertungskreis_id, wup_stadt, haupt_wup_id,
    kreistyp_gruppe_id, dat_umstellung_waage, dat_von_alt, dat_eroeffnung_alt, umzugsfiliale_fg, wup_aenderung_grund_id,
    gf_id, umsatz_ea_eur, umsatz_ea_land, breitengrad, laengengrad, gis_quali_id, gln_id, fipo_pruef_objekt_id, adresse_id,
    dat_dayforce_ab, mandant_id_ursprung, eigentum_miete_kz, dat_letzte_modernisierung_von, dat_letzte_modernisierung_bis,
    dat_letzter_facelift, dat_wiedereroeffnung, einwohner_anzahl, umsatz_erwartung_eur, dat_letzter__facelift_von,
    filialtyp_id, etagen_anz, orig_wup_id, aktuell_wup_id, td_update, td_insert
)
(SELECT
    wup_id,
    nb_id,
    mandant_id,
    vw_id,
    vs_id,
    land_id,
    region_id,
    dat_von,
    wup_typ_id,
    wup_name_v,
    wup_name_e,
    wup_standort,
    wup_plz,
    wup_str,
    vf_id,
    vkl_id,
    hl_id,
    dat_bis,
    lead_mwst,
    uebernahme_von,
    breakevenumsatz,
    systemrentabilitaet,
    verkaufsflaeche,
    betriebsflaeche,
    fleischsystem,
    preiskategorie_food,
    preiskategorie_nonfood,
    sortkategorie_food,
    sortkategorie_nonfood,
    sondermarkt,
    ref_wup_id,
    wm_id,
    kassentyp,
    dat_qbm_umstellung,
    getraenkemarkt_fg,
    kundenfaktor,
    vz_wup_id,
    qbm_id,
    wup_id_alt,
    verkaufsorganisation_id,
    buchungskreis_id,
    dat_eroeffnung,
    bewertungskreis_id,
    wup_stadt,
    haupt_wup_id,
    kreistyp_gruppe_id,
    dat_umstellung_waage,
    dat_von_alt,
    dat_eroeffnung_alt,
    umzugsfiliale_fg,
    wup_aenderung_grund_id,
    gf_id,
    umsatz_ea_eur,
    umsatz_ea_land,
    breitengrad,
    laengengrad,
    gis_quali_id,
    gln_id,
    fipo_pruef_objekt_id,
    adresse_id,
    dat_dayforce_ab,
    mandant_id_ursprung,
    eigentum_miete_kz,
    dat_letzte_modernisierung_von,
    dat_letzte_modernisierung_bis,
    dat_letzter_facelift,
    dat_wiedereroeffnung,
    einwohner_anzahl,
    umsatz_erwartung_eur,
    dat_letzter__facelift_von,
    filialtyp_id,
    etagen_anz,
    orig_wup_id,
    aktuell_wup_id,
    td_update,
    td_insert
FROM `_step2`);


UPDATE dbp_data.wup_2 SET
    aktuell_wup_id = t0.aktuell_wup_id FROM (
    SELECT
        mandant_id,
        orig_wup_id,
        aktuell_wup_id
    FROM `_step2`
    GROUP BY
        aktuell_wup_id,
        mandant_id,
        orig_wup_id
) AS t0
WHERE wup.mandant_id = t0.mandant_id AND wup.wup_id = t0.orig_wup_id;


-- STEP 2
-- Korrekte neue Maerkte in der zukuenftigen Zeitreihe ermitteln. Nur von
-- Maerkten, die noch nicht angefasst worden sind.


CREATE OR REPLACE TEMPORARY TABLE _step1 AS
SELECT *
FROM dbp_etl_process.wup_transfer_per_2
WHERE
    mandant_id = 1
    AND wup_aenderung_grund_id <> 0
    AND (
        mandant_id, wup_id_neu) IN (
        SELECT (mandant_id, wup_id)
        FROM dbp_data.wup_2
        WHERE
            dat_von = DATE '2090-12-31'
            AND mandant_id = 1
    )
    AND dat_von > CURRENT_DATE("Europe/Berlin");


CREATE OR REPLACE TEMPORARY TABLE _step2 AS
SELECT
    A.adresse_id,
    A.aktuell_wup_id,
    A.betriebsflaeche,
    A.bewertungskreis_id,
    A.breakevenumsatz,
    A.breitengrad,
    B.buchungskreis_id_neu AS buchungskreis_id,
    B.dat_bis,
    A.dat_dayforce_ab,
    B.dat_von AS dat_eroeffnung,
    NULL AS dat_eroeffnung_alt,
    A.dat_letzter_facelift,
    A.dat_letzter__facelift_von,
    A.dat_letzte_modernisierung_bis,
    A.dat_letzte_modernisierung_von,
    A.dat_qbm_umstellung,
    A.dat_umstellung_waage,
    B.dat_von,
    NULL AS dat_von_alt,
    A.dat_wiedereroeffnung,
    A.eigentum_miete_kz,
    A.einwohner_anzahl,
    A.etagen_anz,
    A.filialtyp_id,
    A.fipo_pruef_objekt_id,
    A.fleischsystem,
    A.getraenkemarkt_fg,
    A.gf_id,
    A.gis_quali_id,
    A.gln_id,
    A.haupt_wup_id,
    A.hl_id,
    A.kassentyp,
    A.kreistyp_gruppe_id,
    A.kundenfaktor,
    A.laengengrad,
    A.land_id,
    A.lead_mwst,
    A.mandant_id,
    A.mandant_id_ursprung,
    A.nb_id,
    A.orig_wup_id,
    A.preiskategorie_food,
    A.preiskategorie_nonfood,
    A.qbm_id,
    A.ref_wup_id,
    A.region_id,
    A.sondermarkt,
    A.sortkategorie_food,
    A.sortkategorie_nonfood,
    A.systemrentabilitaet,
    CURRENT_TIMESTAMP() AS td_insert,
    CURRENT_TIMESTAMP() AS td_update,
    A.uebernahme_von,
    A.umsatz_ea_eur,
    A.umsatz_ea_land,
    A.umsatz_erwartung_eur,
    A.umzugsfiliale_fg,
    A.verkaufsflaeche,
    A.verkaufsorganisation_id,
    A.vf_id,
    A.vkl_id,
    A.vs_id,
    A.vw_id,
    A.vz_wup_id,
    A.wm_id,
    B.wup_aenderung_grund_id,
    B.wup_id_neu AS wup_id,
    A.wup_id_alt,
    A.wup_name_e,
    A.wup_name_v,
    A.wup_plz,
    A.wup_stadt,
    A.wup_standort,
    A.wup_str,
    A.wup_typ_id
FROM dbp_data.wup_2 AS A
INNER JOIN `_step1`
    AS B ON A.mandant_id = B.mandant_id AND A.orig_wup_id = B.wup_id AND CURRENT_DATE("Europe/Berlin") BETWEEN A.dat_von
AND A.dat_bis;


-- Austausch!


DELETE FROM dbp_data.wup_2
WHERE (
    mandant_id, wup_id) IN (
    SELECT (mandant_id, wup_id)
    FROM `_step2`
);


INSERT INTO dbp_data.wup_2 (
    wup_id, nb_id, mandant_id, vw_id, vs_id, land_id, region_id, dat_von,
    wup_typ_id, wup_name_v, wup_name_e, wup_standort, wup_plz, wup_str, vf_id, vkl_id, hl_id, dat_bis, lead_mwst,
    uebernahme_von, breakevenumsatz, systemrentabilitaet, verkaufsflaeche, betriebsflaeche, fleischsystem,
    preiskategorie_food, preiskategorie_nonfood, sortkategorie_food, sortkategorie_nonfood, sondermarkt, ref_wup_id, wm_id,
    kassentyp, dat_qbm_umstellung, getraenkemarkt_fg, kundenfaktor, vz_wup_id, qbm_id, wup_id_alt,
    verkaufsorganisation_id, buchungskreis_id, dat_eroeffnung, bewertungskreis_id, wup_stadt, haupt_wup_id,
    kreistyp_gruppe_id, dat_umstellung_waage, dat_von_alt, dat_eroeffnung_alt, umzugsfiliale_fg, wup_aenderung_grund_id,
    gf_id, umsatz_ea_eur, umsatz_ea_land, breitengrad, laengengrad, gis_quali_id, gln_id, fipo_pruef_objekt_id, adresse_id,
    dat_dayforce_ab, mandant_id_ursprung, eigentum_miete_kz, dat_letzte_modernisierung_von, dat_letzte_modernisierung_bis,
    dat_letzter_facelift, dat_wiedereroeffnung, einwohner_anzahl, umsatz_erwartung_eur, dat_letzter__facelift_von,
    filialtyp_id, etagen_anz, orig_wup_id, aktuell_wup_id, td_update, td_insert
)
(SELECT
    wup_id,
    nb_id,
    mandant_id,
    vw_id,
    vs_id,
    land_id,
    region_id,
    dat_von,
    wup_typ_id,
    wup_name_v,
    wup_name_e,
    wup_standort,
    wup_plz,
    wup_str,
    vf_id,
    vkl_id,
    hl_id,
    dat_bis,
    lead_mwst,
    uebernahme_von,
    breakevenumsatz,
    systemrentabilitaet,
    verkaufsflaeche,
    betriebsflaeche,
    fleischsystem,
    preiskategorie_food,
    preiskategorie_nonfood,
    sortkategorie_food,
    sortkategorie_nonfood,
    sondermarkt,
    ref_wup_id,
    wm_id,
    kassentyp,
    dat_qbm_umstellung,
    getraenkemarkt_fg,
    kundenfaktor,
    vz_wup_id,
    qbm_id,
    wup_id_alt,
    verkaufsorganisation_id,
    buchungskreis_id,
    dat_eroeffnung,
    bewertungskreis_id,
    wup_stadt,
    haupt_wup_id,
    kreistyp_gruppe_id,
    dat_umstellung_waage,
    CAST(CAST(dat_von_alt AS STRING) AS DATE) AS dat_von_alt,
    CAST(CAST(dat_eroeffnung_alt AS STRING) AS DATE) AS dat_eroeffnung_alt,
    umzugsfiliale_fg,
    wup_aenderung_grund_id,
    gf_id,
    umsatz_ea_eur,
    umsatz_ea_land,
    breitengrad,
    laengengrad,
    gis_quali_id,
    gln_id,
    fipo_pruef_objekt_id,
    adresse_id,
    dat_dayforce_ab,
    mandant_id_ursprung,
    eigentum_miete_kz,
    dat_letzte_modernisierung_von,
    dat_letzte_modernisierung_bis,
    dat_letzter_facelift,
    dat_wiedereroeffnung,
    einwohner_anzahl,
    umsatz_erwartung_eur,
    dat_letzter__facelift_von,
    filialtyp_id,
    etagen_anz,
    orig_wup_id,
    aktuell_wup_id,
    td_update,
    td_insert
FROM `_step2`);


-- 04.02.2025, -dba-
-- Auf Wunsch von Alex sollen nun neu registrierte Maerkte mit ihrer Marktnummer
-- auch in aktuell_wup_id hinterlegt sein. orig_wup_id bleibt auf dem umgegliederten
-- Markt stehen.


UPDATE dbp_data.wup_2 SET
    aktuell_wup_id = wup.wup_id
WHERE wup_aenderung_grund_id < 0;


-- STEP 3
-- Zukuenftige Maerkte werden bei Erreichen des Datums aktiviert.


CREATE OR REPLACE TEMPORARY TABLE _upd AS
SELECT
    mandant_id,
    wup_id,
    orig_wup_id,
    aktuell_wup_id,
    DATE_SUB(dat_von, INTERVAL 1 DAY) AS dat_bis,
    -1 * wup_aenderung_grund_id AS wup_aenderung_grund_id
FROM dbp_data.wup_2
WHERE
    wup_aenderung_grund_id IN (-2, -3)
    AND mandant_id = 1
    AND CURRENT_DATE("Europe/Berlin") = dat_von;


CREATE OR REPLACE TEMPORARY TABLE _upd2 AS
SELECT
    A.mandant_id,
    B.wup_id,
    A.orig_wup_id,
    A.aktuell_wup_id,
    A.dat_von AS dat_von_alt,
    A.dat_eroeffnung AS dat_eroeffnung_alt
FROM dbp_data.wup_2 AS A
INNER JOIN `_upd` AS B ON A.mandant_id = B.mandant_id AND A.wup_id = B.orig_wup_id
WHERE
    A.wup_aenderung_grund_id IN (0)
    AND A.mandant_id = 1;


UPDATE dbp_data.wup_2 SET
    dat_eroeffnung_alt = b.dat_eroeffnung_alt,
    dat_von_alt = b.dat_von_alt
FROM `_upd2` AS b
WHERE wup.mandant_id = b.mandant_id AND wup.wup_id = b.orig_wup_id;


UPDATE dbp_data.wup_2 SET
    dat_bis = b.dat_bis,
    wup_aenderung_grund_id = b.wup_aenderung_grund_id
FROM `_upd` AS b
WHERE
    wup.mandant_id = b.mandant_id AND wup.wup_id = b.orig_wup_id AND wup.aktuell_wup_id = b.aktuell_wup_id AND wup.wup_aenderung_grund_id
    = 0;


UPDATE dbp_data.wup_2 SET
    aktuell_wup_id = b.wup_id,
    wup_aenderung_grund_id = 0,
    wup_id_alt = CASE
        WHEN wup.wup_aenderung_grund_id = -2
            THEN b.orig_wup_id
        ELSE NULL
    END
FROM `_upd` AS b
WHERE wup.mandant_id = b.mandant_id AND wup.wup_id = b.wup_id AND wup.wup_aenderung_grund_id IN (-2, -3);


UPDATE dbp_data.wup_2 SET
    aktuell_wup_id = b.wup_id
FROM `_upd` AS b
WHERE wup.mandant_id = b.mandant_id AND wup.orig_wup_id = b.orig_wup_id;
