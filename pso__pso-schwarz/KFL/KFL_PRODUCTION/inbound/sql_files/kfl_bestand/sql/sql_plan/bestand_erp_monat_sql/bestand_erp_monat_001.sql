--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE OR REPLACE TABLE DBP_ETL.bestand_mardh_tmp1_1 LIKE
DBP_DATA.bestand_erp_monat;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.bestand_mardh_tmp1_1
(
art_id
,mandant_id
,wup_id
,nb_id
,gjmo
,lagerort_id
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_qual_bme
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_ret_gesp_bme
,gjmo_bis
,mard_fg
)
SELECT
art_id
,mandant_id
,wup_id
,nb_id
,gjmo
,lagerort_id
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_qual_bme
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_ret_gesp_bme
,gjmo_bis
,mard_fg
FROM DBP_DATA.bestand_erp_monat
-- zu den gelieferten Datensaetzen passende Daten
WHERE (art_id, mandant_id, wup_id, nb_id, lagerort_id) IN
(SELECT art_id, mandant_id, wup_id, nb_id, lagerort_id
FROM DBP_ETL.bestand_mardh_tmp
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.bestand_mardh_tmp
(
art_id
,mandant_id
,wup_id
,nb_id
,gjmo
,gjmo_bis
,lagerort_id
,mard_fg
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_qual_bme
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_ret_gesp_bme
,lade_kz
)
SELECT
art_id
,mandant_id
,wup_id
,nb_id
,gjmo
,gjmo_bis
,lagerort_id
,mard_fg
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_qual_bme
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_ret_gesp_bme
,1                          AS lade_kz
FROM DBP_ETL.bestand_mardh_tmp1_1
WHERE mard_fg = 0   -- Nur Saetze aus MARDH zurueckholen
-- Datensatz mit gleichem gjmo_bis ausschliessen
AND (art_id, mandant_id, wup_id, nb_id, lagerort_id, gjmo_bis) NOT IN
(SELECT art_id, mandant_id, wup_id, nb_id, lagerort_id, gjmo_bis
FROM DBP_ETL.bestand_mardh_tmp
)
;


CREATE OR REPLACE TABLE DBP_ETL.bestand_mardh_tmp2  (
art_id                            INTEGER NOT NULL,
mandant_id                        BYTEINT NOT NULL ,
wup_id                            INTEGER NOT NULL ,
nb_id                             SMALLINT NOT NULL ,
gjmo                              INTEGER NOT NULL,
lagerort_id                       CHAR(4) COLLATE 'en-ci' NOT NULL,
max_dat                           DATE NOT NULL
, UNIQUE ( art_id, mandant_id, wup_id, nb_id, gjmo, lagerort_id )
);

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.bestand_mardh_tmp2
(
art_id
,mandant_id
,wup_id
,nb_id
,lagerort_id
,gjmo
,max_dat
)
SELECT
bmt1.art_id                           AS art_id
,bmt1.mandant_id                       AS mandant_id
,bmt1.wup_id                           AS wup_id
,bmt1.nb_id                            AS nb_id
,bmt1.lagerort_id                      AS lagerort_id
,m.gjmo_                               AS gjmo
,m.max_dat                             AS max_dat
FROM
(SELECT
art_id
,mandant_id
,wup_id
,nb_id
,lagerort_id
,MAX(gjmo_bis)     AS max_gjmo_bis
FROM DBP_ETL.bestand_mardh_tmp
WHERE nb_id = 0
GROUP BY
art_id
,mandant_id
,wup_id
,nb_id
,lagerort_id
) bmt1
INNER JOIN
(SELECT
mb.mandant_id
--,spkz.gjmo
,CAST(TRIM(spkz.sap_buchungs_jahr)||CASE WHEN TRIM(spkz.buchungsperiode_id) <= 9 THEN CAST ('0'||TRIM(spkz.buchungsperiode_id) AS CHAR(2)) ELSE TRIM(spkz.buchungsperiode_id) END AS INTEGER) AS gjmo_
,MAX(t.dat)       AS max_dat
FROM
(SELECT
mandant_id
,MAX(dat) mbest_max_tag
FROM DBP_DATA.marktbestand_erp
WHERE dat BETWEEN CURRENT_DATE-10 AND CURRENT_DATE
GROUP BY mandant_id
) mb
INNER JOIN
DBP_DATA.tag t
ON  t.dat <= mb.mbest_max_tag

INNER JOIN DBP_DATA.sap_periode_kalender_zu spkz
ON spkz.mandant_id =mb.mandant_id
AND spkz.kjmo = t.kjmo
AND krk_id IN ('DE01', 'CZ01', 'SK01', 'HR01', 'PL01', 'RO01', 'BG01')
AND buchungsperiode_id <=12

GROUP BY 1,2
) m
ON  m.gjmo_ > bmt1.max_gjmo_bis
AND m.mandant_id = bmt1.mandant_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.bestand_mardh_tmp2
(
art_id
,mandant_id
,wup_id
,nb_id
,lagerort_id
,gjmo
,max_dat
)
SELECT
bmt1.art_id                           AS art_id
,bmt1.mandant_id                       AS mandant_id
,bmt1.wup_id                           AS wup_id
,bmt1.nb_id                            AS nb_id
,bmt1.lagerort_id                      AS lagerort_id
,l.gjmo_                                AS gjmo
,l.max_dat                             AS max_dat
FROM
(SELECT
art_id
,mandant_id
,wup_id
,nb_id
,lagerort_id
,MAX(gjmo_bis)     AS max_gjmo_bis
FROM DBP_ETL.bestand_mardh_tmp
WHERE nb_id <> 0
GROUP BY
art_id
,mandant_id
,wup_id
,nb_id
,lagerort_id
) bmt1
INNER JOIN
( SELECT
spkz.mandant_id
,CAST(TRIM(spkz.sap_buchungs_jahr)||CASE WHEN TRIM(spkz.buchungsperiode_id) <= 9 THEN CAST ('0'||TRIM(spkz.buchungsperiode_id) AS CHAR(2)) ELSE TRIM(spkz.buchungsperiode_id) END AS INTEGER) AS gjmo_
,MAX(dat)       AS max_dat
FROM DBP_DATA.tag t
INNER JOIN DBP_DATA.sap_periode_kalender_zu spkz
--ON spkz.mandant_id =bmt1.mandant_id
ON  spkz.kjmo = t.kjmo
AND krk_id IN ('DE01', 'CZ01', 'SK01', 'HR01', 'PL01', 'RO01', 'BG01')
AND buchungsperiode_id <=12
WHERE dat <= CURRENT_DATE
GROUP BY 1,2
) l

ON l.mandant_id =bmt1.mandant_id

AND  l.gjmo_ > bmt1.max_gjmo_bis
;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE OR REPLACE TABLE DBP_ETL.bestand_mardh_tmp3  (
art_id                            INTEGER NOT NULL,
mandant_id                        BYTEINT NOT NULL ,
wup_id                            INTEGER NOT NULL ,
nb_id                             SMALLINT NOT NULL ,
gjmo                              INTEGER NOT NULL,
gjmo_bis                          INTEGER NOT NULL,
lagerort_id                       CHAR(4) COLLATE 'en-ci' NOT NULL,
mard_fg                           BYTEINT NOT NULL ,
menge_lgbest_erp_frei_bme         DECIMAL(18,3) ,
menge_lgbest_erp_umlag_bme        DECIMAL(18,3) ,
menge_lgbest_erp_qual_bme         DECIMAL(18,3) ,
menge_lgbest_erp_nf_charge_bme    DECIMAL(18,3) ,
menge_lgbest_erp_gesp_bme         DECIMAL(18,3) ,
menge_lgbest_erp_ret_gesp_bme     DECIMAL(18,3) )

;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.bestand_mardh_tmp3
(
art_id
,mandant_id
,wup_id
,nb_id
,gjmo
,gjmo_bis
,lagerort_id
,mard_fg
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_qual_bme
/* Folgende Bestandsarten (-gruende) sind noch nicht implementiert */
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_ret_gesp_bme
)
SELECT
art_id
,mandant_id
,wup_id
,nb_id
,gjmo
,999912           AS gjmo_bis
,lagerort_id
,1                AS mard_fg
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_qual_bme
/* Folgende Bestandsarten (-gruende) sind noch nicht implementiert, daher immern 0 */
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_ret_gesp_bme
FROM
( SELECT
m.art_id
,m.mandant_id
,m.wup_id
,m.nb_id
,bmt2.gjmo
,bmt2.lagerort_id
,m.menge_lgbest_erp_frei_bme
,m.menge_lgbest_erp_qual_bme
/* Folgende Bestandsarten (-gruende) sind noch nicht implementiert, daher immer 0 */
,0.0                         AS menge_lgbest_erp_umlag_bme
,0.0                         AS menge_lgbest_erp_nf_charge_bme
,0.0                         AS menge_lgbest_erp_gesp_bme
,0.0                         AS menge_lgbest_erp_ret_gesp_bme
FROM DBP_DATA.marktbestand_erp m
INNER JOIN
DBP_ETL.bestand_mardh_tmp2 bmt2
ON  m.art_id     = bmt2.art_id
AND m.mandant_id = bmt2.mandant_id
AND m.wup_id     = bmt2.wup_id
AND m.nb_id      = bmt2.nb_id
AND m.dat        = bmt2.max_dat
) tmp1
-- Nur Bestaende uebernehmen, die sich geändert haben, unveraenderte Bestaende ausfiltern
QUALIFY COUNT(*) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
ORDER BY gjmo ASC ROWS 1 PRECEDING) = 1
OR SUM(menge_lgbest_erp_frei_bme) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
ORDER BY gjmo ASC ROWS 1 PRECEDING) <> 2.0* menge_lgbest_erp_frei_bme
OR SUM(menge_lgbest_erp_qual_bme) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
ORDER BY gjmo ASC ROWS 1 PRECEDING) <> 2.0* menge_lgbest_erp_qual_bme
/* Folgende Bestandsarten (-gruende) sind noch nicht implementiert */
OR SUM(menge_lgbest_erp_umlag_bme) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
ORDER BY gjmo ASC ROWS 1 PRECEDING) <> 2.0* menge_lgbest_erp_umlag_bme
OR SUM(menge_lgbest_erp_nf_charge_bme) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
ORDER BY gjmo ASC ROWS 1 PRECEDING) <> 2.0* menge_lgbest_erp_nf_charge_bme
OR SUM(menge_lgbest_erp_gesp_bme) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
ORDER BY gjmo ASC ROWS 1 PRECEDING) <> 2.0* menge_lgbest_erp_gesp_bme
OR SUM(menge_lgbest_erp_ret_gesp_bme) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
ORDER BY gjmo ASC ROWS 1 PRECEDING) <> 2.0* menge_lgbest_erp_ret_gesp_bme
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.bestand_mardh_tmp3
(
art_id
,mandant_id
,wup_id
,nb_id
,gjmo
,gjmo_bis
,lagerort_id
,mard_fg
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_qual_bme
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_ret_gesp_bme
)
SELECT
art_id
,mandant_id
,wup_id
,nb_id
,gjmo
,999912           AS gjmo_bis
,lagerort_id
,1                AS mard_fg
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_qual_bme
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_ret_gesp_bme
FROM
( SELECT
l.art_id
,l.mandant_id
,l.wup_id
,l.nb_id
,bmt2.gjmo
,l.lagerort_id
,l.menge_lgbest_erp_frei_bme
,l.menge_lgbest_erp_qual_bme
,l.menge_lgbest_erp_umlag_bme
,l.menge_lgbest_erp_nf_charge_bme
,l.menge_lgbest_erp_gesp_bme
,l.menge_lgbest_erp_ret_gesp_bme
FROM DBP_DATA.lagerbestand_erp_per l
INNER JOIN
DBP_ETL.bestand_mardh_tmp2 bmt2
ON  l.art_id      = bmt2.art_id
AND l.mandant_id  = bmt2.mandant_id
AND l.wup_id      = bmt2.wup_id
AND l.nb_id       = bmt2.nb_id
AND l.lagerort_id = bmt2.lagerort_id
AND bmt2.max_dat BETWEEN l.dat_von AND l.dat_bis
WHERE l.nb_id <> 0
) tmp1
-- Nur Bestaende uebernehmen, die sich geändert haben, unveraenderte Bestaende ausfiltern
QUALIFY COUNT(*) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
ORDER BY gjmo ASC ROWS 1 PRECEDING) = 1
OR SUM(menge_lgbest_erp_frei_bme) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
ORDER BY gjmo ASC ROWS 1 PRECEDING) <> 2.0* menge_lgbest_erp_frei_bme
OR SUM(menge_lgbest_erp_qual_bme) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
ORDER BY gjmo ASC ROWS 1 PRECEDING) <> 2.0* menge_lgbest_erp_qual_bme
OR SUM(menge_lgbest_erp_umlag_bme) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
ORDER BY gjmo ASC ROWS 1 PRECEDING) <> 2.0* menge_lgbest_erp_umlag_bme
OR SUM(menge_lgbest_erp_nf_charge_bme) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
ORDER BY gjmo ASC ROWS 1 PRECEDING) <> 2.0* menge_lgbest_erp_nf_charge_bme
OR SUM(menge_lgbest_erp_gesp_bme) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
ORDER BY gjmo ASC ROWS 1 PRECEDING) <> 2.0* menge_lgbest_erp_gesp_bme
OR SUM(menge_lgbest_erp_ret_gesp_bme) OVER (PARTITION BY mandant_id, art_id, wup_id, nb_id, lagerort_id
ORDER BY gjmo ASC ROWS 1 PRECEDING) <> 2.0* menge_lgbest_erp_ret_gesp_bme
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.bestand_erp_monat_tmp;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.bestand_erp_monat_tmp
LIKE DBP_DATA.bestand_erp_monat;

INSERT INTO DBP_ETL.bestand_erp_monat_tmp
(
art_id
,mandant_id
,wup_id
,nb_id
,gjmo
,gjmo_bis
,lagerort_id
,mard_fg
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_qual_bme
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_ret_gesp_bme
)
SELECT
art_id
,mandant_id
,wup_id
,nb_id
-- Fuer die MARDH-Saetze (mard_fg=0) muss gjmo ermittelt werden
,CASE WHEN mard_fg = 0
THEN CASE WHEN COUNT(*) OVER (PARTITION BY art_id, mandant_id, wup_id, nb_id, lagerort_id
ORDER BY gjmo_bis  ASC ROWS 1 PRECEDING) = 1
THEN gjmo

ELSE TO_NUMBER(TO_CHAR(ADD_MONTHS(TO_DATE(TO_CHAR(LAG(gjmo_bis,1) OVER (PARTITION BY art_id, mandant_id, wup_id, nb_id, lagerort_id
                                         ORDER BY gjmo_bis ASC )  ),'YYYYMM'),-1),'YYYYMM'))

END
ELSE gjmo
END                        AS gjmo_ab
-- Fuer Tages-Saetze (mard_fg=1) muss gjmo_bis ermittelt werden
,COALESCE(CASE 
            WHEN mard_fg = 1
            THEN CASE 
                   WHEN COUNT(*) OVER (PARTITION BY art_id, mandant_id, wup_id, nb_id, lagerort_id ORDER BY gjmo DESC  ROWS 1 PRECEDING) = 1
                   THEN gjmo_bis
                   ELSE TO_NUMBER(TO_CHAR(ADD_MONTHS(TO_DATE(TO_CHAR(LAG(gjmo,1) OVER (PARTITION BY art_id, mandant_id, wup_id, nb_id, lagerort_id ORDER BY gjmo DESC )  ),'YYYYMM'),-1),'YYYYMM'))
                 END
            ELSE gjmo_bis
          END,gjmo_ab) AS _gjmo_bis
,lagerort_id
,mard_fg
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_qual_bme
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_ret_gesp_bme
FROM
(SELECT
art_id
,mandant_id
,wup_id
,nb_id
,gjmo
,gjmo_bis
,lagerort_id
,mard_fg
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_qual_bme
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_ret_gesp_bme
FROM DBP_ETL.bestand_mardh_tmp
UNION ALL
SELECT
art_id
,mandant_id
,wup_id
,nb_id
,gjmo
,gjmo_bis
,lagerort_id
,mard_fg
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_qual_bme
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_ret_gesp_bme
FROM DBP_ETL.bestand_mardh_tmp3
) tmp
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.bestand_erp_monat
WHERE (art_id, mandant_id, wup_id, nb_id, lagerort_id) IN
(SELECT art_id, mandant_id, wup_id, nb_id, lagerort_id
FROM DBP_ETL.bestand_erp_monat_tmp
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.bestand_erp_monat
(
art_id
,mandant_id
,wup_id
,nb_id
,gjmo
,gjmo_bis
,lagerort_id
,mard_fg
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_qual_bme
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_ret_gesp_bme
,td_insert
,td_update
)
SELECT
art_id
,mandant_id
,wup_id
,nb_id
,gjmo
,gjmo_bis
,lagerort_id
,mard_fg
,menge_lgbest_erp_frei_bme
,menge_lgbest_erp_umlag_bme
,menge_lgbest_erp_qual_bme
,menge_lgbest_erp_nf_charge_bme
,menge_lgbest_erp_gesp_bme
,menge_lgbest_erp_ret_gesp_bme
,CURRENT_TIMESTAMP
,CURRENT_TIMESTAMP

FROM DBP_ETL.bestand_erp_monat_tmp
;

