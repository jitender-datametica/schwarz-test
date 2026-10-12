USE WAREHOUSE WH_KFL_P_ETL_2XL;

CREATE OR REPLACE VOLATILE TABLE _step01_2 (
  mandant_id BYTEINT,
  wup_id INTEGER,
  nb_id SMALLINT,
  art_id INTEGER,
  bewart_id INTEGER,
  bewart_det_id INTEGER,
  dat DATE,
  wrg_2 CHAR(3),
  ean_kasse DECIMAL(26,0), 
  menge FLOAT,
  umsatz_netto_alt DECIMAL(18,4),
  umsatz_mwst_betrag_alt DECIMAL(18,4),
  umsatz_bto DECIMAL(18,4),
  umrechnungskurs FLOAT,
  kopf_art_id INTEGER,
  komponentenmengen_faktor DECIMAL(18,4),
  stueckliste_id INTEGER
);

CREATE OR REPLACE VOLATILE TABLE _step02_2 (
  mandant_id BYTEINT,
  wup_id INTEGER,
  nb_id SMALLINT,
  art_id INTEGER,
  bewart_id INTEGER,
  bewart_det_id INTEGER,
  dat DATE,
  wrg_2 CHAR(3),
  ean_kasse DECIMAL(26,0), 
  menge FLOAT,
  umsatz_netto_alt DECIMAL(18,4),
  umsatz_mwst_betrag_alt DECIMAL(18,4),
  umsatz_bto DECIMAL(18,4),
  umrechnungskurs FLOAT,
  kopf_art_id INTEGER,
  komponentenmengen_faktor DECIMAL(18,4),
  stueckliste_id INTEGER,
  bq_findung_id BYTEINT,
  ek_brutto DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_nettonetto DECIMAL(18,4),
  ek_kal_basis DECIMAL(18,4),
  ek_mep DECIMAL(18,4),
  einstandspreis DECIMAL(18,4),
  logistikkostenzuschlag DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto_bnk_sachk DECIMAL(18,4),
  ek_mep_vor_fwu DECIMAL(18,4),
  bonusbasis DECIMAL(18,4)
);

CREATE OR REPLACE VOLATILE TABLE _step02a_2 (
  mandant_id BYTEINT,
  wup_id INTEGER,
  nb_id SMALLINT,
  art_id INTEGER,
  bewart_id INTEGER,
  bewart_det_id INTEGER,
  dat DATE,
  wrg_2 CHAR(3),
  ean_kasse DECIMAL(26,0), 
  menge FLOAT,
  umsatz_netto_alt DECIMAL(18,4),
  umsatz_mwst_betrag_alt DECIMAL(18,4),
  umsatz_bto DECIMAL(18,4),
  umrechnungskurs FLOAT,
  kopf_art_id INTEGER,
  komponentenmengen_faktor DECIMAL(18,4),
  stueckliste_id INTEGER,
  bq_findung_id BYTEINT,
  umsatz_anteil DECIMAL(18,4),
  umsatz_netto DECIMAL(18,4),
  umsatz_mwst DECIMAL(18,4),
  ek_brutto DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_nettonetto DECIMAL(18,4),
  ek_kal_basis DECIMAL(18,4),
  ek_mep DECIMAL(18,4),
  einstandspreis DECIMAL(18,4),
  logistikkostenzuschlag DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto_bnk_sachk DECIMAL(18,4),
  ek_mep_vor_fwu DECIMAL(18,4),
  bonusbasis DECIMAL(18,4),
  diff_ek_brutto_konz DECIMAL(18,4),
  diff_ek_netto_konz DECIMAL(18,4),
  diff_ek_nettonetto_konz DECIMAL(18,4),
  diff_ek_kal_basis_konz DECIMAL(18,4),
  diff_ek_mep_konz DECIMAL(18,4),
  diff_einstandspreis_konz DECIMAL(18,4),
  diff_logkostenzuschlag_konz DECIMAL(18,4),
  diff_ek_netto_bnk_konz DECIMAL(18,4),
  diff_ek_netto_bnk_sachk_konz DECIMAL(18,4),
  ek_mep_vor_fwu_konz DECIMAL(18,4),
  bonusbasis_konz DECIMAL(18,4)
);

CREATE OR REPLACE VOLATILE TABLE _step03_2 (
  mandant_id BYTEINT,
  wup_id INTEGER,
  nb_id SMALLINT,
  art_id INTEGER,
  bewart_id INTEGER,
  bewart_det_id INTEGER,
  dat DATE,
  wrg_2 CHAR(3),
  ean_kasse DECIMAL(26,0), 
  menge FLOAT,
  umsatz_netto_alt DECIMAL(18,4),
  umsatz_mwst_betrag_alt DECIMAL(18,4),
  umsatz_bto DECIMAL(18,4),
  umrechnungskurs FLOAT,
  kopf_art_id INTEGER,
  komponentenmengen_faktor DECIMAL(18,4),
  stueckliste_id INTEGER,
  bq_findung_id BYTEINT,
  umsatz_anteil DECIMAL(18,4),
  umsatz_netto DECIMAL(18,4),
  umsatz_mwst DECIMAL(18,4),
  ek_brutto DECIMAL(18,4),
  ek_netto DECIMAL(18,4),
  ek_nettonetto DECIMAL(18,4),
  ek_kal_basis DECIMAL(18,4),
  ek_mep DECIMAL(18,4),
  einstandspreis DECIMAL(18,4),
  logistikkostenzuschlag DECIMAL(18,4),
  ek_netto_bnk DECIMAL(18,4),
  ek_netto_bnk_sachk DECIMAL(18,4),
  ek_mep_vor_fwu DECIMAL(18,4),
  bonusbasis DECIMAL(18,4),
  diff_ek_brutto_konz DECIMAL(18,4),
  diff_ek_netto_konz DECIMAL(18,4),
  diff_ek_nettonetto_konz DECIMAL(18,4),
  diff_ek_kal_basis_konz DECIMAL(18,4),
  diff_ek_mep_konz DECIMAL(18,4),
  diff_einstandspreis_konz DECIMAL(18,4),
  diff_logkostenzuschlag_konz DECIMAL(18,4),
  diff_ek_netto_bnk_konz DECIMAL(18,4),
  diff_ek_netto_bnk_sachk_konz DECIMAL(18,4),
  ek_mep_vor_fwu_konz DECIMAL(18,4),
  bonusbasis_konz DECIMAL(18,4)
);

CREATE OR REPLACE VOLATILE TABLE _aggregat01_2 (
  mandant_id BYTEINT,
  art_id INTEGER,
  bewart_id INTEGER,
  bewart_det_id INTEGER,
  wup_id INTEGER,
  nb_id SMALLINT,
  dat DATE,
  ean_kasse DECIMAL(26,0), 
  umsatz_netto DECIMAL(18,4)
);

CREATE OR REPLACE VOLATILE TABLE _spannen_agg1 (
  mandant_id BYTEINT,
  wup_id INTEGER,
  kopf_art_id INTEGER,
  bewart_id INTEGER,
  bewart_det_id INTEGER,
  stueckliste_id INTEGER,
  dat DATE,
  ean_kasse DECIMAL(26,0), 
  ek_netto_sum DECIMAL(18,4)
);

/*
_------------------------------------------------------------------------------
_ 12.) Stuecklisten aus ARTBEW_STUECKLISTE_ZU_2 fuer RB extrahieren.
_------------------------------------------------------------------------------
*/

INSERT INTO _step01_2 (mandant_id,
                     wup_id,
                     nb_id,
                     art_id,
                     bewart_id,
                     bewart_det_id,
                     dat,
                     wrg_2,
                     ean_kasse,
                     menge,
                     umsatz_netto_alt,
                     umsatz_mwst_betrag_alt,
                     umsatz_bto,
                     umrechnungskurs,
                     kopf_art_id,
                     komponentenmengen_faktor,
                     stueckliste_id)
SELECT a.mandant_id,
       a.wup_id,
       a.nb_id,
       b.art_id,
       a.bewart_id,
       a.bewart_det_id,
       a.dat,
       a.wrg_2,
       a.ean_kasse,
       SUM(CAST(a.menge AS FLOAT)) AS menge,
       SUM(CAST(a.umsatz_netto AS DECIMAL(18,4))) AS umsatz_netto_alt,
       SUM(CAST(a.umsatz_mwst_betrag AS DECIMAL(18,4))) AS umsatz_mwst_betrag_alt,
       SUM(CAST(a.umsatz_netto+a.umsatz_mwst_betrag AS DECIMAL(18,4))) AS umsatz_bto,
       CAST(0 AS FLOAT) AS umrechnungskurs,
       a.art_id AS kopf_art_id,
       -- falls eine_2 Komponente mehrfach in der Stueckliste_2 vorhanden ist: Menge aufsummieren 
       CAST(SUM(CAST(a.menge AS FLOAT) * CAST(b.komponentenmenge AS FLOAT)) / MAX(COALESCE(c.umrech_faktor, 1.0000)) AS DECIMAL(18,4)) AS komponentenmengen_faktor,
       b.stueckliste_id
FROM DBP_DATA.artbew_2 a

JOIN DBP_ETL.kmo_wpuums_dat_2 d
  ON a.dat = d.dat
  
JOIN DBP_ETL.kmo_wpuums_art_gp_wup_zu_2 z
  ON a.mandant_id = z.mandant_id AND 
     a.art_id     = z.art_id     AND 
     a.wup_id     = z.wup_id     AND 
     a.nb_id      = z.nb_id      AND 
     a.dat        = z.dat

JOIN (SELECT a.mandant_id,
             a.stueckliste_id,
             a.dat_von,
             a.dat_bis,
             a.art_id,
             NULL wup_id,
             NULL nb_id,
             a.stueckliste_verwendung_id
      FROM DBP_DATA.stueckliste_2 a
      JOIN DBP_ETL.kmo_wpuums_dat_min_2 m
        ON a.dat_bis >= m.dat
      WHERE --a.wup_id IS NULL AND
            a.stueckliste_verwendung_id = 3 AND
           (a.mandant_id, a.art_id, a.stueckliste_id) IN (SELECT mandant_id,
                                                                 art_id,
                                                                 MAX(stueckliste_id) AS stueckliste_id
                                                          FROM DBP_DATA.stueckliste_2
                                                          GROUP BY 1,2)) k
  ON a.mandant_id = k.mandant_id  AND 
     a.art_id     = k.art_id      AND
     a.dat BETWEEN k.dat_von AND k.dat_bis

-- Ermittlung Fußartikel_2
JOIN (SELECT *
      FROM DBP_DATA.stueckliste_det_2
      WHERE stueckliste_typ_id = 'M') b
  ON k.mandant_id     = b.mandant_id     AND 
     k.stueckliste_id = b.stueckliste_id AND
     a.dat BETWEEN b.dat_von AND b.dat_bis

-- Ermittlung Umrechnungsfaktor, damit korrekter Bezug zur Basismengeneinheit hergestellt wird.
LEFT JOIN DBP_DATA.art_umrechnung_faktor_per_2 c
ON b.mandant_id               = c.mandant_id          AND 
   b.art_id                   = c.art_id              AND 
   b.komponentenmenge_einh_id = c.altnv_menge_einh_id AND 
   a.dat BETWEEN c.dat_von AND c.dat_bis 
   
WHERE a.mandant_id > 1    AND
      a.menge <> 0        AND
      a.umsatz_netto <> 0
GROUP BY a.mandant_id,a.wup_id,a.nb_id,b.art_id,a.dat,a.art_id,a.bewart_id,a.bewart_det_id,b.stueckliste_id,a.wrg_2,a.ean_kasse
;

/*
_------------------------------------------------------------------------------
_ 13.) Zuspielen der STKL-Koepfe in volatile Tabelle
_------------------------------------------------------------------------------
*/

-- 18.12.2012, -dba-
--
-- Nachgelagert werden dann alle Koepfe in dieselbe volatile Tabelle gespielt. Als Kennung wird in die Spalte
-- KOPF_ART_ID nun der Wert "-100" eingestellt, um spaeter zwischen Kopf und Fuß unterscheiden zu koennen.

INSERT INTO _step01_2 (mandant_id,
                     wup_id,
                     nb_id,
                     art_id,
                     bewart_id,
                     bewart_det_id,
                     dat,
                     wrg_2,
                     ean_kasse,
                     menge,
                     umsatz_netto_alt,
                     umsatz_mwst_betrag_alt,
                     umsatz_bto,
                     umrechnungskurs,
                     kopf_art_id,
                     komponentenmengen_faktor,
                     stueckliste_id)
SELECT a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.bewart_id,
       a.bewart_det_id,
       a.dat,
       a.wrg_2,
       a.ean_kasse,
       SUM(CAST(a.menge AS FLOAT)) AS menge,
       SUM(CAST(a.umsatz_netto AS DECIMAL(18,4))) AS umsatz_netto_alt,
       SUM(CAST(a.umsatz_mwst_betrag AS DECIMAL(18,4))) AS umsatz_mwst_betrag_alt,
       SUM(CAST(a.umsatz_netto+a.umsatz_mwst_betrag AS DECIMAL(18,4))) AS umsatz_bto,
       CAST(b.umrechnungskurs AS FLOAT) AS umrechnungskurs,
       -100 AS kopf_art_id,
       0 AS komponentenmengen_faktor,
       c.stueckliste_id
FROM DBP_DATA.artbew_2 a

JOIN DBP_ETL.kmo_wpuums_dat_2 d
  ON a.dat = d.dat

JOIN DBP_ETL.kmo_wpuums_art_gp_wup_zu_2 b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id     = b.wup_id     AND
     a.nb_id      = b.nb_id      AND
     a.art_id     = b.art_id     AND
     a.dat        = b.dat

JOIN (SELECT a.mandant_id,
             a.stueckliste_id,
             a.dat_von,
             a.dat_bis,
             a.art_id,
             NULL wup_id,
             NULL nb_id,
             a.stueckliste_verwendung_id
      FROM DBP_DATA.stueckliste_2 a
      JOIN DBP_ETL.kmo_wpuums_dat_min_2 m
        ON a.dat_bis >= m.dat
      WHERE -- a.wup_id IS NULL AND
            a.stueckliste_verwendung_id = 3 AND
           (a.mandant_id, a.art_id, a.stueckliste_id) IN (SELECT mandant_id,
                                                                 art_id,
                                                                 MAX(stueckliste_id) AS stueckliste_id
                                                          FROM DBP_DATA.stueckliste_2
                                                          GROUP BY 1,2)) c
  ON a.mandant_id = c.mandant_id  AND 
     a.art_id     = c.art_id      AND
     a.dat BETWEEN c.dat_von AND c.dat_bis

WHERE a.mandant_id > 1    AND
      a.menge <> 0        AND
      a.umsatz_netto <> 0
GROUP BY a.mandant_id,a.wup_id,a.nb_id,a.art_id,a.dat,b.umrechnungskurs,a.art_id,a.bewart_id,a.bewart_det_id,c.stueckliste_id,a.wrg_2,a.ean_kasse
;

/*
_------------------------------------------------------------------------------
_ 14.) Anreicherung der Fueße um Umrechnungskurs von Kopf
_------------------------------------------------------------------------------
*/

UPDATE _step01_2 FROM (SELECT mandant_id,
                            wup_id,
                            nb_id,
                            art_id,
                            bewart_id,
                            bewart_det_id,
                            dat,
                            umrechnungskurs,
                            stueckliste_id,
                            ean_kasse
                     FROM _step01_2
                     WHERE kopf_art_id = -100
                     GROUP BY 1,2,3,4,5,6,7,8,9,10) b
                     
SET umrechnungskurs = b.umrechnungskurs

WHERE _step01.mandant_id     = b.mandant_id     AND
      _step01.wup_id         = b.wup_id         AND
      _step01.nb_id          = b.nb_id          AND
      _step01.kopf_art_id    = b.art_id         AND
      _step01.dat            = b.dat            AND
      _step01.stueckliste_id = b.stueckliste_id AND
      _step01.ean_kasse      = b.ean_kasse      AND
      _step01.bewart_id      = b.bewart_id      AND
      _step01.bewart_det_id  = b.bewart_det_id  AND
      _step01.kopf_art_id   <> -100
;
      
/*
_------------------------------------------------------------------------------
_ 15.) EK-Ermittlung
_------------------------------------------------------------------------------
*/

-- 18.12.2012, -dba-
--
-- Standardmaeßige EK-Ermittlung, die an dieser Stelle nur fuer die Fußartikel_2 greift, da die VK_2-Set Kopfartikel
-- NICHT in der EK-Tabelle gefuehrt werden! Somit sind selbige nach diesem Step noch NULL!

INSERT INTO _step02_2 (mandant_id,
                     wup_id,
                     nb_id,
                     art_id,
                     bewart_id,
                     bewart_det_id,
                     dat,
                     wrg_2,
                     ean_kasse,
                     menge,
                     umsatz_netto_alt,
                     umsatz_mwst_betrag_alt,
                     umsatz_bto,
                     umrechnungskurs,
                     kopf_art_id,
                     komponentenmengen_faktor,
                     stueckliste_id,
                     bq_findung_id,
                     ek_brutto,
                     ek_netto,
                     ek_nettonetto,
                     ek_kal_basis,
                     ek_mep,
                     einstandspreis,
                     logistikkostenzuschlag,
                     ek_netto_bnk,
                     ek_netto_bnk_sachk,
                     ek_mep_vor_fwu,
                     bonusbasis)
SELECT a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       a.bewart_id,
       a.bewart_det_id,
       a.dat,
       a.wrg_2,
       a.ean_kasse,
       a.menge,
       a.umsatz_netto_alt,
       a.umsatz_mwst_betrag_alt,
       a.umsatz_bto,
       a.umrechnungskurs,
       a.kopf_art_id,
       a.komponentenmengen_faktor,
       a.stueckliste_id,
       x.bq_findung_id,
       a.komponentenmengen_faktor * COALESCE(agw.ek_brutto, agww.ek_brutto)                                  AS ek_brutto_,
       a.komponentenmengen_faktor * COALESCE(agw.ek_netto, agww.ek_netto)                                    AS ek_netto_,
       a.komponentenmengen_faktor * COALESCE(agw.ek_nettonetto, agww.ek_nettonetto)                          AS ek_nettonetto_,
       a.komponentenmengen_faktor * COALESCE(agw.ek_kal_basis, agww.ek_kal_basis)                            AS ek_kal_basis_,
       a.komponentenmengen_faktor * COALESCE(agw.ek_mep, agww.ek_mep)                                        AS ek_mep_,
       a.komponentenmengen_faktor * COALESCE(agw.einstandspreis, agww.einstandspreis)                        AS einstandspreis_,
       a.komponentenmengen_faktor * COALESCE(agw.logistikkostenzuschlag, agww.logistikkostenzuschlag,0.0000) AS logistikkostenzuschlag_,
       a.komponentenmengen_faktor * COALESCE(agw.ek_netto_bnk, agww.ek_netto_bnk)                            AS ek_netto_bnk_,
       a.komponentenmengen_faktor * COALESCE(agw.ek_netto_bnk_sachk, agww.ek_netto_bnk_sachk)                AS ek_netto_bnk_sachk_,
       a.komponentenmengen_faktor * COALESCE(agw.ek_mep_vor_fwu, agww.ek_mep_vor_fwu)                        AS ek_mep_vor_fwu_,
       a.komponentenmengen_faktor * COALESCE(agw.bonusbasis, agww.bonusbasis)                                  AS bonusbasis_

FROM _step01_2 a

JOIN DBP_DATA.art_gp_nm_zu_per_2 x
  ON a.mandant_id = x.mandant_id AND
     a.art_id     = x.art_id     AND
     a.wup_id     = x.wup_id     AND
     a.dat BETWEEN x.dat_von AND x.dat_bis
                         
-- Ermittlung betriebsspezifischer ZEKP_2 Satz mit VZ aus
-- VZ Findung bei Bezugsweg 4 und Betrieb bei Bezugsweg 1
LEFT OUTER JOIN __vol_art_gp_wup_zu_per agw
  ON a.mandant_id                 = agw.mandant_id
    AND x.vz_wup_id               = agw.wup_id  /*hier Zugriff mit Wup_2/VZ aus Kreisprozess !!*/
    AND x.nb_id                   = agw.nb_id
    AND a.art_id                  = agw.art_id
    AND x.gp_id                   = agw.gp_id
    AND x.einkaufsorganisation_id = agw.einkaufsorganisation_id
    AND a.dat                     = agw.dat

-- Betrieb = blank für Bezugsweg 1 und 4 beim ersten
-- Zugriff nichts gefunden wird.
LEFT OUTER JOIN __vol_art_gp_wup_zu_per agww
  ON a.mandant_id                 = agww.mandant_id
    AND agww.wup_id               = -1  /*Betrieb = 'blank'*/
    AND a.art_id                  = agww.art_id
    AND x.gp_id                   = agww.gp_id
    AND x.einkaufsorganisation_id = agww.einkaufsorganisation_id
    AND a.dat                     = agww.dat
;

/*
_------------------------------------------------------------------------------
_ 16.) Update fuer NULLs bei EK-Werten
_------------------------------------------------------------------------------
*/

-- 18.12.2012, -dba-
--
-- Im normalen Deltabetrieb eigentlich ein obsoleter Step. Allerdings können durch das Anziehen unserer neuen
-- BQ-Tabelle ART_GP_NM_ZU_PER_2, die erst ab Oktober regelmaeßig mitlief, Ungenauigkeiten beim Lieferanten fuer
-- historische Daten (z.B. auf Q fuer Initialbefuellung!) entstehen. Deswegen zur Sicherheit noch einmal ein
-- Update und das Setzen auf den UMSATZ_NETTO (Spanne 0%) fuer solche Faelle.

UPDATE _step02_2

SET ek_brutto = umsatz_netto_alt,
    ek_netto  = umsatz_netto_alt,
    ek_nettonetto = umsatz_netto_alt,
    ek_kal_basis = umsatz_netto_alt,
    ek_mep = umsatz_netto_alt,
    einstandspreis = umsatz_netto_alt,
    ek_netto_bnk = umsatz_netto_alt,
    ek_netto_bnk_sachk = umsatz_netto_alt,
    ek_mep_vor_fwu = umsatz_netto_alt,
    bonusbasis = umsatz_netto_alt

WHERE _step02.kopf_art_id <> -100 AND
      _step02.ek_brutto IS NULL
;

/*
_------------------------------------------------------------------------------
_ 17.) Aufbau von zwei Hilfstabellen (Spannenermittlung)
_------------------------------------------------------------------------------
*/

-- 18.12.2012, -dba-
--
-- Zunaechst wird eine_2 Tabelle mit Kopfinformationen bzgl. UMSATZ_NETTO erstellt.
INSERT INTO _aggregat01_2 (mandant_id,
                         art_id,
                         bewart_id,
                         bewart_det_id,
                         wup_id,
                         nb_id,
                         dat,
                         ean_kasse,
                         umsatz_netto)
SELECT a.mandant_id,
       a.art_id,
       a.bewart_id,
       a.bewart_det_id,
       a.wup_id,
       a.nb_id,
       a.dat,
       a.ean_kasse,
       a.umsatz_netto_alt AS umsatz_netto
FROM _step02_2 a
WHERE a.kopf_art_id = -100
;

-- 18.12.2012, -dba-
--
-- Hier die ungleich wichtigere Tabelle! Da wir bei der Bestimmung der Umsatzanteile pro Komponente uns am
-- Verhaeltnis von EKN1 (Gesamt) zum EK-Wert eines Einzelartikels orientieren, wird hier in EK_NETTO_SUM 
-- der gesamte EKN1-Wert der Komponenten gespeichert.

INSERT INTO _spannen_agg1 (mandant_id,
                           wup_id,
                           kopf_art_id,
                           bewart_id,
                           bewart_det_id,
                           stueckliste_id,
                           dat,
                           ean_kasse,
                           ek_netto_sum)
SELECT a.mandant_id,
       a.wup_id,
       a.kopf_art_id,
       a.bewart_id,
       a.bewart_det_id,
       a.stueckliste_id,
       a.dat,
       a.ean_kasse,
       SUM(a.ek_netto) AS ek_netto_sum
FROM _step02_2 a
JOIN _aggregat01_2 b
  ON a.mandant_id  = b.mandant_id AND
     a.wup_id      = b.wup_id     AND
     a.kopf_art_id = b.art_id     AND
     a.dat         = b.dat        AND
     a.ean_kasse   = b.ean_kasse  AND
     a.bewart_id   = b.bewart_id  AND
     a.bewart_det_id = b.bewart_det_id
GROUP BY 1,2,3,4,5,6,7,8
;

/*
_------------------------------------------------------------------------------
_ 18.) Umsatzverteilung von Kopf auf Komponenten
_------------------------------------------------------------------------------
*/

INSERT INTO _step02a_2 (mandant_id,
                      wup_id,
                      nb_id,
                      art_id,
                      bewart_id,
                      bewart_det_id,
                      dat,
                      wrg_2,
                      ean_kasse,
                      menge,
                      umsatz_netto_alt,
                      umsatz_mwst_betrag_alt,
                      umsatz_bto,
                      umrechnungskurs,
                      kopf_art_id,
                      komponentenmengen_faktor,
                      stueckliste_id,
                      bq_findung_id,
                      umsatz_anteil,
                      umsatz_netto,
                      umsatz_mwst,
                      ek_brutto,
                      ek_netto,
                      ek_nettonetto,
                      ek_kal_basis,
                      ek_mep,
                      einstandspreis,
                      logistikkostenzuschlag,
                      ek_netto_bnk,
                      ek_netto_bnk_sachk,
                      ek_mep_vor_fwu,
                      bonusbasis,
                      diff_ek_brutto_konz,
                      diff_ek_netto_konz,
                      diff_ek_nettonetto_konz,
                      diff_ek_kal_basis_konz,
                      diff_ek_mep_konz,
                      diff_einstandspreis_konz,
                      diff_logkostenzuschlag_konz,
                      diff_ek_netto_bnk_konz,
                      diff_ek_netto_bnk_sachk_konz,
                      ek_mep_vor_fwu_konz,
                      bonusbasis_konz)
SELECT z.mandant_id,
       z.wup_id,
       z.nb_id,
       z.art_id,
       z.bewart_id,
       z.bewart_det_id,
       z.dat,
       z.wrg_2,
       z.ean_kasse,
       z.menge,
       z.umsatz_netto_alt,
       z.umsatz_mwst_betrag_alt,
       z.umsatz_bto,
       z.umrechnungskurs,
       z.kopf_art_id,
       z.komponentenmengen_faktor,
       z.stueckliste_id,
       z.bq_findung_id,
       CAST(z.ek_netto AS DECIMAL(18,10))/CAST(a.ek_netto_sum AS DECIMAL(18,10)) AS umsatz_anteil_,
       CAST(z.umsatz_netto_alt*umsatz_anteil_ AS DECIMAL(18,4)) AS umsatz_netto,
       CAST(z.umsatz_mwst_betrag_alt*umsatz_anteil_ AS DECIMAL(18,4)) AS umsatz_mwst,
       z.ek_brutto,
       z.ek_netto,
       z.ek_nettonetto,
       z.ek_kal_basis,
       z.ek_mep,
       z.einstandspreis,
       z.logistikkostenzuschlag,
       z.ek_netto_bnk,
       z.ek_netto_bnk_sachk,
       z.ek_mep_vor_fwu,
       z.bonusbasis,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_brutto_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_netto_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_nettonetto_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_kal_basis_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_mep_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_einstandspreis_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_logkostenzuschlag_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_netto_bnk_konz,
       CAST(0 AS DECIMAL(18,4)) AS diff_ek_netto_bnk_sachk_konz,
       CAST(0 AS DECIMAL(18,4)) AS ek_mep_vor_fwu_konz,
       CAST(0 AS DECIMAL(18,4)) AS bonusbasis_konz
FROM _step02_2 z
JOIN _spannen_agg1 a
  ON z.mandant_id     = a.mandant_id     AND
     z.wup_id         = a.wup_id         AND
     z.kopf_art_id    = a.kopf_art_id    AND
     z.stueckliste_id = a.stueckliste_id AND
     z.ean_kasse      = a.ean_kasse      AND 
     z.dat            = a.dat            AND
     z.bewart_id      = a.bewart_id      AND
     z.bewart_det_id  = a.bewart_det_id
WHERE a.ek_netto_sum <> 0
;

/*
_------------------------------------------------------------------------------
_ 19.) Manuelle Spannenpflege fuer Stuecklistenartikel
_------------------------------------------------------------------------------
*/

-- 18.12.2012, -dba-
--
-- Laut Konzept gilt die Regel: Manuelle Spannen stehen ueber der Stuecklistenaufloesung! Falls also fuer die
-- Komponentenartikel manuelle Spannen gepflegt sein sollten, wird das Ganze wieder ueberschrieben!!! Es obliegt 
-- somit dem Fachbereich, hier fuer eine_2 adäquate Pflege der VK_2-Set Artikel_2 zu sorgen, da ansonsten das Prozedere 
-- obsolet waere!

-- manuelle Spanne ohne Betriebsbezug
UPDATE _step02a_2 FROM (SELECT ein.mandant_id,
                             ein.art_id,
                             a.dat,
                             ein.ek_faktor AS zwgs,
                             COALESCE(mep.ek_faktor, ein.ek_faktor) AS zwgm,
                             COALESCE(ekbnk.ek_faktor, mep.ek_faktor, ein.ek_faktor) AS zwge
                      FROM DBP_ETL.kmo_wpuums_dat_2 a
                     
                      JOIN DBP_DATA.art_man_spanne_per_2 ein /*Einstandspreis zwingend erforderlich*/
                        ON ein.konditionsart_id = 'ZWGS' /*einstandspreis*/ AND 
                           ein.loesch_fg = 0 AND 
                           a.dat BETWEEN ein.dat_von AND ein.dat_bis
                     
                      LEFT JOIN DBP_DATA.art_man_spanne_per_2 mep /*optional*/
                        ON mep.mandant_id = ein.mandant_id AND 
                           mep.art_id  = ein.art_id AND 
                           mep.konditionsart_id = 'ZWGM' /*MEP*/ AND 
                           mep.loesch_fg = 0 AND 
                           a.dat BETWEEN mep.dat_von AND mep.dat_bis
                     
                      LEFT JOIN DBP_DATA.art_man_spanne_per_2 ekbnk /*optional*/
                        ON ekbnk.mandant_id = ein.mandant_id AND 
                           ekbnk.art_id  = ein.art_id AND 
                           ekbnk.konditionsart_id = 'ZWGE' /*eknetto bnk*/ AND 
                           ekbnk.loesch_fg = 0 AND 
                           a.dat BETWEEN ekbnk.dat_von AND ekbnk.dat_bis) ms
                          
SET ek_brutto                    = CAST(umsatz_netto * zwge AS DECIMAL(18,4))
   ,ek_netto                     = CAST(umsatz_netto * zwge AS DECIMAL(18,4))
   ,ek_nettonetto                = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,ek_kal_basis                 = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,ek_mep                       = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,einstandspreis               = CAST(umsatz_netto * zwgs AS DECIMAL(18,4))
   ,ek_netto_bnk                 = CAST(umsatz_netto * zwge AS DECIMAL(18,4))
   ,ek_netto_bnk_sachk           = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,ek_mep_vor_fwu               = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,bonusbasis                    = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))

WHERE _step02a.mandant_id     = ms.mandant_id
  AND _step02a.art_id         = ms.art_id
  AND _step02a.dat            = ms.dat
  AND _step02a.bq_findung_id  = 27
  AND _step02a.kopf_art_id   <> -100
;

-- Hier die betriebsspezifischen manuellen Spannenfaktoren
UPDATE _step02a_2 FROM (SELECT ein.mandant_id,
                             ein.wup_id,
                             ein.art_id,
                             a.dat,
                             ein.ek_faktor AS zwgs,
                             COALESCE(mep.ek_faktor, ein.ek_faktor) AS zwgm,
                             COALESCE(ekbnk.ek_faktor, mep.ek_faktor, ein.ek_faktor) AS zwge
                      FROM DBP_ETL.kmo_wpuums_dat_2 a
                      
                      JOIN DBP_DATA.art_wup_man_spanne_per_2 ein /*Einstandspreis zwingend erforderlich*/
                        ON ein.konditionsart_id = 'ZWGS' /*einstandspreis*/ AND 
                           ein.loesch_fg = 0 AND 
                           a.dat BETWEEN ein.dat_von AND ein.dat_bis
                      
                      LEFT JOIN DBP_DATA.art_wup_man_spanne_per_2 mep /*optional*/
                        ON mep.mandant_id = ein.mandant_id AND 
                           mep.wup_id  = ein.wup_id AND 
                           mep.art_id  = ein.art_id AND 
                           mep.konditionsart_id = 'ZWGM' /*MEP*/ AND 
                           mep.loesch_fg = 0 AND 
                           a.dat BETWEEN mep.dat_von AND mep.dat_bis
                      
                      LEFT JOIN DBP_DATA.art_wup_man_spanne_per_2 ekbnk /*optional*/
                        ON ekbnk.mandant_id = ein.mandant_id AND 
                           ekbnk.wup_id  = ein.wup_id AND 
                           ekbnk.art_id  = ein.art_id AND 
                           ekbnk.konditionsart_id = 'ZWGE' /*eknetto bnk*/ AND 
                           ekbnk.loesch_fg = 0 AND 
                           a.dat BETWEEN ekbnk.dat_von AND ekbnk.dat_bis) ms
                          
SET ek_brutto                    = CAST(umsatz_netto * zwge AS DECIMAL(18,4))
   ,ek_netto                     = CAST(umsatz_netto * zwge AS DECIMAL(18,4))
   ,ek_nettonetto                = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,ek_kal_basis                 = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,ek_mep                       = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,einstandspreis               = CAST(umsatz_netto * zwgs AS DECIMAL(18,4))
   ,ek_netto_bnk                 = CAST(umsatz_netto * zwge AS DECIMAL(18,4))
   ,ek_netto_bnk_sachk           = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,ek_mep_vor_fwu               = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))
   ,bonusbasis                    = CAST(umsatz_netto * zwgm AS DECIMAL(18,4))

WHERE _step02a.mandant_id     = ms.mandant_id
  AND _step02a.wup_id         = ms.wup_id 
  AND _step02a.art_id         = ms.art_id
  AND _step02a.dat            = ms.dat
  AND _step02a.bq_findung_id  = 26
  AND _step02a.kopf_art_id   <> -100
;

-- Bei nicht erfolgreicher BQ-Findung setzen wir die 0% Spanne, also UMSATZ_NETTO!
UPDATE _step02a_2

SET umsatz_anteil       = 0
   ,umsatz_netto        = CAST(umsatz_netto_alt AS DECIMAL(18,4))
   ,umsatz_mwst         = CAST(umsatz_mwst_betrag_alt AS DECIMAL(18,4))
   ,umsatz_bto          = CAST(umsatz_netto_alt+umsatz_mwst_betrag_alt AS DECIMAL(18,4))
   ,ek_brutto           = CAST(umsatz_netto_alt AS DECIMAL(18,4))
   ,ek_netto            = CAST(umsatz_netto_alt AS DECIMAL(18,4))
   ,ek_nettonetto       = CAST(umsatz_netto_alt AS DECIMAL(18,4))
   ,ek_kal_basis        = CAST(umsatz_netto_alt AS DECIMAL(18,4))
   ,ek_mep              = CAST(umsatz_netto_alt AS DECIMAL(18,4))
   ,einstandspreis      = CAST(umsatz_netto_alt AS DECIMAL(18,4))
   ,ek_netto_bnk        = CAST(umsatz_netto_alt AS DECIMAL(18,4))
   ,ek_netto_bnk_sachk  = CAST(umsatz_netto_alt AS DECIMAL(18,4))
   ,ek_mep_vor_fwu      = CAST(umsatz_netto_alt AS DECIMAL(18,4))
   ,bonusbasis           = CAST(umsatz_netto_alt AS DECIMAL(18,4))

WHERE _step02a.bq_findung_id  = 25
  AND _step02a.kopf_art_id   <> -100
;

/*
_------------------------------------------------------------------------------
_ 20.) Spannen-EK-Bewertung pro Komponente
_------------------------------------------------------------------------------
*/

-- 18.12.2012, -dba-
--
-- Des Weiteren werden fuer die einzelnen Konditionsstufen die zugrunde liegende Spanne im Verhaeltnis zum 
-- Gesamtabverkauf (UMSATZ_NETTO ermittelt. Mit diesen Spannen werden spaeter die EK-Werte fuer die Kom-
-- ponentenartikel festgeschrieben.

CREATE OR REPLACE VOLATILE TABLE _spannen_agg2_2 AS (
SELECT a.mandant_id,
       a.wup_id,
       a.kopf_art_id,
       a.bewart_id,
       a.bewart_det_id,
       a.ean_kasse,
       a.stueckliste_id,
       a.dat,
       1-SUM(a.ek_brutto/b.umsatz_netto) AS ek_brutto_spn,
       1-SUM(a.ek_netto/b.umsatz_netto) AS ek_netto_spn,
       1-SUM(a.ek_nettonetto/b.umsatz_netto) AS ek_nettonetto_spn,
       1-SUM(a.ek_kal_basis/b.umsatz_netto) AS ek_kal_basis_spn,
       1-SUM(a.ek_mep/b.umsatz_netto) AS ek_mep_spn,
       1-SUM(a.einstandspreis/b.umsatz_netto) AS einstandspreis_spn,
       1-SUM(a.logistikkostenzuschlag/b.umsatz_netto) AS logkostenzuschlag_spn,
       1-SUM(a.ek_netto_bnk/b.umsatz_netto) AS ek_netto_bnk_spn,
       1-SUM(a.ek_netto_bnk_sachk/b.umsatz_netto) AS ek_netto_bnk_sachk_spn,
       1-SUM(a.ek_mep_vor_fwu/b.umsatz_netto) AS ek_mep_vor_fwu_spn,
       1-SUM(a.bonusbasis/b.umsatz_netto) AS bonusbasis_spn
FROM _step02a_2 a
JOIN _aggregat01_2 b
  ON a.mandant_id  = b.mandant_id AND
     a.wup_id      = b.wup_id     AND
     a.kopf_art_id = b.art_id     AND
     a.dat         = b.dat        AND
     a.ean_kasse   = b.ean_kasse  AND
     a.bewart_id   = b.bewart_id  AND
     a.bewart_det_id = b.bewart_det_id
WHERE b.umsatz_netto <> 0
GROUP BY 1,2,3,4,5,6,7,8
);

-- 18.12.2012, -dba-
--
-- Wie dem obigen Titel zu entnehmen ist, werden hier fuer saemtliche Komponenten eines VK_2-Set die entsprechenden
-- Werte ermittelt. Als Anmerkung waere hier noch zu erwaehnen, dass aufgrund von Rundungsungenauigkeiten im Teradata-
-- Umfeld bei der EK-Berechnung laut Spanne leider die Genauigkeit von DECIMAL(18,4) auf DECIMAL(18,2) gesetzt werden
-- musste, da wir ansonsten kein stimmiges Verhaeltnis der EK-Werte im Vergleich von vorher zu nachher gehabt haetten.

INSERT INTO _step03_2 (mandant_id,
                     wup_id,
                     nb_id,
                     art_id,
                     bewart_id,
                     bewart_det_id,
                     dat,
                     wrg_2,
                     ean_kasse,
                     menge,
                     umsatz_netto_alt,
                     umsatz_mwst_betrag_alt,
                     umsatz_bto,
                     umrechnungskurs,
                     kopf_art_id,
                     komponentenmengen_faktor,
                     stueckliste_id,
                     bq_findung_id,
                     umsatz_anteil,
                     umsatz_netto,
                     umsatz_mwst,
                     ek_brutto,
                     ek_netto,
                     ek_nettonetto,
                     ek_kal_basis,
                     ek_mep,
                     einstandspreis,
                     logistikkostenzuschlag,
                     ek_netto_bnk,
                     ek_netto_bnk_sachk,
                     ek_mep_vor_fwu,
                     bonusbasis,
                     diff_ek_brutto_konz,
                     diff_ek_netto_konz,
                     diff_ek_nettonetto_konz,
                     diff_ek_kal_basis_konz,
                     diff_ek_mep_konz,
                     diff_einstandspreis_konz,
                     diff_logkostenzuschlag_konz,
                     diff_ek_netto_bnk_konz,
                     diff_ek_netto_bnk_sachk_konz,
                     ek_mep_vor_fwu_konz,
                     bonusbasis_konz)
SELECT z.mandant_id,
       z.wup_id,
       z.nb_id,
       z.art_id,
       z.bewart_id,
       z.bewart_det_id,
       z.dat,
       z.wrg_2,
       z.ean_kasse,
       z.menge,
       z.umsatz_netto_alt,
       z.umsatz_mwst_betrag_alt,
       z.umsatz_bto,
       z.umrechnungskurs,
       z.kopf_art_id,
       z.komponentenmengen_faktor,
       z.stueckliste_id,
       z.bq_findung_id,
       z.umsatz_anteil,
       z.umsatz_netto,
       z.umsatz_mwst,
       -1*((a.ek_brutto_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_brutto_ ,
       -1*((a.ek_netto_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_netto_,
       -1*((a.ek_nettonetto_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_nettonetto_,
       -1*((a.ek_kal_basis_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_kal_basis_,
       -1*((a.ek_mep_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_mep_,
       -1*((a.einstandspreis_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS einstandspreis_,
       -1*((a.logkostenzuschlag_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS logistikkostenzuschlag_,
       -1*((a.ek_netto_bnk_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_netto_bnk_,
       -1*((a.ek_netto_bnk_sachk_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_netto_bnk_sachk_,
       -1*((a.ek_mep_vor_fwu_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS ek_mep_vor_fwu_,
       -1*((a.bonusbasis_spn) *(CAST(umsatz_netto AS DECIMAL(18,2)))-(CAST(umsatz_netto AS DECIMAL(18,2)))) AS bonusbasis_,
       CAST(ek_brutto_ * z.umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_brutto_konz,
       CAST(ek_netto_ * z.umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_netto_konz,
       CAST(ek_nettonetto_ * z.umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_nettonetto_konz,
       CAST(ek_kal_basis_ * z.umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_kal_basis_konz,
       CAST(ek_mep_ * z.umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_mep_konz,
       CAST(einstandspreis_ * z.umrechnungskurs AS DECIMAL(18,4)) AS diff_einstandspreis_konz,
       CAST(logistikkostenzuschlag_ * z.umrechnungskurs AS DECIMAL(18,4)) AS diff_logkostenzuschlag_konz,
       CAST(ek_netto_bnk_ * z.umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_netto_bnk_konz,
       CAST(ek_netto_bnk_sachk_ * z.umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_netto_bnk_sachk_konz,
       CAST(ek_mep_vor_fwu_ * z.umrechnungskurs AS DECIMAL(18,4)) AS ek_mep_vor_fwu_konz,
       CAST(bonusbasis_ * z.umrechnungskurs AS DECIMAL(18,4)) AS bonusbasis_konz
FROM _step02a_2 z
JOIN _spannen_agg2_2 a
  ON z.mandant_id     = a.mandant_id     AND
     z.wup_id         = a.wup_id         AND
     z.kopf_art_id    = a.kopf_art_id    AND
     z.stueckliste_id = a.stueckliste_id AND
     z.ean_kasse      = a.ean_kasse      AND 
     z.dat            = a.dat            AND
     z.bewart_id      = a.bewart_id      AND
     z.bewart_det_id  = a.bewart_det_id
;

/*
_------------------------------------------------------------------------------
_ 21.) Spannen-EK-Bewertung pro Kopfartikel (ARTBEW_2-Bezug)
_------------------------------------------------------------------------------
*/

INSERT INTO _step03_2 (mandant_id,
                     wup_id,
                     nb_id,
                     art_id,
                     bewart_id,
                     bewart_det_id,
                     dat,
                     wrg_2,
                     ean_kasse,
                     menge,
                     umsatz_netto_alt,
                     umsatz_mwst_betrag_alt,
                     umsatz_bto,
                     umrechnungskurs,
                     kopf_art_id,
                     komponentenmengen_faktor,
                     stueckliste_id,
                     bq_findung_id,
                     umsatz_anteil,
                     umsatz_netto,
                     umsatz_mwst,
                     ek_brutto,
                     ek_netto,
                     ek_nettonetto,
                     ek_kal_basis,
                     ek_mep,
                     einstandspreis,
                     logistikkostenzuschlag,
                     ek_netto_bnk,
                     ek_netto_bnk_sachk,
                     ek_mep_vor_fwu,
                     bonusbasis,
                     diff_ek_brutto_konz,
                     diff_ek_netto_konz,
                     diff_ek_nettonetto_konz,
                     diff_ek_kal_basis_konz,
                     diff_ek_mep_konz,
                     diff_einstandspreis_konz,
                     diff_logkostenzuschlag_konz,
                     diff_ek_netto_bnk_konz,
                     diff_ek_netto_bnk_sachk_konz,
                     ek_mep_vor_fwu_konz,
                     bonusbasis_konz)
SELECT z.mandant_id,
       z.wup_id,
       z.nb_id,
       z.art_id,
       z.bewart_id,
       z.bewart_det_id,
       z.dat,
       z.wrg_2,
       z.ean_kasse,
       z.menge,
       z.umsatz_netto_alt,
       z.umsatz_mwst_betrag_alt,
       z.umsatz_bto,
       z.umrechnungskurs,
       z.kopf_art_id,
       z.komponentenmengen_faktor,
       z.stueckliste_id,
       z.bq_findung_id,
       0 AS umsatz_anteil,
       z.umsatz_netto_alt AS umsatz_netto,
       z.umsatz_mwst_betrag_alt AS umsatz_mwst,
       (1-a.ek_brutto_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS ek_brutto_,
       (1-a.ek_netto_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS ek_netto_,
       (1-a.ek_nettonetto_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS ek_nettonetto_,
       (1-a.ek_kal_basis_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS ek_kal_basis_,
       (1-a.ek_mep_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS ek_mep_,
       (1-a.einstandspreis_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS einstandspreis_,
       (1-a.logkostenzuschlag_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS logistikkostenzuschlag_,
       (1-a.ek_netto_bnk_spn)*(CAST(umsatz_netto AS DECIMAL(18,2)))  AS ek_netto_bnk_,
       (1-a.ek_netto_bnk_sachk_spn)*(CAST(umsatz_netto AS DECIMAL(18,2))) AS ek_netto_bnk_sachk_,
       (1-a.ek_mep_vor_fwu_spn)*(CAST(umsatz_netto AS DECIMAL(18,2))) AS ek_mep_vor_fwu_,
       (1-a.bonusbasis_spn)*(CAST(umsatz_netto AS DECIMAL(18,2))) AS bonusbasis_,
       CAST(ek_brutto_ * z.umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_brutto_konz,
       CAST(ek_netto_ * z.umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_netto_konz,
       CAST(ek_nettonetto_ * z.umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_nettonetto_konz,
       CAST(ek_kal_basis_ * z.umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_kal_basis_konz,
       CAST(ek_mep_ * z.umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_mep_konz,
       CAST(einstandspreis_ * z.umrechnungskurs AS DECIMAL(18,4)) AS diff_einstandspreis_konz,
       CAST(logistikkostenzuschlag_ * z.umrechnungskurs AS DECIMAL(18,4)) AS diff_logkostenzuschlag_konz,
       CAST(ek_netto_bnk_ * z.umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_netto_bnk_konz,
       CAST(ek_netto_bnk_sachk_ * z.umrechnungskurs AS DECIMAL(18,4)) AS diff_ek_netto_bnk_sachk_konz,
       CAST(ek_mep_vor_fwu_ * z.umrechnungskurs AS DECIMAL(18,4)) AS ek_mep_vor_fwu_konz,
       CAST(bonusbasis_ * z.umrechnungskurs AS DECIMAL(18,4)) AS bonusbasis_konz
FROM _step02_2 z
JOIN _spannen_agg2_2 a
  ON z.mandant_id     = a.mandant_id     AND
     z.wup_id         = a.wup_id         AND
     z.art_id         = a.kopf_art_id    AND
     z.stueckliste_id = a.stueckliste_id AND
     z.ean_kasse      = a.ean_kasse      AND 
     z.dat            = a.dat            AND
     z.bewart_id      = a.bewart_id      AND
     z.bewart_det_id  = a.bewart_det_id
WHERE z.kopf_art_id = -100
;

/*
_------------------------------------------------------------------------------
_ 22.) Aktualisierung der EK-Werte fuer Kopfartikel in ARTBEW_2
_------------------------------------------------------------------------------
*/

MERGE INTO DBP_DATA.artbew_2 a
USING (SELECT *
       FROM _step03_2
       WHERE kopf_art_id = -100) b

  ON a.mandant_id = b.mandant_id AND
     a.wup_id     = b.wup_id     AND
     a.nb_id      = b.nb_id      AND
     a.art_id     = b.art_id     AND
     a.ean_kasse  = b.ean_kasse  AND
     a.dat        = b.dat        AND
     a.bewart_id  = b.bewart_id  AND
     a.bewart_det_id = b.bewart_det_id 
     
WHEN MATCHED THEN UPDATE SET ek_brutto                    = b.ek_brutto                    ,
                             diff_ek_brutto_konz          = b.diff_ek_brutto_konz          ,
                             ek_netto                     = b.ek_netto                     ,
                             diff_ek_netto_konz           = b.diff_ek_netto_konz           ,
                             ek_nettonetto                = b.ek_nettonetto                ,
                             diff_ek_nettonetto_konz      = b.diff_ek_nettonetto_konz      ,
                             ek_kal_basis                 = b.ek_kal_basis                 ,
                             diff_ek_kal_basis_konz       = b.diff_ek_kal_basis_konz       ,
                             ek_mep                       = b.ek_mep                       ,
                             diff_ek_mep_konz             = b.diff_ek_mep_konz             ,
                             einstandspreis               = b.einstandspreis               ,
                             diff_einstandspreis_konz     = b.diff_einstandspreis_konz     ,
                             logkostenzuschlag            = b.logistikkostenzuschlag       ,
                             diff_logkostenzuschlag_konz  = b.diff_logkostenzuschlag_konz  ,
                             ek_netto_bnk                 = b.ek_netto_bnk                 ,
                             diff_ek_netto_bnk_konz       = b.diff_ek_netto_bnk_konz       ,
                             ek_netto_bnk_sachk           = b.ek_netto_bnk_sachk           ,
                             diff_ek_netto_bnk_sachk_konz = b.diff_ek_netto_bnk_sachk_konz ,
                             ek_mep_vor_fwu               = b.ek_mep_vor_fwu               ,
                             ek_mep_vor_fwu_konz          = b.ek_mep_vor_fwu_konz          ,
                             bonusbasis                   = b.bonusbasis                   ,
                             bonusbasis_konz              = b.bonusbasis_konz              ,
                             bq_findung_id                = 28
;

/*
_------------------------------------------------------------------------------
_ 23.) Einspielen der Komponentenartikel in Zieltabelle
_------------------------------------------------------------------------------
*/

DELETE FROM DBP_DATA.artbew_stueckliste_zu_2
WHERE mandant_id > 1 AND
      dat IN (SELECT dat
              FROM DBP_ETL.kmo_wpuums_dat_2)
;

INSERT INTO DBP_DATA.artbew_stueckliste_zu_2 (mandant_id,
                                             wup_id,
                                             nb_id,
                                             art_id,
                                             dat,
                                             komponente_art_id,
                                             stueckliste_id,
                                             wrg_id,
                                             umsatz_netto,
                                             umsatz_mwst_betrag,
                                             menge,
                                             ek_brutto,
                                             ek_netto,
                                             ek_nettonetto,
                                             ek_kal_basis,
                                             ek_mep,
                                             einstandspreis,
                                             logkostenzuschlag,
                                             ek_netto_bnk,
                                             ek_netto_bnk_sachk,
                                             bq_findung_id,
                                             umrechnungskurs,
                                             td_insert,
                                             td_update,
                                             ek_mep_vor_fwu,
                                             bonusbasis)
SELECT x.mandant_id,
       x.wup_id,
       x.nb_id,
       x.kopf_art_id AS art_id,
       x.dat,
       x.art_id AS komponente_art_id,
       x.stueckliste_id,
       x.wrg_2 AS wrg_id,
       x.umsatz_netto,
       x.umsatz_mwst AS umsatz_mwst_betrag,
       x.komponentenmengen_faktor AS menge,
       x.ek_brutto AS ek_brutto,
       x.ek_netto AS ek_netto,
       x.ek_nettonetto AS ek_nettonetto,
       x.ek_kal_basis AS ek_kal_basis,
       x.ek_mep AS ek_mep,
       x.einstandspreis AS einstandspreis,
       x.logistikkostenzuschlag AS logkostenzuschlag,
       x.ek_netto_bnk AS ek_netto_bnk,
       x.ek_netto_bnk_sachk AS ek_netto_bnk_sachk,
       x.bq_findung_id,
       x.umrechnungskurs,
       current_timestamp as td_insert,
       current_timestamp as td_update,
       x.ek_mep_vor_fwu,
       x.bonusbasis
FROM (SELECT mandant_id,
             wup_id,
             nb_id,
             kopf_art_id,
             dat,
             art_id,
             stueckliste_id,
             wrg_2,
             SUM(umsatz_netto) AS umsatz_netto,
             SUM(umsatz_mwst) AS umsatz_mwst,
             SUM(komponentenmengen_faktor) AS komponentenmengen_faktor,
             SUM(ek_brutto) AS ek_brutto,
             SUM(ek_netto) AS ek_netto,
             SUM(ek_nettonetto) AS ek_nettonetto,
             SUM(ek_kal_basis) AS ek_kal_basis,
             SUM(ek_mep) AS ek_mep,
             SUM(einstandspreis) AS einstandspreis,
             SUM(logistikkostenzuschlag) AS logistikkostenzuschlag,
             SUM(ek_netto_bnk) AS ek_netto_bnk,
             SUM(ek_netto_bnk_sachk) AS ek_netto_bnk_sachk,
             bq_findung_id,
             MAX(umrechnungskurs) AS umrechnungskurs,
             SUM(ek_mep_vor_fwu) as ek_mep_vor_fwu,
             SUM(bonusbasis) as bonusbasis
      FROM _step03_2
      WHERE kopf_art_id <> -100
      GROUP BY 1,2,3,4,5,6,7,8,21) x
;