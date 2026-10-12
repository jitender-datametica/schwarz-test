
-- temporary for debug
DROP TABLE IF EXISTS DBP_ETL.PISZ1_ART_WUP_ZU_PER_1;
CREATE TABLE DBP_ETL.PISZ1_ART_WUP_ZU_PER_1 CLONE DBP_DATA.ART_WUP_ZU_PER_1;
-- will be removed soon

--translated statement
DROP TABLE IF EXISTS DBP_ETL.awp_vk_1;


--translated statement
CREATE  TABLE DBP_ETL.awp_vk_1  (
art_id      INTEGER NOT NULL,
mandant_id  BYTEINT NOT NULL,
wup_id      INTEGER NOT NULL,
nb_id       SMALLINT NOT NULL ,
dat         DATE NOT NULL,
wrg_id      CHAR(3) COLLATE 'en-ci' NOT NULL ,
vk_brutto   DECIMAL(9,2) NOT NULL
)
;


--translated statement
DROP TABLE IF EXISTS DBP_ETL.awp_marc_1;


--translated statement
CREATE  TABLE DBP_ETL.awp_marc_1  (
art_id       INTEGER NOT NULL,
mandant_id   BYTEINT NOT NULL,
wup_id       INTEGER NOT NULL,
nb_id        SMALLINT NOT NULL ,
dat          DATE NOT NULL,
kdis         BYTEINT ,
bezugsweg_id BYTEINT 
)
;

DROP TABLE IF EXISTS DBP_ETL.awp_lstg_1;

--translated statement
CREATE  TABLE DBP_ETL.awp_lstg_1  (
art_id     INTEGER NOT NULL,
mandant_id BYTEINT NOT NULL,
wup_id     INTEGER NOT NULL,
nb_id      SMALLINT NOT NULL ,
dat        DATE NOT NULL,
listung_id BYTEINT 
)
;


--translated statement
INSERT INTO DBP_ETL.awp_marc_1
(
        art_id
        ,mandant_id
        ,wup_id
        ,nb_id
        ,dat
        ,kdis
        ,bezugsweg_id
)
SELECT
        art_id
        ,mandant_id
        ,wup_id
        ,nb_id
        ,CURRENT_DATE AS dat
        ,kdis
        ,bezugsweg_id
FROM DBP_DATA.art_wup_status_per_1

WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis
AND nb_id = 0
;


--translated statement
INSERT INTO DBP_ETL.awp_vk_1
(
        art_id
        ,mandant_id
        ,wup_id
        ,nb_id
        ,dat
        ,wrg_id
        ,vk_brutto
)
SELECT
        art_id
        ,mandant_id
        ,wup_id
        ,nb_id
        ,CURRENT_DATE AS dat
        ,wrg_id
        ,vk_brutto
FROM DBP_DATA.art_wup_vk_per_1

WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis
AND nb_id = 0

GROUP BY
        art_id
        ,mandant_id
        ,wup_id
        ,nb_id
        ,dat
        ,wrg_id
        ,vk_brutto
;


--translated statement
INSERT INTO DBP_ETL.awp_lstg_1
(
        art_id
        ,mandant_id
        ,wup_id
        ,nb_id
        ,dat
        ,listung_id
)
SELECT
        art_id
        ,mandant_id
        ,wup_id
        ,nb_id
        ,CURRENT_DATE AS dat
        ,1 as listung_id
FROM DBP_DATA.art_list_wup_zu_per_1

WHERE CURRENT_DATE BETWEEN dat_von AND dat_bis
AND nb_id = 0

GROUP BY
1,2,3,4,5,6
;


--translated statement
DROP TABLE IF EXISTS DBP_ETL.awp_tmp_1;


--translated statement
CREATE TABLE DBP_ETL.awp_tmp_1 LIKE DBP_DATA.art_wup_zu_per_1;


--translated statement
CREATE  VOLATILE TABLE _gather AS (
SELECT 
        mandant_id,
        art_id,
        wup_id,
        dat,
        nb_id
FROM DBP_ETL.awp_vk_1
WHERE vk_brutto < 1000000
GROUP BY 1,2,3,4,5

UNION

SELECT 
        mandant_id,
        art_id,
        wup_id,
        dat,
        nb_id
FROM DBP_ETL.awp_lstg_1
GROUP BY 1,2,3,4,5

UNION

SELECT 
        mandant_id,
        art_id,
        wup_id,
        dat,
        nb_id
FROM DBP_ETL.awp_marc_1
GROUP BY 1,2,3,4,5
);


--translated statement
INSERT INTO DBP_ETL.awp_tmp_1
(
art_id
,wup_id
,mandant_id
,dat_von
,dat_bis
,nb_id
,kdis
,bezugsweg_id
,wrg_id
,vk_brutto
,listung_id
,td_insert
,td_update
)
SELECT
t1.art_id
,t1.wup_id
,t1.mandant_id
,t1.dat AS dat_von
, to_date('9999-12-31','YYYY-MM_1-DD') AS dat_bis
,t1.nb_id
,Coalesce(t3.kdis,0) AS kdis
,Coalesce(t3.bezugsweg_id,4) AS bezugsweg_id
,Coalesce(t2.wrg_id,x.default_wrg) AS wrg_id
,Coalesce(t2.vk_brutto,0) AS vk_brutto
,Coalesce(t4.listung_id,0) AS listung_id
,CURRENT_TIMESTAMP
,CURRENT_TIMESTAMP
FROM _gather t1_1

JOIN DBP_DATA.mandant_1 x
ON t1.mandant_id = x.mandant_id

LEFT JOIN DBP_ETL.awp_lstg_1 t4
ON t1.art_id        = t4.art_id
AND t1.wup_id     = t4.wup_id
AND t1.mandant_id = t4.mandant_id
AND t1.dat        = t4.dat

LEFT JOIN (SELECT *
FROM DBP_ETL.awp_vk_1
WHERE vk_brutto <1000000) t2
ON t1.art_id        = t2.art_id
AND t1.wup_id     = t2.wup_id
AND t1.mandant_id = t2.mandant_id
AND t1.dat        = t2.dat

LEFT JOIN DBP_ETL.awp_marc_1 t3
ON t3.art_id        = t1.art_id
AND t3.wup_id     = t1.wup_id
AND t3.mandant_id = t1.mandant_id
AND t3.dat        = t1.dat
;


--translated statement
INSERT INTO DBP_ETL.awp_tmp_1
SELECT *
FROM DBP_DATA.art_wup_zu_per_1

WHERE dat_bis >=  CURRENT_DATE
AND dat_von  < CURRENT_DATE
;


--translated statement
DELETE FROM DBP_ETL.awp_tmp_1 t1_1

WHERE EXISTS
(
SELECT *
FROM DBP_ETL.awp_tmp_1 t2

WHERE t1.wup_id       = t2.wup_id
AND t1.art_id       = t2.art_id
AND t1.mandant_id   = t2.mandant_id
AND t1.dat_von - 1  = t2.dat_von
AND t1.listung_id   = t2.listung_id
AND t1.bezugsweg_id = t2.bezugsweg_id
AND t1.kdis         = t2.kdis
AND t1.vk_brutto    = t2.vk_brutto
AND t1.wrg_id       = t2.wrg_id
);


--translated statement
DELETE FROM DBP_ETL.awp_tmp_1 t1_1

WHERE EXISTS
(
SELECT *
FROM DBP_ETL.awp_tmp_1 t2

WHERE t1.wup_id       = t2.wup_id
AND t1.art_id       = t2.art_id
AND t1.mandant_id   = t2.mandant_id
AND t1.listung_id   = t2.listung_id
AND t1.bezugsweg_id = t2.bezugsweg_id
AND t1.kdis         = t2.kdis
AND t1.vk_brutto    = t2.vk_brutto
AND t1.wrg_id       = t2.wrg_id
AND dat_von < CURRENT_DATE
)
AND dat_von = CURRENT_DATE
;


--translated statement

UPDATE DBP_ETL.awp_tmp_1
SET dat_bis = _dat_bis

FROM
(
        SELECT
        t1.mandant_id AS _mandant_id
        ,t1.art_id     AS _art_id
        ,t1.dat_von    AS _dat_von
        ,t1.wup_id     AS _wup_id
        ,t1.nb_id      AS _nb_id
        ,dateadd(day, -1, LEAD(dat_von, 1, to_date('10000-01-01','YYYY-MM_1-DD')) over (PARTITION BY t1.mandant_id, t1.art_id, t1.wup_id, t1.nb_id ORDER BY dat_von)) AS _dat_bis
        FROM DBP_ETL.awp_tmp_1 t1_1

) dt1
WHERE art_id     = _art_id
AND wup_id     = _wup_id
AND dat_von    = _dat_von
AND mandant_id = _mandant_id
AND dat_bis   <> _dat_bis
;




--translated statement
DELETE FROM DBP_DATA.art_wup_zu_per_1
WHERE dat_bis >= CURRENT_DATE
;

--translated statement
INSERT INTO DBP_DATA.art_wup_zu_per_1
SELECT * FROM DBP_ETL.awp_tmp_1
;



-- temporary for debug
DROP TABLE IF EXISTS DBP_ETL.PISZ2_ART_WUP_ZU_PER_1;
CREATE TABLE DBP_ETL.PISZ2_ART_WUP_ZU_PER_1 CLONE DBP_DATA.ART_WUP_ZU_PER_1;
-- will be removed soon
