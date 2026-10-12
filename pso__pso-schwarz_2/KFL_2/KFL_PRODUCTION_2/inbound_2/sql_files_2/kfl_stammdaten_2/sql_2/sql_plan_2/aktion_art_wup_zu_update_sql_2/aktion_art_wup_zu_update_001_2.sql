
CREATE OR REPLACE TRANSIENT TABLE _rows_mandant_${TRANSIENT_TABLE_SUFFIX} AS (
		SELECT a.mandant_id
			,a.sap_cnt
			 ,b.td_cnt
			,CASE 
				WHEN COALESCE(a.sap_cnt,0) < (COALESCE(b.td_cnt,0) * 0.6)
					THEN 0
				ELSE 1
				END AS update_fg
		FROM (
			SELECT awz.mandant_id
				,count(1) AS sap_cnt
			FROM DBP_ETL.aktion_art_wup_zu_2 awz
                        INNER JOIN DBP_DATA.aktion_2 ak 
                                ON awz.aktion_id = ak.aktion_id
                                AND awz.mandant_id = ak.mandant_id
                                AND awz.bewart_id = ak.bewart_id
                        WHERE ak.dat_von > CURRENT_DATE
			GROUP BY awz.mandant_id
			) a
		FULL OUTER JOIN (
			SELECT awz.mandant_id
				,count(1) AS td_cnt
			FROM DBP_DATA.aktion_art_wup_zu_2 awz
                        INNER JOIN DBP_DATA.aktion_2 ak 
                                ON awz.aktion_id = ak.aktion_id
                                AND awz.mandant_id = ak.mandant_id
                                AND awz.bewart_id = ak.bewart_id
                        WHERE ak.dat_von > CURRENT_DATE
                                AND awz.mandant_id <> 1
			GROUP BY awz.mandant_id
			) b ON a.mandant_id = b.mandant_id
		);

--[OK] statement is translated correctly (syntax and type checks are fine)

CREATE OR REPLACE TABLE DBP_ETL.aktion_art_wup_zu_tmp_2  (
	mandant_id BYTEINT NOT NULL
	,aktion_id CHAR(10) COLLATE 'en-ci' NOT NULL
	,art_id INTEGER NOT NULL
	,bewart_id SMALLINT NOT NULL 
        ,wup_id INTEGER NOT NULL
	,nb_id SMALLINT NOT NULL 
        ,vk_aktion_brutto DECIMAL(9,2) NOT NULL
	,bezugsweg_id BYTEINT NOT NULL 
	,wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL 
	,grund_sperrung CHAR(1) COLLATE 'en-ci' 
	,dat_sperrung DATE ,aktion_thema_id CHAR(4) COLLATE 'en-ci' NOT NULL 
	,vk_vor_aktion_brutto DECIMAL(9,2) 
        ,dat_preisaktiviert DATE NOT NULL DEFAULT to_date('1900-01-01','YYYY-MM_2-DD') 
	,art_fg byteint NOT NULL
	,geloescht_sap_fg BYTEINT
	,dat_geloescht_sap DATE
        ,vor_aktion_wrg_id CHAR(3) COLLATE 'en-ci'  
	) ;

--[OK] statement is translated correctly (syntax and type checks are fine)
DROP TABLE IF EXISTS DBP_ETL.aktion_art_wup_zu_tmp_del_2;


CREATE TABLE DBP_ETL.aktion_art_wup_zu_tmp_del_2  (
	mandant_id BYTEINT NOT NULL
	,aktion_id CHAR(10) COLLATE 'en-ci' NOT NULL
	,art_id INTEGER NOT NULL
	,bewart_id SMALLINT NOT NULL 
        ,wup_id INTEGER NOT NULL
	,nb_id SMALLINT NOT NULL
        ,vk_aktion_brutto DECIMAL(9,2) NOT NULL
	,bezugsweg_id BYTEINT NOT NULL 
	,wrg_id CHAR(3) COLLATE 'en-ci' NOT NULL 
	,grund_sperrung CHAR(1) COLLATE 'en-ci' 
	,dat_sperrung DATE
        ,aktion_thema_id CHAR(4) COLLATE 'en-ci' NOT NULL 
	,vk_vor_aktion_brutto DECIMAL(9,2)
        ,dat_preisaktiviert DATE NOT NULL DEFAULT to_date('1900-01-01','YYYY-MM_2-DD')
	,geloescht_sap_fg BYTEINT
	,dat_geloescht_sap DATE
        ,vor_aktion_wrg_id CHAR(3) COLLATE 'en-ci'  
	) ;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO DBP_ETL.aktion_art_wup_zu_tmp_2
SELECT awz.mandant_id
        ,awz.aktion_id
        ,awz.art_id
        ,awz.bewart_id
        ,awz.wup_id
        ,awz.nb_id
        ,awz.vk_aktion_brutto
        ,awz.bezugsweg_id
        ,awz.wrg_id
        ,awz.grund_sperrung
        ,awz.dat_sperrung
        ,awz.aktion_thema_id
        ,awz.vk_vor_aktion_brutto
        ,awz.dat_preisaktiviert
	,CASE 
		WHEN awz_cur.art_id IS NULL
			THEN 0
		ELSE 1
		END AS art_fg
	,awz_cur.geloescht_sap_fg
	,awz_cur.dat_geloescht_sap
        ,awz.vor_aktion_wrg_id 
FROM DBP_ETL.aktion_art_wup_zu_2 awz
INNER JOIN DBP_DATA.aktion_2 ak 
	ON awz.aktion_id = ak.aktion_id
	AND awz.mandant_id = ak.mandant_id
	AND awz.bewart_id = ak.bewart_id
INNER JOIN _rows_mandant_${TRANSIENT_TABLE_SUFFIX} r 
        ON awz.mandant_id = r.mandant_id
LEFT OUTER JOIN DBP_DATA.aktion_art_wup_zu_2 awz_cur 
        ON awz_cur.aktion_id = awz.aktion_id
	AND awz_cur.mandant_id = awz.mandant_id
	AND awz_cur.bewart_id = awz.bewart_id
	AND awz_cur.art_id = awz.art_id
	AND awz_cur.wup_id = awz.wup_id
	AND awz_cur.nb_id = awz.nb_id
WHERE ak.dat_von > CURRENT_DATE AND
	r.update_fg = 1;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied


INSERT INTO DBP_ETL.aktion_art_wup_zu_tmp_del_2
		SELECT awz_cur.mandant_id
                ,awz_cur.aktion_id
                ,awz_cur.art_id
                ,awz_cur.bewart_id
                ,awz_cur.wup_id
                ,awz_cur.nb_id
                ,awz_cur.vk_aktion_brutto
                ,awz_cur.bezugsweg_id
                ,awz_cur.wrg_id
                ,awz_cur.grund_sperrung
                ,awz_cur.dat_sperrung
                ,awz_cur.aktion_thema_id
                ,awz_cur.vk_vor_aktion_brutto
                ,awz_cur.dat_preisaktiviert
                ,awz_cur.geloescht_sap_fg
                ,awz_cur.dat_geloescht_sap
                ,awz_cur.vor_aktion_wrg_id 
		FROM DBP_DATA.aktion_art_wup_zu_2 awz_cur
		INNER JOIN DBP_DATA.aktion_2 ak 
                        ON awz_cur.aktion_id = ak.aktion_id
			AND awz_cur.mandant_id = ak.mandant_id
			AND awz_cur.bewart_id = ak.bewart_id
		INNER JOIN _rows_mandant_${TRANSIENT_TABLE_SUFFIX} r 
                        ON awz_cur.mandant_id = r.mandant_id
		LEFT OUTER JOIN DBP_ETL.aktion_art_wup_zu_2 awz 
                        ON awz_cur.aktion_id = awz.aktion_id
			AND awz_cur.mandant_id = awz.mandant_id
			AND awz_cur.bewart_id = awz.bewart_id
			AND awz_cur.art_id = awz.art_id
			AND awz_cur.wup_id = awz.wup_id
			AND awz_cur.nb_id = awz.nb_id
		WHERE ak.dat_von > CURRENT_DATE
			AND r.update_fg = 1
			AND awz.art_id IS NULL
;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
INSERT INTO DBP_DATA.aktion_art_wup_zu_2
(
         mandant_id
	,aktion_id
	,art_id
	,bewart_id
	,wup_id
	,nb_id
	,vk_aktion_brutto
	,bezugsweg_id
	,wrg_id
	,grund_sperrung
	,dat_sperrung
	,aktion_thema_id
	,vk_vor_aktion_brutto
	,dat_preisaktiviert
        ,td_insert
        ,td_update
	,geloescht_sap_fg
	,dat_geloescht_sap
        ,vor_aktion_wrg_id
)
SELECT mandant_id
	,aktion_id
	,art_id
	,bewart_id
	,wup_id
	,nb_id
	,vk_aktion_brutto
	,bezugsweg_id
	,wrg_id
	,grund_sperrung
	,dat_sperrung
	,aktion_thema_id
	,vk_vor_aktion_brutto
	,dat_preisaktiviert
        ,CURRENT_TIMESTAMP
        ,CURRENT_TIMESTAMP
	,0 AS geloescht_sap_fg
	,NULL AS dat_geloescht_sap
        ,vor_aktion_wrg_id 
FROM DBP_ETL.aktion_art_wup_zu_tmp_2 awz
WHERE art_fg = 0;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
UPDATE DBP_DATA.aktion_art_wup_zu_2
   SET geloescht_sap_fg = 0,
       dat_geloescht_sap = NULL,
       grund_sperrung = DBP_ETL.aktion_art_wup_zu_tmp.grund_sperrung,
       td_update = CURRENT_TIMESTAMP

        FROM  DBP_ETL.aktion_art_wup_zu_tmp_2
        WHERE DBP_DATA.aktion_art_wup_zu.aktion_id = DBP_ETL.aktion_art_wup_zu_tmp.aktion_id
                AND DBP_DATA.aktion_art_wup_zu.mandant_id = DBP_ETL.aktion_art_wup_zu_tmp.mandant_id
                AND DBP_DATA.aktion_art_wup_zu.bewart_id = DBP_ETL.aktion_art_wup_zu_tmp.bewart_id
                AND DBP_DATA.aktion_art_wup_zu.art_id = DBP_ETL.aktion_art_wup_zu_tmp.art_id
                AND DBP_DATA.aktion_art_wup_zu.wup_id = DBP_ETL.aktion_art_wup_zu_tmp.wup_id
                AND DBP_DATA.aktion_art_wup_zu.nb_id = DBP_ETL.aktion_art_wup_zu_tmp.nb_id
	AND DBP_ETL.aktion_art_wup_zu_tmp.art_fg = 1
	AND DBP_DATA.aktion_art_wup_zu.geloescht_sap_fg = 1
	AND DBP_DATA.aktion_art_wup_zu.dat_geloescht_sap IS NOT NULL;

--[not OK] statement is not translated correctly-----------------------------------------------------------------
UPDATE DBP_DATA.aktion_art_wup_zu_2
   SET geloescht_sap_fg = 1
	,dat_geloescht_sap = CURRENT_DATE
	,grund_sperrung = 'X'
        ,td_update = CURRENT_TIMESTAMP
FROM DBP_ETL.aktion_art_wup_zu_tmp_del_2
WHERE DBP_DATA.aktion_art_wup_zu.aktion_id =  DBP_ETL.aktion_art_wup_zu_tmp_del.aktion_id
	AND DBP_DATA.aktion_art_wup_zu.mandant_id = DBP_ETL.aktion_art_wup_zu_tmp_del.mandant_id
	AND DBP_DATA.aktion_art_wup_zu.bewart_id = DBP_ETL.aktion_art_wup_zu_tmp_del.bewart_id
	AND DBP_DATA.aktion_art_wup_zu.art_id = DBP_ETL.aktion_art_wup_zu_tmp_del.art_id
	AND DBP_DATA.aktion_art_wup_zu.wup_id = DBP_ETL.aktion_art_wup_zu_tmp_del.wup_id
	AND DBP_DATA.aktion_art_wup_zu.nb_id = DBP_ETL.aktion_art_wup_zu_tmp_del.nb_id;

--[~OK - basic syntax] correct Snowflake syntax but one or more objects are missing and type check was not applied
UPDATE DBP_DATA.aktion_art_wup_zu_2
   SET grund_sperrung = CASE WHEN geloescht_sap_fg = 1 then 'X' else a.grund_sperrung END,
       td_update = CURRENT_TIMESTAMP
FROM 
        (SELECT awz.mandant_id, 
                awz.aktion_id, 
                awz.bewart_id, 
                awz.art_id, 
                awz.wup_id, 
                awz.nb_id, 
                awz.grund_sperrung
        FROM DBP_ETL.aktion_art_wup_zu_2 awz
        INNER JOIN DBP_DATA.aktion_2 ak
                ON awz.aktion_id = ak.aktion_id
                AND awz.mandant_id = ak.mandant_id
                AND awz.bewart_id = ak.bewart_id
        WHERE ak.dat_von <= CURRENT_DATE) a WHERE DBP_DATA.aktion_art_wup_zu.aktion_id = a.aktion_id
	AND DBP_DATA.aktion_art_wup_zu.mandant_id = a.mandant_id
	AND DBP_DATA.aktion_art_wup_zu.bewart_id = a.bewart_id
	AND DBP_DATA.aktion_art_wup_zu.art_id = a.art_id
	AND DBP_DATA.aktion_art_wup_zu.wup_id = a.wup_id
	AND DBP_DATA.aktion_art_wup_zu.nb_id = a.nb_id;

/*******************Update vor_aktion_wrg_id *******************/
UPDATE DBP_DATA.aktion_art_wup_zu_2
   SET vor_aktion_wrg_id = DBP_ETL.aktion_art_wup_zu_tmp.vor_aktion_wrg_id,
       td_update = CURRENT_TIMESTAMP
  FROM DBP_ETL.aktion_art_wup_zu_tmp_2
 WHERE DBP_DATA.aktion_art_wup_zu.aktion_id  = DBP_ETL.aktion_art_wup_zu_tmp.aktion_id
   AND DBP_DATA.aktion_art_wup_zu.mandant_id = DBP_ETL.aktion_art_wup_zu_tmp.mandant_id
   AND DBP_DATA.aktion_art_wup_zu.bewart_id  = DBP_ETL.aktion_art_wup_zu_tmp.bewart_id
   AND DBP_DATA.aktion_art_wup_zu.art_id     = DBP_ETL.aktion_art_wup_zu_tmp.art_id
   AND DBP_DATA.aktion_art_wup_zu.wup_id     = DBP_ETL.aktion_art_wup_zu_tmp.wup_id
   AND DBP_DATA.aktion_art_wup_zu.nb_id      = DBP_ETL.aktion_art_wup_zu_tmp.nb_id
   AND DBP_DATA.aktion_art_wup_zu.vor_aktion_wrg_id <> DBP_ETL.aktion_art_wup_zu_tmp.vor_aktion_wrg_id
;

