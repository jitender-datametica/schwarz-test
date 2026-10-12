--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.kmo_artbew_bon_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.kmo_artbew_bon_1  (
-- Informationen stammen aus Bon Kopf
mandant_id          BYTEINT,
bon_id              VARCHAR(25) COLLATE 'en-ci',
dat_booking         DATE,
wup_id              INTEGER,

-- Informationen stammen aus Bon Zeile
bon_zeile           INTEGER,
kl_art_id           INTEGER,
ean_kasse           DECIMAL(26,0),
menge               DECIMAL(18,4),
umsatz_brutto       DECIMAL(18,4),
wg_id               INTEGER,

-- Hilfsattribute fuer Verarbeitung
lkp_art_id          INTEGER,
lkp_nb_id           SMALLINT,
lkp_wg_id           SMALLINT,
lkp_arthiertyp_id   BYTEINT,
lkp_zek_id          SMALLINT,
lkp_mwst_id         BYTEINT,
lkp_posten_id       CHAR(4) COLLATE 'en-ci',
lkp_umrechnungskurs FLOAT,
lkp_mwst            DECIMAL(12,2),
lkp_wrg             CHAR(3) COLLATE 'en-ci'
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.kmo_artbew_bon_promotion_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.kmo_artbew_bon_promotion_1  (
  mandant_id            BYTEINT,
  bon_id                VARCHAR(25) COLLATE 'en-ci',
  dat_booking           DATE,
  kl_art_id             INTEGER,
  bon_zeile             INTEGER,
  bonuskauf_id          CHAR(20) COLLATE 'en-ci',
  konditionsart_id      CHAR(10) COLLATE 'en-ci',
  umsatz_brutto         DECIMAL(18,4),
  umsatz_promo_brutto   DECIMAL(18,4),
  menge_promo			DECIMAL(18,3)
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.kmo_artbew_bon_dat_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : SET TABLE functionality is not provided by Snowflake. Insert only distinct data instead.
CREATE TABLE DBP_ETL.kmo_artbew_bon_dat_1  (dat DATE NOT NULL)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.kmo_artbew_bon_delta_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.kmo_artbew_bon_delta_1  (
mandant_id  BYTEINT NOT NULL,
wup_id      INTEGER NOT NULL,
dat_booking DATE NOT NULL,
xml_name    VARCHAR(255)
)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Schema 'KFL_DEVELOPMENT.DBP_ODS' does not exist or not authorized.
INSERT INTO DBP_ETL.kmo_artbew_bon_delta_1
(
mandant_id
,wup_id
,dat_booking
,xml_name
)
SELECT
k.mandant_id
,k.wup_id
,k.dat_booking
,b.xml_name
FROM DBP_ODS.ods_bon_kopf_1 k

INNER JOIN DBP_ODS.ods_bon_transaction_1 t
ON t.bon_id = k.bon_id
AND t.mandant_id = k.mandant_id
AND t.wup_id = k.wup_id
AND t.mandant_id > 1
AND t.kassensystem_name = 'POSITION'

INNER JOIN DBP_ODS.bon_load_status_1 b
ON b.xml_name = t.datei_name
AND b.artbew_fg = 0

WHERE k.mandant_id <> 1
-- bartosiewiczadm - cloud migration
-- AND b.parseBon_Time <= (CAST(CURRENT_TIME AS TIMESTAMP(0)) - INTERVAL '10 MINUTE' )
AND b.parseBon_Time <= CURRENT_TIMESTAMP() - INTERVAL '10 minute'
AND k.dat_booking <= CURRENT_DATE-1 /*Umsatz maximal bis gestern*/

GROUP BY 1,2,3,4
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Schema 'KFL_DEVELOPMENT.DBP_ODS' does not exist or not authorized.
INSERT INTO DBP_ETL.kmo_artbew_bon_1
(
mandant_id
,bon_id
,dat_booking
,wup_id
,kl_art_id
,ean_kasse
,bon_zeile
,menge
,umsatz_brutto
,wg_id
)
SELECT
k.mandant_id
,k.bon_id
,k.dat_booking
,k.wup_id
,z.kl_art_id
,z.ean_kasse
,z.bon_zeile
,CASE WHEN k.kunde_fg = 0 /* zeilenstornor_fg = 1 */
THEN z.menge * (-1)
ELSE z.menge
END AS menge_
,CASE WHEN k.kunde_fg = 0 /* zeilenstornor_fg = 1 */
THEN z.umsatz_brutto * (-1)
ELSE z.umsatz_brutto
END AS umsatz_brutto_
,z.wg_id
FROM DBP_ODS.ods_bon_kopf_1 k

-- Gesamten Markttag holen
INNER JOIN
(
SELECT
mandant_id
,wup_id
,dat_booking
FROM DBP_ETL.kmo_artbew_bon_delta_1
GROUP BY 1,2,3
) d
ON k.mandant_id = d.mandant_id
AND k.wup_id = d.wup_id
AND k.dat_booking = d.dat_booking

INNER JOIN DBP_ODS.ods_bon_verkauf_1 z
ON k.mandant_id = z.mandant_id
AND k.bon_id = z.bon_id
AND k.wup_id = z.wup_id

INNER JOIN DBP_ODS.ods_bon_transaction_1 t
ON k.mandant_id = t.mandant_id
AND k.bon_id = t.bon_id
AND k.wup_id = t.wup_id

WHERE k.mandant_id > 1
AND k.kunde_fg = 1
AND k.turnover_fg = 1
AND
(
-- pro Mandant_1 kann hier ein spezieller Filter eingebaut werden
CASE WHEN k.mandant_id = 8 THEN 1
WHEN k.mandant_id = 3 AND k.kasse_nr NOT IN (241) THEN 1
WHEN k.mandant_id = 7 AND k.kasse_nr NOT IN (241,242) THEN 1
WHEN k.mandant_id = 2 AND k.kasse_nr NOT IN (241,242) THEN 1
WHEN k.mandant_id = 6 AND k.kasse_nr NOT IN (241,242) THEN 1
WHEN k.mandant_id = 5 AND k.kasse_nr NOT IN (241,242) THEN 1
ELSE 0
END
) = 1

AND (k.bon_id, k.wup_id) NOT IN
(
SELECT
bon_id
,wup_id
FROM DBP_ODS.ods_bon_storno_1
)

UNION

SELECT
k.mandant_id
,k.bon_id
,k.dat_booking
,k.wup_id
,z.kl_art_id
,z.ean_kasse
,z.bon_zeile
-- Mengen Flag beruecksichtigen (Vorgabe David vom 18.03.)
,CASE WHEN k.kunde_fg = 0 /* zeilenstornor_fg = 1 */
THEN z.menge * (-1)
ELSE z.menge
END * z.menge_fg AS menge_
,CASE WHEN k.kunde_fg = 0 /* zeilenstornor_fg = 1 */
THEN z.umsatz_brutto * (-1)
ELSE z.umsatz_brutto
END AS umsatz_brutto_
,z.wg_id
FROM DBP_ODS.ods_bon_kopf_1 k

-- Gesamten Markttag holen
INNER JOIN
(
SELECT
mandant_id
,wup_id
,dat_booking
FROM DBP_ETL.kmo_artbew_bon_delta_1
GROUP BY 1,2,3
) d
ON k.mandant_id = d.mandant_id
AND k.wup_id = d.wup_id
AND k.dat_booking = d.dat_booking

INNER JOIN DBP_ODS.ods_bon_retoure_1 z
ON k.mandant_id = z.mandant_id
AND k.bon_id = z.bon_id
AND k.wup_id = z.wup_id

INNER JOIN DBP_ODS.ods_bon_transaction_1 t
ON k.mandant_id = t.mandant_id
AND k.bon_id = t.bon_id
AND k.wup_id = t.wup_id

WHERE k.mandant_id > 1
AND k.kunde_fg = 1
AND k.turnover_fg = 1
AND
(
-- pro Mandant_1 kann hier ein spezieller Filter eingebaut werden
CASE WHEN k.mandant_id = 8 THEN 1
WHEN k.mandant_id = 3 AND k.kasse_nr NOT IN (241) THEN 1
WHEN k.mandant_id = 7 AND k.kasse_nr NOT IN (241,242) THEN 1
WHEN k.mandant_id = 2 AND k.kasse_nr NOT IN (241,242) THEN 1
WHEN k.mandant_id = 6 AND k.kasse_nr NOT IN (241,242) THEN 1
WHEN k.mandant_id = 5 AND k.kasse_nr NOT IN (241,242) THEN 1
ELSE 0
END
) = 1

AND (k.bon_id, k.wup_id) NOT IN
(
SELECT
bon_id
,wup_id
FROM DBP_ODS.ods_bon_storno_1
)

;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_ETL.kmo_artbew_bon_1
FROM DBP_DATA.wup_1 w

SET lkp_nb_id = w.nb_id

WHERE DBP_ETL.kmo_artbew_bon.mandant_id = w.mandant_id
AND DBP_ETL.kmo_artbew_bon.wup_id = w.wup_id
;


--translated statement
UPDATE DBP_ETL.kmo_artbew_bon_1

SET lkp_art_id = dt.art_id
, lkp_zek_id = dt.zek_id
, lkp_mwst_id = dt.mwst_id
, lkp_posten_id = dt.posten_id

FROM
(
SELECT
mandant_id
,kl_art_id
,art_id
,zek_id
,mwst_id
,posten_id
FROM DBP_DATA.art_1 a

-- bartosiewiczadm - cloud migration
/*GROUP BY
mandant_id
,kl_art_id

QUALIFY CSUM(1, art_id DESC) = 1*/
QUALIFY row_number() OVER (PARTITION BY mandant_id, kl_art_id ORDER BY art_id DESC) = 1
) dt WHERE DBP_ETL.kmo_artbew_bon.mandant_id = dt.mandant_id
AND DBP_ETL.kmo_artbew_bon.kl_art_id = dt.kl_art_id
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE DBP_ETL.kmo_artbew_bon_1
FROM DBP_DATA.art_wg_zu_per_1 w

SET lkp_wg_id = w.wg_id
, lkp_arthiertyp_id = w.arthiertyp_id

WHERE DBP_ETL.kmo_artbew_bon.mandant_id = w.mandant_id
AND DBP_ETL.kmo_artbew_bon.lkp_art_id = w.art_id
AND w.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
AND w.arthiertyp_id = 2
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_ARTBEW_BON_1' does not exist or not authorized.
UPDATE DBP_ETL.kmo_artbew_bon_1
FROM DBP_DATA.mandant_1 m

SET lkp_wrg = m.default_wrg

WHERE DBP_ETL.kmo_artbew_bon.mandant_id = m.mandant_id
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_ARTBEW_BON_1' does not exist or not authorized.
UPDATE DBP_ETL.kmo_artbew_bon_1
FROM DBP_DATA.kurs_1 k

SET lkp_umrechnungskurs = k.umrechnungskurs

WHERE DBP_ETL.kmo_artbew_bon.lkp_wrg = k.von_wrg_id
AND DBP_ETL.kmo_artbew_bon.dat_booking BETWEEN k.dat_von ANd k.dat_bis
AND k.kurstyp_id = 9
AND k.nach_wrg_id = 'EUR'
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_ARTBEW_BON_1' does not exist or not authorized.
UPDATE DBP_ETL.kmo_artbew_bon_1
FROM DBP_DATA.mwst_per_1 m

SET lkp_mwst = m.mwst

WHERE DBP_ETL.kmo_artbew_bon.mandant_id = m.mandant_id
AND DBP_ETL.kmo_artbew_bon.lkp_mwst_id = m.mwst_id
AND DBP_ETL.kmo_artbew_bon.dat_booking BETWEEN m.dat_von AND m.dat_bis
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_ARTBEW_BON_1' does not exist or not authorized.
DELETE  from DBP_ETL.kmo_artbew_bon_1
WHERE lkp_art_id is null;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_ARTBEW_BON_1' does not exist or not authorized.
INSERT INTO DBP_ETL.kmo_artbew_bon_dat_1
(dat)
SELECT dat_booking
FROM DBP_ETL.kmo_artbew_bon_1
GROUP BY dat_booking
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.KMO_ARTBEW_BON_1' does not exist or not authorized.
INSERT INTO DBP_ETL.kmo_artbew_bon_promotion_1
(
mandant_id
,bon_id
,dat_booking
,kl_art_id
,bon_zeile
,bonuskauf_id
,konditionsart_id
,umsatz_brutto
,umsatz_promo_brutto
,menge_promo
)
SELECT
k.mandant_id
,k.bon_id
,k.dat_booking
,k.kl_art_id
,k.bon_zeile
,p.bonuskauf_id
,p.konditionsart_id
,SUM(p.betrag_promo_brutto * (-1)) AS umsatz_brutto
,SUM(p.umsatz_promo_brutto) AS umsatz_promo_brutto
,SUM(p.menge_promo) AS menge_promo

FROM DBP_ETL.kmo_artbew_bon_1 k

INNER JOIN DBP_ODS.ods_promotion_1 p
ON k.mandant_id = p.mandant_id
AND k.bon_id = p.bon_id
AND k.bon_zeile = p.bon_zeile
/*mfialkiewicz ods_promotion_1 filtering condition from on prem bon data loader*/
and p.wup_id >= 1000 and p.wup_id <= 9999 and p.kl_art_id is not null and p.kl_art_id <= 9999999
WHERE COALESCE(p.betrag_promo_brutto, 0) <> 0

-- Falls pro Bonzeile mehrfach die gleichen Konditionsart
-- und Bonuskaufid aufgefuert waeren (???)
GROUP BY
k.mandant_id
,k.bon_id
,k.dat_booking
,k.kl_art_id
,k.bon_zeile
,p.bonuskauf_id
,p.konditionsart_id
;

