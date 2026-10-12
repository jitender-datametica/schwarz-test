
DROP TABLE IF EXISTS DBP_ETL.mk_tmp0_art_vorauswahl_6wo;

CREATE TABLE DBP_ETL.mk_tmp0_art_vorauswahl_6wo  (
analyse_dat DATE,
mandant_id BYTEINT,
wup_id INTEGER,
art_id INTEGER,
abt_id SMALLINT,
min_dat DATE,
max_dat DATE,
wtag_id BYTEINT,
sum_menge DECIMAL(18,4),
sum_umsatz_brutto DECIMAL(18,4))
;

INSERT INTO DBP_ETL.mk_tmp0_art_vorauswahl_6wo(
analyse_dat
, mandant_id
, wup_id
, art_id
, abt_id
, min_dat
, max_dat
, wtag_id
, sum_menge
, sum_umsatz_brutto
)
SELECT
CURRENT_DATE AS analyse_dat
, t01.mandant_id
, t01.wup_id
, t10.art_id
, t04.abt_id
, MIN(ttag.dat)
, MAX(ttag.dat)
, ttag.wtag_id
, COUNT(DISTINCT t01.bon_id) AS sum_menge
, SUM(t01.umsatz_brutto) AS sum_umsatz_brutto
FROM      DBP_ODS.ods_bon_kopf AS t02
INNER JOIN
DBP_ODS.ods_bon_verkauf AS t01
ON        t02.mandant_id = t01.mandant_id
AND      t02.bon_id = t01.bon_id
AND      t01.aktion_id = ''
AND      t02.mandant_id = 1

INNER JOIN
(
SELECT dat, wtag_id
FROM DBP_DATA.tag ttag
WHERE
dat BETWEEN CURRENT_DATE -${days} AND CURRENT_DATE
) ttag
ON t02.bon_dat = ttag.dat

--üblicher join, um kl_art_id und art_id zu verbinden
INNER JOIN
(
SELECT  kl_art_id, mandant_id, MAX(art_id) AS art_id
FROM DBP_DATA.art
WHERE
display_id = 0
AND   loesch_id = ''
AND   posten_id = ''
AND   wg_art_fg = 0
AND   art_id > 0
GROUP BY kl_art_id, mandant_id
) AS  t10
ON        t01.mandant_id = t10.mandant_id
AND       t01.kl_art_id = t10.kl_art_id
-- Nur Märkte aus der Vorauswahl
AND (t01.mandant_id, t01.wup_id) IN (
SELECT  mandant_id
, wup_id
FROM       DBP_MSI_DATA.l_mk_wup
)
INNER JOIN
DBP_DATA.art_wg_zu_per AS t03
ON        t10.mandant_id = t03.mandant_id
AND       t10.art_id = t03.art_id
-- Aktuell gueltige Einträge der art_wg_zu_per
AND       t03.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
AND       t03.arthiertyp_id = 2               --	3stellige WG
INNER JOIN
DBP_DATA.wg_per AS t04
ON        t03.mandant_id = t04.mandant_id
AND       t03.wg_id = t04.wg_id
AND       t03.arthiertyp_id = t04.arthiertyp_id
-- Aktuell gueltige Einträge der wg_per
AND       t04.dat_bis = to_date('9999-12-31','YYYY-MM-DD')
-- KDIS Kennzeichen auf 0 steht
INNER JOIN
(
SELECT mandant_id, wup_id, art_id
FROM
DBP_DATA.art_wup_status_per
WHERE
dispomerkmal IN ('01','11','ZZ')
AND kdis = 0
AND dat_bis = to_date('9999-12-31','YYYY-MM-DD')
)  t05
ON        t01.mandant_id = t05.mandant_id
AND       t01.wup_id = t05.wup_id
AND       t10.art_id = t05.art_id
-- Ausschluss bestimmter Warengruppen aus der Abteilung Food
WHERE    (t03.mandant_id, t03.wg_id) NOT IN (SELECT mandant_id, wg_id FROM DBP_DATA.wg_filter_zu WHERE arthiertyp_id=2 AND wg_filter_id=7)
-- Nur Abteilung Food wird berücksichtigt
AND    (t04.mandant_id, t04.wg_id) IN (SELECT mandant_id, wg_id FROM DBP_DATA.wg_filter_zu WHERE arthiertyp_id=2 AND wg_filter_id=8)
GROUP BY  t01.mandant_id
, t01.wup_id
, t10.art_id
, t04.abt_id
, ttag.wtag_id;

DROP TABLE IF EXISTS DBP_ETL.mk_wupcal;

CREATE TABLE DBP_ETL.mk_wupcal  (
mandant_id BYTEINT,
wup_id INTEGER,
nb_id SMALLINT,
dat DATE,
wtag_id BYTEINT,
offen BYTEINT)
;

INSERT INTO DBP_ETL.mk_wupcal (
mandant_id
, wup_id
, nb_id
, dat
, wtag_id
, offen)

SELECT    t01.mandant_id
, t01.wup_id
, t01.nb_id
, t01.dat
, t02.wtag_id
, t01.offen

FROM DBP_DATA.wupcal AS t01
INNER JOIN
DBP_DATA.tag AS t02
ON        t01.dat = t02.dat
AND       t01.mandant_id = 1
AND       t01.nb_id = 0
AND       t02.wtag_id <> 7;

DROP TABLE IF EXISTS DBP_ETL.mk_tmp1_art_vorauswahl_6wo;

CREATE TABLE DBP_ETL.mk_tmp1_art_vorauswahl_6wo  (
mandant_id BYTEINT,
wup_id INTEGER,
art_id INTEGER,
abt_id SMALLINT,
min_dat DATE,
max_dat DATE,
wtag_id BYTEINT,
cnt_tag_reg BYTEINT,
sum_menge DECIMAL(18,4),
sum_umsatz_brutto DECIMAL(18,4),
avg_menge DECIMAL(18,4),
avg_umsatz_brutto DECIMAL(18,4),
rank_menge INTEGER,
rank_umsatz_brutto INTEGER)
;

INSERT INTO DBP_ETL.mk_tmp1_art_vorauswahl_6wo (
mandant_id
, wup_id
, art_id
, abt_id
, min_dat
, max_dat
, wtag_id
, cnt_tag_reg
, sum_menge
, sum_umsatz_brutto
, avg_menge
, avg_umsatz_brutto
, rank_menge
, rank_umsatz_brutto)

SELECT
t01.mandant_id
, t01.wup_id
, t01.art_id
, t01.abt_id
, t01.min_dat
, t01.max_dat
, t01.wtag_id
, ZEROIFNULL( t03.cnt_dat) - ZEROIFNULL(t08.cnt_dat) AS cnt_dat_reg
, t01.sum_menge
, t01.sum_umsatz_brutto
, t01.sum_menge / NULLIFZERO(ZEROIFNULL(t03.cnt_dat) - ZEROIFNULL(t08.cnt_dat)) AS avg_menge
, t01.sum_umsatz_brutto /NULLIFZERO(ZEROIFNULL(t03.cnt_dat) - ZEROIFNULL(t08.cnt_dat)) AS avg_umsatz_brutto
, RANK() OVER (PARTITION BY t01.wtag_id ORDER BY avg_menge DESC) AS rank_menge
, RANK() OVER (PARTITION BY t01.wtag_id ORDER BY avg_umsatz_brutto DESC) AS rank_umsatz_brutto

FROM      DBP_ETL.mk_tmp0_art_vorauswahl_6wo AS t01
INNER JOIN
( -- Anzahl der offenen Tage nach der letzten Aktivierung
SELECT    t02.mandant_id
, t02.wup_id
, t01.min_dat
, t01.wtag_id
, COUNT(DISTINCT  t02.dat) AS cnt_dat
FROM      DBP_ETL.mk_wupcal AS t02
INNER JOIN
(
SELECT mandant_id, wup_id,  t10.min_dat,  t10.max_dat, ttag.dat, ttag.wtag_id
FROM
(
SELECT mandant_id, wup_id, MIN(min_dat) AS min_dat, MAX(max_dat) AS max_dat
FROM DBP_ETL.mk_tmp0_art_vorauswahl_6wo
GROUP BY mandant_id, wup_id
) AS  t10
INNER JOIN
DBP_DATA.tag ttag
ON ttag.dat BETWEEN  t10.min_dat AND  t10.max_dat
) t01
ON     t02.mandant_id = t01.mandant_id
AND  t02.wup_id= t01.wup_id
AND  t02.dat BETWEEN  t01.min_dat AND  t01.max_dat
AND t02.wtag_id = t01.wtag_id
AND  t02.offen = 1

GROUP BY  t02.mandant_id
, t02.wup_id
, t01.min_dat
, t01.wtag_id
) AS t03
ON        t01.mandant_id = t03.mandant_id
AND     t01.wup_id = t03.wup_id
AND     t01.wtag_id= t03.wtag_id
LEFT OUTER JOIN
( -- Anzahl der Aktionstage des Artikels
SELECT    t04.mandant_id
, t04.wup_id
, t04.art_id
, t04.wtag_id
, COUNT(DISTINCT  t07.dat) AS cnt_dat
FROM
(
SELECT mandant_id, wup_id, art_id,  t10.min_dat,  t10.max_dat, ttag.dat, ttag.wtag_id
FROM
(
SELECT mandant_id, wup_id, art_id, min_dat, max_dat
FROM DBP_ETL.mk_tmp0_art_vorauswahl_6wo
) AS  t10
INNER JOIN
DBP_DATA.tag ttag
ON ttag.dat BETWEEN  t10.min_dat AND  t10.max_dat
)  AS t04
INNER JOIN
DBP_DATA.aktion_art_wup_zu AS t05
ON        t04.mandant_id = t05.mandant_id
AND       t04.wup_id = t05.wup_id
AND       t04.art_id = t05.art_id
INNER JOIN
DBP_DATA.aktion AS t06
ON        t05.mandant_id = t06.mandant_id
AND       t05.aktion_id = t06.aktion_id
AND       t06.preisaktiviert_fg = 1
/*AND       t06.dat_von <=  t04.min_dat
AND       t06.dat_bis >=  t04.max_dat
Änderung der Bedingung, um auch Teilweise Überschneidungen zu erfassen  */
AND       t06.dat_von <=  t04.max_dat
AND       t06.dat_bis >  t04.min_dat
INNER JOIN
DBP_ETL.mk_wupcal AS t07
ON        t04.mandant_id = t07.mandant_id
AND       t04.wup_id = t07.wup_id
AND       t07.dat BETWEEN t06.dat_von AND t06.dat_bis
AND       t07.dat BETWEEN  t04.min_dat AND  t04.max_dat
AND       t07.wtag_id=t04.wtag_id
AND       t07.offen = 1
GROUP BY  t04.mandant_id
, t04.wup_id
, t04.art_id
, t04.wtag_id
) AS t08
ON        t01.mandant_id = t08.mandant_id
AND     t01.wup_id = t08.wup_id
AND     t01.art_id = t08.art_id
AND     t01.wtag_id= t08.wtag_id
AND     t03.cnt_dat <> t08.cnt_dat;

DROP TABLE IF EXISTS DBP_ETL.mk_tmp_art_wug_prom;

CREATE TABLE DBP_ETL.mk_tmp_art_wug_prom  (
mandant_id BYTEINT,
wup_id INTEGER,
nb_id  SMALLINT,
art_id INTEGER,
wg_id INTEGER,
wug_id INTEGER,
abt_id SMALLINT,
dat DATE,
wtag_id BYTEINT,
gewart_id CHAR(3) COLLATE 'en-ci',
menge DECIMAL(18,4))
;


INSERT INTO DBP_ETL.mk_tmp_art_wug_prom (
mandant_id
, wup_id
, nb_id
, art_id
, wg_id
, wug_id
, abt_id
, dat
, wtag_id
, gewart_id
, menge
)
SELECT      t01.mandant_id
, t01.wup_id
, t01.nb_id
, t01.art_id
, t03.wg_id
, t03.wug_id
, t04.abt_id
, t01.dat
, t06.wtag_id
, t02.gewart_id
, SUM(t01.menge)  AS menge       -- 24.02.14 TBac: In der artbew sind pro Artikel-Tag-Markt mehrere Datensaetze vorhanden (EAN mit im Schluessel). Daher Summierung der Menge!)
FROM      DBP_DATA.artbew AS t01
INNER JOIN
DBP_MSI_DATA.l_mk_wup AS a ---Begrenzung auf die Märkte der Vorauswahl
ON        a.wup_id=t01.wup_id
AND       a.mandant_id=t01.mandant_id
AND       t01.mandant_id = 1
INNER JOIN
DBP_DATA.art AS t02
ON        t01.mandant_id = t02.mandant_id
AND       t01.art_id = t02.art_id

-- Ausschluss von Nicht-Promotionverkäufen
AND       t01.bewart_id = 1002  --sonderaktion
-- Einschränkung des Betrachtungszeitraums - die letzten vollen 12 Monate
AND       t01.dat BETWEEN  (ADD_MONTHS(CURRENT_DATE - 1, -12) - (EXTRACT(DAY FROM CURRENT_DATE - 1) - 1)) AND (CURRENT_DATE - 1 - EXTRACT(DAY FROM CURRENT_DATE - 1))
-- Nur die nicht über Warengruppen erfassten Artikel
AND   t02.wg_art_fg = 0
AND   t02.art_id > 0
-- Ausschluss von Postenartikeln
AND       t02.posten_id = ''
-- Ausschluss von gelöschten Artikeln
AND       t02.loesch_id = ''
-- Ausschluss Display
AND
t02.display_id = 0
INNER JOIN
DBP_DATA.tag AS t06
ON        t01.dat = t06.dat
INNER JOIN
DBP_DATA.art_wg_zu_per AS t03
ON        t02.mandant_id = t03.mandant_id
AND       t02.art_id = t03.art_id
-- Aktuell gueltige Einträge der art_wg_zu_per
AND       t03.dat_bis = to_date('9999-12-31','YYYY-MM-DD')

AND       t03.arthiertyp_id = 2

INNER JOIN
DBP_DATA.wg_per AS t04
ON        t03.mandant_id = t04.mandant_id
AND       t03.wg_id = t04.wg_id
AND       t03.arthiertyp_id = t04.arthiertyp_id
-- Aktuell gueltige Einträge der wg_per
AND       t04.dat_bis = to_date('9999-12-31','YYYY-MM-DD')


INNER JOIN
(
SELECT mandant_id, wup_id, art_id
FROM
DBP_DATA.art_wup_status_per
WHERE
dispomerkmal IN ('01','11','ZZ')
AND kdis = 0
AND dat_bis = to_date('9999-12-31','YYYY-MM-DD')
)  t05
ON        t01.mandant_id = t05.mandant_id
AND       t01.wup_id = t05.wup_id
AND       t02.art_id = t05.art_id
-- Ausschluss bestimmter Warengruppen aus der Abteilung Food
WHERE (t03.mandant_id, t03.wg_id) NOT IN (SELECT mandant_id, wg_id FROM DBP_DATA.wg_filter_zu WHERE arthiertyp_id=2 AND wg_filter_id=7)
-- Nur Abteilung Food wird berücksichtigt - geändert, vorher nur 4, in Tabelle aufgenommen
AND       (t04.mandant_id, t04.wg_id) IN (SELECT mandant_id, wg_id FROM DBP_DATA.wg_filter_zu WHERE arthiertyp_id=2 AND wg_filter_id=8)
GROUP BY 1,2,3,4,5,6,7,8,9,10 ;

DELETE FROM DBP_DATA.mk_art_wup_auswahl
WHERE dat_von = CURRENT_DATE
AND (wup_id, mandant_id) IN ( SELECT  wup_id, mandant_id
FROM       DBP_MSI_DATA.l_mk_wup
) ;

DROP TABLE IF EXISTS DBP_ETL.mk_tmp_art_wup_auswahl;

CREATE TABLE DBP_ETL.mk_tmp_art_wup_auswahl  (
mandant_id         BYTEINT,
wup_id             INTEGER,
wtag_id            BYTEINT,
nb_id              SMALLINT,
art_id             INTEGER,
avg_menge          DECIMAL(18,3),
anz_tage_in_aktion BYTEINT,
aktion_fg          BYTEINT,
aktiv_fg           BYTEINT,
anz_tage_0verkauf  BYTEINT,
dat_von            DATE,
dat_bis            DATE)
;


INSERT INTO DBP_ETL.mk_tmp_art_wup_auswahl
(
mandant_id
, wup_id
, wtag_id
, nb_id
, art_id
, avg_menge
, anz_tage_in_aktion
, aktion_fg
, aktiv_fg
, anz_tage_0verkauf
, dat_von
, dat_bis
)

SELECT    t03.mandant_id
, t03.wup_id
, t03.wtag_id
, t03.nb_id
, t03.art_id
, t03.avg_menge
, t03.anz_tage_in_aktion
, t03.aktion_fg AS aktion_fg
, 1 AS aktiv_fg
, 0 AS anz_tage_0verkauf
, CURRENT_DATE AS dat_von
, to_date('9999-12-31','YYYY-MM-DD') AS dat_bis
FROM
( -- Artikel aus der Tabelle mit den regulären Verkäufen - 6 Wochen
SELECT    t01.mandant_id
, t01.wup_id
, t02.nb_id
, t01.wtag_id
, t01.art_id
, t01.avg_menge
, 6 - cnt_tag_reg AS anz_tage_in_aktion
, 0 AS aktion_fg
FROM      DBP_ETL.mk_tmp1_art_vorauswahl_6wo AS t01

INNER JOIN DBP_DATA.wup t02
ON t01.wup_id = t02.wup_id
AND t01.mandant_id = t02.mandant_id

WHERE     t01.avg_menge >= 7

UNION

SELECT
1 AS mandant_id
, t1.wup_id
, t1.nb_id
, t1.wtag_id
, t1.art_id
, SUM(menge) / t2.cnt_dat AS avg_menge
, t2.cnt_dat AS anz_tage_in_aktion
, 1 AS aktion_fg
FROM DBP_ETL.mk_tmp_art_wug_prom t1
INNER JOIN
(
SELECT
wup_id
, art_id
, MAX(cnt_dat) AS cnt_dat
FROM
(
SELECT
wup_id
, art_id
, wtag_id
, COUNT(*) AS cnt_dat
FROM DBP_ETL.mk_tmp_art_wug_prom
GROUP BY 1,2,3
) tt2
GROUP BY 1,2
) t2
ON t1.wup_id = t2.wup_id
AND t1.art_id = t2.art_id
GROUP BY 1,2,3,4,5,7
HAVING  avg_menge >= 7
--tmp. workaround aufgrund Abbruch am 20140223, da Aktionsdauer 3-stellig, aalb--
--WHERE t2.cnt_dat <= 99

) AS t03

GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12
;

UPDATE    DBP_DATA.mk_art_wup_auswahl
SET       dat_bis = CURRENT_DATE - 1
WHERE     dat_bis = to_date('9999-12-31','YYYY-MM-DD');

INSERT INTO DBP_DATA.mk_art_wup_auswahl (
mandant_id
, wup_id
, wtag_id
, nb_id
, art_id
, avg_menge
, anz_tage_in_aktion
, aktion_fg
, aktiv_fg
, anz_tage_0verkauf
, dat_von
, dat_bis)

SELECT    t01.mandant_id
, t01.wup_id
, t01.wtag_id
, t01.nb_id
, t01.art_id
, t01.avg_menge
, t01.anz_tage_in_aktion
, t01.aktion_fg
, t01.aktiv_fg
, t01.anz_tage_0verkauf
, CURRENT_DATE AS dat_von
, to_date('9999-12-31','YYYY-MM-DD') AS dat_bis
FROM      DBP_ETL.mk_tmp_art_wup_auswahl AS t01
;


DROP TABLE IF EXISTS DBP_ETL.mk_tmp_wup_art_std_wt;

CREATE TABLE DBP_ETL.mk_tmp_wup_art_std_wt  (
mandant_id BYTEINT,
wup_id INTEGER,
art_id INTEGER,
bon_dat DATE,
bon_std BYTEINT,
anz INTEGER,
menge INTEGER,
offen BYTEINT)
;


INSERT INTO DBP_ETL.mk_tmp_wup_art_std_wt(
mandant_id
, wup_id
, art_id
, bon_dat
, bon_std
, anz
, menge
, offen
)

SELECT    t02.mandant_id
, t02.wup_id
, t10.art_id
, t02.bon_dat
, EXTRACT(HOUR FROM bon_booking) AS bon_std
, COUNT(DISTINCT t03.bon_id) AS anz
, SUM(t03.menge) AS menge
, t04.offen
FROM      DBP_ODS.ods_bon_kopf AS t02
INNER JOIN
DBP_ODS.ods_bon_verkauf AS t03
ON        t02.mandant_id = t03.mandant_id
AND       t02.bon_id = t03.bon_id
INNER JOIN
DBP_ETL.mk_wupcal  AS t04
ON        t02.mandant_id = t04.mandant_id
AND       t02.wup_id = t04.wup_id
AND       t02.bon_dat = t04.dat
INNER JOIN
(
SELECT  kl_art_id, mandant_id, MAX(art_id) AS art_id
FROM DBP_DATA.art
WHERE      display_id = 0
AND   loesch_id = ''
AND   posten_id = ''
AND   wg_art_fg = 0
AND   art_id > 0
GROUP BY kl_art_id, mandant_id
) t10
ON t03.kl_art_id = t10.kl_art_id
AND t03.mandant_id = t10.mandant_id

INNER JOIN
DBP_DATA.art_wg_zu_per AS t05
ON        t10.mandant_id = t05.mandant_id
AND       t10.art_id = t05.art_id
-- Aktuell gueltige Einträge der art_wg_zu_per
AND       t05.dat_bis = to_date('9999-12-31','YYYY-MM-DD')

AND       t05.arthiertyp_id = 2               --	3stellige WG


INNER JOIN
DBP_DATA.wg_per AS t06
ON        t05.mandant_id = t06.mandant_id
AND       t05.wg_id = t06.wg_id
AND       t05.arthiertyp_id = t06.arthiertyp_id
-- Aktuell gueltige Einträge der wg_per
AND       t06.dat_bis = to_date('9999-12-31','YYYY-MM-DD')

-- Nur KDIS Kennzeichen 0 u. dispomerkmal 01,11,ZZ
INNER JOIN
(
SELECT mandant_id, wup_id, art_id
FROM
DBP_DATA.art_wup_status_per
WHERE
dispomerkmal IN ('01','11','ZZ')
AND kdis = 0
AND dat_bis = to_date('9999-12-31','YYYY-MM-DD')
)  t07
ON        t02.mandant_id = t07.mandant_id
AND       t02.wup_id = t07.wup_id
AND       t10.art_id = t07.art_id

WHERE  t02.mandant_id = 1
AND     (t02.mandant_id, t02.wup_id) IN (
SELECT   mandant_id
, wup_id
FROM       DBP_MSI_DATA.l_mk_wup
)

AND t02.bon_dat BETWEEN CURRENT_DATE -${days} AND CURRENT_DATE
-- Ausschluss bestimmter Warengruppen aus der Abteilung Food
AND (t05.mandant_id, t05.wg_id) NOT IN (SELECT mandant_id, wg_id FROM DBP_DATA.wg_filter_zu WHERE arthiertyp_id=2 AND wg_filter_id=7)
-- Nur Abteilung Food wird berücksichtigt - geändert, vorher nur 4, in Tabelle aufgenommen
AND       (t06.mandant_id, t06.wg_id) IN (SELECT mandant_id, wg_id FROM DBP_DATA.wg_filter_zu WHERE arthiertyp_id=2 AND wg_filter_id=8)

GROUP BY  t02.mandant_id
, t02.wup_id
, t10.art_id
, t02.bon_dat
, bon_std
, t04.offen;


DROP TABLE IF EXISTS DBP_ETL.mk_promocal;

CREATE TABLE DBP_ETL.mk_promocal  (
mandant_id BYTEINT,
wup_id INTEGER,
nb_id SMALLINT,
art_id INTEGER,
dat DATE
)
;

INSERT INTO DBP_ETL.mk_promocal
(
mandant_id
, wup_id
, nb_id
, art_id
, dat
)

SELECT    t05.mandant_id
, t05.wup_id
, t05.nb_id
, t05.art_id
, t05.dat
FROM      ( SELECT    t01.mandant_id
, t01.wup_id
, t01.nb_id
, t01.art_id
, t04.dat
, t02.vk_aktion_brutto
FROM      DBP_ETL.mk_tmp_art_wup_auswahl AS t01
INNER JOIN
DBP_DATA.aktion_art_wup_zu AS t02
ON        t01.mandant_id = t02.mandant_id
AND       t01.wup_id = t02.wup_id
AND       t01.nb_id = t02.nb_id
AND       t01.art_id = t02.art_id
INNER JOIN
DBP_DATA.aktion AS t03
ON        t02.mandant_id = t03.mandant_id
AND       t02.aktion_id = t03.aktion_id
AND       t03.preisaktiviert_fg = 1
INNER JOIN
DBP_DATA.tag AS t04
ON        t04.dat BETWEEN t03.dat_von AND t03.dat_bis
WHERE     t01.aktion_fg = 1
AND       t01.aktiv_fg = 1
AND       CURRENT_DATE BETWEEN t01.dat_von AND t01.dat_bis
AND       t02.grund_sperrung IS NULL

AND       t04.dat BETWEEN CURRENT_DATE-${days} AND CURRENT_DATE
QUALIFY   RANK() OVER(PARTITION BY t01.mandant_id, t01.wup_id, t01.art_id, dat ORDER BY t02.aktion_id DESC) = 1) AS t05
INNER JOIN
DBP_DATA.art_wup_zu_per AS t06
ON        t05.mandant_id = t06.mandant_id
AND       t05.wup_id = t06.wup_id
AND       t05.art_id = t06.art_id
AND       t05.dat BETWEEN t06.dat_von AND t06.dat_bis
GROUP BY 1,2,3,4,5 ;

DROP TABLE IF EXISTS DBP_ETL.mk_wupartcal;

CREATE TABLE DBP_ETL.mk_wupartcal  (
mandant_id BYTEINT,
wup_id INTEGER,
nb_id SMALLINT,
art_id INTEGER,
dat DATE,
wtag_id BYTEINT,
aktion_fg BYTEINT,
saison_fg VARCHAR(1) COLLATE 'en-ci')
;
INSERT INTO DBP_ETL.mk_wupartcal (
mandant_id
, wup_id
, nb_id
, art_id
, dat
, wtag_id
, aktion_fg
, saison_fg
)


SELECT    t05.mandant_id
, t05.wup_id
, t05.nb_id
, t05.art_id
, t05.dat
, t05.wtag_id
, t05.this_aktion_fg AS aktion_fg
, t05.saison_fg

FROM      ( SELECT    t01.mandant_id
, t01.wup_id
, t01.nb_id
, t02.art_id
, t01.dat
, t01.wtag_id
--, t02.reg_fg
, t02.aktion_fg
-- Überprüfung ob Promotion (1), regulärer (0)
, CASE WHEN t03.art_id IS NOT NULL
THEN 1
ELSE 0 END  this_aktion_fg
-- Setzen des Saison Flags (Winter: NOV-MRZ, Sommer: APR-OKT)
, CASE
WHEN EXTRACT(MONTH FROM t01.dat) BETWEEN 4 AND 10 THEN 'S'
ELSE 'W' END AS saison_fg
, t01.offen
FROM      DBP_ETL.mk_wupcal AS t01
INNER JOIN
DBP_ETL.mk_tmp_art_wup_auswahl AS t02
ON        t01.mandant_id = t02.mandant_id
AND       t01.wup_id = t02.wup_id

AND       t01.dat BETWEEN  CURRENT_DATE - ${days} AND CURRENT_DATE
AND       t02.aktiv_fg = 1
AND       CURRENT_DATE BETWEEN t02.dat_von AND t02.dat_bis
LEFT OUTER JOIN
DBP_ETL.mk_promocal AS t03
ON        t01.mandant_id = t03.mandant_id
AND       t01.wup_id = t03.wup_id
AND       t01.nb_id = t03.nb_id
AND       t02.art_id = t03.art_id
AND       t01.dat = t03.dat
INNER JOIN
DBP_DATA.art_wup_zu_per AS t04
ON        t01.mandant_id = t04.mandant_id
AND       t01.wup_id = t04.wup_id
AND       t01.nb_id = t04.nb_id
AND       t02.art_id = t04.art_id
AND       t01.dat BETWEEN  t04.dat_von AND t04.dat_bis) AS t05
WHERE     t05.dat BETWEEN  CURRENT_DATE -${days} AND CURRENT_DATE
AND       t05.offen = 1
AND       (       (t05.this_aktion_fg = 1 AND t05.aktion_fg = 1)
OR    (t05.this_aktion_fg IN (0) AND t05.aktion_fg = 0))
GROUP BY 1,2,3,4,5,6,7,8
;

DROP TABLE IF EXISTS DBP_ETL.mk_bonverteilung_wt_zf;


CREATE TABLE DBP_ETL.mk_bonverteilung_wt_zf AS (
SELECT    t01.mandant_id
, t01.wup_id
, t01.nb_id
, t01.art_id
, t07.art_bez
, t01.aktion_fg
, t06.wtag_id
, COALESCE(SUM(CASE WHEN zf.zeitfenster_id = 1 THEN COALESCE(t05.anz, 0) ELSE NULL END), 0) AS anz_zf1
, COALESCE(SUM(CASE WHEN zf.zeitfenster_id = 2 THEN COALESCE(t05.anz, 0) ELSE NULL END), 0) AS anz_zf2
, COALESCE(SUM(CASE WHEN zf.zeitfenster_id = 3 THEN COALESCE(t05.anz, 0) ELSE NULL END), 0) AS anz_zf3
, COALESCE(SUM(CASE WHEN zf.zeitfenster_id = 1 THEN COALESCE(t05.menge, 0) ELSE NULL END), 0) AS menge_zf1
, COALESCE(SUM(CASE WHEN zf.zeitfenster_id = 2 THEN COALESCE(t05.menge, 0) ELSE NULL END), 0) AS menge_zf2
, COALESCE(SUM(CASE WHEN zf.zeitfenster_id = 3 THEN COALESCE(t05.menge, 0) ELSE NULL END), 0) AS menge_zf3
, COUNT(DISTINCT t05.bon_dat) AS anz_tage
FROM  DBP_ETL.mk_wupartcal  AS t01
LEFT OUTER JOIN
DBP_ETL.mk_tmp_wup_art_std_wt AS t05
ON        t01.mandant_id = t05.mandant_id
AND       t01.wup_id = t05.wup_id
AND       t01.art_id = t05.art_id
AND       t01.dat = t05.bon_dat
INNER JOIN
DBP_DATA.tag AS t06
ON        t05.bon_dat = t06.dat
INNER JOIN
DBP_DATA.art_spr_zu AS t07
ON        t01.mandant_id = t07.mandant_id
AND       t01.art_id = t07.art_id
AND       t07.spr_id = 22
INNER JOIN
DBP_DATA.l_zeitfenster zf
ON      zf.mandant_id = t01.mandant_id
AND   t05.bon_std >= EXTRACT(HOUR FROM zf.zeit_von) AND t05.bon_std < EXTRACT(HOUR FROM zf.zeit_bis)
WHERE     t05.offen = 1

AND t01.dat >=CURRENT_DATE-${days}
AND aktion_fg = 0
GROUP BY  t01.mandant_id
, t01.wup_id
, t01.nb_id
, t01.art_id
, t07.art_bez
, t01.aktion_fg
, t06.wtag_id

HAVING anz_tage >= 4
);

DROP TABLE IF EXISTS DBP_ETL.tmp_mk_art_wup_zeitfenster;

CREATE TABLE DBP_ETL.tmp_mk_art_wup_zeitfenster  (
wup_id INTEGER NOT NULL,
nb_id SMALLINT NOT NULL ,
mandant_id BYTEINT NOT NULL  ,
art_id INTEGER NOT NULL,
wtag_id BYTEINT NOT NULL,
zeitfenster_id BYTEINT NOT NULL ,
aktion_fg BYTEINT ,
dat_von DATE NOT NULL,
dat_bis DATE NOT NULL,
avg_menge DECIMAL(18,3) ,
anz_tage_in_aktion BYTEINT)
;

INSERT INTO DBP_ETL.tmp_mk_art_wup_zeitfenster
(
mandant_id
, wup_id
, nb_id
, art_id
, avg_menge
, anz_tage_in_aktion
, aktion_fg
, wtag_id
, zeitfenster_id
, dat_von
, dat_bis
)
SELECT      t01.mandant_id
, t01.wup_id
, t01.nb_id
, t01.art_id
, t01.anz_zf1 / CAST(t01.anz_tage AS DECIMAL(9,2)) AS avg_anzahl
, t01.anz_tage
, t01.aktion_fg
, t01.wtag_id
, 1 AS zeitfenster_id
, CURRENT_DATE AS dat_von
, to_date('9999-12-31','YYYY-MM-DD') AS dat_bis

FROM      DBP_ETL.mk_bonverteilung_wt_zf AS t01
WHERE avg_anzahl  >= 7;

INSERT INTO DBP_ETL.tmp_mk_art_wup_zeitfenster
(
mandant_id
, wup_id
, nb_id
, art_id
, avg_menge
, anz_tage_in_aktion
, aktion_fg
, wtag_id
, zeitfenster_id
, dat_von
, dat_bis
)
SELECT      t01.mandant_id
, t01.wup_id
, t01.nb_id
, t01.art_id
, t01.anz_zf2 / CAST(t01.anz_tage AS DECIMAL(9,2)) AS avg_anzahl
, t01.anz_tage
, t01.aktion_fg
, t01.wtag_id
, 2 AS zeitfenster_id
, CURRENT_DATE AS dat_von
, to_date('9999-12-31','YYYY-MM-DD') AS dat_bis
FROM      DBP_ETL.mk_bonverteilung_wt_zf AS t01
WHERE avg_anzahl  >= 7;

INSERT INTO DBP_ETL.tmp_mk_art_wup_zeitfenster
(
mandant_id
, wup_id
, nb_id
, art_id
, avg_menge
, anz_tage_in_aktion
, aktion_fg
, wtag_id
, zeitfenster_id
, dat_von
, dat_bis
)
SELECT    t01.mandant_id
, t01.wup_id
, nb_id
, t01.art_id
, t01.anz_zf3 / CAST(t01.anz_tage AS DECIMAL(9,2)) AS avg_anzahl
, t01.anz_tage
, t01.aktion_fg
, t01.wtag_id
, 3 AS zeitfenster_id
, CURRENT_DATE AS dat_von
, to_date('9999-12-31','YYYY-MM-DD') AS dat_bis
FROM      DBP_ETL.mk_bonverteilung_wt_zf AS t01
WHERE avg_anzahl  >= 7;

INSERT INTO DBP_ETL.tmp_mk_art_wup_zeitfenster
(
mandant_id
, wup_id
, nb_id
, art_id
, avg_menge
, anz_tage_in_aktion
, aktion_fg
, wtag_id
, zeitfenster_id
, dat_von
, dat_bis
)
SELECT        t1.mandant_id
, t1.wup_id
, t1.nb_id
, t1.art_id
, menge / NULLIFZERO(t2.cnt_dat) AS avg_menge
, COALESCE(t2.cnt_dat,0) AS cnt_dat
, 1 AS aktion_fg
, t1.wtag_id
, 1 AS zeitfenster_id
, CURRENT_DATE AS dat_von
, to_date('9999-12-31','YYYY-MM-DD') AS dat_bis
FROM
(
SELECT mandant_id, wup_id, art_id, wtag_id, nb_id, SUM(menge) AS menge
FROM DBP_ETL.mk_tmp_art_wug_prom
GROUP BY 1,2,3,4,5
)  t1
LEFT OUTER JOIN
(
SELECT
wup_id
, art_id
, MAX(cnt_dat) AS cnt_dat
FROM
(
SELECT
wup_id
, art_id
, wtag_id
, COUNT(*) AS cnt_dat
FROM DBP_ETL.mk_tmp_art_wug_prom
GROUP BY 1,2,3
) tt2
GROUP BY 1,2
) t2
ON t1.wup_id = t2.wup_id
AND t1.art_id = t2.art_id

WHERE  avg_menge >= 10
--tmp. workaround aufgrund Abbruch am 20140223, da Aktionsdauer 3-stellig, aalb--
--AND t2.cnt_dat <= 99
;


INSERT INTO DBP_ETL.tmp_mk_art_wup_zeitfenster
(
mandant_id
, wup_id
, nb_id
, art_id
, avg_menge
, anz_tage_in_aktion
, aktion_fg
, wtag_id
, zeitfenster_id
, dat_von
, dat_bis
)
SELECT        t1.mandant_id
, t1.wup_id
, t1.nb_id
, t1.art_id
, menge / NULLIFZERO(t2.cnt_dat) AS avg_menge
, COALESCE(t2.cnt_dat,0) AS cnt_dat
, 1 AS aktion_fg
, t1.wtag_id
, 2 AS zeitfenster_id
, CURRENT_DATE AS dat_von
, to_date('9999-12-31','YYYY-MM-DD') AS dat_bis
FROM
(
SELECT mandant_id, wup_id, art_id, wtag_id, nb_id, SUM(menge) AS menge
FROM DBP_ETL.mk_tmp_art_wug_prom
GROUP BY 1,2,3,4,5
)  t1
LEFT OUTER JOIN
(
SELECT
wup_id
, art_id
, MAX(cnt_dat) AS cnt_dat
FROM
(
SELECT
wup_id
, art_id
, wtag_id
, COUNT(*) AS cnt_dat
FROM DBP_ETL.mk_tmp_art_wug_prom
GROUP BY 1,2,3
) tt2
GROUP BY 1,2
) t2
ON t1.wup_id = t2.wup_id
AND t1.art_id = t2.art_id

WHERE  avg_menge >= 10
--tmp. workaround aufgrund Abbruch am 20140223, da Aktionsdauer 3-stellig, aalb--
--AND t2.cnt_dat <= 99
;

INSERT INTO DBP_ETL.tmp_mk_art_wup_zeitfenster
(
mandant_id
, wup_id
, nb_id
, art_id
, avg_menge
, anz_tage_in_aktion
, aktion_fg
, wtag_id
, zeitfenster_id
, dat_von
, dat_bis
)
SELECT        t1.mandant_id
, t1.wup_id
, t1.nb_id
, t1.art_id
, menge / NULLIFZERO(t2.cnt_dat) AS avg_menge
, COALESCE(t2.cnt_dat,0) AS cnt_dat
, 1 AS aktion_fg
, t1.wtag_id
, 3 AS zeitfenster_id
, CURRENT_DATE AS dat_von
, to_date('9999-12-31','YYYY-MM-DD') AS dat_bis
FROM
(
SELECT mandant_id, wup_id, art_id, wtag_id, nb_id, SUM(menge) AS menge
FROM DBP_ETL.mk_tmp_art_wug_prom
GROUP BY 1,2,3,4,5
)  t1
LEFT OUTER JOIN
(
SELECT
wup_id
, art_id
, MAX(cnt_dat) AS cnt_dat
FROM
(
SELECT
wup_id
, art_id
, wtag_id
, COUNT(*) AS cnt_dat
FROM DBP_ETL.mk_tmp_art_wug_prom
GROUP BY 1,2,3
) tt2
GROUP BY 1,2
) t2
ON t1.wup_id = t2.wup_id
AND t1.art_id = t2.art_id

WHERE  avg_menge >= 35
--tmp. workaround aufgrund Abbruch am 20140223, da Aktionsdauer 3-stellig, aalb--
--AND t2.cnt_dat <= 99
;

DELETE FROM DBP_DATA.mk_art_wup_zeitfenster
WHERE dat_von = CURRENT_DATE;

UPDATE    DBP_DATA.mk_art_wup_zeitfenster
SET       dat_bis = CURRENT_DATE - 1
WHERE     dat_bis = to_date('9999-12-31','YYYY-MM-DD');


INSERT INTO  DBP_DATA.mk_art_wup_zeitfenster
(
mandant_id
, wup_id
, nb_id
, art_id
, avg_menge
, anz_tage_in_aktion
, aktion_fg
, wtag_id
, zeitfenster_id
, dat_von
, dat_bis

)

SELECT
mandant_id
, wup_id
, nb_id
, art_id
, avg_menge
, anz_tage_in_aktion
, aktion_fg
, wtag_id
, zeitfenster_id
, dat_von
, dat_bis

FROM  DBP_ETL.tmp_mk_art_wup_zeitfenster
GROUP BY 1,2,3,4,5,6,7,8,9,10,11
;

