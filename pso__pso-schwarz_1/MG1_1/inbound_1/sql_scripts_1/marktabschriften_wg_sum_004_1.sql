--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.marktabschriften_agg_dat_1  (
wup_id              INTEGER NOT NULL,
nb_id               SMALLINT NOT NULL,
dat                 DATE,
mandant_id          BYTEINT NOT NULL
)
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'KFL_DEVELOPMENT.DBP_ETL.MARKTABSCHRIFTEN_TEMP_1' does not exist or not authorized.
INSERT INTO DBP_ETL.marktabschriften_agg_dat_1
(
        wup_id
        ,nb_id
        ,dat
        ,mandant_id
)
SELECT
        wup_id
        ,nb_id
        ,dat
        ,mandant_id
FROM DBP_ETL.marktabschriften_temp_1
GROUP BY 1,2,3,4
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DELETE FROM DBP_DATA.marktabschriften_wg_sum_1
WHERE
(
        wup_id
        ,nb_id
        ,dat
        ,mandant_id
) IN (
        SELECT
        wup_id
        ,nb_id
        ,dat
        ,mandant_id
        FROM DBP_ETL.marktabschriften_agg_dat_1
)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.marktabschriften_wg_sum_1
(
wup_id
,nb_id
,dat
,mandant_id
,wg_id
,abschriftart_ID
,wrg_id
,arthiertyp_id
,abschriftbetrag_netto
,abschriftbetrag_brutto
)
SELECT
t1.wup_id
,t1.nb_id
,t1.dat
,t1.mandant_id
,t2.wg_id
,t1.abschriftart_ID
,t1.wrg_id
,t2.arthiertyp_id
,SUM(t1.abschriftbetrag_netto)
,SUM(t1.abschriftbetrag_brutto)
FROM DBP_DATA.marktabschriften_1 t1_1
INNER JOIN DBP_DATA.art_wg_zu_per_1 t2
ON t1.mandant_id=t2.mandant_id
AND t1.art_id=t2.art_id
AND t1.dat between t2.dat_von and t2.dat_bis
AND t2.arthiertyp_id=2
WHERE
(
t1.wup_id
,t1.nb_id
,t1.dat
,t1.mandant_id
)
IN (
        SELECT
        wup_id
        ,nb_id
        ,dat
        ,mandant_id
        FROM
        DBP_ETL.marktabschriften_agg_dat_1
)
GROUP BY 1,2,3,4,5,6,7,8
;

