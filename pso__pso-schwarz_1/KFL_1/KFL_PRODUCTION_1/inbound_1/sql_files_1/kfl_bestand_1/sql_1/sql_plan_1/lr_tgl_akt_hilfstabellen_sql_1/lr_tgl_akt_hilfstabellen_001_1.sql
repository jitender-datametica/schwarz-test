--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.mk_wupcal_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.mk_wupcal_1  (
      mandant_id BYTEINT,
      wup_id INTEGER,
      nb_id SMALLINT,
      dat DATE,
      wtag_id BYTEINT,
      offen BYTEINT)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.mk_wupcal_1 (
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
            
			FROM        DBP_DATA.wupcal_1 AS t01
            INNER JOIN
                        DBP_DATA.tag_1 AS t02
            ON        t01.dat = t02.dat
            AND       t01.mandant_id = 1
            AND       t01.nb_id = 0
            AND       t02.wtag_id <> 7;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE OR REPLACE TRANSIENT TABLE mk_wup_art_auswahl_updt_$_1{TRANSIENT_TABLE_SUFFIX}  (
      mandant_id BYTEINT,
      wup_id INTEGER,
      wtag_id BYTEINT,
      nb_id SMALLINT,
      art_id INTEGER,
      avg_menge DECIMAL(18,3),
      anz_tage_in_aktion BYTEINT,
      aktion_fg BYTEINT,
      aktiv_fg BYTEINT,
      anz_tage_0verkauf BYTEINT,
      dat_von DATE,
      dat_bis DATE)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO mk_wup_art_auswahl_updt_$_1{TRANSIENT_TABLE_SUFFIX} (
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
            , 0 AS aktiv_fg
            , t01.anz_tage_0verkauf
            , CURRENT_DATE AS dat_von
            , to_date('9999-12-31','YYYY-MM_1-DD') AS dat_bis
  FROM      DBP_DATA.mk_art_wup_auswahl_1 AS t01
  WHERE     (t01.mandant_id, t01.art_id) NOT IN (
              SELECT   t02.mandant_id
                        , t02.art_id
              FROM      DBP_DATA.art_1 AS t02
              INNER JOIN
                        DBP_DATA.art_wg_zu_per_1 AS t03
              ON        t02.mandant_id = t03.mandant_id
              AND       t02.art_id = t03.art_id
              -- Aktuell gueltige Einträge der art_wg_zu_per_1
              AND       t03.dat_bis = to_date('9999-12-31','YYYY-MM_1-DD')
              AND       t03.arthiertyp_id = 2
				       			 
              -- Nur Artikel_1 aus aktueller Auswahl
              WHERE    (t02.mandant_id, t02.art_id) IN (
                          SELECT    t05.mandant_id
                                    , t05.art_id
                          FROM      DBP_DATA.mk_art_wup_auswahl_1 AS t05
                          WHERE     t05.aktiv_fg = 1
                          AND       CURRENT_DATE BETWEEN t05.dat_von AND t05.dat_bis
                          )
              -- Nur die nicht über Warengruppen erfassten Artikel_1
              AND  t02.wg_art_fg = 0     
              -- Ausschluss von Postenartikeln
              AND       t02.posten_id = ''
			  			-- Ausschluss Display
			  			AND t02.display_id = 0
              -- Ausschluss von gelöschten Artikeln
              AND       t02.loesch_id = ''
						  -- Ausschluss bestimmter Warengruppen aus der Abteilung Food
						  AND 			(t03.mandant_id, t03.wg_id) NOT IN (SELECT mandant_id, wg_id FROM DBP_DATA.wg_filter_zu_1 WHERE arthiertyp_id=2 AND wg_filter_id=7)
						  -- Nur Abteilung Food wird berücksichtigt
						  AND 			(t03.mandant_id, t03.wg_id) IN (SELECT mandant_id, wg_id FROM DBP_DATA.wg_filter_zu_1 WHERE arthiertyp_id=2 AND wg_filter_id=8)  
              GROUP BY  t02.mandant_id
                        , t02.art_id)
  AND       t01.aktiv_fg = 1
  AND       CURRENT_DATE BETWEEN t01.dat_von AND t01.dat_bis

  
  ;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'T01' does not exist or not authorized.
UPDATE    DBP_DATA.mk_art_wup_auswahl_1 t01
SET       dat_bis = CURRENT_DATE - 1
FROM      
          mk_wup_art_auswahl_updt_$_1{TRANSIENT_TABLE_SUFFIX} AS t02

WHERE     t01.mandant_id = t02.mandant_id
AND       t01.wup_id = t02.wup_id
AND       t01.art_id = t02.art_id
AND       t01.wtag_id = t02.wtag_id 
AND       t01.aktion_fg = t02.aktion_fg 
AND       t01.aktiv_fg = 1
AND       CURRENT_DATE BETWEEN t01.dat_von AND t01.dat_bis;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.mk_art_wup_auswahl_1(
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
  , dat_bis )

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
            , t01.dat_von
            , t01.dat_bis
  FROM      mk_wup_art_auswahl_updt_$_1{TRANSIENT_TABLE_SUFFIX} AS t01;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS mk_wup_art_auswahl_updt_$_1{TRANSIENT_TABLE_SUFFIX};

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
--WARNING : Volatile tables can be used within one script only. If it's used across multiple sliced scripts it has to be changed to TRANSIENT table (CREATE OR REPLACE TRANSIENT TABLE schema.table ...)
CREATE OR REPLACE TRANSIENT TABLE mk_wup_art_auswahl_updt_$_1{TRANSIENT_TABLE_SUFFIX}  (
      mandant_id BYTEINT,
      wup_id INTEGER,
      wtag_id BYTEINT,
      nb_id SMALLINT,
      art_id INTEGER,
      avg_menge DECIMAL(18,3),
      anz_tage_in_aktion BYTEINT,
      aktion_fg BYTEINT,
      aktiv_fg BYTEINT,
      anz_tage_0verkauf BYTEINT,
      dat_von DATE,
      dat_bis DATE)
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO mk_wup_art_auswahl_updt_$_1{TRANSIENT_TABLE_SUFFIX} (
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
            , 0 AS aktiv_fg
            , t01.anz_tage_0verkauf
            , CURRENT_DATE AS dat_von
            , to_date('9999-12-31','YYYY-MM_1-DD') AS dat_bis
  FROM      DBP_DATA.mk_art_wup_auswahl_1 AS t01
  WHERE     (t01.mandant_id, t01.wup_id, t01.art_id) NOT IN (   
              SELECT    t02.mandant_id
                        , t02.wup_id
                        , t02.art_id
              FROM      DBP_DATA.mk_art_wup_auswahl_1 AS t01
              INNER JOIN
                        DBP_DATA.art_wup_zu_per_1 t02
              ON        t01.mandant_id = t02.mandant_id
              AND       t01.wup_id = t02.wup_id
              AND       t01.art_id = t02.art_id
              WHERE     t01.aktiv_fg = 1
              AND       CURRENT_DATE BETWEEN t01.dat_von AND t01.dat_bis
              -- Überprüfen ob Artikel_1 gelistet ist ...
              AND       t02.listung_id = 1
              AND       t02.bezugsweg_id IN (1, 4)
              -- ... und das KDIS Kennzeichen auf 0 steht
              AND       t02.kdis = 0
              AND       CURRENT_DATE BETWEEN t02.dat_von AND t02.dat_bis)
 
  AND        (t01.mandant_id, t01.wup_id, t01.art_id) NOT IN ( 
             SELECT     mandant_id
                       , wup_id
                       , art_id  
			    FROM 
			  DBP_DATA.art_wup_status_per_1
			  WHERE         
			  dispomerkmal IN ('01','11','ZZ')
			  AND kdis = 0  
			  AND dat_bis = to_date('9999-12-31','YYYY-MM_1-DD') 
			  GROUP BY 1,2,3 )           
  AND       t01.aktiv_fg = 1
  AND       CURRENT_DATE BETWEEN t01.dat_von AND t01.dat_bis
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied

--Comment from validation checker
--MESSAGE: SQL compilation error:
--Object 'T01' does not exist or not authorized.
UPDATE    DBP_DATA.mk_art_wup_auswahl_1 t01
SET       dat_bis = CURRENT_DATE - 1
FROM      mk_wup_art_auswahl_updt_$_1{TRANSIENT_TABLE_SUFFIX} AS t02

WHERE     t01.mandant_id = t02.mandant_id
AND       t01.wup_id = t02.wup_id
AND       t01.wtag_id = t02.wtag_id
AND       t01.art_id = t02.art_id
AND       t01.aktion_fg = t02.aktion_fg 
AND       t01.aktiv_fg = 1
AND       CURRENT_DATE BETWEEN t01.dat_von AND t01.dat_bis;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_DATA.mk_art_wup_auswahl_1(
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
  , dat_bis )

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
            , t01.dat_von
            , t01.dat_bis
  FROM      mk_wup_art_auswahl_updt_$_1{TRANSIENT_TABLE_SUFFIX} AS t01;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.mk_promocal_1;

--[OK] statement is translated correctly (syntax and type checks are fine)
--WARNING : FORMAT is not supported by Snowflake. Use TO_CHAR() function instead.
CREATE TABLE DBP_ETL.mk_promocal_1  (
      mandant_id BYTEINT,
      wup_id INTEGER,
      nb_id SMALLINT,
      art_id INTEGER,
      dat DATE
      )
;

--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.mk_promocal_1
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
              FROM      DBP_DATA.mk_art_wup_auswahl_1 AS t01
              INNER JOIN
                        DBP_DATA.aktion_art_wup_zu_1 AS t02
              ON        t01.mandant_id = t02.mandant_id
              AND       t01.wup_id = t02.wup_id
              AND       t01.nb_id = t02.nb_id
              AND       t01.art_id = t02.art_id
              INNER JOIN
                        DBP_DATA.aktion_1 AS t03
              ON        t02.mandant_id = t03.mandant_id
              AND       t02.aktion_id = t03.aktion_id
              AND       t03.preisaktiviert_fg = 1
              INNER JOIN
                        DBP_DATA.tag_1 AS t04
              ON        t04.dat BETWEEN t03.dat_von AND t03.dat_bis
              WHERE     t01.aktion_fg = 1
              AND       t01.aktiv_fg = 1
              AND       CURRENT_DATE BETWEEN t01.dat_von AND t01.dat_bis
              AND       t02.grund_sperrung IS NULL
              
              AND       t04.dat BETWEEN CURRENT_DATE -7 AND CURRENT_DATE
              QUALIFY   RANK() OVER(PARTITION BY t01.mandant_id, t01.wup_id, t01.art_id, dat ORDER BY t02.aktion_id DESC) = 1) AS t05
  INNER JOIN 
            DBP_DATA.art_wup_zu_per_1 AS t06
  ON        t05.mandant_id = t06.mandant_id
  AND       t05.wup_id = t06.wup_id
  AND       t05.art_id = t06.art_id
  AND       t05.dat BETWEEN t06.dat_von AND t06.dat_bis
GROUP BY 1,2,3,4,5 ;

