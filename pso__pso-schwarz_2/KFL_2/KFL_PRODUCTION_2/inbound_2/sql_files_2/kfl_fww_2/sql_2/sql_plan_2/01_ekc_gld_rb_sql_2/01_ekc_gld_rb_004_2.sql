--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.gld_dat_2 (dat)
SELECT dat
FROM DBP_DATA.tag_2
WHERE dat BETWEEN (SELECT Min(dat) FROM DBP_DATA.tag_2 WHERE akt_mo = (-1)*${MONAT_2}) AND (SELECT Max(dat) FROM DBP_DATA.tag_2 WHERE akt_mo = (-1)*${MONAT_2}) AND
      dat NOT IN (SELECT dat FROM DBP_ETL.gld_dat_2)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.tmp_art_wup_tag_gld_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.tmp_art_wup_tag_gld_2  (
		art_id          INTEGER NOT NULL,
		mandant_id      BYTEINT NOT NULL,
		wup_id          INTEGER NOT NULL,
		nb_id           SMALLINT NOT NULL,
		dat             DATE NOT NULL,
		ek_gld          DECIMAL(18,4),
		umrechnungskurs FLOAT
	)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE OR REPLACE TRANSIENT TABLE _snap1_$_2{TRANSIENT_TABLE_SUFFIX} AS (
SELECT x.mandant_id,
       x.art_id,
       x.wup_id,
       x.nb_id,
       x.dat_buch,
       Sum(Cast(x.sum_betrag AS DECIMAL(18,4))) AS sum_betrag,
       Sum(Cast(x.sum_menge AS DECIMAL(18,4)))  AS sum_menge
FROM (SELECT mandant_id
            ,art_id
            ,wup_id
            ,nb_id
            ,dat_buch
            ,Abs(Sum(Cast((betrag_lagerbew ) AS DECIMAL(18,4)))) AS sum_betrag
            ,Abs(Sum(menge_lagerbew_bme)) AS sum_menge
      FROM DBP_DATA.lagerbew_det_2 l
      JOIN DBP_ETL.gld_dat_2 d
        ON dat_buch = dat
      WHERE l.lager_bewart_id IN ('251', '252') AND 
            l.mandant_id > 1
      GROUP BY 1,2,3,4,5
      UNION ALL
      SELECT mandant_id
            ,art_id
            ,wup_id
            ,nb_id
            ,dat_buch
            ,Abs(Sum(Cast((betrag_lagerbew ) AS DECIMAL(18,4)))) AS sum_betrag
            ,Abs(Sum(menge_lagerbew_bme)) AS sum_menge
      FROM DBP_DATA.lagerbew_det_delta_2 l
      JOIN DBP_ETL.gld_dat_2 d
        ON dat_buch = dat
      WHERE l.lager_bewart_id IN ('251', '252') AND 
            l.mandant_id > 1
      GROUP BY 1,2,3,4,5) x
GROUP BY 1,2,3,4,5
);

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.tmp_art_wup_tag_gld_2
(	 mandant_id
	,art_id
	,wup_id
	,nb_id
	,dat
	,ek_gld
	,umrechnungskurs
)
SELECT a.mandant_id
      ,a.art_id
      ,a.wup_id
      ,a.nb_id
      ,a.dat_buch
      ,CASE
         WHEN sum_menge = 0 
         THEN 0 /*bei Division durch 0: ek_gld = 0*/
         ELSE sum_betrag/sum_menge
       END AS ek_gld
      ,k.umrechnungskurs
FROM _snap1_$_2{TRANSIENT_TABLE_SUFFIX} a
JOIN DBP_DATA.mandant_2 m
  ON a.mandant_id = m.mandant_id
JOIN DBP_DATA.kurs_2 k
  ON k.von_wrg_id = m.default_wrg AND 
     k.kurstyp_id = 9 AND
     k.nach_wrg_id = 'EUR' AND
     a.dat_buch BETWEEN k.dat_von AND k.dat_bis
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--UPDATE 	${DWH_COMMON_DBX_DATA}.artbew_2
--SET 	ek_gld           = 0
--	, diff_ek_gld_konz = 0
--WHERE 	${DWH_COMMON_DBX_DATA}.artbew.dat        = ${DWH_COMMON_DBX_LOAD}.gld_dat.dat
--AND 	${DWH_COMMON_DBX_DATA}.artbew.mandant_id > 1
--;
--
--Comment from validation checker
--error line 4 at position 36
--WHERE 	DBP_DATA.artbew.dat        =  ^^^> DBP_ETL.gld_dat.dat
--invalid identifier 'DBP_ETL.GLD_DAT.DAT'
--translated statement
UPDATE 	DBP_DATA.artbew_2
SET 	ek_gld           = 0
	, diff_ek_gld_konz = 0
WHERE 	DBP_DATA.artbew.dat        = DBP_ETL.gld_dat.dat
AND 	DBP_DATA.artbew.mandant_id > 1
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--UPDATE ${DWH_COMMON_DBX_DATA}.artbew_2
--SET 	ek_gld           = umsatz_netto
--	, diff_ek_gld_konz = diff_umsatz_netto_konz
--
--WHERE 	${DWH_COMMON_DBX_DATA}.artbew.dat        = ${DWH_COMMON_DBX_LOAD}.gld_dat.dat
--AND 	${DWH_COMMON_DBX_DATA}.artbew.mandant_id > 1
--AND 	${DWH_COMMON_DBX_DATA}.artbew.art_id     = -1 /*unbekannter Artikel_2*/
--;
--
--Comment from validation checker
--error line 5 at position 36
--WHERE 	DBP_DATA.artbew.dat        =  ^^^> DBP_ETL.gld_dat.dat
--invalid identifier 'DBP_ETL.GLD_DAT.DAT'
--translated statement
UPDATE DBP_DATA.artbew_2
SET 	ek_gld           = umsatz_netto
	, diff_ek_gld_konz = diff_umsatz_netto_konz

WHERE 	DBP_DATA.artbew.dat        = DBP_ETL.gld_dat.dat
AND 	DBP_DATA.artbew.mandant_id > 1
AND 	DBP_DATA.artbew.art_id     = -1 /*unbekannter Artikel_2*/
;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
--original statement
--UPDATE 	${DWH_COMMON_DBX_DATA}.artbew_2
--FROM	${DWH_COMMON_DBX_DATA}.art_2 a
--SET 	ek_gld           	= (ek_netto )
--	, diff_ek_gld_konz 	= (diff_ek_netto_konz )
--WHERE ${DWH_COMMON_DBX_DATA}.artbew.dat        = ${DWH_COMMON_DBX_LOAD}.gld_dat.dat
--AND 	${DWH_COMMON_DBX_DATA}.artbew.mandant_id > 1
--AND 	${DWH_COMMON_DBX_DATA}.artbew.mandant_id = a.mandant_id
--AND 	${DWH_COMMON_DBX_DATA}.artbew.art_id     = a.art_id
--AND 	${DWH_COMMON_DBX_DATA}.artbew.art_id     > -1
--AND 	a.wg_art_fg                 = 1 /*Warengruppenerfassartikel*/
--;
--
--Comment from validation checker
--error line 5 at position 35
--WHERE DBP_DATA.artbew.dat        =  ^^^> DBP_ETL.gld_dat.dat
--invalid identifier 'DBP_ETL.GLD_DAT.DAT'
--translated statement
UPDATE 	DBP_DATA.artbew_2
FROM	DBP_DATA.art_2 a
SET 	ek_gld           	= (ek_netto )
	, diff_ek_gld_konz 	= (diff_ek_netto_konz )
WHERE DBP_DATA.artbew.dat        = DBP_ETL.gld_dat.dat
AND 	DBP_DATA.artbew.mandant_id > 1
AND 	DBP_DATA.artbew.mandant_id = a.mandant_id
AND 	DBP_DATA.artbew.art_id     = a.art_id
AND 	DBP_DATA.artbew.art_id     > -1
AND 	a.wg_art_fg                 = 1 /*Warengruppenerfassartikel*/
;

--[OK] statement is translated correctly (syntax and type checks are fine)
UPDATE 	DBP_DATA.artbew_2
FROM 	DBP_ETL.tmp_art_wup_tag_gld_2 g
	, DBP_DATA.art_2 a
SET 	ek_gld           = g.ek_gld * menge
	, diff_ek_gld_konz = g.ek_gld * menge * umrechnungskurs
WHERE 	DBP_DATA.artbew.dat        = g.dat
AND 	DBP_DATA.artbew.mandant_id = g.mandant_id
AND 	DBP_DATA.artbew.wup_id     = g.wup_id
AND 	DBP_DATA.artbew.art_id     = g.art_id
AND 	DBP_DATA.artbew.dat        = g.dat
AND 	DBP_DATA.artbew.art_id     > -1
AND 	DBP_DATA.artbew.mandant_id = a.mandant_id
AND 	DBP_DATA.artbew.art_id     = a.art_id
AND 	a.wg_art_fg                 = 0 /*keine WG Erfassartiekel*/
;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.gld_dat_2;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.tmp_art_wup_tag_gld_2;

