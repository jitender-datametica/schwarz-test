CREATE OR REPLACE TABLE dbp_etl.kmo_artbew_bon_aktion_relevant_2 (
    mandant_id INTEGER NOT NULL,
    aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
    bewart_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    anz_aktion INTEGER NOT NULL
);


CREATE OR REPLACE TABLE dbp_etl.artbew_kmo_tmp_2 (
    wup_id INTEGER NOT NULL,
    mandant_id INTEGER NOT NULL,
    bewart_id INTEGER NOT NULL,
    bewart_det_id INTEGER NOT NULL,
    gp_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    aktion_id STRING(10) COLLATE 'und:ci' DEFAULT '          ' NOT NULL,
    promo_fg INTEGER DEFAULT 0 NOT NULL,
    ean_kasse INTEGER DEFAULT 0 NOT NULL,
    einkaufsorganisation_id INTEGER,
    herst_id INTEGER,
    mwst_id INTEGER NOT NULL,
    menge NUMERIC(29, 3),
    wrg_2 STRING(3) COLLATE 'und:ci',
    umsatz_netto NUMERIC(29, 4),
    diff_umsatz_netto_konz NUMERIC(29, 4),
    umsatz_mwst_betrag NUMERIC(29, 4),
    diff_umsatz_mwst_betrag_konz NUMERIC(29, 4),
    ek_brutto NUMERIC(29, 4),
    diff_ek_brutto_konz NUMERIC(29, 4),
    ek_netto NUMERIC(29, 4),
    diff_ek_netto_konz NUMERIC(29, 4),
    ek_nettonetto NUMERIC(29, 4),
    diff_ek_nettonetto_konz NUMERIC(29, 4),
    ek_kal_basis NUMERIC(29, 4),
    diff_ek_kal_basis_konz NUMERIC(29, 4),
    ek_mep NUMERIC(29, 4),
    diff_ek_mep_konz NUMERIC(29, 4),
    einstandspreis NUMERIC(29, 4),
    diff_einstandspreis_konz NUMERIC(29, 4),
    logkostenzuschlag NUMERIC(29, 4),
    diff_logkostenzuschlag_konz NUMERIC(29, 4),
    bezugsweg_id INTEGER,
    ek_netto_bnk NUMERIC(29, 4),
    diff_ek_netto_bnk_konz NUMERIC(29, 4),
    ek_netto_bnk_sachk NUMERIC(29, 4),
    diff_ek_netto_bnk_sachk_konz NUMERIC(29, 4),
    posten_id STRING(2) COLLATE 'und:ci',
    bq_findung_id INTEGER,
    ek_gld NUMERIC(29, 4),
    diff_ek_gld_konz NUMERIC(29, 4),
    pv_aktion NUMERIC(29, 4),
    pv_bby NUMERIC(29, 4),
    pv_kdn_bby NUMERIC(29, 4),
    pv_kdp_bby NUMERIC(29, 4),
    pv_aktion_bby NUMERIC(29, 4),
    pv_aktion_kdn_bby NUMERIC(29, 4),
    pv_aktion_kdp_bby NUMERIC(29, 4),
    pv_bonrabatt_bby NUMERIC(29, 4),
    pv_aktion_konz NUMERIC(29, 4),
    pv_bby_konz NUMERIC(29, 4),
    pv_kdn_bby_konz NUMERIC(29, 4),
    pv_kdp_bby_konz NUMERIC(29, 4),
    pv_aktion_bby_konz NUMERIC(29, 4),
    pv_aktion_kdn_bby_konz NUMERIC(29, 4),
    pv_aktion_kdp_bby_konz NUMERIC(29, 4),
    pv_bonrabatt_bby_konz NUMERIC(29, 4),
    standard_aktion_id STRING(10) COLLATE 'und:ci' NOT NULL,
    loyalty_berechtigt_fg INTEGER
);


-- regel gp_2 aus einkaufsinfosatz
-- anzahl infosätze (1 wenn nur ungültige vorhanden sind)

-- kurs_2 für die umrechnung von landeswährung in euro
-- ausstiegspunkt der bezugsquellenfindung

-- gp_2 nach bezugsquellenfindung
-- kreistyp_gruppe aus marktstamm.
-- warengruppe für zugriff auf vz_wup_wg_zu_per

-- vz aus kreisprozess für bezugsweg 4 oder wup_id für bezugsweg 1 für zugriff auf eina_2 und eord_2

-- anzahl orderbuch gepflegt
-- regel ekorg aus einkaufsinfosatz
-- ekorg nach bezugsquellenfindung

-- vz aus kreisprozess für bezugsweg 4 oder wup_id für bezugsweg 1 für zugriff auf eina_2 und eord_2
CREATE OR REPLACE
TABLE dbp_etl.kmo_wpuums_art_gp_wup_zu_2 (
    mandant_id INTEGER NOT NULL,
    art_id INTEGER NOT NULL,
    wup_id INTEGER NOT NULL,
    nb_id INTEGER NOT NULL,
    dat DATE NOT NULL,
    bezugsweg_id INTEGER,
    anz_ek_infosatz INTEGER,
    anz_ek_orderbuch INTEGER,
    bq_gp_id INTEGER,
    bq_ekorg INTEGER,
    bq_findung_id INTEGER,
    regel_gp_id INTEGER,
    regel_ekorg INTEGER,
    ref_wup_id INTEGER,
    ref_nb_id INTEGER,
    kreistyp_gruppe_id STRING(4) COLLATE 'und:ci',
    wg_id INTEGER,
    umrechnungskurs FLOAT64
);


UPDATE dbp_etl.kmo_artbew_bon_2 SET
    bewart_det_id = 888888
WHERE TRUE;


UPDATE dbp_etl.kmo_artbew_bon_2 SET
    bewart_det_id = 100121 FROM (
    SELECT
        mandant_id,
        bon_id,
        bon_zeile,
        kl_art_id,
        wup_id,
        dat_booking
    FROM dbp_etl.`_zwischen1_2`
    WHERE important = 'A'
    GROUP BY
        mandant_id,
        bon_id,
        dat_booking,
        wup_id,
        kl_art_id,
        bon_zeile
) AS b
WHERE
    kmo_artbew_bon.wup_id = b.wup_id AND kmo_artbew_bon.mandant_id = b.mandant_id AND kmo_artbew_bon.dat_booking = b.dat_booking
    AND kmo_artbew_bon.kl_art_id = b.kl_art_id AND kmo_artbew_bon.bon_id = b.bon_id AND kmo_artbew_bon.bon_zeile = b.bon_zeile;


UPDATE dbp_etl.kmo_artbew_bon_2 SET
    bewart_det_id = 100121 FROM (
    SELECT
        mandant_id,
        bon_id,
        bon_zeile,
        kl_art_id,
        wup_id,
        dat_booking
    FROM dbp_etl.`_zwischen2`
    WHERE important = 'A'
    GROUP BY
        mandant_id,
        bon_id,
        dat_booking,
        wup_id,
        kl_art_id,
        bon_zeile
) AS b
WHERE
    kmo_artbew_bon.wup_id = b.wup_id AND kmo_artbew_bon.mandant_id = b.mandant_id AND kmo_artbew_bon.dat_booking = b.dat_booking
    AND kmo_artbew_bon.kl_art_id = b.kl_art_id AND kmo_artbew_bon.bon_id = b.bon_id AND kmo_artbew_bon.bon_zeile = b.bon_zeile;


UPDATE dbp_etl.kmo_artbew_bon_2 SET
    bewart_det_id = 100111 FROM (
    SELECT
        mandant_id,
        bon_id,
        bon_zeile,
        kl_art_id,
        wup_id,
        dat_booking
    FROM dbp_etl.`_zwischen1_2`
    WHERE important = 'B'
    GROUP BY
        mandant_id,
        bon_id,
        dat_booking,
        wup_id,
        kl_art_id,
        bon_zeile
) AS b
WHERE
    kmo_artbew_bon.wup_id = b.wup_id AND kmo_artbew_bon.mandant_id = b.mandant_id AND kmo_artbew_bon.dat_booking = b.dat_booking
    AND kmo_artbew_bon.kl_art_id = b.kl_art_id AND kmo_artbew_bon.bon_id = b.bon_id AND kmo_artbew_bon.bon_zeile = b.bon_zeile AND kmo_artbew_bon.wg_id = 822;


UPDATE dbp_etl.kmo_artbew_bon_2 SET
    bewart_det_id = 100111 FROM (
    SELECT
        mandant_id,
        bon_id,
        bon_zeile,
        kl_art_id,
        wup_id,
        dat_booking
    FROM dbp_etl.`_zwischen2`
    WHERE important = 'B'
    GROUP BY
        mandant_id,
        bon_id,
        dat_booking,
        wup_id,
        kl_art_id,
        bon_zeile
) AS b
WHERE
    kmo_artbew_bon.wup_id = b.wup_id AND kmo_artbew_bon.mandant_id = b.mandant_id AND kmo_artbew_bon.dat_booking = b.dat_booking
    AND kmo_artbew_bon.kl_art_id = b.kl_art_id AND kmo_artbew_bon.bon_id = b.bon_id AND kmo_artbew_bon.bon_zeile = b.bon_zeile AND kmo_artbew_bon.wg_id = 822;


CREATE OR REPLACE TEMPORARY TABLE _track_personal AS
SELECT
    A.mandant_id,
    A.bon_id,
    A.bon_zeile,
    A.bon_dat,
    A.wup_id,
    A.promotion_art,
    MAX(b.anz) AS anz,
    COUNT(*) AS anz_zeilen,
    MAX(b.bonrabatt) AS bonrabatt
FROM dbp_etl.bd_for_promotion_2 AS A
INNER JOIN (
    SELECT
        mandant_id,
        bon_id,
        bon_zeile,
        bon_dat,
        wup_id,
        COUNT(DISTINCT promotion_art) AS anz,
        MAX(CASE
            WHEN konditionsart_id IN ('ZBON', 'ZBOV')
                THEN 1
            ELSE 0
        END) AS bonrabatt
    FROM dbp_etl.bd_for_promotion_2
    WHERE konditionsart_id NOT IN ('ZRT3', 'ZTAG', 'ZGEB')
    GROUP BY
        mandant_id,
        bon_id,
        bon_zeile,
        bon_dat,
        wup_id
) AS b
    ON
        A.mandant_id = b.mandant_id AND A.bon_id = b.bon_id AND A.bon_zeile = b.bon_zeile AND A.bon_dat = b.bon_dat
        AND A.wup_id = b.wup_id
WHERE (A.mandant_id, A.bon_id, A.bon_zeile, A.bon_dat, A.wup_id) IN (SELECT (
    mandant_id, bon_id, bon_zeile, bon_dat,
    wup_id
)
FROM dbp_etl.bd_for_promotion_2
WHERE promotion_art = 'PERSONAL'
GROUP BY mandant_id,
bon_id,
bon_zeile,
bon_dat,
wup_id)
AND A.konditionsart_id NOT IN ('ZRT3', 'ZTAG', 'ZGEB')
GROUP BY
    A.mandant_id,
    A.bon_id,
    A.bon_zeile,
    A.bon_dat,
    A.wup_id,
    A.promotion_art;


-- 1. Update fuer 100231


UPDATE dbp_etl.kmo_artbew_bon_2 SET
    bewart_det_id = 100231 FROM (
    SELECT
        mandant_id,
        bon_id,
        bon_zeile,
        wup_id,
        bon_dat
    FROM `_track_personal`
    WHERE promotion_art = 'CUSTOMER'
    GROUP BY
        mandant_id,
        bon_id,
        bon_zeile,
        bon_dat,
        wup_id
) AS b
WHERE
    kmo_artbew_bon.wup_id = b.wup_id AND kmo_artbew_bon.mandant_id = b.mandant_id AND kmo_artbew_bon.dat_booking = b.bon_dat
    AND kmo_artbew_bon.bon_id = b.bon_id AND kmo_artbew_bon.bon_zeile = b.bon_zeile AND kmo_artbew_bon.bewart_det_id
    = 888888 AND kmo_artbew_bon.wg_id = 822;


-- 2. Update fuer 100221


UPDATE dbp_etl.kmo_artbew_bon_2 SET
    bewart_det_id = 100221 FROM (
    SELECT
        mandant_id,
        bon_id,
        bon_zeile,
        wup_id,
        bon_dat
    FROM `_track_personal`
    WHERE promotion_art = 'COMMON'
    GROUP BY
        mandant_id,
        bon_id,
        bon_zeile,
        bon_dat,
        wup_id
) AS b
WHERE
    kmo_artbew_bon.wup_id = b.wup_id AND kmo_artbew_bon.mandant_id = b.mandant_id AND kmo_artbew_bon.dat_booking = b.bon_dat
    AND kmo_artbew_bon.bon_id = b.bon_id AND kmo_artbew_bon.bon_zeile = b.bon_zeile AND kmo_artbew_bon.bewart_det_id
    = 888888 AND kmo_artbew_bon.wg_id = 822;


-- 3. Update fuer 100211


UPDATE dbp_etl.kmo_artbew_bon_2 SET
    bewart_det_id = 100211 FROM (
    SELECT
        mandant_id,
        bon_id,
        bon_zeile,
        wup_id,
        bon_dat
    FROM `_track_personal`
    WHERE promotion_art = 'PERSONAL_SMP'
    GROUP BY
        mandant_id,
        bon_id,
        bon_zeile,
        bon_dat,
        wup_id
) AS b
WHERE
    kmo_artbew_bon.wup_id = b.wup_id AND kmo_artbew_bon.mandant_id = b.mandant_id AND kmo_artbew_bon.dat_booking = b.bon_dat
    AND kmo_artbew_bon.bon_id = b.bon_id AND kmo_artbew_bon.bon_zeile = b.bon_zeile AND kmo_artbew_bon.bewart_det_id
    = 888888 AND kmo_artbew_bon.aktion_id <> '' AND kmo_artbew_bon.wg_id = 822;


UPDATE dbp_etl.kmo_artbew_bon_2 SET
    bewart_det_id = 100211 FROM (
    SELECT
        mandant_id,
        bon_id,
        bon_zeile,
        wup_id,
        bon_dat
    FROM `_track_personal`
    WHERE
        promotion_art = 'PERSONAL' AND anz = 1
        OR promotion_art = 'PERSONAL' AND bonrabatt = 1
    GROUP BY
        mandant_id,
        bon_id,
        bon_zeile,
        bon_dat,
        wup_id
) AS b
WHERE
    kmo_artbew_bon.wup_id = b.wup_id AND kmo_artbew_bon.mandant_id = b.mandant_id AND kmo_artbew_bon.dat_booking = b.bon_dat
    AND kmo_artbew_bon.bon_id = b.bon_id AND kmo_artbew_bon.bon_zeile = b.bon_zeile AND kmo_artbew_bon.bewart_det_id
    = 888888 AND kmo_artbew_bon.aktion_id <> '' AND kmo_artbew_bon.wg_id = 822 AND kmo_artbew_bon.kundenkarte_id
    IS NOT NULL;


UPDATE dbp_etl.kmo_artbew_bon_2 SET
    bewart_det_id = 100241 FROM (
    SELECT
        mandant_id,
        bon_id,
        bon_zeile,
        wup_id,
        bon_dat
    FROM `_track_personal`
    WHERE
        promotion_art = 'PERSONAL'
        AND anz_zeilen > 1
        AND anz = 1
        AND bonrabatt = 0
    GROUP BY
        mandant_id,
        bon_id,
        bon_zeile,
        bon_dat,
        wup_id
) AS b
WHERE
    kmo_artbew_bon.wup_id = b.wup_id AND kmo_artbew_bon.mandant_id = b.mandant_id AND kmo_artbew_bon.dat_booking = b.bon_dat
    AND kmo_artbew_bon.bon_id = b.bon_id AND kmo_artbew_bon.bon_zeile = b.bon_zeile AND kmo_artbew_bon.bewart_det_id
    = 888888 AND kmo_artbew_bon.aktion_id <> '' AND kmo_artbew_bon.wg_id = 822;


-- 4. Update fuer 100131


UPDATE dbp_etl.kmo_artbew_bon_2 SET
    bewart_det_id = 100131 FROM (
    SELECT
        mandant_id,
        bon_id,
        bon_zeile,
        wup_id,
        bon_dat
    FROM `_track_personal`
    WHERE
        promotion_art IN ('PERSONAL', 'PERSONAL_SMP', 'CUSTOMER', 'COMMON')
        AND bonrabatt = 1
    GROUP BY
        mandant_id,
        bon_id,
        bon_zeile,
        bon_dat,
        wup_id
) AS b
WHERE
    kmo_artbew_bon.wup_id = b.wup_id AND kmo_artbew_bon.mandant_id = b.mandant_id AND kmo_artbew_bon.dat_booking = b.bon_dat
    AND kmo_artbew_bon.bon_id = b.bon_id AND kmo_artbew_bon.bon_zeile = b.bon_zeile AND kmo_artbew_bon.bewart_det_id
    = 888888 AND kmo_artbew_bon.aktion_id = '' AND kmo_artbew_bon.wg_id = 822;


-- 5. Update fuer 100121


UPDATE dbp_etl.kmo_artbew_bon_2 SET
    bewart_det_id = 100121 FROM (
    SELECT
        mandant_id,
        bon_id,
        bon_zeile,
        wup_id,
        bon_dat
    FROM `_track_personal`
    WHERE promotion_art IN ('PERSONAL_SMP')
    GROUP BY
        mandant_id,
        bon_id,
        bon_zeile,
        bon_dat,
        wup_id
) AS b
WHERE
    kmo_artbew_bon.wup_id = b.wup_id AND kmo_artbew_bon.mandant_id = b.mandant_id AND kmo_artbew_bon.dat_booking = b.bon_dat
    AND kmo_artbew_bon.bon_id = b.bon_id AND kmo_artbew_bon.bon_zeile = b.bon_zeile AND kmo_artbew_bon.bewart_det_id
    = 888888 AND kmo_artbew_bon.aktion_id = '' AND kmo_artbew_bon.wg_id = 822;


-- 6. Update fuer 100211


UPDATE dbp_etl.kmo_artbew_bon_2 SET
    bewart_det_id = 100211 FROM (
    SELECT
        mandant_id,
        bon_id,
        bon_zeile,
        wup_id,
        bon_dat
    FROM `_track_personal`
    GROUP BY
        mandant_id,
        bon_id,
        bon_zeile,
        bon_dat,
        wup_id
) AS b
WHERE
    kmo_artbew_bon.wup_id = b.wup_id AND kmo_artbew_bon.mandant_id = b.mandant_id AND kmo_artbew_bon.dat_booking = b.bon_dat
    AND kmo_artbew_bon.bon_id = b.bon_id AND kmo_artbew_bon.bon_zeile = b.bon_zeile AND kmo_artbew_bon.bewart_det_id
    = 888888 AND kmo_artbew_bon.aktion_id <> '' AND kmo_artbew_bon.wg_id = 822;


--- Interimslogik


CREATE OR REPLACE TABLE dbp_etl.dd_test_2 LIKE dbp_etl_process.artbew_pv_subset_2;


ALTER TABLE dbp_etl.dd_test_2
ADD COLUMN IF NOT EXISTS aktionsart_id STRING(1000),
ADD COLUMN IF NOT EXISTS aktionsart_bez STRING(1000),
ADD COLUMN IF NOT EXISTS aktion_typ_id_2 STRING(1000),
ADD COLUMN IF NOT EXISTS aktion_typ_bez STRING(1000),
ADD COLUMN IF NOT EXISTS aktionsart_std STRING(1000),
ADD COLUMN IF NOT EXISTS aktionsart_bez_std STRING(1000);


CREATE OR REPLACE TABLE dbp_etl.bd_for_promotion_2 AS
SELECT *
FROM dbp_ods.ods_promotion_2
WHERE mandant_id > 1;


UPDATE dbp_etl.bd_for_promotion_2 SET
    promotion_art = 'PERSONAL'
WHERE promotion_art = 'XTRA';


CREATE OR REPLACE TEMPORARY TABLE _test AS
SELECT
    OP.bon_id,
    OP.wup_id,
    OP.mandant_id,
    OP.bon_dat,
    OP.kl_art_id,
    b.art_id,
    OP.bon_zeile,
    OP.bonuskauf_id,
    OP.customer_promotion_fg,
    OP.promotion_art,
    ab.aktionsart_id,
    C.aktionsart_bez,
    ab.aktion_typ_id,
    D.aktion_typ_bez
FROM dbp_etl.bd_for_promotion_2 AS OP
INNER JOIN (
    SELECT
        mandant_id,
        kl_art_id,
        MAX(art_id) AS art_id
    FROM dbp_data.art_2
    GROUP BY
        mandant_id,
        kl_art_id
) AS b ON OP.mandant_id = b.mandant_id AND OP.kl_art_id = b.kl_art_id
LEFT JOIN (
    SELECT
        B.mandant_id,
        B.bonuskauf_id,
        A.aktion_typ_id,
        A.aktionsart_id
    FROM dbp_data.aktion_2 AS A
    LEFT JOIN dbp_data.l_bonuskauf_2 AS B ON A.aktion_id = B.aktion_id AND A.mandant_id = B.mandant_id
    GROUP BY
        A.aktionsart_id,
        A.aktion_typ_id,
        B.mandant_id,
        B.bonuskauf_id
) AS ab ON OP.bonuskauf_id = ab.bonuskauf_id AND OP.mandant_id = ab.mandant_id
LEFT JOIN dbp_data.aktionsart_spr_zu_2 AS C ON OP.mandant_id = C.mandant_id AND ab.aktionsart_id = C.aktionsart_id

LEFT JOIN dbp_data.l_aktion_typ_2 AS D ON OP.mandant_id = D.mandant_id AND ab.aktion_typ_id = D.aktion_typ_id

GROUP BY
    OP.mandant_id,
    OP.bon_id,
    OP.wup_id,
    OP.bon_zeile,
    OP.bonuskauf_id,
    OP.kl_art_id,
    OP.bon_dat,
    OP.customer_promotion_fg,
    OP.promotion_art,
    b.art_id,
    ab.aktion_typ_id,
    ab.aktionsart_id,
    C.aktionsart_bez,
    D.aktion_typ_bez;


insert into dbp_etl.dd_test_2 (
    mandant_id,
    wup_id,
    lkp_nb_id,
    lkp_art_id,
    lkp_posten_id,
    dat_booking,
    lkp_mwst,
    lkp_mwst_id,
    lkp_wrg,
    lkp_umrechnungskurs,
    promo_fg,
    ean_kasse,
    aktion_id,
    kundenkarte_id,
    kundenkarte_typ_id,
    bonuskauf_id,
    aktion_typ_id,
    konditionsart_id,
    vk_aktion_brutto,
    vk_brutto,
    bonuskauf_id_lb,
    bde_kundenkarte_id,
    bewart_det_id,
    customer_promotion_fg,
    promotion_art,
    betrag_promo_brutto_bby,
    betrag_promo_brutto_kdn,
    betrag_promo_brutto_kdp,
    betrag_promo_brutto_null,
    umsatz_brutto_,
    menge_,
    umsatz_promotion_brutto_,
    pv_aktion,
    pv_bby,
    pv_kdn_bby,
    pv_kdp_bby,
    pv_aktion_bby,
    pv_aktion_kdn_bby,
    pv_aktion_kdp_bby,
    pv_bonrabatt_bby,
    important,
    standard_aktion_id,
    loyalty_berechtigt_fg,
    aktionsart_id,  --dkn
    aktionsart_bez,
    aktion_typ_id_2,
    aktion_typ_bez,
    aktionsart_std,
    aktionsart_bez_std
)
select
    mandant_id,
    wup_id,
    lkp_nb_id,
    lkp_art_id,
    lkp_posten_id,
    dat_booking,
    lkp_mwst,
    lkp_mwst_id,
    lkp_wrg,
    lkp_umrechnungskurs,
    promo_fg,
    ean_kasse,
    aktion_id,
    kundenkarte_id,
    kundenkarte_typ_id,
    bonuskauf_id,
    aktion_typ_id,
    konditionsart_id,
    vk_aktion_brutto as vk_aktion_brutto,
    vk_brutto as vk_brutto,
    bonuskauf_id_lb,
    bde_kundenkarte_id,
    bewart_det_id,
    customer_promotion_fg,
    promotion_art,
    sum(betrag_promo_brutto_bby) as betrag_promo_brutto_bby,
    sum(betrag_promo_brutto_kdn) as betrag_promo_brutto_kdn,
    sum(betrag_promo_brutto_kdp) as betrag_promo_brutto_kdp,
    sum(betrag_promo_brutto_null) as betrag_promo_brutto_null,
    sum(umsatz_brutto) as umsatz_brutto_,
    sum(menge) as menge_,
    sum(umsatz_promotion_brutto) as umsatz_promotion_brutto_,
    sum(0) as pv_aktion,
    sum(0) as pv_bby,
    sum(0) as pv_kdn_bby,
    sum(0) as pv_kdp_bby,
    sum(0) as pv_aktion_bby,
    sum(0) as pv_aktion_kdn_bby,
    sum(0) as pv_aktion_kdp_bby,
    sum(0) as pv_bonrabatt_bby,
    important,
    standard_aktion_id,
    loyalty_berechtigt_fg,
    aktionsart_id,  --dkn
    aktionsart_bez,
    aktion_typ_id_2,
    aktion_typ_bez,
    aktionsart_std,
    aktionsart_bez_std
from (
    select
        z.mandant_id,
        z.bon_id,
        z.wup_id,
        z.lkp_nb_id,
        z.lkp_art_id,
        z.lkp_posten_id,
        z.dat_booking,
        z.bon_zeile,
        z.umsatz_brutto,
        z.menge,
        z.lkp_mwst,
        z.lkp_mwst_id,
        z.lkp_wrg,
        z.lkp_umrechnungskurs,
        coalesce(promotion_brutto, 0) as umsatz_promotion_brutto,
        case
            when
                coalesce(promotion_brutto, 0) <> 0 and --CORRECTED 
                z.bonuskauf_id is not null and
                CAST(z.bonuskauf_id AS INT64) <> 0 --CORRECTED 
                then 1
            else 0
        end as promo_fg,
        z.ean_kasse,
        case
            when z.aktion_typ_id = 'KDB'
                then ''
            when
                z.dat_booking >= CAST(x.dat AS DATE) and --CORRECTED 
                p.aktion_id <> ''
                then p.aktion_id
            else z.aktion_id
        end aktion_id,
        z.kundenkarte_id,
        z.kundenkarte_typ_id,
        z.bonuskauf_id,
        z.aktion_typ_id,
        z.vk_aktion_brutto,
        z.vk_brutto,
        z.betrag_promo_brutto_bby,
        z.betrag_promo_brutto_kdn,
        z.betrag_promo_brutto_kdp,
        z.betrag_promo_brutto_null,
        z.konditionsart_id,
        z.bonuskauf_id_lb,
        z.bde_kundenkarte_id,
        z.customer_promotion_fg,
        z.promotion_art,
        z.important,
        z.bewart_det_id,
        z.standard_aktion_id,
        z.loyalty_berechtigt_fg,
        xxxxx.aktionsart_id,
        xxxxx.aktionsart_bez,
        xxxxx.aktion_typ_id as aktion_typ_id_2,
        xxxxx.aktion_typ_bez,
        yyyyy.aktionsart_id as aktionsart_std,
        yyyyy.aktionsart_bez as aktionsart_bez_std
    from dbp_etl.kmo_artbew_bon_2 z
    left join (
        select
            a.mandant_id,
            a.aktion_id,
            a.aktionsart_id,
            b.aktionsart_bez
        from dbp_data.aktion_2 a
        join dbp_data.aktionsart_spr_zu_2 b
            on
                a.mandant_id = b.mandant_id and
                a.aktionsart_id = b.aktionsart_id and
                b.spr_id = 22
    ) yyyyy
        on
            z.mandant_id = yyyyy.mandant_id and
            z.standard_aktion_id = yyyyy.aktion_id
    left join _test xxxxx
        on
            z.bon_id = xxxxx.bon_id and
            z.wup_id = xxxxx.wup_id and
            z.mandant_id = xxxxx.mandant_id and
            z.dat_booking = xxxxx.bon_dat and
            z.kl_art_id = xxxxx.kl_art_id and
            z.bon_zeile = xxxxx.bon_zeile
    join dbp_etl_process.kpos_bon_bby_dates_2 x
        on z.mandant_id = x.mandant_id
    left join (
        select
            a.mandant_id,
            a.bon_id,
            a.dat_booking,
            a.bon_zeile,
            max(coalesce(b.aktion_id, '')) as aktion_id,
            sum(a.umsatz_brutto) as promotion_brutto
        from dbp_etl.kmo_artbew_bon_promotion_2 a
        left join dbp_data.l_bonuskauf_2 b
            on
                a.mandant_id = b.mandant_id and
                a.bonuskauf_id = b.bonuskauf_id and
                a.dat_booking between b.dat_von and b.dat_bis
        group by 1, 2, 3, 4
    ) p
        on
            z.mandant_id = p.mandant_id and
            z.bon_id = p.bon_id and
            z.dat_booking = p.dat_booking and
            z.bon_zeile = p.bon_zeile
    group by all
)
group by all;

TRUNCATE TABLE dbp_etl_process.artbew_pv_subset_2;


insert into dbp_etl_process.artbew_pv_subset_2 (
    mandant_id,
    wup_id,
    lkp_nb_id,
    lkp_art_id,
    lkp_posten_id,
    dat_booking,
    lkp_mwst,
    lkp_mwst_id,
    lkp_wrg,
    lkp_umrechnungskurs,
    promo_fg,
    ean_kasse,
    aktion_id,
    kundenkarte_id,
    kundenkarte_typ_id,
    bonuskauf_id,
    aktion_typ_id,
    konditionsart_id,
    vk_aktion_brutto,
    vk_brutto,
    bonuskauf_id_lb,
    bde_kundenkarte_id,
    bewart_det_id,
    customer_promotion_fg,
    promotion_art,
    betrag_promo_brutto_bby,
    betrag_promo_brutto_kdn,
    betrag_promo_brutto_kdp,
    betrag_promo_brutto_null,
    umsatz_brutto_,
    menge_,
    umsatz_promotion_brutto_,
    pv_aktion,
    pv_bby,
    pv_kdn_bby,
    pv_kdp_bby,
    pv_aktion_bby,
    pv_aktion_kdn_bby,
    pv_aktion_kdp_bby,
    pv_bonrabatt_bby,
    important,
    standard_aktion_id,
    loyalty_berechtigt_fg
)
select
    mandant_id,
    wup_id,
    lkp_nb_id,
    lkp_art_id,
    lkp_posten_id,
    dat_booking,
    lkp_mwst,
    lkp_mwst_id,
    lkp_wrg,
    lkp_umrechnungskurs,
    promo_fg,
    ean_kasse,
    aktion_id,
    kundenkarte_id,
    kundenkarte_typ_id,
    bonuskauf_id,
    aktion_typ_id,
    konditionsart_id,
    vk_aktion_brutto as vk_aktion_brutto,
    vk_brutto as vk_brutto,
    bonuskauf_id_lb,
    bde_kundenkarte_id,
    bewart_det_id,
    customer_promotion_fg,
    promotion_art,
    sum(betrag_promo_brutto_bby) as betrag_promo_brutto_bby,
    sum(betrag_promo_brutto_kdn) as betrag_promo_brutto_kdn,
    sum(betrag_promo_brutto_kdp) as betrag_promo_brutto_kdp,
    sum(betrag_promo_brutto_null) as betrag_promo_brutto_null,
    sum(umsatz_brutto) as umsatz_brutto_,
    sum(menge) as menge_,
    sum(umsatz_promotion_brutto) as umsatz_promotion_brutto_,
    sum(0) as pv_aktion,
    sum(0) as pv_bby,
    sum(0) as pv_kdn_bby,
    sum(0) as pv_kdp_bby,
    sum(0) as pv_aktion_bby,
    sum(0) as pv_aktion_kdn_bby,
    sum(0) as pv_aktion_kdp_bby,
    sum(0) as pv_bonrabatt_bby,
    important,
    standard_aktion_id,
    loyalty_berechtigt_fg
from (
    select
        z.mandant_id,
        z.bon_id,
        z.wup_id,
        z.lkp_nb_id,
        z.lkp_art_id,
        z.lkp_posten_id,
        z.dat_booking,
        z.bon_zeile,
        z.umsatz_brutto,
        z.menge,
        z.lkp_mwst,
        z.lkp_mwst_id,
        z.lkp_wrg,
        z.lkp_umrechnungskurs,
        coalesce(
            promotion_brutto, 0) as
        umsatz_promotion_brutto,
        case
            when
                coalesce(promotion_brutto, 0) <> 0 and
                z.bonuskauf_id is not null and
                CAST(z.bonuskauf_id AS INT64) <> 0 --CORRECTED
                then 1
            else 0
        end as promo_fg,
        z.ean_kasse,
        case
            when z.aktion_typ_id = 'KDB'
                then ''
            when
                z.dat_booking >= CAST(x.dat AS DATE) and --CORRECTED
                p.aktion_id <> ''
                then p.aktion_id
            else z.aktion_id
        end aktion_id,
        z.kundenkarte_id,
        z.kundenkarte_typ_id,
        z.bonuskauf_id,
        z.aktion_typ_id,
        z.vk_aktion_brutto,
        z.vk_brutto,
        z.betrag_promo_brutto_bby,
        z.betrag_promo_brutto_kdn,
        z.betrag_promo_brutto_kdp,
        z.betrag_promo_brutto_null,
        z.konditionsart_id,
        z.bonuskauf_id_lb,
        z.bde_kundenkarte_id,
        z.customer_promotion_fg,
        z.promotion_art,
        z.important,
        coalesce(z.bewart_det_id_zmp, z.bewart_det_id) as bewart_det_id, --CORRECTED  --dkn
        -- z.bewart_det_id, --dkn
        z.standard_aktion_id,
        z.loyalty_berechtigt_fg
    from dbp_etl.kmo_artbew_bon_2 z
    join dbp_etl_process.kpos_bon_bby_dates_2 x
        on z.mandant_id = x.mandant_id
    left join (
        select
            a.mandant_id,
            a.bon_id,
            a.dat_booking,
            a.bon_zeile,
            max(coalesce(b.aktion_id, '')) as aktion_id,
            sum(a.umsatz_brutto) as promotion_brutto
        from dbp_etl.kmo_artbew_bon_promotion_2 a
        left join dbp_data.l_bonuskauf_2 b
            on
                a.mandant_id = b.mandant_id and
                a.bonuskauf_id = b.bonuskauf_id and
                a.dat_booking between b.dat_von and b.dat_bis
        group by 1, 2, 3, 4
    ) p
        on
            z.mandant_id = p.mandant_id and
            z.bon_id = p.bon_id and
            z.dat_booking = p.dat_booking and
            z.bon_zeile = p.bon_zeile
)
group by all;

-- start bewart_det_id --

begin
    DECLARE max_cnt INT64;
    DECLARE counter INT64 default 0;
    DECLARE i INT64 default 1;
    DECLARE statement string;
    SET max_cnt = (
        select count(*) from dbp_etl_process.artbew_pv_logic_2
        where key_field = 'bewart_det_id' and logic = 'new'
    );
    WHILE (i < max_cnt)
    DO
        SET statement = """(select statement from dbp_etl_process.artbew_pv_logic_2 where key_field = 'bewart_det_id' and logic = 'new' and key_value = {i})""";
        SET statement = REPLACE(statement, '{i}', CAST(i AS STRING));
        execute immediate statement;
        SET counter = counter + 1;
        SET i = i + 1;
    end while;
    SELECT counter;
end;

-- start pv-bbys values --
--EXECUTE IMMEDIATE CONVERTED BLOCK - START
begin
    DECLARE max_cnt INT64;
    DECLARE counter INT64 default 0;
    DECLARE i INT64 default 1;
    DECLARE statement string;
    SET max_cnt = (
        select count(*) from dbp_etl_process.artbew_pv_logic_2
        where key_field = 'pv_values' and logic = 'new'
    );
    WHILE (i < max_cnt)
    DO
        SET statement = """(select statement from dbp_etl_process.artbew_pv_logic_2 where key_field = 'pv_values' and logic = 'new' and key_value = {i})""";
        SET statement = REPLACE(statement, '{i}', CAST(i AS STRING));
        execute immediate statement;
        SET counter = counter + 1;
        SET i = i + 1;
    SELECT counter;
end;
--EXECUTE IMMEDIATE CONVERTED BLOCK - END


CREATE OR REPLACE TABLE dbp_etl.dd_final_2 LIKE dbp_etl_process.artbew_pv_subset_2;


ALTER TABLE dbp_etl.dd_final_2
ADD COLUMN IF NOT EXISTS aktionsart_id STRING(1000),
ADD COLUMN IF NOT EXISTS aktionsart_bez STRING(1000),
ADD COLUMN IF NOT EXISTS aktion_typ_id_2 STRING(1000),
ADD COLUMN IF NOT EXISTS aktion_typ_bez STRING(1000);


INSERT INTO dbp_etl.dd_final_2
(SELECT
    mandant_id,
    wup_id,
    lkp_nb_id,
    lkp_art_id,
    lkp_posten_id,
    dat_booking,
    lkp_mwst,
    lkp_mwst_id,
    lkp_wrg,
    lkp_umrechnungskurs,
    promo_fg,
    ean_kasse,
    aktion_id,
    kundenkarte_id,
    kundenkarte_typ_id,
    bonuskauf_id,
    aktion_typ_id,
    konditionsart_id,
    vk_aktion_brutto,
    vk_brutto,
    bonuskauf_id_lb,
    bde_kundenkarte_id,
    bewart_det_id,
    customer_promotion_fg,
    promotion_art,
    betrag_promo_brutto_kdn,
    betrag_promo_brutto_kdp,
    betrag_promo_brutto_null,
    umsatz_brutto_,
    menge_,
    umsatz_promotion_brutto_,
    pv_aktion,
    pv_bby,
    pv_kdn_bby,
    pv_kdp_bby,
    pv_aktion_bby,
    pv_aktion_kdn_bby,
    pv_aktion_kdp_bby,
    pv_bonrabatt_bby,
    betrag_promo_brutto_bby,
    important,
    standard_aktion_id,
    loyalty_berechtigt_fg,
    CAST(NULL AS STRING) AS aktionsart_id,
    CAST(NULL AS STRING) AS aktionsart_bez,
    CAST(NULL AS STRING) AS aktion_typ_id_2,
    CAST(NULL AS STRING) AS aktion_typ_bez
FROM dbp_etl_process.artbew_pv_subset_2 AS A);


update dbp_etl.dd_final_2 a
set
    a.aktionsart_id = aktionsart_id_liste,
    a.aktionsart_bez = aktionsart_bez_liste,
    a.aktion_typ_id_2 = aktion_typ_liste,
    a.aktion_typ_bez = aktion_typ_bez_liste
from (
    select
        mandant_id,
        wup_id,
        lkp_nb_id,
        lkp_art_id,
        lkp_posten_id,
        dat_booking,
        lkp_mwst,
        lkp_mwst_id,
        lkp_wrg,
        lkp_umrechnungskurs,
        promo_fg,
        ean_kasse,
        aktion_id,
        standard_aktion_id,
        kundenkarte_id,
        kundenkarte_typ_id,
        bonuskauf_id,
        aktion_typ_id,
        konditionsart_id,
        customer_promotion_fg,
        promotion_art,
        menge_,
        case
            when trim(aktionsart_std) <> '' and aktionsart_std is not null
                then aktionsart_std || ',' || trim(STRING_AGG(distinct cast(aktionsart_id as STRING), ','), ',')
            else trim(STRING_AGG(distinct cast(aktionsart_id as STRING), ','), ',')
        end as aktionsart_id_liste,
        case
            when trim(aktionsart_bez_std) <> '' and aktionsart_bez_std is not null
                then aktionsart_bez_std || ',' || trim(STRING_AGG(distinct cast(aktionsart_bez as STRING), ','), ',')
            else trim(STRING_AGG(distinct cast(aktionsart_bez as STRING), ','), ',')
        end as aktionsart_bez_liste,
        trim(STRING_AGG(distinct cast(aktion_typ_id_2 as STRING), ','), ',') as aktion_typ_liste,
        trim(STRING_AGG(distinct cast(aktion_typ_bez as STRING), ','), ',') as aktion_typ_bez_liste,
        aktionsart_std,
        aktionsart_bez_std
    from dbp_etl.dd_test_2 a
    group by all
) b

where
    coalesce(a.mandant_id, -1) = coalesce(b.mandant_id, -1) and
    coalesce(a.wup_id, -1) = coalesce(b.wup_id, -1) and
    coalesce(a.lkp_nb_id, -1) = coalesce(b.lkp_nb_id, -1) and
    coalesce(a.lkp_art_id, -1) = coalesce(b.lkp_art_id, -1) and
    coalesce(a.lkp_posten_id, '-1') = coalesce(b.lkp_posten_id, '-1') and
    a.dat_booking = b.dat_booking and
    coalesce(a.lkp_mwst, -1) = coalesce(b.lkp_mwst, -1) and
    coalesce(a.lkp_mwst_id, -1) = coalesce(b.lkp_mwst_id, -1) and
    coalesce(a.lkp_wrg, '-1') = coalesce(b.lkp_wrg, '-1') and
    coalesce(a.lkp_umrechnungskurs, -1) = coalesce(b.lkp_umrechnungskurs, -1) and
    coalesce(a.promo_fg, -1) = coalesce(b.promo_fg, -1) and
    coalesce(a.ean_kasse, -1) = coalesce(b.ean_kasse, -1) and
    coalesce(a.aktion_id, '-1') = coalesce(b.aktion_id, '-1') and
    coalesce(a.standard_aktion_id, '-1') = coalesce(b.standard_aktion_id, '-1') and
    coalesce(a.kundenkarte_id, '-1') = coalesce(b.kundenkarte_id, '-1') and
    coalesce(a.kundenkarte_typ_id, -1) = coalesce(b.kundenkarte_typ_id, -1) and
    coalesce(a.bonuskauf_id, '-1') = coalesce(b.bonuskauf_id, '-1') and
    coalesce(a.aktion_typ_id, '-1') = coalesce(b.aktion_typ_id, '-1') and
    coalesce(a.konditionsart_id, '-1') = coalesce(b.konditionsart_id, '-1') and
    coalesce(a.customer_promotion_fg, -1) = coalesce(b.customer_promotion_fg, -1) and
    coalesce(a.promotion_art, '-1') = coalesce(b.promotion_art, '-1') and
    coalesce(a.menge_, -1) = coalesce(b.menge_, -1);

UPDATE `dbp_etl.dd_final_2`
SET
    aktionsart_id = SUBSTR(aktionsart_id, 1, LENGTH(aktionsart_id) - 1),
    aktionsart_bez = SUBSTR(aktionsart_bez, 1, LENGTH(aktionsart_bez) - 1)
WHERE ENDS_WITH(aktionsart_id, ',');

UPDATE `dbp_etl.dd_final_2`
SET
    aktion_typ_id_2 = SUBSTR(aktion_typ_id_2, 1, LENGTH(aktion_typ_id_2) - 1),
    aktion_typ_bez = SUBSTR(aktion_typ_bez, 1, LENGTH(aktion_typ_bez) - 1)
WHERE ENDS_WITH(aktion_typ_id_2, ',');


UPDATE dbp_etl.dd_final_2 SET
    bewart_det_id = CASE
        WHEN dd_final.bewart_det_id = 100131
            THEN 100130
        WHEN dd_final.bewart_det_id = 100111
            THEN 100110
        WHEN dd_final.bewart_det_id = 100211
            THEN 100210
        WHEN dd_final.bewart_det_id = 100221
            THEN 100220
        WHEN dd_final.bewart_det_id IN (100231, 100241)
            THEN 9999
        ELSE dd_final.bewart_det_id
    END
WHERE MOD(bewart_det_id, 10) <> loyalty_berechtigt_fg AND loyalty_berechtigt_fg = 0;


UPDATE dbp_etl.dd_final_2 SET
    bewart_det_id = CASE
        WHEN dd_final.bewart_det_id = 100130
            THEN 100131
        WHEN dd_final.bewart_det_id = 100110
            THEN 100111
        WHEN dd_final.bewart_det_id = 100210
            THEN 100211
        WHEN dd_final.bewart_det_id = 100220
            THEN 100221
        ELSE dd_final.bewart_det_id
    END
WHERE MOD(bewart_det_id, 10) <> loyalty_berechtigt_fg AND loyalty_berechtigt_fg = 1;


create or replace table dbp_etl.artbew_subset2_2 as (
    select
        mandant_id,
        wup_id,
        lkp_nb_id,
        lkp_art_id,
        lkp_posten_id,
        dat_booking,
        lkp_mwst,
        lkp_mwst_id,
        lkp_wrg,
        lkp_umrechnungskurs,
        promo_fg,
        ean_kasse,
        aktion_id,
        standard_aktion_id,
        sum(umsatz_brutto_) as umsatz_brutto,
        sum(menge_) as menge,
        sum(umsatz_promotion_brutto_) as umsatz_promotion_brutto,
        bewart_det_id,
        sum(pv_aktion) as pv_aktion,
        sum(pv_bby) as pv_bby,
        sum(pv_kdn_bby) as pv_kdn_bby,
        sum(pv_kdp_bby) as pv_kdp_bby,
        sum(pv_aktion_bby) as pv_aktion_bby,
        sum(pv_aktion_kdn_bby) as pv_aktion_kdn_bby,
        sum(pv_aktion_kdp_bby) as pv_aktion_kdp_bby,
        sum(pv_bonrabatt_bby) as pv_bonrabatt_bby,
        max(aktionsart_id) as aktionsart_id,
        max(aktionsart_bez) as aktionsart_bez,
        max(aktion_typ_id_2) as aktion_typ_id_2,
        max(aktion_typ_bez) as aktion_typ_bez
    from dbp_etl.dd_final_2 l
    group by all
);

ALTER TABLE dbp_etl.artbew_kmo_tmp_2
ADD COLUMN IF NOT EXISTS aktionsart_id_liste_txt STRING(1000),
ADD COLUMN IF NOT EXISTS aktionsart_bez_liste_txt STRING(1000),
ADD COLUMN IF NOT EXISTS aktion_typ_id_liste_txt STRING(1000),
ADD COLUMN IF NOT EXISTS aktion_typ_bez_liste_txt STRING(1000);


insert into dbp_etl.artbew_kmo_tmp_2 (
    mandant_id,
    wup_id,
    nb_id,
    art_id,
    gp_id,
    einkaufsorganisation_id,
    bewart_id,
    dat,
    aktion_id,
    herst_id,
    mwst_id,
    wrg_2,
    posten_id,
    bezugsweg_id,
    menge,
    umsatz_netto,
    umsatz_mwst_betrag,
    promo_fg,
    ean_kasse,
    diff_umsatz_netto_konz,
    diff_umsatz_mwst_betrag_konz,
    bewart_det_id,
    pv_aktion,
    pv_bby,
    pv_kdn_bby,
    pv_kdp_bby,
    pv_aktion_bby,
    pv_aktion_kdn_bby,
    pv_aktion_kdp_bby,
    pv_bonrabatt_bby,
    pv_aktion_konz,
    pv_bby_konz,
    pv_kdn_bby_konz,
    pv_kdp_bby_konz,
    pv_aktion_bby_konz,
    pv_aktion_kdn_bby_konz,
    pv_aktion_kdp_bby_konz,
    pv_bonrabatt_bby_konz,
    --standard_aktion_id, -- CORRECTED
    aktionsart_id_liste_txt,
    aktionsart_bez_liste_txt,
    aktion_typ_id_liste_txt,
    aktion_typ_bez_liste_txt
)
select
    g.mandant_id,
    g.wup_id,
    g.nb_id,
    g.art_id,
    g.gp_id,
    g.einkaufsorganisation_id,
    g.bewart_id,
    g.dat,
    g.aktion_id,
    g.herst_id,
    g.mwst_id,
    g.wrg_2,
    g.posten_id,
    g.bezugsweg_id,
    g.menge,
    g.umsatz_netto,
    g.umsatz_mwst_betrag,
    g.promo_fg,
    coalesce(CAST(g.ean_kasse AS INT64), 9999),
    g.diff_umsatz_netto_konz,
    g.diff_umsatz_mwst_betrag_konz,
    g.bewart_det_id,
    g.pv_aktion,
    g.pv_bby,
    g.pv_kdn_bby,
    g.pv_kdp_bby,
    g.pv_aktion_bby,
    g.pv_aktion_kdn_bby,
    g.pv_aktion_kdp_bby,
    g.pv_bonrabatt_bby,
    g.pv_aktion_konz,
    g.pv_bby_konz,
    g.pv_kdn_bby_konz,
    g.pv_kdp_bby_konz,
    g.pv_aktion_bby_konz,
    g.pv_aktion_kdn_bby_konz,
    g.pv_aktion_kdp_bby_konz,
    g.pv_bonrabatt_bby_konz,
    --g.standard_aktion_id, -- CORRECTED
    g.aktionsart_id,
    g.aktionsart_bez,
    g.aktion_typ_id_2,
    g.aktion_typ_bez
from (
    select
        l.mandant_id as mandant_id,
        l.wup_id as wup_id,
        lkp_nb_id as nb_id,
        lkp_art_id as art_id,
        -1 as gp_id,
        -1 as einkaufsorganisation_id,
        case
            when l.dat_booking >= CAST(x.dat AS DATE)
                then
                    case
                        when trim(l.aktion_id) <> ''
                            then 1002
                        else 1001
                    end
            else coalesce(r.bewart_id, 1001)
        end bewart_id,
        dat_booking as dat,
        case
            when l.dat_booking >= CAST(x.dat AS DATE)
                then trim(l.aktion_id)
            else coalesce(r.aktion_id, '')
        end as aktion_id,
        --l.standard_aktion_id, -- CORRECTED
        -1 as herst_id,
        lkp_mwst_id as mwst_id,
        lkp_wrg as wrg_2,
        coalesce(lkp_posten_id, ' ') as posten_id,
        0 as bezugsweg_id,
        menge,
        cast(umsatz_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) as umsatz_brutto_ohne_promo,
        cast(umsatz_brutto * lkp_umrechnungskurs as NUMERIC) as umsatz_brutto_ohne_promo_conv,
        cast(cast(umsatz_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) / (1 + (lkp_mwst / 100)) as NUMERIC) AS umsatz_netto,

        cast(cast(umsatz_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) - cast(cast(umsatz_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) / (1 + (lkp_mwst / 100)) as NUMERIC) as NUMERIC) as umsatz_mwst_betrag,
        promo_fg,
        ean_kasse,
        cast(umsatz_brutto / (1 + (lkp_mwst / 100)) * lkp_umrechnungskurs as NUMERIC) as diff_umsatz_netto_konz,
        cast(cast(umsatz_brutto * lkp_umrechnungskurs as NUMERIC) - cast(umsatz_brutto / (1 + (lkp_mwst / 100)) * lkp_umrechnungskurs as NUMERIC) as NUMERIC) as diff_umsatz_mwst_betrag_konz,
        bewart_det_id,
        cast(pv_aktion * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) as pv_aktion,
        cast(pv_bby * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) as pv_bby,
        cast(pv_kdn_bby * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) as pv_kdn_bby,
        cast(pv_kdp_bby * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) as pv_kdp_bby,
        cast(pv_aktion_bby * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) as pv_aktion_bby,
        cast(pv_aktion_kdn_bby * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) as pv_aktion_kdn_bby,
        cast(pv_aktion_kdp_bby * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) as pv_aktion_kdp_bby,
        cast(pv_bonrabatt_bby * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) as pv_bonrabatt_bby,
        cast(pv_aktion * lkp_umrechnungskurs as NUMERIC) as pv_aktion_konz,
        cast(pv_bby * lkp_umrechnungskurs as NUMERIC) as pv_bby_konz,
        cast(pv_kdn_bby * lkp_umrechnungskurs as NUMERIC) as pv_kdn_bby_konz,
        cast(pv_kdp_bby * lkp_umrechnungskurs as NUMERIC) as pv_kdp_bby_konz,
        cast(pv_aktion_bby * lkp_umrechnungskurs as NUMERIC) as pv_aktion_bby_konz,
        cast(pv_aktion_kdn_bby * lkp_umrechnungskurs as NUMERIC) as pv_aktion_kdn_bby_konz,
        cast(pv_aktion_kdp_bby * lkp_umrechnungskurs as NUMERIC) as pv_aktion_kdp_bby_konz,
        cast(pv_bonrabatt_bby * lkp_umrechnungskurs as NUMERIC) as pv_bonrabatt_bby_konz,
        aktionsart_id,
        aktionsart_bez,
        aktion_typ_id_2,
        aktion_typ_bez
    from dbp_etl.artbew_subset2_2 l
    join dbp_etl_process.kpos_bon_bby_dates_2 x
        on l.mandant_id = x.mandant_id
    left join (
        select
            a.*,
            1 as conv_fg
        from dbp_data.mandant_wrg_zu_per_2 a
        where
            a.von_wrg_id is not null and
            a.wrg_id <> a.von_wrg_id and
            CURRENT_DATE("Europe/Berlin") between a.dat_von and a.dat_bis
    ) y
        on
            l.mandant_id = y.mandant_id and
            l.lkp_wrg = y.wrg_id
    left join dbp_etl_process.marktabschriften_stamm_2 r
        on
            l.mandant_id = r.mandant_id and
            l.lkp_art_id = r.art_id and
            l.wup_id = r.wup_id and
            l.lkp_nb_id = r.nb_id and
            l.dat_booking = r.dat
) g;


UPDATE dbp_etl.artbew_kmo_tmp_2 SET
    bewart_id = 1001
WHERE bewart_det_id IN (100110, 100111, 100121, 100130, 100131);


DELETE FROM dbp_data.artbew_2 AS A
WHERE dat IN (
    SELECT dat
    FROM dbp_etl.kmo_artbew_bon_dat_2) AND (mandant_id, wup_id, dat) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM dbp_etl.artbew_kmo_tmp_2
) AND bewart_id <> 1010;


DELETE FROM dbp_data.artbew_promotion_zu_2 AS A
WHERE dat IN (
    SELECT dat
    FROM dbp_etl.kmo_artbew_bon_dat_2) AND (mandant_id, wup_id, dat) IN (
    SELECT (mandant_id, wup_id, dat)
    FROM dbp_etl.artbew_kmo_tmp_2
    WHERE promo_fg = 1
) AND konditionsart_id <> 'RB19';

insert into dbp_data.artbew_2 (
    mandant_id,
    wup_id,
    nb_id,
    art_id,
    promo_fg,
    gp_id,
    einkaufsorganisation_id,
    bewart_id,
    dat,
    aktion_id,
    herst_id,
    mwst_id,
    wrg_2,
    posten_id,
    bezugsweg_id,
    menge,
    umsatz_netto,
    umsatz_mwst_betrag,
    ek_brutto,
    ek_netto,
    ek_nettonetto,
    ek_kal_basis,
    ek_mep,
    einstandspreis,
    logkostenzuschlag,
    ek_netto_bnk,
    ek_netto_bnk_sachk,
    ean_kasse,
    diff_umsatz_netto_konz,
    diff_umsatz_mwst_betrag_konz,
    bewart_det_id,
    pv_aktion,
    pv_bby,
    pv_kdn_bby,
    pv_kdp_bby,
    pv_aktion_bby,
    pv_aktion_kdn_bby,
    pv_aktion_kdp_bby,
    pv_bonrabatt_bby,
    td_insert,
    td_update,
    ek_mep_vor_fwu,
    ek_mep_vor_fwu_konz,
    bonusbasis,
    bonusbasis_konz,
    wup_bereinigt_fg,
    pv_aktion_konz,
    pv_bby_konz,
    pv_kdn_bby_konz,
    pv_kdp_bby_konz,
    pv_aktion_bby_konz,
    pv_aktion_kdn_bby_konz,
    pv_aktion_kdp_bby_konz,
    pv_bonrabatt_bby_konz,
    standard_aktion_id,
    umrechnungskurs_hist,
    --,aktionsart_id_liste_txt 
    aktionsart_bez_liste_txt,
    aktion_typ_id_liste_txt,
    aktion_typ_bez_liste_txt
)
select
    mandant_id,
    wup_id,
    nb_id,
    art_id,
    promo_fg,
    gp_id,
    einkaufsorganisation_id,
    bewart_id,
    dat,
    aktion_id,
    herst_id,
    mwst_id,
    wrg_2,
    posten_id,
    bezugsweg_id,
    menge_sum,
    umsatz_netto_sum,
    umsatz_mwst_betrag_sum,
    zero_enc as ek_brutto,
    zero_enc as ek_netto,
    zero_enc as ek_nettonetto,
    zero_enc as ek_kal_basis,
    zero_enc as ek_mep,
    zero_enc as einstandspreis,
    0 as logkostenzuschlag,
    zero_enc as ek_netto_bnk,
    zero_enc as ek_netto_bnk_sachk,
    ean_kasse,
    diff_umsatz_netto_konz,
    diff_umsatz_mwst_betrag_konz,
    bewart_det_id,
    pv_aktion,
    pv_bby,
    pv_kdn_bby,
    pv_kdp_bby,
    pv_aktion_bby,
    pv_aktion_kdn_bby,
    pv_aktion_kdp_bby,
    pv_bonrabatt_bby,
    current_timestamp as td_insert,
    current_timestamp as td_update,
    0 as ek_mep_vor_fwu,
    null as ek_mep_vor_fwu_konz,
    0 as bonusbasis,
    null as bonusbasis_konz,
    wup_bereinigt_fg,
    pv_aktion_konz,
    pv_bby_konz,
    pv_kdn_bby_konz,
    pv_kdp_bby_konz,
    pv_aktion_bby_konz,
    pv_aktion_kdn_bby_konz,
    pv_aktion_kdp_bby_konz,
    pv_bonrabatt_bby_konz,
    standard_aktion_id,
    umrechnungskurs_hist,
    --,aktionsart_id_liste_txt --CORRECTED
    aktionsart_bez_liste_txt,
    aktion_typ_id_liste_txt,
    aktion_typ_bez_liste_txt
from (
    select
        a.mandant_id,
        a.wup_id,
        a.nb_id,
        a.art_id,
        a.promo_fg,
        a.gp_id,
        a.einkaufsorganisation_id,
        a.bewart_id,
        a.dat,
        a.aktion_id,
        a.herst_id,
        a.mwst_id,
        a.wrg_2,
        a.posten_id,
        a.bezugsweg_id,
        sum(a.menge) as menge_sum,
        sum(a.umsatz_netto) as umsatz_netto_sum,
        sum(a.umsatz_mwst_betrag) as umsatz_mwst_betrag_sum,
        0 as zero_enc,
        a.ean_kasse,
        sum(a.diff_umsatz_netto_konz) diff_umsatz_netto_konz,
        sum(a.diff_umsatz_mwst_betrag_konz) diff_umsatz_mwst_betrag_konz,
        a.bewart_det_id,
        a.pv_aktion,
        a.pv_bby,
        a.pv_kdn_bby,
        a.pv_kdp_bby,
        a.pv_aktion_bby,
        a.pv_aktion_kdn_bby,
        a.pv_aktion_kdp_bby,
        a.pv_bonrabatt_bby,
        coalesce(b.wup_bereinigt_fg, 0) as wup_bereinigt_fg,
        a.pv_aktion_konz,
        a.pv_bby_konz,
        a.pv_kdn_bby_konz,
        a.pv_kdp_bby_konz,
        a.pv_aktion_bby_konz,
        a.pv_aktion_kdn_bby_konz,
        a.pv_aktion_kdp_bby_konz,
        a.pv_bonrabatt_bby_konz,
        a.standard_aktion_id,
        k.umrechnungskurs as umrechnungskurs_hist,
        --,a.aktionsart_id_liste_txt  --CORRECTED
        a.aktionsart_bez_liste_txt,
        a.aktion_typ_id_liste_txt,
        a.aktion_typ_bez_liste_txt
    from dbp_etl.artbew_kmo_tmp_2 a
    left join dbp_etl_process.wup_fg_2 b
        on
            a.mandant_id = b.mandant_id and
            a.wup_id = b.wup_id and
            a.dat = b.dat
    left join dbp_data.kurs_2 k
        on
            a.wrg_2 = k.von_wrg_id and
            a.dat between k.dat_von and k.dat_bis and
            k.nach_wrg_id = 'EUR' and
            k.kurstyp_id = 3
    group by all
) a
where (a.mandant_id, a.art_id) not in (
    select (mandant_id, art_id)
    FROM (
        select
            mandant_id,
            art_id
        from dbp_data.art_wg_zu_per_2
        where
            mandant_id > 1 and
            arthiertyp_id = 2 and
            dat_bis = '9999-12-31' and
            wg_id = 961
        union DISTINCT
        select
            mandant_id,
            art_id
        from dbp_data.art_wg_zu_per_2
        where
            mandant_id = 7 and
            arthiertyp_id = 2 and
            dat_bis = '9999-12-31' and
            wg_id = 980
        union DISTINCT
        select
            mandant_id,
            art_id
        from dbp_data.art_2
        where
            mandant_id = 2 and
            art_id in (818410, 202685400, 1485930, 207699370)
    )
);

DELETE FROM dbp_etl.kmo_artbew_bon_promotion_2
WHERE COALESCE(umsatz_brutto, 0) = 0;


insert into dbp_data.artbew_promotion_zu_2 (
    mandant_id,
    wup_id,
    nb_id,
    --,art_id  --CORRECTED
    dat,
    bonuskauf_id,
    konditionsart_id,
    wrg_id,
    betrag_promo_netto,
    betrag_mwst,
    umrechnungskurs,
    system_id,
    ean_kasse,
    menge_promo,
    umsatz_promo_netto,
    umsatz_mwst,
    umrechnungskurs_hist
)
select
    mandant_id,
    wup_id,
    nb_id,
    --,art_id --CORRECTED
    dat,
    bonuskauf_id,
    konditionsart_id,
    wrg_id,
    sum(coalesce(betrag_promo_netto, 0)),
    sum(betrag_mwst),
    CAST(p.umrechnungskurs AS NUMERIC),
    system_id,
    ean_kasse,
    sum(coalesce(menge_promo, 0)),
    sum(coalesce(umsatz_promo_netto, 0)),
    sum(coalesce(umsatz_mwst, 0)),
    k.umrechnungskurs as umrechnungskurs_hist
from (
    select
        l.mandant_id as mandant_id,
        l.wup_id as wup_id,
        l.lkp_nb_id as nb_id,
        l.lkp_art_id as art_id,
        l.dat_booking as dat,
        p.bonuskauf_id,
        p.konditionsart_id,
        l.lkp_wrg as wrg_id,
        cast(p.umsatz_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) as umsatz_brutto_conv,
        cast(p.umsatz_promo_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) as umsatz_promo_brutto_conv,
        cast(cast(p.umsatz_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) / (1 + (lkp_mwst / 100)) as NUMERIC) as betrag_promo_netto,
        cast(cast(p.umsatz_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) - cast(cast(p.umsatz_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) / (1 + (lkp_mwst / 100)) as NUMERIC) as NUMERIC) as betrag_mwst,
        lkp_umrechnungskurs as umrechnungskurs,
        coalesce(k.system_id, 0) as system_id,
        l.ean_kasse,
        menge_promo as menge_promo,
        cast(cast(p.umsatz_promo_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) / (1 + (lkp_mwst / 100)) as NUMERIC) as umsatz_promo_netto,
        cast(cast(p.umsatz_promo_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) - cast(cast(p.umsatz_promo_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) / (1 + (lkp_mwst / 100)) as NUMERIC) as NUMERIC) as umsatz_mwst
    from dbp_etl.kmo_artbew_bon_2 l
    left join (
        select
            a.*,
            1 as conv_fg
        from dbp_data.mandant_wrg_zu_per_2 a
        where
            a.von_wrg_id is not null and
            a.wrg_id <> a.von_wrg_id and
            CURRENT_DATE("Europe/Berlin") between a.dat_von and a.dat_bis
    ) y
        on
            l.mandant_id = y.mandant_id and
            l.lkp_wrg = y.wrg_id
    join dbp_etl.kmo_artbew_bon_promotion_2 p
        on
            l.mandant_id = p.mandant_id and
            l.bon_id = p.bon_id and
            l.dat_booking = p.dat_booking and
            l.bon_zeile = p.bon_zeile
    left join dbp_data.l_konditionsart_2 k
        on
            p.mandant_id = k.mandant_id and
            p.konditionsart_id = k.konditionsart_id
) p
left join dbp_data.kurs_2 k
    on
        p.wrg_id = k.von_wrg_id and
        p.dat between k.dat_von and k.dat_bis and
        k.nach_wrg_id = 'EUR' and
        k.kurstyp_id = 3
group by all;

INSERT INTO dbp_data.artbew_agg_wt_2 (mandant_id, wup_id, nb_id, dat)
(
    SELECT
        mandant_id,
        wup_id,
        nb_id,
        dat
    FROM dbp_etl.artbew_kmo_tmp_2
    WHERE (
        mandant_id, wup_id, nb_id, dat) NOT IN (
        SELECT (mandant_id, wup_id, nb_id, dat)
        FROM dbp_data.artbew_agg_wt_2
    )
    GROUP BY
        wup_id,
        mandant_id,
        nb_id,
        dat
);


INSERT INTO dbp_etl_process.uapc_artbew_delta_2 (mandant_id, wup_id, dat, row_id, td_insert, td_update)
(SELECT
    mandant_id,
    wup_id,
    dat,
    (ROW_NUMBER()
        OVER (ORDER BY mandant_id IS NULL, mandant_id, wup_id IS NULL, wup_id, dat IS NULL, dat)) + COALESCE((
        SELECT MAX(row_id)
        FROM dbp_etl_process.uapc_artbew_delta_2
    ), 0) AS row_id,
    CURRENT_TIMESTAMP() AS td_insert,
    CURRENT_TIMESTAMP() AS td_update
FROM (
    SELECT
        mandant_id,
        wup_id,
        dat
    FROM dbp_etl.artbew_kmo_tmp_2
    GROUP BY
        wup_id,
        mandant_id,
        dat
) AS t0);


UPDATE dbp_data.wupcal_2 SET
    datenlieferung_artbew = 1,
    dat_extrakt_umsatz = CURRENT_DATE("Europe/Berlin"),
    umsatz_brutto_ods_verkauf = x1.umsatz_netto_sum + x1.umsatz_mwst_betrag_sum,
    wrg_id = x1.wrg_,
    td_update = CURRENT_TIMESTAMP() FROM (
    SELECT
        mandant_id AS mandant_id_,
        wup_id AS wup_id_,
        nb_id AS nb_id_,
        dat AS dat_,
        wrg_2 AS wrg_,
        SUM(umsatz_netto) AS umsatz_netto_sum,
        SUM(umsatz_mwst_betrag) AS umsatz_mwst_betrag_sum
    FROM dbp_etl.artbew_kmo_tmp_2
    GROUP BY
        mandant_id_,
        wup_id_,
        nb_id_,
        dat_,
        wrg_
) AS x1
WHERE
    wupcal.mandant_id = x1.mandant_id_ AND wupcal.wup_id = x1.wup_id_ AND wupcal.nb_id = x1.nb_id_ AND wupcal.dat = x1.dat_;


UPDATE dbp_data.wupcal_2 SET
    bonanzahl = s.anz_kunden_,
    bonanzahl_imbiss = s.anz_kunden_imbiss_,
    umsatz_brutto_ods_kassenabschluss = CAST(s.umsatz_brutto_ods_kassenabschluss_ AS NUMERIC),
    datenlieferung_bonanzahl = 1,
    wrg_id = s.wrg_id_ FROM (
    SELECT
        K.mandant_id AS mandant_id_,
        K.wup_id AS wup_id_,
        K.bon_dat AS dat_,
        SUM(K.anz_kunden) - SUM(K.anz_kunden_imbiss) AS anz_kunden_,
        SUM(K.anz_kunden_imbiss) AS anz_kunden_imbiss_,
        SUM(K.umsatz_brutto * COALESCE(x.umrech, 1)) AS umsatz_brutto_ods_kassenabschluss_,
        MIN(x.wrg_id) AS wrg_id_
    FROM dbp_ods.ods_bon_kassenabschluss_2 AS K
    INNER JOIN dbp_data.mandant_wrg_zu_per_2 AS WRG_2
        ON
            K.mandant_id = WRG.mandant_id AND K.bon_dat BETWEEN
            WRG.dat_von AND WRG.dat_bis
    INNER JOIN dbp_data.mandant_2 AS Y ON K.mandant_id = Y.mandant_id
    LEFT JOIN (
        SELECT
            mandant_id,
            wrg_id,
            dat_von,
            dat_bis,
            von_wrg_id,
            umrechnungskurs,
            td_update,
            td_insert,
            1 / CAST(umrechnungskurs AS FLOAT64) AS umrech
        FROM dbp_data.mandant_wrg_zu_per_2
        WHERE
            von_wrg_id IS NOT NULL
            AND wrg_id <> von_wrg_id
            AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
    ) AS x ON K.mandant_id = x.mandant_id AND WRG.wrg_id = x.von_wrg_id
    INNER JOIN (
        SELECT
            mandant_id,
            wup_id,
            dat
        FROM dbp_etl.artbew_kmo_tmp_2
        GROUP BY
            wup_id,
            mandant_id,
            dat
    ) AS a ON K.mandant_id = a.mandant_id AND K.wup_id = a.wup_id AND K.bon_dat = a.dat
    GROUP BY
        mandant_id_,
        wup_id_,
        dat_
) AS s
WHERE wupcal.mandant_id = s.mandant_id_ AND wupcal.wup_id = s.wup_id_ AND wupcal.dat = s.dat_;


/*
Jetzt kann nachträglich noch eine_2 Kassenabschluss kommen.
Wir benötigen dann die Summe der beiden Werte in der wupcal_2 Spalte.
*/


CREATE OR REPLACE TABLE dbp_etl.wupcal_correction_2 AS
-- sum(umsatz_brutto) AS
-- umsatz_brutto
-- group by all
SELECT DISTINCT
    mandant_id,
    wup_id,
    bon_dat
FROM dbp_ods.ods_bon_kassenabschluss_2
WHERE (
    mandant_id, wup_id, bon_dat) IN (
    SELECT (mandant_id, wup_id, bon_dat)
    FROM dbp_ods.ods_bon_kassenabschluss_2
    WHERE
        mandant_id > 1
        AND bon_dat BETWEEN DATE_SUB(CURRENT_DATE("Europe/Berlin"), INTERVAL 7 DAY) AND (CURRENT_DATE("Europe/Berlin"))
    GROUP BY
        mandant_id,
        wup_id,
        bon_dat
    HAVING COUNT(*) > 1
)
ORDER BY
    mandant_id NULLS LAST,
    wup_id NULLS LAST,
    bon_dat DESC NULLS FIRST;


UPDATE dbp_data.wupcal_2 SET
    bonanzahl = s.anz_kunden_,
    bonanzahl_imbiss = s.anz_kunden_imbiss_,
    umsatz_brutto_ods_kassenabschluss = CAST(s.umsatz_brutto_ods_kassenabschluss_ AS NUMERIC),
    datenlieferung_bonanzahl = 1,
    wrg_id = s.wrg_id_ FROM (
    SELECT
        K.mandant_id AS mandant_id_,
        K.wup_id AS wup_id_,
        K.bon_dat AS dat_,
        SUM(K.anz_kunden) - SUM(K.anz_kunden_imbiss) AS anz_kunden_,
        SUM(K.anz_kunden_imbiss) AS anz_kunden_imbiss_,
        SUM(K.umsatz_brutto * COALESCE(x.umrech, 1)) AS umsatz_brutto_ods_kassenabschluss_,
        MIN(x.wrg_id) AS wrg_id_
    FROM dbp_ods.ods_bon_kassenabschluss_2 AS K
    INNER JOIN dbp_data.mandant_wrg_zu_per_2 AS WRG_2
        ON
            K.mandant_id = WRG.mandant_id AND K.bon_dat BETWEEN
            WRG.dat_von AND WRG.dat_bis
    INNER JOIN dbp_data.mandant_2 AS Y ON K.mandant_id = Y.mandant_id
    LEFT JOIN (
        SELECT
            mandant_id,
            wrg_id,
            dat_von,
            dat_bis,
            von_wrg_id,
            umrechnungskurs,
            td_update,
            td_insert,
            1 / CAST(umrechnungskurs AS FLOAT64) AS umrech
        FROM dbp_data.mandant_wrg_zu_per_2
        WHERE
            von_wrg_id IS NOT NULL
            AND wrg_id <> von_wrg_id
            AND CURRENT_DATE("Europe/Berlin") BETWEEN dat_von AND dat_bis
    ) AS x ON K.mandant_id = x.mandant_id AND WRG.wrg_id = x.von_wrg_id
    INNER JOIN (
        SELECT
            mandant_id,
            wup_id,
            bon_dat
        FROM dbp_etl.wupcal_correction_2
        GROUP BY
            mandant_id,
            wup_id,
            bon_dat
    ) AS a ON K.mandant_id = a.mandant_id AND K.wup_id = a.wup_id AND K.bon_dat = a.bon_dat
    GROUP BY
        mandant_id_,
        wup_id_,
        dat_
) AS s
WHERE wupcal.mandant_id = s.mandant_id_ AND wupcal.wup_id = s.wup_id_ AND wupcal.dat = s.dat_;


UPDATE dbp_data.wup_2 SET
    kassentyp = 'KPO'
WHERE (
    mandant_id, nb_id, wup_id) IN (
    SELECT (mandant_id, nb_id, wup_id)
    FROM dbp_etl.artbew_kmo_tmp_2
);


INSERT INTO dbp_etl.kmo_wpuums_art_gp_wup_zu_2 (
    mandant_id, art_id, wup_id, nb_id, dat, bezugsweg_id,
    anz_ek_infosatz, anz_ek_orderbuch, bq_gp_id, bq_ekorg, bq_findung_id, regel_gp_id, regel_ekorg, ref_wup_id, ref_nb_id,
    kreistyp_gruppe_id, wg_id, umrechnungskurs
)
(
    SELECT
        mandant_id,
        lkp_art_id,
        wup_id,
        lkp_nb_id,
        dat_booking,
        0 AS bezugsweg_id,
        0 AS anz_ek_infosatz,
        0 AS anz_ek_orderbuch,
        0 AS bq_gp_id,
        0 AS bq_ekorg,
        0 AS bq_findung_id,
        0 AS regel_gp_id,
        0 AS regel_ekorg,
        0 AS ref_wup_id,
        0 AS ref_nb_id,
        '' AS kreistyp_gruppe_id,
        0 AS wg_id,
        MAX(lkp_umrechnungskurs)
    FROM dbp_etl.kmo_artbew_bon_2 AS A
    WHERE (
        mandant_id, wup_id, lkp_nb_id, lkp_art_id, dat_booking) NOT IN (
        SELECT (mandant_id, wup_id, nb_id, art_id, dat)
        FROM dbp_etl.kmo_wpuums_art_gp_wup_zu_2
    )
    GROUP BY
        mandant_id,
        dat_booking,
        wup_id,
        lkp_art_id,
        lkp_nb_id
);


UPDATE dbp_ods.bon_load_status_2 SET
    artbew_fg = 1
WHERE xml_name IN (
    SELECT xml_name
    FROM dbp_etl.kmo_artbew_bon_delta_2
);


-- crm_kartebew_2


CREATE OR REPLACE TEMPORARY TABLE _crm_keys AS
SELECT
    mandant_id,
    wup_id,
    lkp_nb_id AS nb_id,
    kundenkarte_id,
    dat_booking AS dat,
    lkp_wrg AS wrg_2,
    COUNT(DISTINCT CASE
        WHEN bon_id <> ''
            THEN bon_id
        ELSE NULL
    END) AS anz_bon
FROM dbp_etl.kmo_artbew_bon_2
WHERE
    (mandant_id IN (2, 4, 7, 6, 5, 8) OR mandant_id IN (3) AND kundenkarte_typ_id = 2)
    AND (
        mandant_id, lkp_art_id) NOT IN (
        SELECT (mandant_id, art_id)
        FROM ((
            SELECT
                mandant_id,
                art_id
            FROM dbp_data.art_wg_zu_per_2
            WHERE
                mandant_id > 1
                AND arthiertyp_id = 2
                AND dat_bis = DATE '9999-12-31'
                AND wg_id = 961
            UNION DISTINCT
            SELECT
                mandant_id,
                art_id
            FROM dbp_data.art_wg_zu_per_2
            WHERE
                mandant_id = 7
                AND arthiertyp_id = 2
                AND dat_bis = DATE '9999-12-31'
                AND wg_id = 980
        )
        UNION DISTINCT
        SELECT
            mandant_id,
            art_id
        FROM dbp_data.art_2
        WHERE
            mandant_id = 2
            AND art_id IN (818410, 202685400, 1485930, 207699370)
        ) AS t5
    )
GROUP BY
    mandant_id,
    wup_id,
    nb_id,
    kundenkarte_id,
    dat,
    wrg_2;


create or replace TEMPORARY TABLE _artbew_subset3 as (
    select
        mandant_id,
        wup_id,
        lkp_nb_id,
        lkp_art_id,
        lkp_posten_id,
        dat_booking,
        lkp_mwst,
        lkp_mwst_id,
        lkp_wrg,
        lkp_umrechnungskurs,
        promo_fg,
        ean_kasse,
        aktion_id,
        sum(umsatz_brutto_) as umsatz_brutto,
        sum(menge_) as menge,
        sum(umsatz_promotion_brutto_) as umsatz_promotion_brutto,
        bewart_det_id,
        kundenkarte_id,
        kundenkarte_typ_id,
        loyalty_berechtigt_fg
    from dbp_etl.dd_final_2 l
    where (
        (mandant_id in (2, 4, 7, 6, 5, 8)) or
        (mandant_id in (3) and kundenkarte_typ_id = 2)
    )
    group by all
);

create or replace TEMPORARY TABLE _crm1 as (
    select
        g.mandant_id,
        g.wup_id,
        g.nb_id,
        g.art_id,
        g.gp_id,
        g.einkaufsorganisation_id,
        g.bewart_id,
        g.dat,
        g.aktion_id,
        g.herst_id,
        g.mwst_id,
        g.wrg_2,
        g.posten_id,
        g.bezugsweg_id,
        g.menge,
        g.umsatz_netto,
        g.umsatz_mwst_betrag,
        g.promo_fg,
        coalesce(g.ean_kasse, 9999) as ean_kasse,
        g.diff_umsatz_netto_konz,
        g.diff_umsatz_mwst_betrag_konz,
        g.bewart_det_id,
        g.kundenkarte_id,
        g.kundenkarte_typ_id,
        g.loyalty_berechtigt_fg
    from (
        select
            l.mandant_id as mandant_id,
            l.wup_id as wup_id,
            lkp_nb_id as nb_id,
            lkp_art_id as art_id,
            -1 as gp_id,
            -1 as einkaufsorganisation_id,
            case
                when l.dat_booking >= CAST(x.dat AS DATE)
                    then
                        case
                            when trim(l.aktion_id) <> ''
                                then 1002
                            else 1001
                        end
                else coalesce(r.bewart_id, 1001)
            end bewart_id,
            dat_booking as dat,
            case
                when l.dat_booking >= CAST(x.dat AS DATE)
                    then trim(l.aktion_id)
                else coalesce(r.aktion_id, '')
            end as aktion_id,
            -1 as herst_id,
            lkp_mwst_id as mwst_id,
            lkp_mwst,
            lkp_wrg as wrg_2,
            coalesce(lkp_posten_id, ' ') as posten_id,
            0 as bezugsweg_id,
            menge,
            cast(umsatz_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) as umsatz_brutto_ohne_promo,
            cast(umsatz_brutto * lkp_umrechnungskurs as NUMERIC) as umsatz_brutto_ohne_promo_conv,
            cast(cast(umsatz_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) / (1 + (lkp_mwst / 100)) as NUMERIC) AS umsatz_netto,
            cast(cast(umsatz_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) - cast(cast(umsatz_brutto * case when y.conv_fg = 1 then lkp_umrechnungskurs else 1 end as NUMERIC) / (1 + (lkp_mwst / 100)) as NUMERIC) as NUMERIC) as umsatz_mwst_betrag,
            promo_fg,
            ean_kasse,
            kundenkarte_id,
            kundenkarte_typ_id,
            cast(umsatz_brutto / (1 + (lkp_mwst / 100)) * lkp_umrechnungskurs as NUMERIC) as diff_umsatz_netto_konz,
            cast(cast(umsatz_brutto * lkp_umrechnungskurs as NUMERIC) - cast(umsatz_brutto / (1 + (lkp_mwst / 100)) * lkp_umrechnungskurs as NUMERIC) as NUMERIC) as diff_umsatz_mwst_betrag_konz,
            bewart_det_id,
            y.conv_fg,
            l.loyalty_berechtigt_fg
        from _artbew_subset3 l
        join dbp_etl_process.kpos_bon_bby_dates_2 x
            on l.mandant_id = x.mandant_id
        left join (
            select
                a.*,
                1 as conv_fg
            from dbp_data.mandant_wrg_zu_per_2 a
            where
                a.von_wrg_id is not null and
                a.wrg_id <> a.von_wrg_id and
                CURRENT_DATE("Europe/Berlin") between a.dat_von and a.dat_bis
        ) y
            on
                l.mandant_id = y.mandant_id and
                l.lkp_wrg = y.wrg_id
        left join dbp_etl_process.marktabschriften_stamm_2 r
            on
                l.mandant_id = r.mandant_id and
                l.lkp_art_id = r.art_id and
                l.wup_id = r.wup_id and
                l.lkp_nb_id = r.nb_id and
                l.dat_booking = r.dat
    ) g
    where (g.mandant_id, g.art_id) not in (
        select (mandant_id, art_id)
        FROM (
            select
                mandant_id,
                art_id
            from dbp_data.art_wg_zu_per_2
            where
                mandant_id > 1 and
                arthiertyp_id = 2 and
                dat_bis = '9999-12-31' and
                wg_id = 961
            union distinct
            select
                mandant_id,
                art_id
            from dbp_data.art_wg_zu_per_2
            where
                mandant_id = 7 and
                arthiertyp_id = 2 and
                dat_bis = '9999-12-31' and
                wg_id = 980
            union distinct
            select
                mandant_id,
                art_id
            from dbp_data.art_2
            where
                mandant_id = 2 and
                art_id in (818410, 202685400, 1485930, 207699370)
        )
    )
);

update _crm1 set bewart_id = 1001
where bewart_det_id in (100110, 100111, 100121, 100130, 100131);


delete from dbp_data.crm_kartebew_2 a
where
    a.dat in (select distinct dat from dbp_etl.kmo_artbew_bon_dat_2) and
    (a.mandant_id, a.wup_id, a.dat) in (select distinct (mandant_id, wup_id, dat) from _crm1);

insert into dbp_data.crm_kartebew_2 (
    mandant_id,
    wup_id,
    nb_id,
    kundenkarte_id,
    dat,
    wrg_id,
    umsatz_netto_sa,
    umsatz_netto_af,
    umsatz_brutto_sa,
    umsatz_brutto_af,
    anz_bons,
    td_insert,
    td_update,
    loyalty_berechtigt_fg
)
select
    aktc.mandant_id,
    aktc.wup_id,
    aktc.nb_id,
    aktc.kundenkarte_id,
    aktc.dat,
    aktc.wrg_2,
    sum(case when aktc.bewart_id = 1002 then aktc.umsatz_netto else 0 end) as umsatz_netto_sa,
    sum(case when aktc.bewart_id = 1001 then aktc.umsatz_netto else 0 end) as umsatz_netto_af,
    sum(case when aktc.bewart_id = 1002 then aktc.umsatz_netto + aktc.umsatz_mwst_betrag else 0 end) as umsatz_brutto_sa,
    sum(case when aktc.bewart_id = 1001 then aktc.umsatz_netto + aktc.umsatz_mwst_betrag else 0 end) as umsatz_brutto_af,
    max(k.anz_bon) as anz_bons,
    current_timestamp,
    current_timestamp,
    CAST(case
        when aktc.dat >= '2025-03-01'
            then aktc.loyalty_berechtigt_fg
        else -1
    end AS INT64) as loyalty_berechtigt_fg
from _crm1 aktc
join _crm_keys k
    on
        aktc.mandant_id = k.mandant_id and
        aktc.wup_id = k.wup_id and
        aktc.nb_id = k.nb_id and
        aktc.kundenkarte_id = k.kundenkarte_id and
        aktc.dat = k.dat and
        aktc.wrg_2 = k.wrg_2
left join dbp_data.bewart_det_ecommerce_2 bde
    on
        aktc.mandant_id = bde.mandant_id and
        aktc.kundenkarte_id = bde.kundenkarte_id
where
    aktc.kundenkarte_id is not null and
    bde.kundenkarte_id is null
group by all;

DROP TABLE IF EXISTS dbp_etl.artbew_kmo_tmp_2;


DROP TABLE IF EXISTS dbp_etl.kmo_artbew_bon_aktion_relevant_2;
