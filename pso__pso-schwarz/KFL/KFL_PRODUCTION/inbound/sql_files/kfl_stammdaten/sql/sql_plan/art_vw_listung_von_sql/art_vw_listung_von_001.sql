/*
#------------------------------------------------------------------------------
# Skriptname   : erstlistung.btq
# Erstelldatum : 26.05.2009
#------------------------------------------------------------------------------
# Projekt      : STAMM LISTUNG
# Kommentar    : Anlegen und Aktualisieren der Information Erstlistung fuer alle
#                Artikel pro Vertriebsweg.
#
# Datenquellen : dbp_data.wup
#                dbp_data.art_list_wup_zu_per
#                dbp_data.art
#
# Datenziele   : dbp_data.art_vw_listung_von
#------------------------------------------------------------------------------
# Historie:
#   26.05.2009    Alexander Alberg  Ersterstellung
#   20.07.2010    Michael Ueding    Integration der KMO Mandanten
#   10.08.2010    Michael Ueding    Vorbelegen der VW ID fuer KMO mit 0
#                                   (kein Vertriebsbeg)
#   06.03.2012    Michael Ueding    Vorbelegen der VW ID fuer KMO mit 10
#                                   (Marktverkauf)
#   09.04.2013    Ulrike Hofmann    VW_ID 0 fuer Zwischentabelle vorbelegt
#   25.09.2016    Dennis Bayraktar  Nach VTL-Aufloesung nur noch "VW_ID = 6" fuer DE!
#   04.12.2019    Dennis Bayraktar  Neue KSM-Logik mit aufgenommen.
#------------------------------------------------------------------------------
# Verarbeitungsschritte
#   1.) Logon auf der Datenbank
#   2.) Temporaere Tabellen erstellen
#   3.) Beladung der tmp-Tabelle mit mandant_id, vw_id, art_id & MIN(dat_von) als
#       dat_erst_listung
#   4.) Beladung der tmp1-Tabelle mit mandant_id, vw_id, art_id & sm_id
#   5.) Bereinigung der durchgaengigen Listungen pro VW und sm, die eine hoehere
#       sm haben, die nicht durchgaengig gelistet ist
#   6.) Loeschen aller sm Einträge, die nicht durchgaengig gelistet sind
#   7.) Ermitteln des niedrigsten sm-Eintrages und loeschen aller hoeheren
#   8.) Erzeugung der tmp2-Tabelle mit allen moeglichen mandant_id, vw_id,
#       art_id - Kombinationen
#   9.) Einfuegen der neuen/aktualisierten     CURRENT_DATE Saetze
#       in die Zieltabelle art_vw_listung_von
#  11.) Aktualisieren dat_von & sm_id (auf Auslistung) in der Zieltabelle
#       art_vw_listung_von, falls Sortimentskategorie nicht verändert wurde
#  12.) Aktualisieren dat_erst_listung in der Zieltabelle art_vw_listung_von
#  13.) Bteq beenden
#------------------------------------------------------------------------------
*/


/*
#------------------------------------------------------------------------------
# 2.) Temporaere Tabellen erstellen
#------------------------------------------------------------------------------
*/

DROP TABLE IF EXISTS dbp_etl.art_vw_listung_von_tmp;
DROP TABLE IF EXISTS dbp_etl.art_vw_listung_von_tmp1;
DROP TABLE IF EXISTS dbp_etl.art_vw_listung_von_tmp2;

CREATE TABLE dbp_etl.art_vw_listung_von_tmp
(
mandant_id       BYTEINT NOT NULL,
vw_id            BYTEINT NOT NULL,
art_id           INTEGER NOT NULL,
dat_erst_listung DATE NOT NULL
);

CREATE TABLE dbp_etl.art_vw_listung_von_tmp1
(
mandant_id      BYTEINT NOT NULL,
vw_id           BYTEINT NOT NULL,
art_id          INTEGER NOT NULL,
sm_id           BYTEINT,
ksm_id          VARCHAR(4),
durchgaengig_fg BYTEINT NOT NULL
);


CREATE TABLE dbp_etl.art_vw_listung_von_tmp2
(
mandant_id BYTEINT NOT NULL,
vw_id      BYTEINT NOT NULL,
art_id     INTEGER NOT NULL
);

/*
#------------------------------------------------------------------------------
# 3.) Beladung der tmp-Tabelle mit mandant_id, vw_id, art_id & MIN(dat_von) als
#     dat_erst_listung
#------------------------------------------------------------------------------
*/

INSERT INTO dbp_etl.art_vw_listung_von_tmp
(
mandant_id
,vw_id
,art_id
,dat_erst_listung
)
SELECT
t1.mandant_id
,COALESCE(dt2.vw_id,0)
,t1.art_id
,MIN(t1.dat_von) AS dat_erst_listung
FROM dbp_data.art_list_wup_zu_per t1

INNER JOIN
(
SELECT
mandant_id AS mandant_id
,wup_id     AS wup_id
,nb_id      AS nb_id
,vw_id      AS vw_id
FROM dbp_data.wup

WHERE nb_id = 0
) dt2
ON t1.mandant_id = dt2.mandant_id
AND t1.wup_id  = dt2.wup_id
AND t1.nb_id   = dt2.nb_id

GROUP BY
t1.mandant_id
,dt2.vw_id
,t1.art_id
;



/*
#------------------------------------------------------------------------------
# 4.) Beladung der tmp1-Tabelle mit mandant_id, vw_id, art_id & sm_id
#------------------------------------------------------------------------------
*/

-- alte sm-Logik

INSERT INTO dbp_etl.art_vw_listung_von_tmp1 (mandant_id
,vw_id
,art_id
,sm_id
,ksm_id
,durchgaengig_fg)
SELECT dt_1.mandant_id
,dt_1.vw_id
,dt_2.art_id
,dt_1.sm_id
,'K0' AS ksm_id
,CASE WHEN (dt_2.s_lstg = dt_1.wup_anz)
THEN 1
ELSE 0
END AS durchgaengig_fg
FROM (SELECT dt1_1.mandant_id
,Count(DISTINCT dt1_1.wup_id) AS wup_anz
,dt1_1.wg_id
,dt1_1.sm_id
,dt1_2.vw_id
FROM dbp_data.sm_wup_wg_zu_per dt1_1
JOIN dbp_data.wup dt1_2
ON dt1_2.mandant_id = dt1_1.mandant_id AND
dt1_2.wup_id  = dt1_1.wup_id AND
dt1_2.nb_id   = dt1_1.nb_id
WHERE     CURRENT_DATE BETWEEN dt1_1.dat_von AND dt1_1.dat_bis AND
    CURRENT_DATE BETWEEN dt1_2.dat_von AND dt1_2.dat_bis AND
dt1_1.nb_id = 0
GROUP BY 1,3,4,5) dt_1
JOIN (SELECT dt2_1.mandant_id
,Count(dt2_1.wup_id) AS c_wup_id
,dt2_1.art_id
,dt2_1.wg_id
,dt2_2.sm_id
,dt2_2.vw_id
,Sum(dt2_1.listung_id) AS s_lstg
FROM (SELECT dt2_1_1.mandant_id
,dt2_1_1.art_id
,dt2_1_1.wup_id
,dt2_1_2.wg_id
,dt2_1_1.listung_id
FROM dbp_data.art_wup_zu_per dt2_1_1
JOIN dbp_data.art_wg_zu_per dt2_1_2
ON dt2_1_1.art_id = dt2_1_2.art_id AND
dt2_1_1.mandant_id = dt2_1_2.mandant_id
WHERE dt2_1_2.arthiertyp_id = 2 AND
    CURRENT_DATE BETWEEN dt2_1_2.dat_von AND dt2_1_2.dat_bis AND
    CURRENT_DATE BETWEEN dt2_1_1.dat_von AND dt2_1_1.dat_bis
GROUP BY 1,2,3,4,5) dt2_1
JOIN (SELECT dt2_2_1.mandant_id
,dt2_2_1.wup_id
,dt2_2_1.wg_id
,dt2_2_1.sm_id
,dt2_2_2.vw_id
FROM dbp_data.sm_wup_wg_zu_per dt2_2_1
JOIN dbp_data.wup dt2_2_2
ON dt2_2_2.mandant_id = dt2_2_1.mandant_id AND
dt2_2_2.wup_id  = dt2_2_1.wup_id AND
dt2_2_2.nb_id   = dt2_2_1.nb_id
WHERE     CURRENT_DATE BETWEEN dt2_2_1.dat_von AND dt2_2_1.dat_bis AND
    CURRENT_DATE BETWEEN dt2_2_2.dat_von AND dt2_2_2.dat_bis AND
dt2_2_1.nb_id = 0
GROUP BY 1,2,3,4,5) AS dt2_2
ON dt2_1.mandant_id = dt2_2.mandant_id AND
dt2_1.wup_id  = dt2_2.wup_id AND
dt2_1.wg_id   = dt2_2.wg_id
GROUP BY 1,3,4,5,6) dt_2
ON dt_1.mandant_id = dt_2.mandant_id AND
dt_1.wg_id = dt_2.wg_id AND
dt_1.sm_id = dt_2.sm_id AND
dt_1.vw_id = dt_2.vw_id
WHERE dt_2.sm_id > -1
;



-- neue ksm_id-Logik

INSERT INTO dbp_etl.art_vw_listung_von_tmp1 (mandant_id
,vw_id
,art_id
,sm_id
,ksm_id
,durchgaengig_fg)
SELECT dt_1.mandant_id
,dt_1.vw_id
,dt_2.art_id
,-1 AS sm_id
,'K'||Trim(Cast(dt_1.ksm_id AS VARCHAR(1))) AS ksm_id
  ,CASE WHEN (dt_2.s_lstg = dt_1.wup_anz)
   THEN 1
   ELSE 0
   END AS durchgaengig_fg
FROM 
(
SELECT dt1_1.mandant_id
,Count(DISTINCT dt1_1.wup_id) AS wup_anz
,dt1_1.wg_id
,CASE WHEN Cast(Substr(dt1_1.ksm_id,2,1) AS BYTEINT) > 7
THEN 7
ELSE Cast(Substr(dt1_1.ksm_id,2,1) AS BYTEINT)
END AS ksm_id
,dt1_2.vw_id
FROM dbp_data.sm_wup_wg_zu_per dt1_1
JOIN dbp_data.wup dt1_2
ON dt1_2.mandant_id = dt1_1.mandant_id AND
dt1_2.wup_id  = dt1_1.wup_id AND
dt1_2.nb_id   = dt1_1.nb_id
WHERE     CURRENT_DATE BETWEEN dt1_1.dat_von AND dt1_1.dat_bis AND
    CURRENT_DATE BETWEEN dt1_2.dat_von AND dt1_2.dat_bis AND
dt1_1.nb_id = 0 AND
LENGTH(dt1_1.ksm_id) = 2 AND
Substr(dt1_1.ksm_id,1,1) = 'K' AND
Cast(Substr(dt1_1.ksm_id,2,1) AS BYTEINT) BETWEEN 1 AND 9
GROUP BY 1,3,4,5
) dt_1
JOIN 
(
SELECT dt2_1.mandant_id
,Count(dt2_1.wup_id) AS c_wup_id
,dt2_1.art_id
,dt2_1.wg_id
,dt2_2.ksm_id
,dt2_2.vw_id
,Sum(dt2_1.listung_id) AS s_lstg
FROM 
(
SELECT dt2_1_1.mandant_id
,dt2_1_1.art_id
,dt2_1_1.wup_id
,dt2_1_2.wg_id
,dt2_1_1.listung_id
FROM dbp_data.art_wup_zu_per dt2_1_1
JOIN dbp_data.art_wg_zu_per dt2_1_2
ON dt2_1_1.art_id = dt2_1_2.art_id AND
dt2_1_1.mandant_id = dt2_1_2.mandant_id
WHERE dt2_1_2.arthiertyp_id = 2 AND
    CURRENT_DATE BETWEEN dt2_1_2.dat_von AND dt2_1_2.dat_bis AND
    CURRENT_DATE BETWEEN dt2_1_1.dat_von AND dt2_1_1.dat_bis
GROUP BY 1,2,3,4,5
) dt2_1
JOIN 
(
SELECT dt2_2_1.mandant_id
,dt2_2_1.wup_id
,dt2_2_1.wg_id
,CASE WHEN Cast(Substr(dt2_2_1.ksm_id,2,1) AS BYTEINT) > 7
THEN 7
ELSE Cast(Substr(dt2_2_1.ksm_id,2,1) AS BYTEINT)
END AS ksm_id
,dt2_2_2.vw_id
FROM dbp_data.sm_wup_wg_zu_per dt2_2_1
JOIN dbp_data.wup dt2_2_2
ON dt2_2_2.mandant_id = dt2_2_1.mandant_id AND
dt2_2_2.wup_id = dt2_2_1.wup_id AND
dt2_2_2.nb_id = dt2_2_1.nb_id
WHERE     CURRENT_DATE BETWEEN dt2_2_1.dat_von AND dt2_2_1.dat_bis AND
    CURRENT_DATE BETWEEN dt2_2_2.dat_von AND dt2_2_2.dat_bis AND
dt2_2_1.nb_id = 0 AND
LENGTH(dt2_2_1.ksm_id) = 2 AND
Substr(dt2_2_1.ksm_id,1,1) = 'K' AND
Cast(Substr(dt2_2_1.ksm_id,2,1) AS BYTEINT) BETWEEN 1 AND 9
GROUP BY 1,2,3,4,5
) AS dt2_2
ON dt2_1.mandant_id = dt2_2.mandant_id AND
dt2_1.wup_id  = dt2_2.wup_id AND
dt2_1.wg_id   = dt2_2.wg_id
GROUP BY 1,3,4,5,6
) dt_2
ON dt_1.mandant_id = dt_2.mandant_id AND
dt_1.wg_id = dt_2.wg_id 
AND coalesce(TRY_TO_NUMBER(dt_1.ksm_id),0) = coalesce(TRY_TO_NUMBER(dt_2.ksm_id),0) 
AND dt_1.vw_id = dt_2.vw_id
;











/*
#------------------------------------------------------------------------------
# 5.) Bereinigung der durchgaengigen Listungen pro VW und sm, die eine hoehere
#     sm haben, die nicht durchgaengig gelistet ist
#------------------------------------------------------------------------------
*/

-- alte sm_id-Logik

DELETE FROM dbp_etl.art_vw_listung_von_tmp1 t1

WHERE t1.durchgaengig_fg = 1
AND EXISTS
(
SELECT
*
FROM dbp_etl.art_vw_listung_von_tmp1 t2

WHERE t1.vw_id      = t2.vw_id
AND t1.mandant_id = t2.mandant_id
AND t1.art_id     = t2.art_id
AND t2.sm_id      > t1.sm_id
AND t2.durchgaengig_fg = 0
)
;



-- neue ksm_id-Logik

DELETE FROM dbp_etl.art_vw_listung_von_tmp1 t1

WHERE t1.durchgaengig_fg = 1
AND EXISTS
(
SELECT
*
FROM dbp_etl.art_vw_listung_von_tmp1 t2

WHERE t1.vw_id      = t2.vw_id
AND t1.mandant_id = t2.mandant_id
AND t1.art_id     = t2.art_id
AND t2.ksm_id     > t1.ksm_id
AND t2.durchgaengig_fg = 0
)
;



/*
#------------------------------------------------------------------------------
# 6.) Loeschen aller sm Einträge, die nicht durchgaengig gelistet sind
#------------------------------------------------------------------------------
*/

DELETE FROM dbp_etl.art_vw_listung_von_tmp1 t1
WHERE t1.durchgaengig_fg = 0
;



/*
#------------------------------------------------------------------------------
# 7.) Ermitteln des niedrigsten sm-Eintrages und loeschen aller hoeheren
#------------------------------------------------------------------------------
*/

-- alte sm_id-Logik

DELETE FROM dbp_etl.art_vw_listung_von_tmp1

WHERE (mandant_id,vw_id,art_id,sm_id) NOT IN
(
SELECT
mandant_id
,vw_id
,art_id
,MIN(sm_id)
FROM dbp_etl.art_vw_listung_von_tmp1

GROUP BY
mandant_id
,vw_id
,art_id
)
;



-- neue ksm_id-Logik

DELETE FROM dbp_etl.art_vw_listung_von_tmp1

WHERE (mandant_id,vw_id,art_id,ksm_id) NOT IN
(
SELECT
mandant_id
,vw_id
,art_id
,Min(ksm_id)
FROM dbp_etl.art_vw_listung_von_tmp1

GROUP BY
mandant_id
,vw_id
,art_id
)
;


/*
#------------------------------------------------------------------------------
# 8.) Erzeugung der tmp2-Tabelle mit allen moeglichen mandant_id, vw_id,
#     art_id - Kombinationen
#       - fuer die Vertriebslinien 1, 2 und 3 fuer Deutschland
#       - fuer die Vertriebslinien 0 fuer die KMO Mandanten
#
# 25.09.2016, -dbay-
#
# Neu nach VTL-Aufloesung: Jetzt nur noch VW_ID = 6 fuer DE!!!!

#------------------------------------------------------------------------------
*/

--vw_id = 6 fuer den Mandanten Deutschland
INSERT INTO dbp_etl.art_vw_listung_von_tmp2
(
mandant_id
,vw_id
,art_id
)
SELECT
t1.mandant_id
,6 AS vw_id
,t1.art_id

FROM dbp_data.art t1

WHERE mandant_id = 1
;



--vw_id = 10 fuer die KMO Mandanten
INSERT INTO dbp_etl.art_vw_listung_von_tmp2
(
mandant_id
,vw_id
,art_id
)
SELECT
t1.mandant_id
,10 AS vw_id
,t1.art_id
FROM dbp_data.art t1

WHERE mandant_id > 1
;



/*
#------------------------------------------------------------------------------
# 9.) Einfuegen der neuen/aktualisierten     CURRENT_DATE Saetze
#     in die Zieltabelle art_vw_listung_von
#------------------------------------------------------------------------------
*/

--* SQL_NAME: INS:dbp_data.art_vw_listung_von
INSERT INTO dbp_data.art_vw_listung_von
(
mandant_id
,vw_id
,art_id
,dat_von
,sm_id
,ksm_id
,dat_erst_listung
)
SELECT
mandant_id
,vw_id
,art_id
,to_date('19000101', 'YYYYMMDD') AS dat_von
,-1  AS sm_id
,'K0' AS ksm_id
,to_date('99991231', 'YYYYMMDD') AS dat_erst_listung
FROM dbp_etl.art_vw_listung_von_tmp2

WHERE (mandant_id,vw_id,art_id) NOT IN
(
SELECT
mandant_id
,vw_id
,art_id
FROM dbp_data.art_vw_listung_von
)
;



/*
#------------------------------------------------------------------------------
# 10.) Aktualisieren dat_von & sm_id in der Zieltabelle art_vw_listung_von,
#      falls Sortimentskategorie veraendert wurde
#------------------------------------------------------------------------------
*/

-- alte sm_id-Logik

UPDATE dbp_data.art_vw_listung_von
FROM
(
SELECT
vw_id vw_id_
,art_id art_id_
,mandant_id mandant_id_
,sm_id sm_id_
FROM dbp_etl.art_vw_listung_von_tmp1
)t1
SET sm_id = sm_id_
, dat_von =     CURRENT_DATE

WHERE mandant_id = mandant_id_
AND vw_id      = vw_id_
AND art_id     = art_id_
AND sm_id     <> sm_id_
;


-- neue ksm_id-Logik

UPDATE dbp_data.art_vw_listung_von
FROM
(
SELECT
vw_id vw_id_
,art_id art_id_
,mandant_id mandant_id_
,ksm_id ksm_id_
FROM dbp_etl.art_vw_listung_von_tmp1
)t1
SET ksm_id = ksm_id_
, dat_von =     CURRENT_DATE

WHERE mandant_id = mandant_id_
AND vw_id      = vw_id_
AND art_id     = art_id_
AND ksm_id     <> ksm_id_
;


/*
#------------------------------------------------------------------------------
# 11.) Aktualisieren dat_von & sm_id (auf Auslistung) in der Zieltabelle
#      art_vw_listung_von, falls Sortimentskategorie nicht verändert wurde
#------------------------------------------------------------------------------
*/

UPDATE dbp_data.art_vw_listung_von
SET sm_id   = -1
, dat_von =     CURRENT_DATE

WHERE sm_id <> -1
AND (mandant_id,vw_id,art_id) NOT IN
(
SELECT
mandant_id
,vw_id
,art_id
FROM dbp_etl.art_vw_listung_von_tmp1
)
;


UPDATE dbp_data.art_vw_listung_von
SET ksm_id  = 'K0'
, dat_von =     CURRENT_DATE

WHERE ksm_id <> 'K0'
AND (mandant_id,vw_id,art_id) NOT IN
(
SELECT
mandant_id
,vw_id
,art_id
FROM dbp_etl.art_vw_listung_von_tmp1
)
;

/*
#------------------------------------------------------------------------------
# 12.) Aktualisieren dat_erst_listung in der Zieltabelle art_vw_listung_von
#------------------------------------------------------------------------------
*/

UPDATE dbp_data.art_vw_listung_von
FROM
(
SELECT
vw_id vw_id_
,art_id art_id_
,mandant_id mandant_id_
,dat_erst_listung dat_erst_listung_
FROM dbp_etl.art_vw_listung_von_tmp
)t1
SET dat_erst_listung=dat_erst_listung_

WHERE mandant_id = mandant_id_
AND vw_id      = vw_id_
AND art_id     = art_id_
;


