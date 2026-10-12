set (wkw) = (${WKW});

CREATE OR REPLACE VOLATILE TABLE _werbeartikel_1_kmo  (
  kjwo INTEGER,
  werbetyp_id BYTEINT,
  dat_von DATE,
  dat_bis DATE,
  wup_id INTEGER,
  mandant_id BYTEINT,
  art_id INTEGER,
  akt_wo SMALLINT,
  vk_brutto DECIMAL(9,2),
  stkl_kopf_fg BYTEINT,
  komponente INTEGER,
  mutter_wb_id INTEGER,
  avq_relevant_fg BYTEINT,
  grund_sperrung VARCHAR(1)
);

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT CASE
         WHEN c.werbetyp_id = 8 AND x1.wtag_id = 7
         THEN x2.kjwo
         ELSE x1.kjwo
       END AS kjwo,
       c.werbetyp_id,
       CASE
         WHEN c.werbetyp_id = 8 AND x1.wtag_id = 7
         THEN akt.dat_von 
         ELSE akt.dat_von
       END AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN (SELECT mandant_id,
             dat_von,
             dat_bis,
             werbe_typ_id AS werbetyp_id
      FROM dbp_data.ts_avq_werbezeitraum_abw_1
      WHERE mandant_id > 1) c
  ON akt.mandant_id = c.mandant_id AND
     akt.dat_von = c.dat_von AND
     akt.dat_bis = c.dat_bis
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat
WHERE ((akt.mandant_id IN (2,5,6) AND
        x1.akt_wo = $wkw) OR
       (akt.mandant_id IN (3) AND
        SUBSTR(akt.aktion_id,9,2) NOT IN ('DN','DV','DP','DW','DS','DK') AND
        x1.akt_wo = $wkw) OR
       (akt.mandant_id IN (7,4) AND
        SUBSTR(akt.aktion_id,9,2) IN ('MM_1','HG','NF','HA','HB','LD','TV','VD') AND
        x1.akt_wo = $wkw) OR
       (akt.mandant_id IN (7,4) AND
        TRY_TO_NUMBER(akt.aktion_id) IS NOT NULL AND
        x1.akt_wo = $wkw) OR
       (akt.mandant_id IN (8) AND
        POSITION('D1' IN akt.aktion_id) = 0 AND
        POSITION('D2' IN akt.aktion_id) = 0 AND
        POSITION('DS' IN akt.aktion_id) = 0 AND
       (RIGHT(akt.aktion_id,1) <> 'J' OR LENGTH(akt.aktion_id) = 10) AND
        x1.akt_wo = $wkw)) AND
       (x2.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,c.werbetyp_id) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT a.kjwo,
       a.werbe_typ_id,
       CASE
         WHEN a.werbe_typ_id = 5 AND b.wtag_id = 1
         THEN b.dat+3
         WHEN a.werbe_typ_id = 6 AND b.wtag_id = 1
         THEN b.dat+2
         WHEN a.werbe_typ_id = 7 AND b.wtag_id = 1
         THEN b.dat
       END AS dat_von_,
       CASE
         WHEN a.werbe_typ_id = 5 AND b.wtag_id = 1
         THEN b.dat+9
         WHEN a.werbe_typ_id = 6 AND b.wtag_id = 1
         THEN b.dat+8
         WHEN a.werbe_typ_id = 7 AND b.wtag_id = 1
         THEN b.dat+6
       END AS dat_bis_,
       a.wup_id,
       a.mandant_id,
       a.art_id,
       b.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       a.mutter_wb_id,
       a.avq_relevant_fg,
       ' ' as grund_sperrung
FROM dbp_process.werbung_kennzahlen_kopf_1 a
JOIN dbp_data.tag_1 b
  ON a.kjwo = b.kjwo
WHERE b.akt_wo = $wkw AND
      dat_von_ IS NOT NULL AND
      dat_bis_ IS NOT NULL AND
      a.mandant_id IN (2,3,4,5,6,7,8) AND
     (a.kjwo,a.wup_id,a.mandant_id,a.art_id) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       CASE
         WHEN akt.mandant_id = 2 AND
              akt.dat_bis >= '2019-02-27'
         THEN 6
         WHEN akt.mandant_id IN (4,7)
         THEN 6
         WHEN akt.mandant_id = 8
         THEN 7
         ELSE 5
       END AS werbetyp_id,
       akt.dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
	ON akt.aktion_id = akta.aktion_id AND
	akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = CASE
                    WHEN akt.mandant_id = 2 AND
                         akt.dat_bis >= '2019-02-27'
                    THEN 3
                    WHEN akt.mandant_id IN (4,7)
                    THEN 3
                    WHEN akt.mandant_id = 8
                    THEN 1
                    ELSE 4
                  END
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = CASE
                    WHEN akt.mandant_id = 2 AND
                         akt.dat_bis >= '2019-02-27'
                    THEN 2
                    WHEN akt.mandant_id IN (4,7)
                    THEN 2
                    WHEN akt.mandant_id = 8
                    THEN 7
                    ELSE 3
                  END AND
     x2.dat - 6 = x1.dat
WHERE ((akt.mandant_id IN (2,5,6) AND
        x1.akt_wo = $wkw) OR
       (akt.mandant_id IN (3) AND
        SUBSTR(akt.aktion_id,9,2) NOT IN ('DN','DV','DP','DW','DS','DK') AND
        x1.akt_wo = $wkw) OR
       (akt.mandant_id IN (4,7) AND
        CASE
          WHEN akt.mandant_id = 4
          THEN 1
          WHEN akt.mandant_id = 7 AND 
               akta.wrg_id = ''
          THEN 0
          ELSE 1
        END = 1 AND
        CASE
          WHEN akt.mandant_id IN (4,7) AND
               TRY_TO_NUMBER(akt.aktion_id) IS NOT NULL
          THEN 1
          WHEN SUBSTR(akt.aktion_id,9,2) IN ('MM_1','HG','NF','HA','HB','LD') 
          THEN 1
          ELSE 0
        END = 1 AND
        x1.akt_wo = $wkw) OR
	  (akt.mandant_id IN (8) AND
	   POSITION('D1' IN akt.aktion_id) = 0 AND
	   POSITION('D2' IN akt.aktion_id) = 0 AND
	   POSITION('DS' IN akt.aktion_id) = 0 AND
	  (RIGHT(akt.aktion_id,1) <> 'J' OR LENGTH(akt.aktion_id) = 10) AND
     x1.akt_wo = $wkw)) AND
    (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       8 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
	ON akt.aktion_id = akta.aktion_id AND
	akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 1
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 3 AND
     x2.dat - 2 = x1.dat
WHERE ((akt.mandant_id IN (2,4,5,6,7) AND
        CASE
          WHEN akt.mandant_id = 4
          THEN 1
          WHEN akt.mandant_id IN (2,5,6,7) AND 
               akta.wrg_id = ''
          THEN 0
          ELSE 1
        END = 1 AND
       x1.akt_wo = $wkw) OR
       (akt.mandant_id IN (3) AND
        SUBSTR(akt.aktion_id,9,2) NOT IN ('DN','DV','DP','DW','DS','DK') AND
        x1.akt_wo = $wkw) OR
	     (akt.mandant_id IN (8) AND
        POSITION('DS' IN akt.aktion_id) = 0 AND
       (RIGHT(akt.aktion_id,1) <> 'J' OR LENGTH(akt.aktion_id) = 10) AND
        x1.akt_wo = $wkw)) AND
       (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,8) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       9 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 6
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 7 AND
     x2.dat - 1 = x1.dat
WHERE ((akt.mandant_id IN (2,6) AND
	      x1.akt_wo = $wkw) OR
	     (akt.mandant_id IN (7,4) AND
        CASE
          WHEN akt.mandant_id = 4
          THEN 1
          WHEN akt.mandant_id IN (7) AND 
               akta.wrg_id = ''
          THEN 0
          ELSE 1
        END = 1 AND
	      SUBSTR(akt.aktion_id,9,2) IN ('MM_1','HG','NF','HA','HB','LD','TV','VD') AND
        x1.akt_wo = $wkw) OR
	   (akt.mandant_id IN (7,4) AND
		  CASE
          WHEN akt.mandant_id = 4
          THEN 1
          WHEN akt.mandant_id IN (7) AND 
               akta.wrg_id = ''
          THEN 0
          ELSE 1
        END = 1 AND
	    TRY_TO_NUMBER(akt.aktion_id) IS NOT NULL AND
        x1.akt_wo = $wkw) OR
       (akt.mandant_id IN (3) AND
		    SUBSTR(akt.aktion_id,9,2) NOT IN ('DN','DV','DP','DW','DS','DK') AND
        x1.akt_wo = $wkw)) AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,9) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       10 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 5
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 1 AND
     x2.dat - 3 = x1.dat
WHERE akt.mandant_id IN (4,7) AND
        CASE
          WHEN akt.mandant_id = 4
          THEN 1
          WHEN akt.mandant_id IN (2,5,6,7) AND 
               akta.wrg_id = ''
          THEN 0
          ELSE 1
        END = 1 AND
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,10) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       4 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 4
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 7 AND
     x2.dat - 3 = x1.dat
WHERE ((akt.mandant_id IN (2,3,4,6) AND
        x1.akt_wo = $wkw) OR
       (akt.mandant_id IN (8) AND
        POSITION('DS' IN akt.aktion_id) = 0 AND
       (RIGHT(akt.aktion_id,1) <> 'J' OR LENGTH(akt.aktion_id) = 10) AND
        x1.akt_wo = $wkw)) AND
       (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,4) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;
                    
INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       6 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 3
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 2 AND
     x2.dat - 6 = x1.dat
WHERE ((akt.mandant_id IN (6) AND
        
        x1.akt_wo = $wkw) OR
       (akt.mandant_id IN (8) AND
        
        POSITION('DS' IN akt.aktion_id) = 0 AND
        (RIGHT(akt.aktion_id,1) <> 'J' OR LENGTH(akt.aktion_id) = 10) AND
        x1.akt_wo = $wkw)) AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,6) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;
                    
INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       7 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 1
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 7 AND
     x2.dat - 6 = x1.dat
WHERE ((akt.mandant_id IN (2,5,6) AND
		
        x1.akt_wo = $wkw) OR
       (akt.mandant_id IN (3) AND
		
	    SUBSTR(akt.aktion_id,9,2) NOT IN ('DN','DV','DP','DW','DS','DK') AND
        x1.akt_wo = $wkw) OR
	   (akt.mandant_id IN (4,7) AND
        CASE
          WHEN akt.mandant_id = 4
          THEN 1
          WHEN akt.mandant_id IN (2,5,6,7) AND 
               akta.wrg_id = ''
          THEN 0
          ELSE 1
        END = 1 AND
        CASE
          WHEN TRY_TO_NUMBER(akt.aktion_id) IS NOT NULL
          THEN 1
          WHEN SUBSTR(akt.aktion_id,9,2) IN ('MM_1','HG','NF','HA','HB','LD')
          THEN 1
          ELSE 0
        END = 1 AND
        x1.akt_wo = $wkw)) AND
      (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,7) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;
                    
INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       5 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
	ON akt.aktion_id = akta.aktion_id AND
	akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 4
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 3 AND
     x2.dat - 6 = x1.dat
WHERE ((akt.mandant_id in (4)) or
      (akt.mandant_id IN (8) AND
       POSITION('D1' IN akt.aktion_id) = 0 AND
       POSITION('D2' IN akt.aktion_id) = 0 AND
       POSITION('DS' IN akt.aktion_id) = 0 AND
      (RIGHT(akt.aktion_id,1) <> 'J' OR LENGTH(akt.aktion_id) = 10))) AND
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,5) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;
                    
INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       12 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
	ON akt.aktion_id = akta.aktion_id AND
	akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 1
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 2 AND
     x2.dat - 1 = x1.dat
WHERE akt.mandant_id IN (2,4,6,7) AND
        CASE
          WHEN akt.mandant_id = 4
          THEN 1
          WHEN akt.mandant_id IN (2,5,6,7) AND 
               akta.wrg_id = ''
          THEN 0
          ELSE 1
        END = 1 AND
        CASE
          WHEN akt.mandant_id in (2,6)
          THEN 1
          WHEN TRY_TO_NUMBER(akt.aktion_id) IS NOT NULL
          THEN 1
          WHEN SUBSTR(akt.aktion_id,9,2) IN ('LM') 
          THEN 1
          ELSE 0
        END = 1 AND
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,12) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       13 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 5
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 7 AND
     x2.dat - 2 = x1.dat
WHERE ((akt.mandant_id IN (4,7) AND
        CASE
          WHEN akt.mandant_id = 4
          THEN 1
          WHEN akt.mandant_id IN (2,5,6,7) AND 
               akta.wrg_id = ''
          THEN 0
          ELSE 1
        END = 1 AND
        CASE
          WHEN TRY_TO_NUMBER(akt.aktion_id) IS NOT NULL
          THEN 1
          WHEN akt.mandant_id = 7 AND
	       SUBSTR(akt.aktion_id,9,2) IN ('VD','TV') 
          THEN 1
          WHEN akt.mandant_id = 4 AND
	       SUBSTR(akt.aktion_id,9,2) IN ('VD','TV') 
          THEN 1
          ELSE 0
        END = 1 AND
        x1.akt_wo = $wkw) OR
       (akt.mandant_id IN (2,6) AND
        x1.akt_wo = $wkw) OR
       (akt.mandant_id IN (8) AND
        POSITION('D1' IN akt.aktion_id) = 0 AND
        POSITION('D2' IN akt.aktion_id) = 0 AND
        POSITION('DS' IN akt.aktion_id) = 0 AND
       (RIGHT(akt.aktion_id,1) <> 'J' OR LENGTH(akt.aktion_id) = 10) AND
        x1.akt_wo = $wkw)) AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,13) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       11 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
	ON akt.aktion_id = akta.aktion_id AND
	akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 3
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 6 AND
     x2.dat - 3 = x1.dat
WHERE ((akt.mandant_id IN (8) AND
        POSITION('D1' IN akt.aktion_id) = 0 AND
        POSITION('D2' IN akt.aktion_id) = 0 AND
        POSITION('DS' IN akt.aktion_id) = 0 AND
       (RIGHT(akt.aktion_id,1) <> 'J' OR LENGTH(akt.aktion_id) = 10) AND
        x1.akt_wo = $wkw) or
       (akt.mandant_id IN (2) AND
        x1.akt_wo = $wkw)) AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,11) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       14 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 7
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 7 AND
     x2.dat - 0 = x1.dat
WHERE akt.mandant_id IN (5) AND
	  
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,14) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
	   16 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
	   0 AS vk_brutto,
  	   0 AS stkl_kopf_fg,
	   0 AS komponente,
	   -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
	ON akt.aktion_id = akta.aktion_id AND
	akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 6
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 6 AND
     x2.dat - 0 = x1.dat
WHERE akt.mandant_id IN (3) AND
	  
      SUBSTR(akt.aktion_id,9,2) NOT IN ('DN','DV','DP','DW','DS','DK') AND
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,16) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
	   16 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
	   0 AS vk_brutto,
  	   0 AS stkl_kopf_fg,
	   0 AS komponente,
	   -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
	ON akt.aktion_id = akta.aktion_id AND
	akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 6
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 6 AND
     x2.dat - 0 = x1.dat
WHERE akt.mandant_id IN (8) AND
	  
	  POSITION('D1' IN akt.aktion_id) = 0 AND
	  POSITION('D2' IN akt.aktion_id) = 0 AND
	  POSITION('DS' IN akt.aktion_id) = 0 AND
	  (RIGHT(akt.aktion_id,1) <> 'J' OR LENGTH(akt.aktion_id) = 10) AND
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,16) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       15 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
	ON akt.aktion_id = akta.aktion_id AND
	akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 1
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 7 AND
     x2.dat - 13 = x1.dat
WHERE akt.mandant_id IN (8) AND
	  
	  POSITION('D1' IN akt.aktion_id) = 0 AND
	  POSITION('D2' IN akt.aktion_id) = 0 AND
	  POSITION('DS' IN akt.aktion_id) = 0 AND
	  (RIGHT(akt.aktion_id,1) <> 'J' OR LENGTH(akt.aktion_id) = 10) AND
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,15) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

-- 21.09.2022, -dbay-
--
-- new promotion type for bulgaria

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       18 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 5
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 6 AND
     x2.dat - 1 = x1.dat
WHERE ((akt.mandant_id IN (8) AND
        POSITION('D1' IN akt.aktion_id) = 0 AND
        POSITION('D2' IN akt.aktion_id) = 0 AND
        POSITION('DS' IN akt.aktion_id) = 0 AND
       (RIGHT(akt.aktion_id,1) <> 'J' OR LENGTH(akt.aktion_id) = 10) AND
        x1.akt_wo = $wkw) or
       (akt.mandant_id IN (2,6) AND
        x1.akt_wo = $wkw)) AND
       (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,18) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
	   17 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
	   0 AS vk_brutto,
  	   0 AS stkl_kopf_fg,
	   0 AS komponente,
	   -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
	ON akt.aktion_id = akta.aktion_id AND
	akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 2
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 7 AND
     x2.dat - 5 = x1.dat
WHERE akt.mandant_id IN (8) AND
	  
	  POSITION('D1' IN akt.aktion_id) = 0 AND
	  POSITION('D2' IN akt.aktion_id) = 0 AND
	  POSITION('DS' IN akt.aktion_id) = 0 AND
	  (RIGHT(akt.aktion_id,1) <> 'J' OR LENGTH(akt.aktion_id) = 10) AND
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,17) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
	   19 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
	   0 AS vk_brutto,
  	   0 AS stkl_kopf_fg,
	   0 AS komponente,
	   -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
	ON akt.aktion_id = akta.aktion_id AND
	akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 7 AND
	 x1.akt_wo = $wkw-1
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 3 AND
     x2.dat - 3 = x1.dat AND
	 x2.akt_wo = $wkw
WHERE akt.mandant_id IN (5) AND
        CASE
          WHEN akt.mandant_id = 4
          THEN 1
          WHEN akt.mandant_id IN (2,5,6,7) AND 
               akta.wrg_id = ''
          THEN 0
          ELSE 1
        END = 1 AND
      x2.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,19) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
	   20 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
	   0 AS vk_brutto,
  	   0 AS stkl_kopf_fg,
	   0 AS komponente,
	   -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 3
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 5 AND
     x2.dat - 2 = x1.dat
WHERE akt.mandant_id IN (4,7) AND
        CASE
          WHEN akt.mandant_id = 4
          THEN 1
          WHEN akt.mandant_id IN (7) AND 
               akta.wrg_id = ''
          THEN 0
          ELSE 1
        END = 1 AND
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,20) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       21 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 4
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 6 AND
     x2.dat - 2 = x1.dat
WHERE akt.mandant_id IN (3) AND
      SUBSTR(akt.aktion_id,9,2) NOT IN ('DN','DV','DP','DW','DS','DK') AND
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,21) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       22 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
  	   0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 4
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 4 AND
     x2.dat - 0 = x1.dat
WHERE akt.mandant_id IN (4) AND
        CASE
          WHEN akt.mandant_id = 4
          THEN 1
          WHEN akt.mandant_id IN (7) AND 
               akta.wrg_id = ''
          THEN 0
          ELSE 1
        END = 1 AND
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,22) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

-- 04.04.2025, neuer Werbetyp fuer HR (Mo. bis Sa.)

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       1 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 1
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 6 AND
     x2.dat - 5 = x1.dat
WHERE akt.mandant_id IN (6) AND
	  
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,1) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

-- TV-Werbung RO (Mi. bis So.)

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       23 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 3
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 7 AND
     x2.dat - 4 = x1.dat
WHERE akt.mandant_id IN (7) AND
        CASE
          WHEN akt.mandant_id = 4
          THEN 1
          WHEN akt.mandant_id IN (7) AND 
               akta.wrg_id = ''
          THEN 0
          ELSE 1
        END = 1 AND
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,23) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

-- TV-Werbung RO (Mi. bis Do.)

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       24 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 3
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 4 AND
     x2.dat - 1 = x1.dat
WHERE akt.mandant_id IN (7) AND
        CASE
          WHEN akt.mandant_id = 4
          THEN 1
          WHEN akt.mandant_id IN (7) AND 
               akta.wrg_id = ''
          THEN 0
          ELSE 1
        END = 1 AND
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,24) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

-- TV-Werbung RO (Fr. bis Di.)

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       29 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 5
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 2 AND
     x2.dat - 4 = x1.dat
WHERE akt.mandant_id IN (7) AND
        CASE
          WHEN akt.mandant_id = 4
          THEN 1
          WHEN akt.mandant_id IN (7) AND 
               akta.wrg_id = ''
          THEN 0
          ELSE 1
        END = 1 AND
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,29) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

-- TV-Werbung RO (Sa. bis Di.)

INSERT INTO _werbeartikel_1_kmo (kjwo
                                ,werbetyp_id
                                ,dat_von
                                ,dat_bis
                                ,wup_id
                                ,mandant_id
                                ,art_id
                                ,akt_wo
                                ,vk_brutto
                                ,stkl_kopf_fg
                                ,komponente
                                ,mutter_wb_id
                                ,avq_relevant_fg
                                ,grund_sperrung)
SELECT x1.kjwo,
       30 AS werbetyp_id,
       akt.dat_von AS dat_von,
       akt.dat_bis,
       akta.wup_id,
       akta.mandant_id,
       akta.art_id,
       x1.akt_wo,
       0 AS vk_brutto,
       0 AS stkl_kopf_fg,
       0 AS komponente,
       -999 AS mutter_wb_id,
       akt.avq_relevant_fg,
       akta.grund_sperrung
FROM (SELECT a.*,
             case when aktion_typ_id is not null then 0 else 1 end as avq_relevant_fg
      FROM dbp_data.aktion_1 a
      WHERE mandant_id > 1) akt
JOIN (SELECT *
      FROM dbp_data.aktion_art_wup_zu_1
      WHERE mandant_id > 1 AND
            COALESCE(geloescht_sap_fg,0) <> 1) akta
  ON akt.aktion_id = akta.aktion_id AND
     akt.mandant_id = akta.mandant_id
JOIN dbp_data.tag_1 x1
  ON akt.dat_von = x1.dat AND
     x1.wtag_id = 6
JOIN dbp_data.tag_1 x2
  ON akt.dat_bis = x2.dat AND
     x2.wtag_id = 2 AND
     x2.dat - 3 = x1.dat
WHERE akt.mandant_id IN (7) AND
        CASE
          WHEN akt.mandant_id = 4
          THEN 1
          WHEN akt.mandant_id IN (7) AND 
               akta.wrg_id = ''
          THEN 0
          ELSE 1
        END = 1 AND
      x1.akt_wo = $wkw AND
     (x1.kjwo,akta.wup_id,akta.mandant_id,akta.art_id,30) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _werbeartikel_1_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14
;

CREATE OR REPLACE VOLATILE TABLE _pp AS (
SELECT *
FROM _werbeartikel_1_kmo
);
                    
DELETE FROM _werbeartikel_1_kmo;

INSERT INTO _werbeartikel_1_kmo
SELECT kjwo,
       werbetyp_id,
       MIN(dat_von) AS dat_von,
       MAX(dat_bis) AS dat_bis,
       wup_id,
       mandant_id,
       art_id,
       akt_wo,
       vk_brutto,
       stkl_kopf_fg,
       komponente,
       MAX(mutter_wb_id) AS mutter_wb_id,
       MAX(avq_relevant_fg) as avq_relevant_fg,
       MIN(grund_sperrung) as grund_sperrung
FROM _pp
GROUP BY 1,2,5,6,7,8,9,10,11
;

CREATE OR REPLACE VOLATILE TABLE _ff_mutter_art_kmo AS (
SELECT a.mandant_id,
       a.art_id,
       COALESCE(a.mutter_wb_id,a.art_id) AS mutter_wb_id
FROM dbp_data.art_1 a
WHERE a.dat_bis = '9999-12-31' AND
     (a.mandant_id,a.art_id) IN (SELECT mandant_id,
                                        art_id
	                         FROM _werbeartikel_1_kmo
				 GROUP BY 1,2)
GROUP BY 1,2,3
);

UPDATE _werbeartikel_1_kmo 
SET mutter_wb_id = b.mutter_wb_id
FROM (SELECT *
      FROM _ff_mutter_art_kmo) b
WHERE _werbeartikel_1_kmo.mandant_id = b.mandant_id AND
      _werbeartikel_1_kmo.art_id = b.art_id AND
      _werbeartikel_1_kmo.mutter_wb_id = -999
;

UPDATE _werbeartikel_1_kmo SET mutter_wb_id = art_id
WHERE mutter_wb_id = -999
;

DELETE FROM _werbeartikel_1_kmo
WHERE (mandant_id,wup_id,art_id) IN (SELECT b.mandant_id,
                                            b.wup_id,
                                            b.art_id
                                     FROM _werbeartikel_1_kmo a
                                     JOIN dbp_data.artbew_stueckliste_zu_1 b
                                       ON a.mandant_id = b.mandant_id AND
                                          a.art_id = b.komponente_art_id AND
	                                  a.wup_id = b.wup_id AND
	                                  b.dat BETWEEN a.dat_von AND a.dat_bis)
;

CREATE OR REPLACE VOLATILE TABLE _matchings AS (
SELECT kjwo,
       MIN(dat_von) AS dat_von,
       MAX(dat_bis) AS dat_bis,
       mandant_id,
       akt_wo,
       werbetyp_id
FROM _werbeartikel_1_kmo
GROUP BY 1,4,5,6
);

INSERT INTO _werbeartikel_1_kmo (kjwo,
                                 dat_von,
                                 dat_bis,
                                 wup_id,
                                 mandant_id,
                                 art_id,
                                 akt_wo,
                                 werbetyp_id,
                                 stkl_kopf_fg,
                                 komponente,
                                 vk_brutto,
                                 avq_relevant_fg,
                                 grund_sperrung)
SELECT c.kjwo,
       MIN(c.dat_von) AS dat_von,
       MAX(a.dat_bis) AS dat_bis,
       b.wup_id,
       c.mandant_id,
       b.art_id,
       c.akt_wo,
       c.werbetyp_id,
       1 AS stkl_kopf_fg,
       b.komponente_art_id,
       0 AS vk_brutto,
       a.avq_relevant_fg,
       a.grund_sperrung
FROM _werbeartikel_1_kmo a
JOIN dbp_data.artbew_stueckliste_zu_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.komponente_art_id AND
     a.wup_id = b.wup_id AND
     b.dat BETWEEN a.dat_von AND a.dat_bis
JOIN dbp_data.art_wg_zu_per_1 b1
  ON a.mandant_id = b1.mandant_id AND
     b.art_id = b1.art_id AND
     b1.arthiertyp_id = 2 AND
     b1.dat_bis = '9999-12-31' AND
     b1.wg_id NOT IN (SELECT wg_id FROM dbp_data.wg_filter_zu_1 WHERE wg_filter_id = 46 AND mandant_id > 1) AND
     CASE
       WHEN a.mandant_id IN (4,7) AND
           (b1.wg_id = 30 OR
            b1.wg_id = 161 OR
            b1.wg_id = 162 OR
            b1.wg_id = 163 OR
            b1.wg_id = 164 OR
            b1.wg_id = 165 OR
            b1.wg_id = 166)
       THEN 0
       ELSE 1
     END = 1
JOIN _matchings c
  ON a.mandant_id = c.mandant_id AND
     a.werbetyp_id = c.werbetyp_id
GROUP BY 1,4,5,6,7,8,9,10,11,12,13
;

CREATE OR REPLACE VOLATILE TABLE _double_check AS (
SELECT c.kjwo,
       c.dat_von,
       a.dat_bis,
       b.wup_id,
       c.mandant_id,
       b.art_id,
       c.akt_wo,
       c.werbetyp_id,
       1 AS stkl_kopf_fg,
       b.komponente_art_id,
       0 AS vk_brutto,
       a.avq_relevant_fg,
       a.grund_sperrung
FROM _werbeartikel_1_kmo a
JOIN dbp_data.artbew_stueckliste_zu_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     a.wup_id = b.wup_id AND
     b.dat BETWEEN a.dat_von AND a.dat_bis
JOIN dbp_data.art_wg_zu_per_1 b1
  ON a.mandant_id = b1.mandant_id AND
     b.art_id = b1.art_id AND
     b1.arthiertyp_id = 2 AND
     b1.dat_bis = '9999-12-31' AND
     b1.wg_id NOT IN (SELECT wg_id FROM dbp_data.wg_filter_zu_1 WHERE wg_filter_id = 46 AND mandant_id > 1) AND
     CASE
       WHEN a.mandant_id IN (4,7) AND
           (b1.wg_id = 30 OR
            b1.wg_id = 161 OR
            b1.wg_id = 162 OR
            b1.wg_id = 163 OR
            b1.wg_id = 164 OR
            b1.wg_id = 165 OR
            b1.wg_id = 166)
       THEN 0
       ELSE 1
     END = 1
JOIN _matchings c
  ON a.mandant_id = c.mandant_id AND
     a.werbetyp_id = c.werbetyp_id
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13
);

MERGE INTO _werbeartikel_1_kmo a
USING (SELECT *
       FROM _double_check
       WHERE (kjwo,mandant_id,dat_von,dat_bis,wup_id,art_id,werbetyp_id) IN (SELECT kjwo,mandant_id,dat_von,dat_bis,wup_id,art_id,werbetyp_id
                                                                             FROM _double_check
                                                                             GROUP BY 1,2,3,4,5,6,7
                                                                             HAVING COUNT(*) = 1)) b
								 
ON a.kjwo = b.kjwo AND
   a.mandant_id = b.mandant_id AND
   a.dat_von = b.dat_von AND
   a.dat_bis = b.dat_bis AND
   a.wup_id = b.wup_id AND
   a.art_id = b.art_id AND
   a.werbetyp_id = b.werbetyp_id 

WHEN MATCHED THEN UPDATE SET komponente = b.komponente_art_id,
                             stkl_kopf_fg = 1
							 
WHEN NOT MATCHED THEN INSERT (kjwo,
                              werbetyp_id,
                              dat_von,
                              dat_bis,
                              wup_id,
                              mandant_id,
                              art_id,
                              akt_wo,
                              vk_brutto,
                              stkl_kopf_fg,
                              komponente,
                              mutter_wb_id,
                              avq_relevant_fg,
                              grund_sperrung)
                      VALUES (b.kjwo,
                              b.werbetyp_id,
                              b.dat_von,
                              b.dat_bis,
                              b.wup_id,
                              b.mandant_id,
                              b.art_id,
                              b.akt_wo,
                              b.vk_brutto,
                              b.stkl_kopf_fg,
                              b.komponente_art_id,
                              NULL,
                              b.avq_relevant_fg,
                              b.grund_sperrung)
;

MERGE INTO _werbeartikel_1_kmo a
USING (SELECT *
       FROM _double_check
       WHERE (kjwo,mandant_id,dat_von,dat_bis,wup_id,art_id,werbetyp_id) IN (SELECT kjwo,mandant_id,dat_von,dat_bis,wup_id,komponente_art_id,werbetyp_id
                                                                             FROM _double_check
                                                                             GROUP BY 1,2,3,4,5,6,7
                                                                             HAVING COUNT(*) = 1)) b
						 
ON a.kjwo = b.kjwo AND
   a.mandant_id = b.mandant_id AND
   a.dat_von = b.dat_von AND
   a.dat_bis = b.dat_bis AND
   a.wup_id = b.wup_id AND
   a.art_id = b.komponente_art_id AND
   a.werbetyp_id = b.werbetyp_id 

WHEN MATCHED THEN UPDATE SET stkl_kopf_fg = 3

WHEN NOT MATCHED THEN INSERT (kjwo,
                              werbetyp_id,
                              dat_von,
                              dat_bis,
                              wup_id,
                              mandant_id,
                              art_id,
                              akt_wo,
                              vk_brutto,
                              stkl_kopf_fg,
                              komponente,
                              mutter_wb_id,
                              avq_relevant_fg,
                              grund_sperrung)
                      VALUES (b.kjwo,
                              b.werbetyp_id,
                              b.dat_von,
                              b.dat_bis,
                              b.wup_id,
                              b.mandant_id,
                              b.komponente_art_id,
                              b.akt_wo,
                              b.vk_brutto,
                              0,
                              0,
                              -999,
                              b.avq_relevant_fg,
                              b.grund_sperrung)
;

UPDATE _werbeartikel_1_kmo 
SET mutter_wb_id = b.mutter_wb_id
FROM (SELECT *
      FROM _ff_mutter_art_kmo) b
WHERE _werbeartikel_1_kmo.mandant_id = b.mandant_id AND
      _werbeartikel_1_kmo.art_id = b.art_id AND
      _werbeartikel_1_kmo.mutter_wb_id = -999
;

UPDATE _werbeartikel_1_kmo SET mutter_wb_id = art_id
WHERE mutter_wb_id = -999
;

CREATE OR REPLACE VOLATILE TABLE _kompo_tracking AS (
SELECT komponente,
       COUNT(DISTINCT art_id) AS anzahl
FROM _werbeartikel_1_kmo
WHERE stkl_kopf_fg = 1
GROUP BY 1
HAVING COUNT(DISTINCT art_id) > 1
);

UPDATE _werbeartikel_1_kmo 
SET stkl_kopf_fg = 2 
FROM (SELECT *
      FROM _kompo_tracking) b
WHERE _werbeartikel_1_kmo.komponente = b.komponente
;

create or replace volatile table _pp as (
select a.*,
       cast(0 as decimal(18,4)) as vk_vor_aktion_brutto,
       cast(0 as decimal(18,4)) as vk_aktion_brutto,
       cast(0 as decimal(18,4)) as vk_kcard_brutto
from _werbeartikel_1_kmo a
);

create or replace volatile table _werbeartikel_1_kmo as (
select *
from _pp
);

UPDATE _werbeartikel_1_kmo 
SET vk_brutto = b.vk_brutto
FROM (SELECT a.art_id,
             a.mandant_id,
             a.wup_id,
             b.werbetyp_id,
             MAX(a.vk_brutto) AS vk_brutto
      FROM dbp_data.art_wup_vk_per_1 a
      JOIN _werbeartikel_1_kmo b
        ON a.mandant_id = b.mandant_id AND
           a.art_id = b.art_id AND
           a.wup_id = b.wup_id AND
           b.dat_von BETWEEN a.dat_von AND a.dat_bis
      GROUP BY 1,2,3,4) b
WHERE _werbeartikel_1_kmo.mandant_id = b.mandant_id AND
      _werbeartikel_1_kmo.wup_id = b.wup_id AND
      _werbeartikel_1_kmo.art_id = b.art_id AND
      _werbeartikel_1_kmo.werbetyp_id = b.werbetyp_id
;

UPDATE _werbeartikel_1_kmo 
SET vk_vor_aktion_brutto = b.vk_vor_aktion_brutto,
    vk_aktion_brutto = b.vk_aktion_brutto
FROM (SELECT a.art_id,
             a.mandant_id,
             a.wup_id,
             b.werbetyp_id,
             MAX(a.vk_vor_aktion_brutto) AS vk_vor_aktion_brutto,
             MIN(CASE WHEN a.vk_aktion_brutto > 0 THEN a.vk_aktion_brutto ELSE a.vk_vor_aktion_brutto END) as vk_aktion_brutto
      FROM dbp_data.aktion_1 c
      join dbp_data.aktion_art_wup_zu_1 a
        on c.mandant_id = a.mandant_id and
           c.aktion_id = a.aktion_id
      JOIN _werbeartikel_1_kmo b
        ON a.mandant_id = b.mandant_id AND
           a.art_id = b.art_id AND
           a.wup_id = b.wup_id AND
           b.dat_von BETWEEN c.dat_von AND c.dat_bis
      GROUP BY 1,2,3,4) b
WHERE _werbeartikel_1_kmo.mandant_id = b.mandant_id AND
      _werbeartikel_1_kmo.wup_id = b.wup_id AND
      _werbeartikel_1_kmo.art_id = b.art_id AND
      _werbeartikel_1_kmo.werbetyp_id = b.werbetyp_id
;

update _werbeartikel_1_kmo from (select b.mandant_id,
                                        b.wup_id,
                                        b.art_id,
                                        a.dat_von,
                                        a.dat_bis,
                                        min(b.vk_aktion_brutto) as min_vk_aktion_brutto,
                                        max(b.vk_aktion_brutto) as max_vk_aktion_brutto,
                                        min(a.aktion_id) as min_aktion_id,
                                        max(a.aktion_id) as max_aktion_id,
                                        count(distinct a.aktion_id) as anz_aktion_id,
                                        min(coalesce(x.flag,0)) as min_flag,
                                        max(coalesce(x.flag,0)) as max_flag
                                 from dbp_data.aktion_1 a
                                 join dbp_data.aktion_art_wup_zu_1 b
                                   on a.mandant_id = b.mandant_id and
                                      a.aktion_id = b.aktion_id
                                 left join (select mandant_id,
                                                   aktion_id,
                                                   1 as flag
                                            from dbp_data.l_bonuskauf_1
                                            group by 1,2,3) x
                                   on a.aktion_id = x.aktion_id and 
                                      a.mandant_id = x.mandant_id
                                 join (select mandant_id,
                                              dat_von,
                                              dat_bis
                                       from _werbeartikel_1_kmo
                                       group by 1,2,3) c
                                   on a.mandant_id = c.mandant_id and
                                      a.dat_von = c.dat_von and
                                      a.dat_bis = c.dat_bis
                                 where coalesce(b.geloescht_sap_fg,0) <> 1
                                 group by 1,2,3,4,5
                                 having min_vk_aktion_brutto = 0 and
                                        max_vk_aktion_brutto = 0 and
                                        max_flag = 1 and
                                        min_flag = 1) b
                                 
set avq_relevant_fg = 9

where _werbeartikel_1_kmo.mandant_id = b.mandant_id and
      _werbeartikel_1_kmo.wup_id = b.wup_id and
      _werbeartikel_1_kmo.art_id = b.art_id and
      _werbeartikel_1_kmo.dat_von = b.dat_von and
      _werbeartikel_1_kmo.dat_bis = b.dat_bis and
      _werbeartikel_1_kmo.avq_relevant_fg = 1
;

update _werbeartikel_1_kmo 
set vk_kcard_brutto = b.vk_kcard_brutto
from (select a.art_id,
             a.mandant_id,
             a.wup_id,
             b.werbetyp_id,
             min(d.preis_aktion) as vk_kcard_brutto
      from dbp_data.aktion_1 c
      join dbp_data.aktion_art_wup_zu_1 a
        on c.mandant_id = a.mandant_id and
           c.aktion_id = a.aktion_id
      join dbp_data.pmr_angebot_art_wup_zu_1 d
        on a.mandant_id and d.mandant_id and
           a.wup_id = d.wup_id and
           a.art_id = d.art_id and
           a.aktion_id = d.aktion_id
      join _werbeartikel_1_kmo b
        on a.mandant_id = b.mandant_id and
           a.art_id = b.art_id and
           a.wup_id = b.wup_id and
           b.dat_von = c.dat_von and 
           b.dat_bis = c.dat_bis
      where d.preis_aktion <> 0 and
            c.aktion_typ_id <> 'KDP'
      group by 1,2,3,4) b
where _werbeartikel_1_kmo.mandant_id = b.mandant_id and
      _werbeartikel_1_kmo.wup_id = b.wup_id and
      _werbeartikel_1_kmo.art_id = b.art_id and
      _werbeartikel_1_kmo.werbetyp_id = b.werbetyp_id
;

CREATE OR REPLACE VOLATILE TABLE _pp AS (
SELECT *
FROM _werbeartikel_1_kmo
);
                    
DELETE FROM _werbeartikel_1_kmo;

INSERT INTO _werbeartikel_1_kmo
SELECT kjwo,
       werbetyp_id,
       MIN(dat_von) AS dat_von,
       MAX(dat_bis) AS dat_bis,
       wup_id,
       mandant_id,
       art_id,
       akt_wo,
       vk_brutto,
       min(stkl_kopf_fg) as stkl_kopf_fg,
       min(komponente) as komponente,
       MAX(mutter_wb_id) AS mutter_wb_id,
       MAX(avq_relevant_fg) as avq_relevant_fg,
       MIN(grund_sperrung) as grund_sperrung,
       max(vk_vor_aktion_brutto) as vk_vor_aktion_brutto,
       max(vk_aktion_brutto) as vk_aktion_brutto,
       max(vk_kcard_brutto) as vk_kcard_brutto
FROM _pp
GROUP BY 1,2,5,6,7,8,9
;

CREATE OR REPLACE VOLATILE TABLE _werbetyp_tage_kmo AS (
SELECT b.mandant_id,
       b.werbetyp_id,
       CASE 
         -- kunftige und abgeschlossene aktionen volle anzahl tage
	 WHEN b.dat_von >= CURRENT_DATE OR b.dat_bis < CURRENT_DATE THEN b.dat_bis-b.dat_von+1
	 -- laufende aktionen anzahl tage start bis heute
	 ELSE CURRENT_DATE-b.dat_von 
       END AS anz_tage_aktion
FROM _werbeartikel_1_kmo b
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _die_tage_kmo AS (
SELECT b.mandant_id,
       a.dat
FROM dbp_data.tag_1 a
JOIN _werbeartikel_1_kmo b
  ON a.dat BETWEEN b.dat_von AND b.dat_bis
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _test1_ff_kmo AS (
SELECT w.kjwo,
       w.werbetyp_id,
       w.dat_von,
       w.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       v.nb_id,
       w.grund_sperrung,
       SUM(v.umsatz_netto) AS umsatz_netto,
       SUM(v.menge) AS menge_,
       6-COUNT(DISTINCT v.dat) AS tage_menge_0
FROM dbp_data.artbew_1 v
JOIN _werbeartikel_1_kmo w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.dat BETWEEN w.dat_von AND w.dat_bis
WHERE v.bewart_id = 1002 AND
     (v.mandant_id,v.dat) IN (SELECT mandant_id,dat FROM _die_tage_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9
HAVING menge_ > 0
);

INSERT INTO _test1_ff_kmo
SELECT w.kjwo,
       w.werbetyp_id,
       w.dat_von,
       w.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       v.nb_id,
       w.grund_sperrung,
       SUM(v.umsatz_netto) AS umsatz_netto,
       SUM(v.menge) AS menge_,
       6-COUNT(DISTINCT v.dat) AS tage_menge_0
FROM dbp_data.artbew_1 v
JOIN (SELECT *
      FROM _werbeartikel_1_kmo
      WHERE (kjwo,werbetyp_id,mandant_id,art_id) NOT IN (SELECT kjwo,werbetyp_id,mandant_id,art_id FROM _test1_ff_kmo) AND
             stkl_kopf_fg = 3) w 
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.dat BETWEEN w.dat_von AND w.dat_bis
WHERE v.bewart_id = 1001 AND
     (v.mandant_id,v.dat) IN (SELECT mandant_id,dat FROM _die_tage_kmo)
GROUP BY 1,2,3,4,5,6,7,8,9
HAVING menge_ > 0
;

CREATE OR REPLACE VOLATILE TABLE _ff_we1_kmo AS (
SELECT a.mandant_id,
       a.kjwo,
       a.dat_von,
       a.dat_bis,
       a.werbetyp_id,
       a.wup_id,
       a.nb_id,
       a.art_id
FROM _test1_ff_kmo a
JOIN dbp_data.art_wg_zu_per_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
);

create or replace volatile table _ff_we2_kmo as (
select a.*,
       b.dat,
       b.dat_2
from _ff_we1_kmo a
join (select a.mandant_id,
             a.kjwo,
             a.werbetyp_id,
             case
               when b.dat between a.dat_von and a.dat_bis
               then b.dat
               else null
             end as dat,
             case
               when b.dat not between a.dat_von and a.dat_bis
               then b.dat
               else null
             end as dat_2
      from _ff_we1_kmo a
      join dbp_data.tag_1 b
        on b.dat between a.dat_von-7 and a.dat_bis
      group by 1,2,3,4,5) b
  on a.kjwo = b.kjwo and
     a.werbetyp_id = b.werbetyp_id and
     a.mandant_id = b.mandant_id
);

create or replace volatile table _ff_we3_kmo as (
select a.mandant_id,
       a.werbetyp_id,
       a.dat_von,
       a.dat_bis,
       a.kjwo,
       coalesce(a.dat,a.dat_2) as dat,
       a.wup_id,
       a.nb_id,
       a.art_id,
       coalesce(b.menge_lagerbew_bme, 0) as we_menge,
       coalesce(c.menge_lagerbew_bme, 0) as we_menge_2
from _ff_we2_kmo a
left join (select b.mandant_id,
                  b.wup_id,
                  c.werbetyp_id,
                  b.art_id,
                  b.dat_buch,
                  sum(b.menge_lagerbew_bme) as menge_lagerbew_bme
           from dbp_data.lagerbew_1 a
           join dbp_data.lagerbew_det_1 b
             on a.mandant_id = b.mandant_id and
                a.lagerbew_beleg_id = b.lagerbew_beleg_id and
                a.dat_buch = b.dat_buch
           join (select *
                 from _ff_we2_kmo
                 where dat is not null) c
             on b.mandant_id = c.mandant_id and
                b.wup_id = c.wup_id and
                b.art_id = c.art_id and
                b.dat_buch = c.dat
           join dbp_data.art_wg_zu_per_1 x
             on b.mandant_id = x.mandant_id and
                b.art_id = x.art_id and
                x.arthiertyp_id = 2 and
                x.dat_bis = '9999-12-31'
           join dbp_data.besch_best_1 c1
             on b.mandant_id = c1.mandant_id and
                b.best_beleg_id = c1.best_beleg_id
           join dbp_data.besch_best_det_1 c2
             on b.mandant_id = c2.mandant_id and
                b.wup_id = c2.wup_id and
                c1.dat_best_beleg = c2.dat_best_beleg  and
                b.best_beleg_id = c2.best_beleg_id and
                b.best_beleg_pos_id = c2.best_beleg_pos_id and
                b.art_id = c2.art_id
           where a.vorgangsart_id in ('WE','WL') and
                 b.lager_bewart_id not in ('301','302','311','312','641','642','647','648') and
                 case
                   when a.mandant_id in (4) and
                        c1.bestellart_id in ('UBPX','UBP','UBP1','NBP','NBBG','UB2','UBE','NBCZ','NBPL','NBSK','NBHR','NBRO','UBGK','UBG1','UBG2','NZP','NZP1','NBMD','UBP0','ZUBZ')
                   then 1
                   when a.mandant_id in (2,3,5,6,7,8) and
                        c1.bestellart_id in ('UBPX','UBP','UBP1','NBP','NBBG','UB2','UBE','NBCZ','NBPL','NBSK','NBHR','NBRO','UBGK','UBG1','UBG2','NZP','NZP1','NBMD','UBP0')
                   then 1
                   else 0
                 end = 1 and
                 x.wg_id not in (select wg_id from dbp_data.wg_filter_zu_1 where wg_filter_id = 26 and mandant_id > 1) and
                 a.mandant_id > 1 and
                 a.dat_buch between (select min(dat_2)-7 from _ff_we2_kmo where dat_2 is not null) and (select max(dat) from _ff_we2_kmo where dat is not null)
           group by 1,2,3,4,5
           union all
           select b.mandant_id,
                  b.wup_id,
                  c.werbetyp_id,
                  b.art_id,
                  b.dat_buch,
                  sum(b.menge_lagerbew_bme) as menge_lagerbew_bme
           from dbp_data.lagerbew_1 a
           join dbp_data.lagerbew_det_1 b
             on a.mandant_id = b.mandant_id and
                a.lagerbew_beleg_id = b.lagerbew_beleg_id and
                a.dat_buch = b.dat_buch
           join (select *
                 from _ff_we2_kmo
                 where dat is not null) c
             on b.mandant_id = c.mandant_id and
                b.wup_id = c.wup_id and
                b.art_id = c.art_id and
                b.dat_buch = c.dat
           join dbp_data.art_wg_zu_per_1 x
             on b.mandant_id = x.mandant_id and
                b.art_id = x.art_id and
                x.arthiertyp_id = 2 and
                x.dat_bis = '9999-12-31'
           join dbp_data.besch_best_1 c1
             on b.mandant_id = c1.mandant_id and
                b.best_beleg_id = c1.best_beleg_id
           join dbp_data.besch_best_det_1 c2
             on b.mandant_id = c2.mandant_id and
                b.wup_id = c2.wup_id and
                c1.dat_best_beleg = c2.dat_best_beleg  and
                b.best_beleg_id = c2.best_beleg_id and
                b.best_beleg_pos_id = c2.best_beleg_pos_id and
                b.art_id = c2.art_id
           where a.vorgangsart_id in ('WE','WL') and
                 b.lager_bewart_id not in ('301', '302', '311', '312', '641', '642', '647', '648') and
                 x.wg_id in (select wg_id from dbp_data.wg_filter_zu_1 where wg_filter_id = 26 and mandant_id > 1) and
                 a.mandant_id > 1 and
                 a.dat_buch between (select min(dat_2)-7 from _ff_we2_kmo where dat_2 is not null) and (select max(dat) from _ff_we2_kmo where dat is not null)
           group by 1,2,3,4,5) b
  on a.mandant_id = b.mandant_id and
     a.wup_id = b.wup_id and
     a.art_id = b.art_id and
     a.dat = b.dat_buch and
     a.werbetyp_id = b.werbetyp_id
left join (select b.mandant_id,
                  c.werbetyp_id,
                  b.wup_id,
                  b.art_id,
                  b.dat_buch,
                  sum(b.menge_lagerbew_bme) as menge_lagerbew_bme
           from dbp_data.lagerbew_1 a
           join dbp_data.lagerbew_det_1 b
             on a.mandant_id = b.mandant_id and
                a.lagerbew_beleg_id = b.lagerbew_beleg_id and
                a.dat_buch = b.dat_buch
           join (select *
                 from _ff_we2_kmo
                 where dat_2 is not null) c
             on b.mandant_id = c.mandant_id and
                b.wup_id = c.wup_id and
                b.art_id = c.art_id and
                b.dat_buch = c.dat_2
           join dbp_data.art_wg_zu_per_1 x
             on b.mandant_id = x.mandant_id and
                b.art_id = x.art_id and
                x.arthiertyp_id = 2 and
                x.dat_bis = '9999-12-31'
           join dbp_data.besch_best_1 c1
             on b.mandant_id = c1.mandant_id and
                b.best_beleg_id = c1.best_beleg_id
           join dbp_data.besch_best_det_1 c2
             on b.mandant_id = c2.mandant_id and
                b.wup_id = c2.wup_id and
                c1.dat_best_beleg = c2.dat_best_beleg  and
                b.best_beleg_id = c2.best_beleg_id and
                b.best_beleg_pos_id = c2.best_beleg_pos_id and
                b.art_id = c2.art_id
           where a.vorgangsart_id in ('WE','WL') and
                 b.lager_bewart_id not in ('301', '302', '311', '312', '641', '642', '647', '648') and
                 case
                   when a.mandant_id in (4) and
                        c1.bestellart_id in ('UBPX','UBP','UBP1','NBP','NBBG','UB2','UBE','NBCZ','NBPL','NBSK','NBHR','NBRO','UBGK','UBG1','UBG2','NZP','NZP1','NBMD','UBP0','ZUBZ')
                   then 1
                   when a.mandant_id in (2,3,5,6,7,8) and
                        c1.bestellart_id in ('UBPX','UBP','UBP1','NBP','NBBG','UB2','UBE','NBCZ','NBPL','NBSK','NBHR','NBRO','UBGK','UBG1','UBG2','NZP','NZP1','NBMD','UBP0')
                   then 1
                   else 0
                 end = 1 and
                 x.wg_id not in (select wg_id from dbp_data.wg_filter_zu_1 where wg_filter_id = 26 and mandant_id > 1) and
                 a.mandant_id > 1 and
                 a.dat_buch between (select min(dat_2)-7 from _ff_we2_kmo where dat_2 is not null) and (select max(dat) from _ff_we2_kmo where dat is not null)
           group by 1,2,3,4,5
           union all
           select b.mandant_id,
                  c.werbetyp_id,
                  b.wup_id,
                  b.art_id,
                  b.dat_buch,
                  sum(b.menge_lagerbew_bme) as menge_lagerbew_bme
           from dbp_data.lagerbew_1 a
           join dbp_data.lagerbew_det_1 b
             on a.mandant_id = b.mandant_id and
	            a.lagerbew_beleg_id = b.lagerbew_beleg_id and
	            a.dat_buch = b.dat_buch
           join (select *
                 from _ff_we2_kmo
                 where dat_2 is not null) c
             on b.mandant_id = c.mandant_id and
                b.wup_id = c.wup_id and
                b.art_id = c.art_id and
                b.dat_buch = c.dat_2
           join dbp_data.art_wg_zu_per_1 x
             on b.mandant_id = x.mandant_id and
                b.art_id = x.art_id and
                x.arthiertyp_id = 2 and
                x.dat_bis = '9999-12-31'
           where a.vorgangsart_id in ('WE','WL') and
                 b.lager_bewart_id not in ('301', '302', '311', '312', '641', '642', '647', '648') and
                 x.wg_id in (select wg_id from dbp_data.wg_filter_zu_1 where wg_filter_id = 26 and mandant_id > 1) and
                 a.mandant_id > 1 and
                 a.dat_buch between (select min(dat_2)-7 from _ff_we2_kmo where dat_2 is not null) and (select max(dat) from _ff_we2_kmo where dat is not null)
           group by 1,2,3,4,5
           union all
           select b.mandant_id,
                  c.werbetyp_id,
                  b.wup_id,
                  b.art_id,
                  c.dat_2 as dat_buch,
                  sum(b.menge_lagerbew_bme) as menge_lagerbew_bme
           from dbp_data.lagerbew_1 a
           join dbp_data.lagerbew_det_1 b
             on a.mandant_id = b.mandant_id and
                a.lagerbew_beleg_id = b.lagerbew_beleg_id and
                a.dat_buch = b.dat_buch
           join (select *
                 from _ff_we2_kmo
                 where dat_2 is not null) c
             on b.mandant_id = c.mandant_id and
                b.wup_id = c.wup_id and
                b.art_id = c.art_id and
                b.dat_buch = c.dat_2-7
           join dbp_data.art_wg_zu_per_1 x
             on b.mandant_id = x.mandant_id and
                b.art_id = x.art_id and
                x.arthiertyp_id = 2 and
                x.dat_bis = '9999-12-31'
           where a.vorgangsart_id in ('WE','WL') and
                 b.lager_bewart_id not in ('301','302','311','312','641','642','647','648') and
                (x.mandant_id,x.wg_id) in (select mandant_id,wg_id from dbp_data.wg_filter_zu_1 where wg_filter_id = 30 and mandant_id > 1) and
                 a.mandant_id > 1 and
                 a.dat_buch between (select min(dat_2)-7 from _ff_we2_kmo where dat_2 is not null) and (select max(dat) from _ff_we2_kmo where dat is not null)
          group by 1,2,3,4,5) c
  on a.mandant_id = c.mandant_id and
     a.wup_id = c.wup_id and
     a.art_id = c.art_id and
     a.dat_2 = c.dat_buch and
     a.werbetyp_id = c.werbetyp_id
);

create or replace volatile table _stpo_kmo as (
select a.mandant_id,
       a.stueckliste_id,
       a.art_id as kopf_art
from dbp_data.stueckliste_1 a
where a.dat_bis = '9999-12-31' and
      a.mandant_id in (2,3,4,5,6,7,8)
group by 1,2,3
);
                    
create or replace volatile table _x_ray_kmo as (
select a.mandant_id,
       a.wup_id,
       a.werbetyp_id,
       b.kopf_art as art_id,
       a.dat,
       a.dat_2
from (select mandant_id,
             wup_id,
             werbetyp_id,
             dat,
             dat_2
      from _ff_we2_kmo
      group by 1,2,3,4,5) a
join (select kopf_art
      from _stpo_kmo
      group by 1) b
  on 1 = 1
group by 1,2,3,4,5,6
);

create or replace volatile table _help_me1_kmo as (
select mandant_id,
       dat
from _x_ray_kmo
where dat is not null
group by 1,2
);

create or replace volatile table _help_me2_kmo as (
select mandant_id,
       dat_2
from _x_ray_kmo
where dat_2 is not null
group by 1,2
);

create or replace volatile table _mseg_package_ekpo as (
select b.*
from dbp_data.lagerbew_1 a
join dbp_data.lagerbew_det_1 b
  on a.mandant_id = b.mandant_id and
     a.lagerbew_beleg_id = b.lagerbew_beleg_id and
     a.dat_buch = b.dat_buch
join dbp_data.besch_best_1 c1
  on b.mandant_id = c1.mandant_id and
     b.best_beleg_id = c1.best_beleg_id
join dbp_data.besch_best_det_1 c2
  on b.mandant_id = c2.mandant_id and
     b.wup_id = c2.wup_id and
     c1.dat_best_beleg = c2.dat_best_beleg  and
     b.best_beleg_id = c2.best_beleg_id and
     b.best_beleg_pos_id = c2.best_beleg_pos_id and
     b.art_id = c2.art_id
where a.vorgangsart_id in ('WE','WL') and
      b.lager_bewart_id not in ('301', '302', '311', '312', '641', '642', '647', '648') and
      case
        when a.mandant_id in (4) and
             c1.bestellart_id in ('UBPX','UBP','UBP1','NBP','NBBG','UB2','UBE','NBCZ','NBPL','NBSK','NBHR','NBRO','UBGK','UBG1','UBG2','NZP','NZP1','NBMD','UBP0','ZUBZ')
        then 1
        when a.mandant_id in (2,3,5,6,7,8) and
             c1.bestellart_id in ('UBPX','UBP','UBP1','NBP','NBBG','UB2','UBE','NBCZ','NBPL','NBSK','NBHR','NBRO','UBGK','UBG1','UBG2','NZP','NZP1','NBMD','UBP0')
        then 1
        else 0
      end = 1 and
      a.dat_buch >= (select min(dat) from (select min(dat) as dat from _help_me1_kmo union select min(dat_2) as dat from _help_me2_kmo)) and
      a.mandant_id > 1
);

create or replace volatile table _mseg_package_not_ekpo as (
select b.*
from dbp_data.lagerbew_1 a
join dbp_data.lagerbew_det_1 b
  on a.mandant_id = b.mandant_id and
     a.lagerbew_beleg_id = b.lagerbew_beleg_id and
     a.dat_buch = b.dat_buch
join dbp_data.besch_best_1 c1
  on b.mandant_id = c1.mandant_id and
     b.best_beleg_id = c1.best_beleg_id
join dbp_data.besch_best_det_1 c2
  on b.mandant_id = c2.mandant_id and
     b.wup_id = c2.wup_id and
     c1.dat_best_beleg = c2.dat_best_beleg  and
     b.best_beleg_id = c2.best_beleg_id and
     b.best_beleg_pos_id = c2.best_beleg_pos_id and
     b.art_id = c2.art_id
where a.vorgangsart_id in ('WE','WL') and
      b.lager_bewart_id not in ('301', '302', '311', '312', '641', '642', '647', '648') and
      a.dat_buch >= (select min(dat) from (select min(dat) as dat from _help_me1_kmo union select min(dat_2) as dat from _help_me2_kmo)) and
      a.mandant_id > 1
);

create or replace volatile table _x_track1_kmo as (
select a.mandant_id,
       c.werbetyp_id,
       a.lagerbew_beleg_id,
       a.wup_id,
       a.art_id,
       a.dat_buch,
       sum(a.menge_lagerbew_bme) as menge_lagerbew_bme
from _mseg_package_ekpo a
join (select *
      from _x_ray_kmo
      where dat is not null) c
  on a.mandant_id = c.mandant_id and
     a.wup_id = c.wup_id and
     a.art_id = c.art_id and
     a.dat_buch = c.dat
join dbp_data.art_wg_zu_per_1 x
  on a.mandant_id = x.mandant_id and
     a.art_id = x.art_id and
     x.arthiertyp_id = 2 and
     x.dat_bis = '9999-12-31'
where x.wg_id not in (select wg_id from dbp_data.wg_filter_zu_1 where wg_filter_id = 26 and mandant_id > 1) and
     (a.mandant_id,a.dat_buch) in (select mandant_id,dat from _help_me1_kmo)
group by 1,2,3,4,5,6
union all
select a.mandant_id,
       c.werbetyp_id,
       a.lagerbew_beleg_id,
       a.wup_id,
       a.art_id,
       a.dat_buch,
       sum(a.menge_lagerbew_bme) as menge_lagerbew_bme
from _mseg_package_not_ekpo a
join (select *
      from _x_ray_kmo
      where dat is not null)  c
  on a.mandant_id = c.mandant_id and
     a.wup_id = c.wup_id and
     a.art_id = c.art_id and
     a.dat_buch = c.dat
join dbp_data.art_wg_zu_per_1 x
  on a.mandant_id = x.mandant_id and
     a.art_id = x.art_id and
     x.arthiertyp_id = 2 and
     x.dat_bis = '9999-12-31'
where (a.mandant_id,a.dat_buch) in (select mandant_id,dat from _help_me1_kmo) and
       x.wg_id in (select wg_id from dbp_data.wg_filter_zu_1 where wg_filter_id = 26 and mandant_id > 1)
group by 1,2,3,4,5,6
);

create or replace volatile table _x_track2_kmo as (
select a.mandant_id,
       c.werbetyp_id,
       a.lagerbew_beleg_id,
       a.wup_id,
       a.art_id,
       a.dat_buch,
       sum(a.menge_lagerbew_bme) as menge_lagerbew_bme
from _mseg_package_ekpo a
join (select *
      from _x_ray_kmo
      where dat_2 is not null)  c
  on a.mandant_id = c.mandant_id and
     a.wup_id = c.wup_id and
     a.art_id = c.art_id and
     a.dat_buch = c.dat_2
join dbp_data.art_wg_zu_per_1 x
  on a.mandant_id = x.mandant_id and
     a.art_id = x.art_id and
     x.arthiertyp_id = 2 and
     x.dat_bis = '9999-12-31'
where x.wg_id not in (select wg_id from dbp_data.wg_filter_zu_1 where wg_filter_id = 26 and mandant_id > 1) and
	   (a.mandant_id,a.dat_buch) in (select mandant_id,dat_2 from _help_me2_kmo)
group by 1,2,3,4,5,6
union all
select a.mandant_id,
       c.werbetyp_id,
       a.lagerbew_beleg_id,
       a.wup_id,
       a.art_id,
       a.dat_buch,
       sum(a.menge_lagerbew_bme) as menge_lagerbew_bme
from _mseg_package_not_ekpo a
join (select *
      from _x_ray_kmo
      where dat_2 is not null)  c
  on a.mandant_id = c.mandant_id and
     a.wup_id = c.wup_id and
     a.art_id = c.art_id and
     a.dat_buch = c.dat_2
join dbp_data.art_wg_zu_per_1 x
  on a.mandant_id = x.mandant_id and
     a.art_id = x.art_id and
     x.arthiertyp_id = 2 and
     x.dat_bis = '9999-12-31'
where x.wg_id in (select wg_id from dbp_data.wg_filter_zu_1 where wg_filter_id = 26 and mandant_id > 1) and
	   (a.mandant_id,a.dat_buch) in (select mandant_id,dat_2 from _help_me2_kmo)
group by 1,2,3,4,5,6
);

create or replace volatile table _display_update_kmo as (
select b.mandant_id,
       c.werbetyp_id,
       b.wup_id,
       b.art_id,
       b.dat_buch,
       sum(b.menge_lagerbew_bme) as menge_lagerbew_bme
from dbp_data.lagerbew_1 a
join dbp_data.lagerbew_det_1 b
  on a.mandant_id = b.mandant_id and
     a.lagerbew_beleg_id = b.lagerbew_beleg_id and
     a.dat_buch = b.dat_buch
join (select c.mandant_id,
             c.werbetyp_id,
             c.lagerbew_beleg_id,
             c.wup_id,
             b.art_id,
             c.dat_buch
      from dbp_data.stueckliste_1 a
      join dbp_data.stueckliste_det_1 b
        on a.mandant_id = b.mandant_id and
           a.stueckliste_id = b.stueckliste_id
      join (select mandant_id,
                   werbetyp_id,
                   lagerbew_beleg_id,
                   wup_id,
                   art_id,
                   dat_buch
            from _x_track1_kmo
            group by 1,2,3,4,5,6
            union all
            select mandant_id,
                   werbetyp_id,
                   lagerbew_beleg_id,
                   wup_id,
                   art_id,
                   dat_buch
            from _x_track2_kmo
            group by 1,2,3,4,5,6) c
        on a.mandant_id = c.mandant_id and
           a.art_id = c.art_id
      where a.dat_bis = '9999-12-31'
      group by 1,2,3,4,5,6) c
  on b.mandant_id = c.mandant_id and
     b.wup_id = c.wup_id and
     b.art_id = c.art_id and
     b.dat_buch between (select min(dat)-7 from _ff_we3_kmo where dat is not null) and (select max(dat) from _ff_we3_kmo where dat is not null) and
     b.lagerbew_beleg_id = c.lagerbew_beleg_id
where a.vorgangsart_id in ('WE','WL') and
      b.lager_bewart_id not in ('301', '302', '311', '312', '641', '642', '647', '648')
group by 1,2,3,4,5
);

update _ff_we3_kmo

set we_menge = b.menge_lagerbew_bme+_ff_we3_kmo.we_menge

from (select *
      from _display_update_kmo) b
where _ff_we3_kmo.mandant_id = b.mandant_id and
      _ff_we3_kmo.wup_id = b.wup_id and
      _ff_we3_kmo.art_id = b.art_id and
      _ff_we3_kmo.werbetyp_id = b.werbetyp_id and
      _ff_we3_kmo.dat = b.dat_buch and
      _ff_we3_kmo.dat between _ff_we3_kmo.dat_von and _ff_we3_kmo.dat_bis
;

update _ff_we3_kmo
 
set we_menge_2 = b.menge_lagerbew_bme+_ff_we3_kmo.we_menge_2

from (select *
      from _display_update_kmo) b
where _ff_we3_kmo.mandant_id = b.mandant_id and
      _ff_we3_kmo.wup_id = b.wup_id and
      _ff_we3_kmo.art_id = b.art_id and
      _ff_we3_kmo.werbetyp_id = b.werbetyp_id and
      _ff_we3_kmo.dat = b.dat_buch and
      _ff_we3_kmo.dat not between _ff_we3_kmo.dat_von and _ff_we3_kmo.dat_bis
;

update _ff_we3_kmo 

set we_menge_2 = 0

from (select a.mandant_id,
             a.werbetyp_id,
             a.kjwo,
             a.wup_id,
             a.art_id,
             a.dat_von-3 as min_dat
      from _ff_we3_kmo a
      join dbp_data.art_wg_zu_per_1 x
        on a.mandant_id = x.mandant_id and
           a.art_id = x.art_id and
	         x.arthiertyp_id = 2 and
	         x.dat_bis = '9999-12-31'
      where (x.mandant_id,x.wg_id) in (select mandant_id,wg_id from dbp_data.wg_filter_zu_1 where wg_filter_id = 27 and mandant_id > 1)
      group by 1,2,3,4,5,6) b
where _ff_we3_kmo.mandant_id = b.mandant_id and
      _ff_we3_kmo.wup_id = b.wup_id and
      _ff_we3_kmo.werbetyp_id = b.werbetyp_id and
      _ff_we3_kmo.art_id = b.art_id and
      _ff_we3_kmo.kjwo = b.kjwo and
      _ff_we3_kmo.dat < b.min_dat
;

update _ff_we3_kmo
 
set we_menge_2 = 0

from (select a.mandant_id,
             a.werbetyp_id,
             a.kjwo,
             a.wup_id,
             a.art_id,
             a.dat_von-1 as min_dat
      from _ff_we3_kmo a
      join dbp_data.art_wg_zu_per_1 x
        on a.mandant_id = x.mandant_id and
           a.art_id = x.art_id and
           x.arthiertyp_id = 2 and
	   x.dat_bis = '9999-12-31'
      where (x.mandant_id,x.wg_id) in (select mandant_id,wg_id from dbp_data.wg_filter_zu_1 where wg_filter_id = 28 and mandant_id > 1)
      group by 1,2,3,4,5,6) b
where _ff_we3_kmo.mandant_id = b.mandant_id and
      _ff_we3_kmo.wup_id = b.wup_id and
      _ff_we3_kmo.werbetyp_id = b.werbetyp_id and
      _ff_we3_kmo.art_id = b.art_id and
      _ff_we3_kmo.kjwo = b.kjwo and
      _ff_we3_kmo.dat < b.min_dat
;

update _ff_we3_kmo
 
set we_menge_2 = 0

from (select a.mandant_id,
             a.werbetyp_id,
             a.kjwo,
             a.wup_id,
             a.art_id,
             a.dat_von as min_dat
      from _ff_we3_kmo a
      join dbp_data.art_wg_zu_per_1 x
        on a.mandant_id = x.mandant_id and
           a.art_id = x.art_id and
	   x.arthiertyp_id = 2 and
	   x.dat_bis = '9999-12-31'
      where (x.mandant_id,x.wg_id) in (select mandant_id,wg_id from dbp_data.wg_filter_zu_1 where wg_filter_id = 50 and mandant_id > 1)
      group by 1,2,3,4,5,6) b
where _ff_we3_kmo.mandant_id = b.mandant_id and
      _ff_we3_kmo.wup_id = b.wup_id and
      _ff_we3_kmo.werbetyp_id = b.werbetyp_id and
      _ff_we3_kmo.art_id = b.art_id and
      _ff_we3_kmo.kjwo = b.kjwo and
      _ff_we3_kmo.dat < b.min_dat
;

create or replace volatile table _ff_we4_kmo as (
select a.kjwo,
       a.werbetyp_id,
       a.dat_von,
       a.dat_bis,
       a.wup_id,
       a.mandant_id,
       a.art_id,
       a.nb_id,
       sum(a.we_menge) as we_menge,
       sum(a.we_menge_2) as we_menge_2,
       sum(cast(0 as decimal(18,3))) as menge_aktionsstart
from _ff_we3_kmo a
group by 1,2,3,4,5,6,7,8
);

CREATE OR REPLACE VOLATILE TABLE _mbst_we1_kmo AS (
SELECT v.kjwo,
       v.werbetyp_id,
	   v.dat_von,
	   v.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       v.nb_id,
       SUM(COALESCE(u.menge_lgbest_erp_frei_bme,0)) AS menge_aktionsstart
FROM _ff_we4_kmo v
JOIN (SELECT mandant_id,
             werbetyp_id,
             wup_id,
	         art_id,
	         dat_von-1 AS dat_von,
	         kjwo
      FROM _werbeartikel_1_kmo
      GROUP BY 1,2,3,4,5,6) w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id  AND
	 v.werbetyp_id = w.werbetyp_id AND
    (v.kjwo = w.kjwo OR
     v.kjwo = w.kjwo-1)
LEFT JOIN dbp_data.marktbestand_erp_1 u
  ON w.mandant_id = u.mandant_id AND
     w.wup_id = u.wup_id AND
     w.art_id = u.art_id AND
     u.dat = w.dat_von
GROUP BY 1,2,3,4,5,6,7,8
);

UPDATE _ff_we4_kmo 
SET menge_aktionsstart = b.menge_aktionsstart

FROM (SELECT *
                         FROM _mbst_we1_kmo
	   	                 WHERE menge_aktionsstart <> 0) b
 WHERE _ff_we4_kmo.mandant_id = b.mandant_id AND
      _ff_we4_kmo.wup_id = b.wup_id AND
      _ff_we4_kmo.nb_id = b.nb_id AND
      _ff_we4_kmo.art_id = b.art_id AND
      _ff_we4_kmo.kjwo = b.kjwo AND
	  _ff_we4_kmo.werbetyp_id = b.werbetyp_id
;

CREATE OR REPLACE VOLATILE TABLE _wup_kalender_kmo AS (
SELECT a.kjwo,
       a.werbetyp_id,
       a.mandant_id,
       a.wup_id,
       SUM(COALESCE(b.offen,1)) AS anz_offen
FROM (SELECT mandant_id,
             werbetyp_id,
             wup_id,
	         dat_von,
             dat_bis,
	         kjwo
      FROM _werbeartikel_1_kmo
      GROUP BY 1,2,3,4,5,6) a
LEFT JOIN (SELECT *
           FROM dbp_data.wupcal_1
	       WHERE (mandant_id,dat) IN (SELECT mandant_id,dat FROM _die_tage_kmo)) b
  ON a.wup_id = b.wup_id AND
     a.mandant_id = b.mandant_id AND
     b.dat BETWEEN a.dat_von AND a.dat_bis
GROUP BY 1,2,3,4
);

-- Start Protokollierung Umrechnungsfaktor --

delete from dbp_etl_process.avq_protokoll_umrechnung_1
where (kjwo,mandant_id,art_id) in (select kjwo,mandant_id,art_id from _werbeartikel_1_kmo)
;

insert into dbp_etl_process.avq_protokoll_umrechnung_1 (kjwo,
                                                      mandant_id,
                                                      art_id,
                                                      komponente_art_id,
                                                      komponentenmenge_einh_id,
                                                      stueckliste_id)
select w.kjwo,
       v.mandant_id,
       v.art_id,
       v.komponente_art_id,
       v.komponentenmenge_einh_id,
       v.stueckliste_id
from (select a.*,
             b.stueckliste_id,
             b.komponente_art_id,
             b.komponentenmenge_einh_id,
             cast(coalesce(c.umrech_faktor, 9999999999) as decimal(18,3)) as menge_
      from dbp_data.artbew_1 a
      join (select a.mandant_id,
                   a.stueckliste_id,
                   a.art_id,
                   b.art_id as komponente_art_id,
                   b.komponentenmenge,
                   b.komponentenmenge_einh_id,
                   b.dat_von,
                   b.dat_bis
            from dbp_data.stueckliste_1 a
            join dbp_data.stueckliste_det_1 b
              on a.mandant_id = b.mandant_id and
                 a.stueckliste_id = b.stueckliste_id
            join (select mandant_id,
                         art_id,
                         komponente
                  from _werbeartikel_1_kmo
                  where stkl_kopf_fg in (1,2)
                  group by 1,2,3) c
              on a.mandant_id = c.mandant_id and
                 a.art_id = c.art_id and
                 b.art_id = c.komponente
            where a.stueckliste_verwendung_id = 3 and
                  b.stueckliste_typ_id = 'M') b
        on a.mandant_id = b.mandant_id and
           a.art_id = b.art_id and
           a.dat between b.dat_von and b.dat_bis
      left join dbp_data.art_umrechnung_faktor_per_1 c
        on b.mandant_id = c.mandant_id and 
           b.art_id = c.art_id and 
           b.komponentenmenge_einh_id = c.altnv_menge_einh_id and 
           c.dat_bis = '9999-12-31'
      where (a.mandant_id,a.dat) in (select mandant_id,dat from _die_tage_kmo) and
             a.umsatz_netto > 0) v
join (select mandant_id,
             kjwo,
             werbetyp_id,
             wup_id,
             art_id,
             dat_von,
             dat_bis
      from _werbeartikel_1_kmo
      group by 1,2,3,4,5,6,7) w
  on v.mandant_id = w.mandant_id and
     v.wup_id = w.wup_id and
     v.art_id = w.art_id and
     v.dat between w.dat_von and w.dat_bis
where v.menge_ = 9999999999
group by 1,2,3,4,5,6
;

-- Ende Protokollierung Umrechnungsfaktor --

create or replace volatile table _ff_we_artbew_kmo as (
select w.kjwo,
       w.werbetyp_id,
       w.dat_von,
       w.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       v.nb_id,
       max(v.posten_id) as posten_id,
       sum(case when x.wtag_id = 1 then v.umsatz_netto else 0 end) as umsatz_netto_mo,
       sum(case when x.wtag_id = 2 then v.umsatz_netto else 0 end) as umsatz_netto_di,
       sum(case when x.wtag_id = 3 then v.umsatz_netto else 0 end) as umsatz_netto_mi,
       sum(case when x.wtag_id = 4 then v.umsatz_netto else 0 end) as umsatz_netto_do,
       sum(case when x.wtag_id = 5 then v.umsatz_netto else 0 end) as umsatz_netto_fr,
       sum(case when x.wtag_id = 6 then v.umsatz_netto else 0 end) as umsatz_netto_sa,
       sum(case when x.wtag_id = 7 then v.umsatz_netto else 0 end) as umsatz_netto_so,
       sum(v.umsatz_netto) as umsatz_netto_wo,
       sum(case when x.wtag_id = 1 then v.menge_ else 0 end) as menge_mo,
       sum(case when x.wtag_id = 2 then v.menge_ else 0 end) as menge_di,
       sum(case when x.wtag_id = 3 then v.menge_ else 0 end) as menge_mi,
       sum(case when x.wtag_id = 4 then v.menge_ else 0 end) as menge_do,
       sum(case when x.wtag_id = 5 then v.menge_ else 0 end) as menge_fr,
       sum(case when x.wtag_id = 6 then v.menge_ else 0 end) as menge_sa,
       sum(case when x.wtag_id = 7 then v.menge_ else 0 end) as menge_so,
       sum(v.menge_) as menge_wo,
       sum(case when v.bewart_id = 1002 then v.menge_ else 0 end) as menge_sa2,
       max(z.anz_offen)-count(distinct v.dat) as tage_menge_0,
       sum(cast(0 as decimal(18,3))) as we_menge,
       sum(cast(0 as decimal(18,3))) as menge_aktionsstart,
       sum(cast(0 as decimal(18,3))) as we_menge_ab_vorwoche,
       -- 14.09.2016, -dbay-
       -- aufnahme einer hilfsvariablen zur identifikation von displaykoepfen.
       cast(0 as decimal(18,3)) as hilfe
from (select a.*,
             coalesce(cast(cast(a.menge as float) * cast(b.komponentenmenge as float)/coalesce(c.umrech_faktor, 1000.0000) as decimal(18,3)),a.menge) as menge_
      from dbp_data.artbew_1 a
      left join (select a.mandant_id,
                        a.art_id,
                        b.art_id as komponente_art_id,
                        b.komponentenmenge,
                        b.komponentenmenge_einh_id,
                        b.dat_von,
                        b.dat_bis
                 from dbp_data.stueckliste_1 a
                 join dbp_data.stueckliste_det_1 b
                   on a.mandant_id = b.mandant_id and
                      a.stueckliste_id = b.stueckliste_id
                 join (select mandant_id,
                              art_id,
                              komponente
                       from _werbeartikel_1_kmo
                       where stkl_kopf_fg in (1,2)
                       group by 1,2,3) c
                   on a.mandant_id = c.mandant_id and
                      a.art_id = c.art_id and
                      b.art_id = c.komponente
                 where a.stueckliste_verwendung_id = 3 and
                       b.stueckliste_typ_id = 'M') b
        on a.mandant_id = b.mandant_id and
           a.art_id = b.art_id and
           a.dat between b.dat_von and b.dat_bis
      left join dbp_data.art_umrechnung_faktor_per_1 c
        on b.mandant_id = c.mandant_id and 
           b.art_id = c.art_id and 
           b.komponentenmenge_einh_id = c.altnv_menge_einh_id and 
           c.dat_bis = '9999-12-31'
      where (a.mandant_id,a.dat) in (select mandant_id,dat from _die_tage_kmo) and
             a.umsatz_netto > 0) v
join (select mandant_id,
             kjwo,
             werbetyp_id,
             wup_id,
             art_id,
             dat_von,
             dat_bis
      from _werbeartikel_1_kmo
      group by 1,2,3,4,5,6,7) w
  on v.mandant_id = w.mandant_id and
     v.wup_id = w.wup_id and
     v.art_id = w.art_id and
     v.dat between w.dat_von and w.dat_bis
join dbp_data.tag_1 x
  on v.dat = x.dat
join _wup_kalender_kmo z
  on w.kjwo = z.kjwo and
     v.wup_id = z.wup_id and
     v.mandant_id = z.mandant_id and
     w.werbetyp_id = z.werbetyp_id
group by 1,2,3,4,5,6,7,8
);

CREATE OR REPLACE VOLATILE TABLE _test_we_mbst1_kmo AS (
SELECT v.kjwo,
       v.werbetyp_id,
       v.dat_von,
       v.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       v.nb_id,
       SUM(COALESCE(u.menge_lgbest_erp_frei_bme,0)) AS menge_endbestand
FROM _ff_we4_kmo v
JOIN (SELECT mandant_id,
             werbetyp_id,
             wup_id,
             art_id,
             dat_bis,
             kjwo
      FROM _werbeartikel_1_kmo
      GROUP BY 1,2,3,4,5,6) w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.werbetyp_id = w.werbetyp_id AND
    (v.kjwo = w.kjwo OR
     v.kjwo = w.kjwo-1)
LEFT JOIN dbp_data.marktbestand_erp_1 u
  ON w.mandant_id = u.mandant_id AND
     w.wup_id = u.wup_id AND
     w.art_id = u.art_id AND
     u.dat = w.dat_bis AND
     u.menge_lgbest_erp_frei_bme >= 0
GROUP BY 1,2,3,4,5,6,7,8
);

CREATE OR REPLACE VOLATILE TABLE _test_we_mbst2_kmo AS (
SELECT v.kjwo,
       v.werbetyp_id,
       v.dat_von,
       v.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       v.nb_id,
       SUM(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme = 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000 THEN 1
             ELSE 0
           END) AS anz_tage_null,
       SUM(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme < 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             ELSE 0
           END) AS anz_tage_minus
FROM _ff_we4_kmo v
JOIN (SELECT a.mandant_id,
             a.werbetyp_id,
             a.wup_id,
             a.art_id,
             a.dat_von,
             a.dat_bis,
             b.dat,
             a.kjwo
      FROM _werbeartikel_1_kmo a
      JOIN dbp_data.tag_1 b
        ON b.dat BETWEEN a.dat_von AND a.dat_bis
      GROUP BY 1,2,3,4,5,6,7,8) w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.werbetyp_id = w.werbetyp_id AND
    (v.kjwo = w.kjwo OR
     v.kjwo = w.kjwo-1)
JOIN dbp_data.art_1 xx
  ON v.mandant_id = xx.mandant_id AND
     v.art_id = xx.art_id
LEFT JOIN dbp_data.marktbestand_erp_1 x
  ON w.mandant_id = x.mandant_id AND
     w.wup_id = x.wup_id AND
     w.art_id = x.art_id AND
     w.dat = x.dat and
     x.dat < current_date
GROUP BY 1,2,3,4,5,6,7,8
);

CREATE OR REPLACE VOLATILE TABLE _test_we_mbst2a_kmo AS (
SELECT v.kjwo,
       v.werbetyp_id,
       v.dat_von,
       v.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       v.nb_id,
       MAX(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme = 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000 THEN 1
             ELSE 0
           END) AS anz_null_tag1,
       0 as anz_null_tag2,
       0 as anz_null_tag3,
       0 as anz_null_tag4,
       0 as anz_null_tag5,
       0 as anz_null_tag6,
       0 as anz_null_tag7,
       MAX(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme < 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             ELSE 0
           END) AS anz_minus_tag1
FROM _ff_we4_kmo v
JOIN (SELECT a.mandant_id,
             a.werbetyp_id,
             a.wup_id,
             a.art_id,
             a.dat_von,
             a.dat_bis,
             b.dat,
             a.kjwo
      FROM _werbeartikel_1_kmo a
      JOIN dbp_data.tag_1 b
        ON b.dat = a.dat_von
      GROUP BY 1,2,3,4,5,6,7,8) w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.werbetyp_id = w.werbetyp_id AND
    (v.kjwo = w.kjwo OR
     v.kjwo = w.kjwo-1)
JOIN dbp_data.art_1 xx
  ON v.mandant_id = xx.mandant_id AND
     v.art_id = xx.art_id
LEFT JOIN dbp_data.marktbestand_erp_1 x
  ON w.mandant_id = x.mandant_id AND
     w.wup_id = x.wup_id AND
     w.art_id = x.art_id AND
     w.dat = x.dat and
     x.dat < current_date
GROUP BY 1,2,3,4,5,6,7,8
);

-- Anzahl Nullbestand Tag_1 2

update _test_we_mbst2a_kmo from (select a.mandant_id,
                                        a.wup_id,
                                        a.art_id,
                                        a.dat,
                                        w.dat_von,
                                        w.dat_bis,
                                        w.werbetyp_id,
                                        MAX(CASE
                                              WHEN xx.gewart_id  = 'ST' AND a.menge_lgbest_erp_frei_bme = 0 THEN 1
                                              WHEN xx.gewart_id  = 'KG' AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090 THEN 1
                                              WHEN xx.gewart_id  = 'G'  AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000 THEN 1
                                              ELSE 0
                                            END) AS anz_null_tag2
                                 from dbp_data.marktbestand_erp_1 a
                                 JOIN (SELECT a.mandant_id,
                                              a.werbetyp_id,
                                              a.wup_id,
                                              a.art_id,
                                              a.dat_von,
                                              a.dat_bis,
                                              b.dat
                                       FROM _werbeartikel_1_kmo a
                                       JOIN dbp_data.tag_1 b
                                         ON b.dat = a.dat_von+1 and
                                            b.dat <= a.dat_bis
                                       GROUP BY 1,2,3,4,5,6,7) w
                                   ON w.mandant_id = a.mandant_id AND
                                      w.wup_id = a.wup_id AND
                                      w.art_id = a.art_id AND
                                      w.dat = a.dat and
                                      a.dat < current_date
                                 JOIN dbp_data.art_1 xx
                                   ON w.mandant_id = xx.mandant_id AND
                                      w.art_id = xx.art_id
                                 group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag2 = b.anz_null_tag2

where _test_we_mbst2a_kmo.mandant_id = b.mandant_id and
      _test_we_mbst2a_kmo.wup_id = b.wup_id and
      _test_we_mbst2a_kmo.art_id = b.art_id and
      _test_we_mbst2a_kmo.dat_von = b.dat_von and
      _test_we_mbst2a_kmo.dat_bis = b.dat_bis and
      _test_we_mbst2a_kmo.werbetyp_id = b.werbetyp_id
;

-- Anzahl Nullbestand Tag_1 3

update _test_we_mbst2a_kmo from (select a.mandant_id,
                                        a.wup_id,
                                        a.art_id,
                                        a.dat,
                                        w.dat_von,
                                        w.dat_bis,
                                        w.werbetyp_id,
                                        MAX(CASE
                                              WHEN xx.gewart_id  = 'ST' AND a.menge_lgbest_erp_frei_bme = 0 THEN 1
                                              WHEN xx.gewart_id  = 'KG' AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090 THEN 1
                                              WHEN xx.gewart_id  = 'G'  AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000 THEN 1
                                              ELSE 0
                                            END) AS anz_null_tag3
                                 from dbp_data.marktbestand_erp_1 a
                                 JOIN (SELECT a.mandant_id,
                                              a.werbetyp_id,
                                              a.wup_id,
                                              a.art_id,
                                              a.dat_von,
                                              a.dat_bis,
                                              b.dat
                                       FROM _werbeartikel_1_kmo a
                                       JOIN dbp_data.tag_1 b
                                         ON b.dat = a.dat_von+2 and
                                            b.dat <= a.dat_bis
                                       GROUP BY 1,2,3,4,5,6,7) w
                                   ON w.mandant_id = a.mandant_id AND
                                      w.wup_id = a.wup_id AND
                                      w.art_id = a.art_id AND
                                      w.dat = a.dat and
                                      a.dat < current_date
                                 JOIN dbp_data.art_1 xx
                                   ON w.mandant_id = xx.mandant_id AND
                                      w.art_id = xx.art_id
                                 group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag3 = b.anz_null_tag3

where _test_we_mbst2a_kmo.mandant_id = b.mandant_id and
      _test_we_mbst2a_kmo.wup_id = b.wup_id and
      _test_we_mbst2a_kmo.art_id = b.art_id and
      _test_we_mbst2a_kmo.dat_von = b.dat_von and
      _test_we_mbst2a_kmo.dat_bis = b.dat_bis and
      _test_we_mbst2a_kmo.werbetyp_id = b.werbetyp_id
;

-- Anzahl Nullbestand Tag_1 4

update _test_we_mbst2a_kmo from (select a.mandant_id,
                                        a.wup_id,
                                        a.art_id,
                                        a.dat,
                                        w.dat_von,
                                        w.dat_bis,
                                        w.werbetyp_id,
                                        MAX(CASE
                                              WHEN xx.gewart_id  = 'ST' AND a.menge_lgbest_erp_frei_bme = 0 THEN 1
                                              WHEN xx.gewart_id  = 'KG' AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090 THEN 1
                                              WHEN xx.gewart_id  = 'G'  AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000 THEN 1
                                              ELSE 0
                                            END) AS anz_null_tag4
                                 from dbp_data.marktbestand_erp_1 a
                                 JOIN (SELECT a.mandant_id,
                                              a.werbetyp_id,
                                              a.wup_id,
                                              a.art_id,
                                              a.dat_von,
                                              a.dat_bis,
                                              b.dat
                                       FROM _werbeartikel_1_kmo a
                                       JOIN dbp_data.tag_1 b
                                         ON b.dat = a.dat_von+3 and
                                            b.dat <= a.dat_bis
                                       GROUP BY 1,2,3,4,5,6,7) w
                                   ON w.mandant_id = a.mandant_id AND
                                      w.wup_id = a.wup_id AND
                                      w.art_id = a.art_id AND
                                      w.dat = a.dat and
                                      a.dat < current_date
                                 JOIN dbp_data.art_1 xx
                                   ON w.mandant_id = xx.mandant_id AND
                                      w.art_id = xx.art_id
                                 group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag4 = b.anz_null_tag4

where _test_we_mbst2a_kmo.mandant_id = b.mandant_id and
      _test_we_mbst2a_kmo.wup_id = b.wup_id and
      _test_we_mbst2a_kmo.art_id = b.art_id and
      _test_we_mbst2a_kmo.dat_von = b.dat_von and
      _test_we_mbst2a_kmo.dat_bis = b.dat_bis and
      _test_we_mbst2a_kmo.werbetyp_id = b.werbetyp_id
;

-- Anzahl Nullbestand Tag_1 5

update _test_we_mbst2a_kmo from (select a.mandant_id,
                                        a.wup_id,
                                        a.art_id,
                                        a.dat,
                                        w.dat_von,
                                        w.dat_bis,
                                        w.werbetyp_id,
                                        MAX(CASE
                                              WHEN xx.gewart_id  = 'ST' AND a.menge_lgbest_erp_frei_bme = 0 THEN 1
                                              WHEN xx.gewart_id  = 'KG' AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090 THEN 1
                                              WHEN xx.gewart_id  = 'G'  AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000 THEN 1
                                              ELSE 0
                                            END) AS anz_null_tag5
                                 from dbp_data.marktbestand_erp_1 a
                                 JOIN (SELECT a.mandant_id,
                                              a.werbetyp_id,
                                              a.wup_id,
                                              a.art_id,
                                              a.dat_von,
                                              a.dat_bis,
                                              b.dat
                                       FROM _werbeartikel_1_kmo a
                                       JOIN dbp_data.tag_1 b
                                         ON b.dat = a.dat_von+4 and
                                            b.dat <= a.dat_bis
                                       GROUP BY 1,2,3,4,5,6,7) w
                                   ON w.mandant_id = a.mandant_id AND
                                      w.wup_id = a.wup_id AND
                                      w.art_id = a.art_id AND
                                      w.dat = a.dat and
                                      a.dat < current_date
                                 JOIN dbp_data.art_1 xx
                                   ON w.mandant_id = xx.mandant_id AND
                                      w.art_id = xx.art_id
                                 group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag5 = b.anz_null_tag5

where _test_we_mbst2a_kmo.mandant_id = b.mandant_id and
      _test_we_mbst2a_kmo.wup_id = b.wup_id and
      _test_we_mbst2a_kmo.art_id = b.art_id and
      _test_we_mbst2a_kmo.dat_von = b.dat_von and
      _test_we_mbst2a_kmo.dat_bis = b.dat_bis and
      _test_we_mbst2a_kmo.werbetyp_id = b.werbetyp_id
;

-- Anzahl Nullbestand Tag_1 6

update _test_we_mbst2a_kmo from (select a.mandant_id,
                                        a.wup_id,
                                        a.art_id,
                                        a.dat,
                                        w.dat_von,
                                        w.dat_bis,
                                        w.werbetyp_id,
                                        MAX(CASE
                                              WHEN xx.gewart_id  = 'ST' AND a.menge_lgbest_erp_frei_bme = 0 THEN 1
                                              WHEN xx.gewart_id  = 'KG' AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090 THEN 1
                                              WHEN xx.gewart_id  = 'G'  AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000 THEN 1
                                              ELSE 0
                                            END) AS anz_null_tag6
                                 from dbp_data.marktbestand_erp_1 a
                                 JOIN (SELECT a.mandant_id,
                                              a.werbetyp_id,
                                              a.wup_id,
                                              a.art_id,
                                              a.dat_von,
                                              a.dat_bis,
                                              b.dat
                                       FROM _werbeartikel_1_kmo a
                                       JOIN dbp_data.tag_1 b
                                         ON b.dat = a.dat_von+5 and
                                            b.dat <= a.dat_bis
                                       GROUP BY 1,2,3,4,5,6,7) w
                                   ON w.mandant_id = a.mandant_id AND
                                      w.wup_id = a.wup_id AND
                                      w.art_id = a.art_id AND
                                      w.dat = a.dat and
                                      a.dat < current_date
                                 JOIN dbp_data.art_1 xx
                                   ON w.mandant_id = xx.mandant_id AND
                                      w.art_id = xx.art_id
                                 group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag6 = b.anz_null_tag6

where _test_we_mbst2a_kmo.mandant_id = b.mandant_id and
      _test_we_mbst2a_kmo.wup_id = b.wup_id and
      _test_we_mbst2a_kmo.art_id = b.art_id and
      _test_we_mbst2a_kmo.dat_von = b.dat_von and
      _test_we_mbst2a_kmo.dat_bis = b.dat_bis and
      _test_we_mbst2a_kmo.werbetyp_id = b.werbetyp_id
;

-- Anzahl Nullbestand Tag_1 7

update _test_we_mbst2a_kmo from (select a.mandant_id,
                                        a.wup_id,
                                        a.art_id,
                                        a.dat,
                                        w.dat_von,
                                        w.dat_bis,
                                        w.werbetyp_id,
                                        MAX(CASE
                                              WHEN xx.gewart_id  = 'ST' AND a.menge_lgbest_erp_frei_bme = 0 THEN 1
                                              WHEN xx.gewart_id  = 'KG' AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090 THEN 1
                                              WHEN xx.gewart_id  = 'G'  AND a.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000 THEN 1
                                              ELSE 0
                                            END) AS anz_null_tag7
                                 from dbp_data.marktbestand_erp_1 a
                                 JOIN (SELECT a.mandant_id,
                                              a.werbetyp_id,
                                              a.wup_id,
                                              a.art_id,
                                              a.dat_von,
                                              a.dat_bis,
                                              b.dat
                                       FROM _werbeartikel_1_kmo a
                                       JOIN dbp_data.tag_1 b
                                         ON b.dat = a.dat_von+6 and
                                            b.dat <= a.dat_bis
                                       GROUP BY 1,2,3,4,5,6,7) w
                                   ON w.mandant_id = a.mandant_id AND
                                      w.wup_id = a.wup_id AND
                                      w.art_id = a.art_id AND
                                      w.dat = a.dat and
                                      a.dat < current_date
                                 JOIN dbp_data.art_1 xx
                                   ON w.mandant_id = xx.mandant_id AND
                                      w.art_id = xx.art_id
                                 group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag7 = b.anz_null_tag7

where _test_we_mbst2a_kmo.mandant_id = b.mandant_id and
      _test_we_mbst2a_kmo.wup_id = b.wup_id and
      _test_we_mbst2a_kmo.art_id = b.art_id and
      _test_we_mbst2a_kmo.dat_von = b.dat_von and
      _test_we_mbst2a_kmo.dat_bis = b.dat_bis and
      _test_we_mbst2a_kmo.werbetyp_id = b.werbetyp_id
;

CREATE OR REPLACE VOLATILE TABLE _test_we_mbst2b_kmo AS (
SELECT v.kjwo,
       v.werbetyp_id,
       v.dat_von,
       v.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       v.nb_id,
       SUM(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme = 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000 THEN 1
             ELSE 0
           END) AS anz_null_tag1_bis_tag3,
       SUM(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme < 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             ELSE 0
           END) AS anz_minus_tag1_bis_tag3
FROM _ff_we4_kmo v
JOIN (SELECT a.mandant_id,
             a.werbetyp_id,
             a.wup_id,
             a.art_id,
             a.dat_von,
             a.dat_bis,
             b.dat,
             a.kjwo
      FROM _werbeartikel_1_kmo a
      JOIN dbp_data.tag_1 b
        ON b.dat BETWEEN a.dat_von AND a.dat_bis AND
           b.dat BETWEEN a.dat_von AND a.dat_von+2
      GROUP BY 1,2,3,4,5,6,7,8) w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.werbetyp_id = w.werbetyp_id AND
    (v.kjwo = w.kjwo OR
     v.kjwo = w.kjwo-1)
JOIN dbp_data.art_1 xx
  ON v.mandant_id = xx.mandant_id AND
     v.art_id = xx.art_id
LEFT JOIN dbp_data.marktbestand_erp_1 x
  ON w.mandant_id = x.mandant_id AND
     w.wup_id = x.wup_id AND
     w.art_id = x.art_id AND
     w.dat = x.dat and
     x.dat < current_date
GROUP BY 1,2,3,4,5,6,7,8
);

CREATE OR REPLACE VOLATILE TABLE _ff_we5_kmo AS (
SELECT a.kjwo,
       a.werbetyp_id,
	   a.dat_von,
	   a.dat_bis,
       a.mandant_id,
       a.wup_id,
       a.nb_id,
       a.art_id,
       SUM(a.we_menge) AS we_menge,
       SUM(a.we_menge_2) AS we_menge_ab_vorwoche,
       SUM(a.menge_aktionsstart) AS menge_aktionsstart,
       SUM(b.menge_endbestand) AS menge_endbestand
FROM _ff_we4_kmo a
JOIN _test_we_mbst1_kmo b
  ON a.mandant_id = b.mandant_id AND
     a.kjwo = b.kjwo AND
     a.wup_id = b.wup_id AND
     a.nb_id = b.nb_id AND
     a.art_id = b.art_id AND
	 a.werbetyp_id = b.werbetyp_id
GROUP BY 1,2,3,4,5,6,7,8
);

CREATE OR REPLACE VOLATILE TABLE _ff_we_artbew1_kmo AS (
SELECT a.*,
       CAST(0 AS DECIMAL(18,3)) AS menge_endbestand,
       CAST(0 AS DECIMAL(18,3)) AS min_sicherh_bestand,
       CAST(1 AS DECIMAL(9,3)) AS faktor_flaki,
       CAST(0 AS INTEGER) AS anzahl_nullbestand,
       CAST(0 AS INTEGER) AS anzahl_tage_aktion,
       CAST(0 AS DECIMAL(18,3)) AS menge_historie_af,
       CAST(0 AS DECIMAL(18,3)) AS sollbestand,
       CAST(0 AS SMALLINT) AS lager_prozent,
       CAST(0 AS SMALLINT) AS mhd_zeitraum,
       CAST(0 AS DECIMAL(18,3)) AS menge_bestand_soll_max,
       CAST(0 AS DECIMAL(9,3)) AS menge_tag1_7bis13h,
       CAST(0 AS DECIMAL(9,3)) AS menge_nur_tag1,
       CAST(-1 AS BYTEINT) AS bezugsweg_id,
       CAST(0 AS DECIMAL(18,3)) AS we_menge_vor_aktion,
       CAST(0 AS INTEGER) AS anzahl_nullbestand_tag1,
       CAST(0 AS INTEGER) AS anzahl_nullbestand_tag2,
       CAST(0 AS INTEGER) AS anzahl_nullbestand_tag3,
       CAST(0 AS INTEGER) AS anzahl_nullbestand_tag4,
       CAST(0 AS INTEGER) AS anzahl_nullbestand_tag5,
       CAST(0 AS INTEGER) AS anzahl_nullbestand_tag6,
       CAST(0 AS INTEGER) AS anzahl_nullbestand_tag7,
       CAST(0 AS INTEGER) AS anzahl_nullbestand_tag1bis3,
       CAST(0 AS INTEGER) AS anzahl_minusbestand,
       CAST(0 AS INTEGER) AS anzahl_minusbestand_tag1,
       CAST(0 AS INTEGER) AS anzahl_minusbestand_tag1bis3
FROM _ff_we_artbew_kmo a
);

UPDATE _ff_we_artbew1_kmo 
SET we_menge = b.we_menge,
    we_menge_ab_vorwoche = b.we_menge_ab_vorwoche,
-- 08.01.2019, -dbay-
--
-- Auf Wunsch der Laender wird nun die Menge der Vorwoche auch fuer KMO
-- beruecksichtigt, allerdings in einem separaten Feld! Die "we_menge_zentral"
-- deckt zunaechst weiterhin NUR die Menge der Aktionswoche ab! -> Standard fuer KMO!
    we_menge_vor_aktion = b.we_menge_ab_vorwoche,
    menge_aktionsstart = b.menge_aktionsstart,
    menge_endbestand = b.menge_endbestand,
    min_sicherh_bestand = b.min_sicherh_bestand,
    sollbestand = b.sollbestand,
-- 08.01.2019, -dbay-
--
-- Zuspielen des Bezugsweg, um JOIN im FED zu vermeiden!
    bezugsweg_id = b.bezugsweg_id
FROM (SELECT a.*,
             f.min_sicherh_bestand,
             f.sollbestand,
             f.bezugsweg_id
      FROM _ff_we5_kmo a
      LEFT JOIN dbp_data.art_wup_status_per_1 f
        ON a.mandant_id = f.mandant_id AND
           a.wup_id = f.wup_id AND
           a.nb_id = f.nb_id AND
           a.art_id = f.art_id AND
           f.dat_bis = '9999-12-31') b
WHERE _ff_we_artbew1_kmo.mandant_id = b.mandant_id AND
      _ff_we_artbew1_kmo.wup_id = b.wup_id AND
      _ff_we_artbew1_kmo.nb_id = b.nb_id AND
      _ff_we_artbew1_kmo.art_id = b.art_id AND
      _ff_we_artbew1_kmo.kjwo = b.kjwo AND
      _ff_we_artbew1_kmo.werbetyp_id = b.werbetyp_id
;

UPDATE _ff_we_artbew1_kmo 
SET mhd_zeitraum = b.mhd_zeitraum,
    lager_prozent = b.lager_prozent
FROM (SELECT a.*,
             f.mhd_zeitraum,
             f.lager_prozent
      FROM _ff_we5_kmo a
      LEFT JOIN dbp_data.art_1 f
        ON a.mandant_id = f.mandant_id AND
           a.art_id = f.art_id) b
WHERE _ff_we_artbew1_kmo.mandant_id = b.mandant_id AND
      _ff_we_artbew1_kmo.wup_id = b.wup_id AND
      _ff_we_artbew1_kmo.nb_id = b.nb_id AND
      _ff_we_artbew1_kmo.art_id = b.art_id AND
      _ff_we_artbew1_kmo.kjwo = b.kjwo AND
      _ff_we_artbew1_kmo.werbetyp_id = b.werbetyp_id
;

UPDATE _ff_we_artbew1_kmo 
SET menge_bestand_soll_max = b.menge_bestand_soll_max
FROM (SELECT a.*,
             f.menge_bestand_soll_max
      FROM _ff_we5_kmo a
      LEFT JOIN dbp_data.art_wup_nachschub_per_1 f
        ON a.mandant_id = f.mandant_id AND
           a.wup_id = f.wup_id AND
           a.nb_id = f.nb_id AND
           a.art_id = f.art_id AND
           f.dat_bis = '9999-12-31') b
WHERE _ff_we_artbew1_kmo.mandant_id = b.mandant_id AND
      _ff_we_artbew1_kmo.wup_id = b.wup_id AND
      _ff_we_artbew1_kmo.nb_id = b.nb_id AND
      _ff_we_artbew1_kmo.art_id = b.art_id AND
      _ff_we_artbew1_kmo.kjwo = b.kjwo AND
      _ff_we_artbew1_kmo.werbetyp_id = b.werbetyp_id
;

CREATE OR REPLACE VOLATILE TABLE _fix_it_kmo AS (
SELECT b.mandant_id,
       b.werbetyp_id,
       b.wup_id,
       b.art_id,
       b.kjwo, 
       SUM(a.menge) menge_tag1_7bis13h 
FROM dbp_ods.ods_bon_verkauf_1 a
JOIN _werbeartikel_1_kmo b
  ON b.mandant_id = a.mandant_id AND 
     CAST(a.start_bon_zeile AS DATE) = b.dat_von AND
     b.wup_id = a.wup_id AND
     b.art_id/10 = a.kl_art_id AND
     CAST(a.start_bon_zeile AS TIME) BETWEEN '07:00:00' AND '13:00:00'
JOIN (SELECT a.mandant_id,
             a.wup_id,
             a.werbetyp_id
      FROM _werbeartikel_1_kmo a
      JOIN dbp_data.wupcal_1 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           a.dat_von = b.dat
      WHERE b.offen = 1
      GROUP BY 1,2,3) x
  ON a.mandant_id = x.mandant_id AND
     a.wup_id = x.wup_id AND
     b.werbetyp_id = x.werbetyp_id
WHERE a.mandant_id > 1
GROUP BY 1,2,3,4,5
HAVING menge_tag1_7bis13h > 0
);

INSERT INTO _fix_it_kmo
SELECT b.mandant_id,
       b.werbetyp_id,
       b.wup_id,
       b.art_id,
       b.kjwo, 
       SUM(a.menge) menge_tag1_7bis13h 
FROM dbp_ods.ods_bon_verkauf_1 a
JOIN _werbeartikel_1_kmo b
  ON b.mandant_id = a.mandant_id AND 
     CAST(a.start_bon_zeile AS DATE) BETWEEN b.dat_von AND b.dat_bis AND
     b.wup_id = a.wup_id AND
     b.art_id/10 = a.kl_art_id AND
     CAST(a.start_bon_zeile AS TIME) BETWEEN '07:00:00' AND '13:00:00'
JOIN (SELECT a.mandant_id,
             a.wup_id,
             a.werbetyp_id,
             MIN(b.dat) AS min_dat
      FROM (SELECT a.mandant_id,
                   a.wup_id,
                   a.werbetyp_id,
                   a.dat_von,
                   a.dat_bis
            FROM _werbeartikel_1_kmo a
            JOIN dbp_data.wupcal_1 b
              ON a.mandant_id = b.mandant_id AND
                 a.wup_id = b.wup_id AND
                 a.dat_von = b.dat
            WHERE b.offen = 0
            GROUP BY 1,2,3,4,5) a
      JOIN dbp_data.wupcal_1 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           b.dat BETWEEN a.dat_von AND a.dat_bis
      WHERE b.offen = 1
      GROUP BY 1,2,3) x
  ON a.mandant_id = x.mandant_id AND
     a.wup_id = x.wup_id AND
     b.werbetyp_id = x.werbetyp_id AND
     CAST(a.start_bon_zeile AS DATE) = x.min_dat
WHERE a.mandant_id > 1
GROUP BY 1,2,3,4,5
HAVING menge_tag1_7bis13h > 0
;

UPDATE _ff_we_artbew1_kmo 
SET menge_tag1_7bis13h = b.menge_tag1_7bis13h
FROM (SELECT mandant_id,
             werbetyp_id,
             wup_id,
             art_id,
             kjwo,
             MAX(menge_tag1_7bis13h) AS menge_tag1_7bis13h
      FROM _fix_it_kmo
      GROUP BY 1,2,3,4,5) b
WHERE _ff_we_artbew1_kmo.mandant_id = b.mandant_id AND
      _ff_we_artbew1_kmo.wup_id = b.wup_id AND
      _ff_we_artbew1_kmo.art_id = b.art_id AND
      _ff_we_artbew1_kmo.kjwo = b.kjwo AND
      _ff_we_artbew1_kmo.werbetyp_id = b.werbetyp_id
;

CREATE OR REPLACE VOLATILE TABLE _fix_it_kmo2 AS (
SELECT b.mandant_id,
       b.werbetyp_id,
       b.wup_id,
       b.art_id,
       b.kjwo, 
       SUM(a.menge) menge_nur_tag1
FROM dbp_ods.ods_bon_verkauf_1 a
JOIN _werbeartikel_1_kmo b
  ON b.mandant_id = a.mandant_id AND 
     CAST(a.start_bon_zeile AS DATE) = b.dat_von AND
     b.wup_id = a.wup_id AND
     b.art_id/10 = a.kl_art_id
JOIN (SELECT a.mandant_id,
             a.wup_id,
             a.werbetyp_id
      FROM _werbeartikel_1_kmo a
      JOIN dbp_data.wupcal_1 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           a.dat_von = b.dat
      WHERE b.offen = 1
      GROUP BY 1,2,3) x
  ON a.mandant_id = x.mandant_id AND
     a.wup_id = x.wup_id AND
     b.werbetyp_id = x.werbetyp_id
WHERE a.mandant_id > 1
GROUP BY 1,2,3,4,5
HAVING menge_nur_tag1 > 0
);

INSERT INTO _fix_it_kmo2
SELECT b.mandant_id,
       b.werbetyp_id,
       b.wup_id,
       b.art_id,
       b.kjwo, 
       SUM(a.menge) menge_nur_tag1 
FROM dbp_ods.ods_bon_verkauf_1 a
JOIN _werbeartikel_1_kmo b
  ON b.mandant_id = a.mandant_id AND 
     CAST(a.start_bon_zeile AS DATE) BETWEEN b.dat_von AND b.dat_bis AND
     b.wup_id = a.wup_id AND
     b.art_id/10 = a.kl_art_id
JOIN (SELECT a.mandant_id,
             a.wup_id,
             a.werbetyp_id,
             MIN(b.dat) AS min_dat
      FROM (SELECT a.mandant_id,
                   a.wup_id,
                   a.werbetyp_id,
                   a.dat_von,
                   a.dat_bis
            FROM _werbeartikel_1_kmo a
            JOIN dbp_data.wupcal_1 b
              ON a.mandant_id = b.mandant_id AND
                 a.wup_id = b.wup_id AND
                 a.dat_von = b.dat
            WHERE b.offen = 0
            GROUP BY 1,2,3,4,5) a
      JOIN dbp_data.wupcal_1 b
        ON a.mandant_id = b.mandant_id AND
           a.wup_id = b.wup_id AND
           b.dat BETWEEN a.dat_von AND a.dat_bis
      WHERE b.offen = 1
      GROUP BY 1,2,3) x
  ON a.mandant_id = x.mandant_id AND
     a.wup_id = x.wup_id AND
     b.werbetyp_id = x.werbetyp_id AND
     CAST(a.start_bon_zeile AS DATE) = x.min_dat
WHERE a.mandant_id > 1
GROUP BY 1,2,3,4,5
HAVING menge_nur_tag1 > 0
;

UPDATE _ff_we_artbew1_kmo 
SET menge_nur_tag1 = b.menge_nur_tag1
FROM (SELECT mandant_id,
             werbetyp_id,
             wup_id,
             art_id,
             kjwo,
             MAX(menge_nur_tag1) AS menge_nur_tag1
      FROM _fix_it_kmo2
      GROUP BY 1,2,3,4,5) b
WHERE _ff_we_artbew1_kmo.mandant_id = b.mandant_id AND
      _ff_we_artbew1_kmo.wup_id = b.wup_id AND
      _ff_we_artbew1_kmo.art_id = b.art_id AND
      _ff_we_artbew1_kmo.kjwo = b.kjwo AND
      _ff_we_artbew1_kmo.werbetyp_id = b.werbetyp_id
;

UPDATE _ff_we_artbew1_kmo 
SET anzahl_nullbestand = b.anz_tage_null,
    anzahl_minusbestand = b.anz_tage_minus
FROM (SELECT *
      FROM _test_we_mbst2_kmo) b
WHERE _ff_we_artbew1_kmo.mandant_id = b.mandant_id AND
      _ff_we_artbew1_kmo.wup_id = b.wup_id AND
      _ff_we_artbew1_kmo.nb_id = b.nb_id AND
      _ff_we_artbew1_kmo.art_id = b.art_id AND
      _ff_we_artbew1_kmo.kjwo = b.kjwo AND
      _ff_we_artbew1_kmo.werbetyp_id = b.werbetyp_id
;

UPDATE _ff_we_artbew1_kmo 
SET anzahl_nullbestand_tag1 = b.anz_null_tag1,
    anzahl_nullbestand_tag2 = b.anz_null_tag2,
    anzahl_nullbestand_tag3 = b.anz_null_tag3,
    anzahl_nullbestand_tag4 = b.anz_null_tag4,
    anzahl_nullbestand_tag5 = b.anz_null_tag5,
    anzahl_nullbestand_tag6 = b.anz_null_tag6,
    anzahl_nullbestand_tag7 = b.anz_null_tag7,
    anzahl_minusbestand_tag1 = b.anz_minus_tag1
FROM (SELECT *
      FROM _test_we_mbst2a_kmo) b
WHERE _ff_we_artbew1_kmo.mandant_id = b.mandant_id AND
      _ff_we_artbew1_kmo.wup_id = b.wup_id AND
      _ff_we_artbew1_kmo.nb_id = b.nb_id AND
      _ff_we_artbew1_kmo.art_id = b.art_id AND
      _ff_we_artbew1_kmo.kjwo = b.kjwo AND
      _ff_we_artbew1_kmo.werbetyp_id = b.werbetyp_id
;

UPDATE _ff_we_artbew1_kmo 
SET anzahl_nullbestand_tag1bis3 = b.anz_null_tag1_bis_tag3,
    anzahl_minusbestand_tag1bis3 = b.anz_minus_tag1_bis_tag3
FROM (SELECT *
      FROM _test_we_mbst2b_kmo) b
WHERE _ff_we_artbew1_kmo.mandant_id = b.mandant_id AND
      _ff_we_artbew1_kmo.wup_id = b.wup_id AND
      _ff_we_artbew1_kmo.nb_id = b.nb_id AND
      _ff_we_artbew1_kmo.art_id = b.art_id AND
      _ff_we_artbew1_kmo.kjwo = b.kjwo AND
      _ff_we_artbew1_kmo.werbetyp_id = b.werbetyp_id
;

UPDATE _ff_we_artbew1_kmo 
SET menge_historie_af = b.menge_historie_af
FROM (SELECT a.mandant_id,
             a.wup_id,
             a.art_id,
             SUM(d.menge)/42.000 AS menge_historie_af
      FROM _ff_we_artbew1_kmo a
      JOIN dbp_data.woche_1 b
        ON a.kjwo = b.kjwo
      JOIN dbp_data.woche_kj_kl_1 c
        ON c.akt_wo BETWEEN b.akt_wo-6 AND b.akt_wo-1
      JOIN dbp_data.artbew_wo_sum_1 d
        ON a.mandant_id = d.mandant_id AND
           a.wup_id = d.wup_id AND
           a.art_id = d.art_id AND
           c.kjwo_kl = d.kjwo_kl
      WHERE d.bewart_id = 1001 AND
            d.menge >= 0
      GROUP BY 1,2,3) b
WHERE _ff_we_artbew1_kmo.mandant_id = b.mandant_id AND
      _ff_we_artbew1_kmo.wup_id = b.wup_id AND
      _ff_we_artbew1_kmo.art_id = b.art_id
;

UPDATE _ff_we_artbew1_kmo 
SET anzahl_tage_aktion = b.anz_tage_aktion
FROM (SELECT mandant_id,
             werbetyp_id,
             MAX(anz_tage_aktion) AS anz_tage_aktion
      FROM _werbetyp_tage_kmo
      GROUP BY 1,2) b
WHERE _ff_we_artbew1_kmo.mandant_id = b.mandant_id AND
      _ff_we_artbew1_kmo.werbetyp_id = b.werbetyp_id
;

UPDATE _ff_we_artbew1_kmo SET we_menge_ab_vorwoche = we_menge
;

CREATE OR REPLACE VOLATILE TABLE _ff_we_artbew2_kmo AS (
SELECT DISTINCT
       a.*,
       b.wtag_id AS wtag_id_start,
       c.wtag_id AS wtag_id_ende,
       -- 14.09.2016, -dbay-
       -- Zuspielen der Mutter jetzt ueber die eingefrorenen Daten.
       w.mutter_wb_id,
       w.avq_relevant_fg,
       w.vk_vor_aktion_brutto,
       w.vk_aktion_brutto,
       w.vk_kcard_brutto
FROM _ff_we_artbew1_kmo a
JOIN dbp_data.tag_1 b
  ON CASE
       WHEN a.werbetyp_id = 1
       THEN a.dat_von+1
       ELSE a.dat_von
     END = b.dat
JOIN dbp_data.tag_1 c
  ON a.dat_bis = c.dat
JOIN _werbeartikel_1_kmo w
  ON a.mandant_id = w.mandant_id AND
     a.wup_id = w.wup_id AND
     a.art_id = w.art_id AND
     a.dat_von BETWEEN w.dat_von AND w.dat_bis AND
     a.werbetyp_id = w.werbetyp_id
);

UPDATE _ff_we_artbew2_kmo 
SET mutter_wb_id = b.max_komponente,
    we_menge_ab_vorwoche = CASE
                             WHEN _ff_we_artbew2_kmo.we_menge_ab_vorwoche = 0
                             THEN 0.001
                             ELSE _ff_we_artbew2_kmo.we_menge_ab_vorwoche
                           END,
    -- Fuer die Darstellung im Frontend wichtig, sonst wandern die Koepfe je nach
    -- Konstellation in eine_1 andere Warengruppe rein und foerdert somit abstruse
    -- Quoten zum Vorscheind.
    art_id = b.max_komponente,
    -- 14.09.2016, -dbay-
    -- Befuellung der Hilfsvariablen.
    hilfe = 99
FROM (SELECT mandant_id,
             art_id,
             MAX(komponente) AS max_komponente
      FROM _werbeartikel_1_kmo
      WHERE stkl_kopf_fg IN (1,2) AND
            mandant_id <> 4
      GROUP BY 1,2) b
WHERE _ff_we_artbew2_kmo.mandant_id = b.mandant_id AND
      _ff_we_artbew2_kmo.art_id = b.art_id
;

UPDATE _ff_we_artbew2_kmo 
SET mutter_wb_id = b.max_komponente,
    we_menge_ab_vorwoche = CASE
                             WHEN _ff_we_artbew2_kmo.we_menge_ab_vorwoche = 0
                             THEN 0.001
                             ELSE _ff_we_artbew2_kmo.we_menge_ab_vorwoche
                           END,
    -- Fuer die Darstellung im Frontend wichtig, sonst wandern die Koepfe je nach
    -- Konstellation in eine_1 andere Warengruppe rein und foerdert somit abstruse
    -- Quoten zum Vorscheind.
    art_id = b.max_komponente,
    -- 14.09.2016, -dbay-
    -- Befuellung der Hilfsvariablen.
    hilfe = 99,
    anzahl_nullbestand_tag1 = b.anzahl_nullbestand_tag1,
    anzahl_nullbestand_tag1bis3 = b.anzahl_nullbestand_tag1bis3,
    anzahl_nullbestand = b.anzahl_nullbestand
FROM (SELECT a.mandant_id,
             a.art_id,
             max(a.komponente) as max_komponente,
             min(anzahl_nullbestand_tag1) as anzahl_nullbestand_tag1,
             min(anzahl_nullbestand_tag1bis3) as anzahl_nullbestand_tag1bis3,
             min(anzahl_nullbestand) as anzahl_nullbestand
      FROM _werbeartikel_1_kmo a
      join _ff_we_artbew2_kmo b
        on a.mandant_id = b.mandant_id and
           a.komponente = b.art_id
      WHERE a.stkl_kopf_fg IN (1,2) and
            a.mandant_id = 4
      GROUP BY 1,2) b
WHERE _ff_we_artbew2_kmo.mandant_id = b.mandant_id AND
      _ff_we_artbew2_kmo.art_id = b.art_id
;

UPDATE _ff_we_artbew2_kmo 
SET we_menge_ab_vorwoche = CASE
                             WHEN _ff_we_artbew2_kmo.we_menge_ab_vorwoche = 0.001
                             THEN 0.0
                             ELSE _ff_we_artbew2_kmo.we_menge_ab_vorwoche
                           END
FROM (SELECT mandant_id,
             komponente AS max_komponente
      FROM _werbeartikel_1_kmo
      WHERE stkl_kopf_fg IN (2)
      GROUP BY 1,2) b
WHERE _ff_we_artbew2_kmo.mandant_id = b.mandant_id AND
      _ff_we_artbew2_kmo.art_id = b.max_komponente
;

UPDATE _ff_we_artbew2_kmo 
SET mutter_wb_id = b.komponente,
    -- 14.09.2016, -dbay-
    -- Befuellung der Hilfsvariablen.
    hilfe = CASE WHEN hilfe = 0 THEN 98 ELSE hilfe END
FROM (SELECT mandant_id,
             komponente
      FROM _werbeartikel_1_kmo
      WHERE stkl_kopf_fg IN (1,2)
      GROUP BY 1,2) b
WHERE _ff_we_artbew2_kmo.mandant_id = b.mandant_id AND
      _ff_we_artbew2_kmo.art_id = b.komponente
;

UPDATE _ff_we_artbew2_kmo 
SET mutter_wb_id = b.mutter_wb_id
FROM (SELECT a.mandant_id,
             a.art_id,
             MAX(COALESCE(a.mutter_wb_id,a.art_id)) AS mutter_wb_id
      FROM dbp_data.art_1 a
      JOIN (SELECT mandant_id,
                   art_id,
                   MAX(komponente) AS komponente
            FROM _werbeartikel_1_kmo
            WHERE stkl_kopf_fg IN (1,2)
            GROUP BY 1,2) b
        ON a.mandant_id = b.mandant_id AND
           a.art_id = b.komponente
      GROUP BY 1,2) b
WHERE _ff_we_artbew2_kmo.mandant_id = b.mandant_id AND
      _ff_we_artbew2_kmo.art_id = b.art_id AND
      _ff_we_artbew2_kmo.hilfe IN (98,99)
;

CREATE OR REPLACE VOLATILE TABLE _ff_we_artbew3_kmo AS (
SELECT kjwo,
       werbetyp_id,
	   dat_von,
	   dat_bis,
	   wup_id,
	   mandant_id,
	   art_id,
	   nb_id,
	   MAX(posten_id) AS posten_id,
	   SUM(umsatz_netto_mo) AS umsatz_netto_mo,
	   SUM(umsatz_netto_di) AS umsatz_netto_di,
	   SUM(umsatz_netto_mi) AS umsatz_netto_mi,
	   SUM(umsatz_netto_do) AS umsatz_netto_do,
	   SUM(umsatz_netto_fr) AS umsatz_netto_fr,
	   SUM(umsatz_netto_sa) AS umsatz_netto_sa,
	   SUM(umsatz_netto_so) AS umsatz_netto_so,
	   SUM(umsatz_netto_wo) AS umsatz_netto_wo,
	   SUM(menge_mo) AS menge_mo,
	   SUM(menge_di) AS menge_di,
	   SUM(menge_mi) AS menge_mi,
	   SUM(menge_do) AS menge_do,
	   SUM(menge_fr) AS menge_fr,
	   SUM(menge_sa) AS menge_sa,
	   SUM(menge_so) AS menge_so,
	   SUM(menge_wo) AS menge_wo,
           sum(menge_sa2) as menge_sa2,
	   SUM(CASE WHEN hilfe <> 99 THEN tage_menge_0 ELSE 0 END) AS tage_menge_0,
	   SUM(we_menge) AS we_menge,
	   SUM(menge_aktionsstart) AS menge_aktionsstart,
	   SUM(we_menge_ab_vorwoche) AS we_menge_ab_vorwoche,
	   MAX(hilfe) AS hilfe,
	   SUM(menge_endbestand) AS menge_endbestand,
	   MAX(min_sicherh_bestand) AS min_sicherh_bestand,
	   MAX(faktor_flaki) AS faktor_flaki,
	   MAX(wtag_id_start) AS wtag_id_start,
	   MAX(wtag_id_ende) AS wtag_id_ende,
	   MAX(mutter_wb_id) AS mutter_wb_id,
	   SUM(CASE WHEN hilfe <> 99 THEN anzahl_nullbestand ELSE 0 END) AS anzahl_nullbestand,
	   MAX(anzahl_tage_aktion) AS anzahl_tage_aktion,
	   SUM(menge_historie_af) AS menge_historie_af,
	   MAX(sollbestand) AS sollbestand,
	   MAX(lager_prozent) AS lager_prozent,
	   MAX(mhd_zeitraum) AS mhd_zeitraum,
	   MAX(menge_bestand_soll_max) AS menge_bestand_soll_max,
	   SUM(menge_tag1_7bis13h) AS menge_tag1_7bis13h,
       SUM(menge_nur_tag1) AS menge_nur_tag1,
	   MAX(bezugsweg_id) AS bezugsweg_id,
	   SUM(we_menge_vor_aktion) AS we_menge_vor_aktion,
           SUM(CASE WHEN hilfe <> 99 THEN anzahl_minusbestand ELSE 0 END) AS anzahl_minusbestand,
           MAX(anzahl_nullbestand_tag1) AS anzahl_nullbestand_tag1,
           MAX(anzahl_nullbestand_tag1bis3) AS anzahl_nullbestand_tag1bis3,
           MAX(anzahl_minusbestand_tag1) AS anzahl_minusbestand_tag1,
           MAX(anzahl_minusbestand_tag1bis3) AS anzahl_minusbestand_tag1bis3,
           MAX(avq_relevant_fg) as avq_relevant_fg,
           MAX(anzahl_nullbestand_tag2) AS anzahl_nullbestand_tag2,
           MAX(anzahl_nullbestand_tag3) AS anzahl_nullbestand_tag3,
           MAX(anzahl_nullbestand_tag4) AS anzahl_nullbestand_tag4,
           MAX(anzahl_nullbestand_tag5) AS anzahl_nullbestand_tag5,
           MAX(anzahl_nullbestand_tag6) AS anzahl_nullbestand_tag6,
           MAX(anzahl_nullbestand_tag7) AS anzahl_nullbestand_tag7,
           MAX(vk_vor_aktion_brutto) as vk_vor_aktion_brutto,
           MAX(vk_aktion_brutto) as vk_aktion_brutto,
           MAX(vk_kcard_brutto) as vk_kcard_brutto
FROM _ff_we_artbew2_kmo
GROUP BY 1,2,3,4,5,6,7,8
);

UPDATE _ff_we_artbew3_kmo 
SET menge_aktionsstart = b.menge

FROM (SELECT mandant_id,
             art_id,
             wup_id,
             dat+1 AS dat_,
             SUM(menge_lgbest_erp_frei_bme) AS menge
      FROM dbp_data.marktbestand_erp_1
      WHERE (mandant_id,art_id,wup_id,dat) IN (SELECT mandant_id,art_id,wup_id,dat_von-1
                                               FROM _ff_we_artbew3_kmo
                                               WHERE menge_aktionsstart = 0) AND
             menge_lgbest_erp_frei_bme <> 0
      GROUP BY 1,2,3,4) b
WHERE _ff_we_artbew3_kmo.mandant_id = b.mandant_id AND
      _ff_we_artbew3_kmo.art_id = b.art_id AND
      _ff_we_artbew3_kmo.wup_id = b.wup_id AND
      _ff_we_artbew3_kmo.dat_von = b.dat_
;

DELETE FROM _ff_we_artbew3_kmo
WHERE (mandant_id,mutter_wb_id) IN (SELECT akt.mandant_id,
                                           akta.art_id
                                    FROM dbp_data.aktion_1 akt
                                    JOIN dbp_data.aktion_art_wup_zu_1 akta
                                      ON akt.mandant_id = akta.mandant_id AND
                                         akt.aktion_id = akta.aktion_id
                                    JOIN dbp_data.tag_1 x1
                                      ON akt.dat_von = x1.dat
                                    WHERE akta.grund_sperrung is null and
                                          akt.mandant_id IN (8) AND
                                          charindex('J',akt.aktion_id) > 0 and 
                                          length(trim(akt.aktion_id)) = 9 and
                                          x1.akt_wo = $wkw
                                    GROUP BY 1,2)
;

DELETE FROM dbp_data.werbung_kennzahlen_woche_1
WHERE (kjwo,werbe_typ_id,wup_id,art_id,mandant_id) IN (SELECT kjwo,werbetyp_id,wup_id,art_id,mandant_id FROM _ff_we_artbew3_kmo)
;

INSERT INTO dbp_data.werbung_kennzahlen_woche_1 (kjwo
                                               ,wup_id
                                               ,nb_id
                                               ,mandant_id
                                               ,art_id
                                               ,werbe_typ_id
                                               ,menge_tag1
                                               ,menge_tag2
                                               ,menge_tag3
                                               ,menge_tag4
                                               ,menge_tag5
                                               ,menge_tag6
                                               ,menge_tag7
                                               ,tage_menge_0       
                                               ,menge_endbestand   
                                               ,menge_aktionsstart 
                                               ,umsatz_netto_tag1    
                                               ,umsatz_netto_tag2  
                                               ,umsatz_netto_tag3  
                                               ,umsatz_netto_tag4  
                                               ,umsatz_netto_tag5
                                               ,umsatz_netto_tag6
                                               ,umsatz_netto_tag7  
                                               ,we_menge           
                                               ,min_sicherh_bestand
                                               ,posten_id
                                               ,we_menge_zentral
                                               ,faktor_flaki
                                               ,mutter_wb_id
                                               ,wtag_id_start
                                               ,wtag_id_ende
                                               ,menge_historie_af
                                               ,anzahl_nullbestand
                                               ,anzahl_tage_aktion
                                               ,menge_tag1_7bis13h
                                               ,menge_nur_tag1
                                               ,lager_prozent
                                               ,mhd_zeitraum
                                               ,sollbestand
                                               ,menge_bestand_soll_max
                                               ,werbenachvermarktung_fg
                                               ,art_mutter_bezugsweg_id
                                               ,we_menge_vor_aktion
                                               ,anzahl_nullbestand_tag1
                                               ,anzahl_nullbestand_tag1bis3
                                               ,anzahl_minusbestand
                                               ,anzahl_minusbestand_tag1
                                               ,anzahl_minusbestand_tag1bis3
                                               ,avq_relevant_fg
                                               ,wrg_id
                                               ,anzahl_nullbestand_tag2
                                               ,anzahl_nullbestand_tag3
                                               ,anzahl_nullbestand_tag4
                                               ,anzahl_nullbestand_tag5
                                               ,anzahl_nullbestand_tag6
                                               ,anzahl_nullbestand_tag7
                                               ,vk_vor_aktion_brutto
                                               ,vk_aktion_brutto
                                               ,vk_kcard_brutto
                                               ,menge_sa
                                               ,td_insert
                                               ,td_update)
SELECT kjwo               
      ,wup_id             
      ,nb_id              
      ,x1.mandant_id
      ,art_id
      ,werbetyp_id AS werbe_typ_id
      ,CASE
         WHEN werbetyp_id IN (1,7,8,12,15)
         THEN menge_mo
         WHEN werbetyp_id IN (17)
         THEN menge_di
         WHEN werbetyp_id IN (6,11,20,23,24)
         THEN menge_mi
         WHEN werbetyp_id IN (4,5,21,22)
         THEN menge_do
         WHEN werbetyp_id IN (10,13,18,29)
         THEN menge_fr
         WHEN werbetyp_id IN (9,16,30)
         THEN menge_sa
         WHEN werbetyp_id IN (14,19)
         THEN menge_so
         ELSE 0
       END AS menge_tag1
      ,CASE
         WHEN werbetyp_id IN (1,7,8,12,15)
         THEN menge_di
         WHEN werbetyp_id IN (17)
         THEN menge_mi
         WHEN werbetyp_id IN (6,11,20,23,24)
         THEN menge_do
         WHEN werbetyp_id IN (4,5,21)
         THEN menge_fr
         WHEN werbetyp_id IN (10,13,18,29)
         THEN menge_sa
         WHEN werbetyp_id IN (9,16,30)
         THEN menge_so
         WHEN werbetyp_id IN (14,19)
         THEN menge_mo
         ELSE 0
       END AS menge_tag2
      ,CASE
         WHEN werbetyp_id IN (1,7,8,12,15)
         THEN menge_mi
         WHEN werbetyp_id IN (17)
         THEN menge_do
         WHEN werbetyp_id IN (6,11,20,23,24)
         THEN menge_fr
         WHEN werbetyp_id IN (4,5,21)
         THEN menge_sa
         WHEN werbetyp_id IN (10,13,18,29)
         THEN menge_so
         WHEN werbetyp_id IN (9,16,30)
         THEN menge_mo
         WHEN werbetyp_id IN (14,19)
         THEN menge_di
         ELSE 0
       END AS menge_tag3
      ,CASE
	 WHEN werbetyp_id IN (1,7,8,12,15)
         THEN menge_do
	 WHEN werbetyp_id IN (17)
         THEN menge_fr
	 WHEN werbetyp_id IN (6,11,20,23,24)
	 THEN menge_sa
	 WHEN werbetyp_id IN (4,5,21)
	 THEN menge_so
	 WHEN werbetyp_id IN (10,13,18,29)
	 THEN menge_mo
         WHEN werbetyp_id IN (9,16,30)
	 THEN menge_di
	 WHEN werbetyp_id IN (14,19)
	 THEN menge_mi
	 ELSE 0
       END AS menge_tag4
      ,CASE
	 WHEN werbetyp_id IN (1,7,8,12,15)
	 THEN menge_fr
	 WHEN werbetyp_id IN (17)
	 THEN menge_sa
	 WHEN werbetyp_id IN (6,11,20,23,24)
	 THEN menge_so
	 WHEN werbetyp_id IN (4,5,21)
	 THEN menge_mo
	 WHEN werbetyp_id IN (10,13,18,29)
	 THEN menge_di
         WHEN werbetyp_id IN (9,16,30)
	 THEN menge_mi
	 WHEN werbetyp_id IN (14,19)
	 THEN menge_do
	 ELSE 0
       END AS menge_tag5
      ,CASE
	 WHEN werbetyp_id IN (1,7,8,12,15)
	 THEN menge_sa
	 WHEN werbetyp_id IN (17)
	 THEN menge_so
	 WHEN werbetyp_id IN (6,11,20,23,24)
	 THEN menge_mo
	 WHEN werbetyp_id IN (4,5,21)
	 THEN menge_di
	 WHEN werbetyp_id IN (10,13,18,29)
	 THEN menge_mi
         WHEN werbetyp_id IN (9,16,30)
	 THEN menge_do
	 WHEN werbetyp_id IN (14,19)
	 THEN menge_fr
	 ELSE 0
       END AS menge_tag6
      ,CASE
	 WHEN werbetyp_id IN (1,7,8,12,15)
	 THEN menge_so
	 WHEN werbetyp_id IN (17)
	 THEN menge_mo
	 WHEN werbetyp_id IN (6,11,20,23,24)
	 THEN menge_di
	 WHEN werbetyp_id IN (4,5,21)
	 THEN menge_mi
	 WHEN werbetyp_id IN (10,13,18,29)
	 THEN menge_do
         WHEN werbetyp_id IN (9,16,30)
	 THEN menge_fr
	 WHEN werbetyp_id IN (14,19)
	 THEN menge_sa
	 ELSE 0
       END AS menge_tag7
      ,tage_menge_0       
      ,menge_endbestand   
      ,menge_aktionsstart 
      ,CASE
         WHEN werbetyp_id IN (1,7,8,12,15)
	 THEN umsatz_netto_mo
	 WHEN werbetyp_id IN (17)
	 THEN umsatz_netto_di
	 WHEN werbetyp_id IN (6,11,20,23,24)
	 THEN umsatz_netto_mi
	 WHEN werbetyp_id IN (4,5,21,22)
	 THEN umsatz_netto_do
	 WHEN werbetyp_id IN (10,13,18,29)
	 THEN umsatz_netto_fr
         WHEN werbetyp_id IN (9,16,30)
	 THEN umsatz_netto_sa
	 WHEN werbetyp_id IN (14,19)
	 THEN umsatz_netto_so
	 ELSE 0
       END AS umsatz_netto_tag1
      ,CASE
	 WHEN werbetyp_id IN (1,7,8,12,15)
	 THEN umsatz_netto_di
	 WHEN werbetyp_id IN (17)
	 THEN umsatz_netto_mi
	 WHEN werbetyp_id IN (6,11,20,23,24)
	 THEN umsatz_netto_do
	 WHEN werbetyp_id IN (4,5,21)
	 THEN umsatz_netto_fr
	 WHEN werbetyp_id IN (10,13,18,29)
	 THEN umsatz_netto_sa
         WHEN werbetyp_id IN (9,16,30)
	 THEN umsatz_netto_so
	 WHEN werbetyp_id IN (14,19)
	 THEN umsatz_netto_mo
	 ELSE 0
       END AS umsatz_netto_tag2
      ,CASE
	 WHEN werbetyp_id IN (1,7,8,12,15)
	 THEN umsatz_netto_mi
	 WHEN werbetyp_id IN (17)
	 THEN umsatz_netto_do
	 WHEN werbetyp_id IN (6,11,20,23,24)
	 THEN umsatz_netto_fr
	 WHEN werbetyp_id IN (4,5,21)
	 THEN umsatz_netto_sa
	 WHEN werbetyp_id IN (10,13,18,29)
	 THEN umsatz_netto_so
         WHEN werbetyp_id IN (9,16,30)
	 THEN umsatz_netto_mo
	 WHEN werbetyp_id IN (14,19)
	 THEN umsatz_netto_di
	 ELSE 0
       END AS umsatz_netto_tag3
      ,CASE
	 WHEN werbetyp_id IN (1,7,8,12,15)
	 THEN umsatz_netto_do
	 WHEN werbetyp_id IN (17)
	 THEN umsatz_netto_fr
	 WHEN werbetyp_id IN (6,11,20,23,24)
	 THEN umsatz_netto_sa
	 WHEN werbetyp_id IN (4,5,21)
	 THEN umsatz_netto_so
	 WHEN werbetyp_id IN (10,13,18,29)
	 THEN umsatz_netto_mo
         WHEN werbetyp_id IN (9,16,30)
	 THEN umsatz_netto_di
	 WHEN werbetyp_id IN (14,19)
	 THEN umsatz_netto_mi
	 ELSE 0
       END AS umsatz_netto_tag4
      ,CASE
         WHEN werbetyp_id IN (1,7,8,12,15)
	 THEN umsatz_netto_fr
	 WHEN werbetyp_id IN (17)
	 THEN umsatz_netto_sa
	 WHEN werbetyp_id IN (6,11,20,23,24)
	 THEN umsatz_netto_so
	 WHEN werbetyp_id IN (4,5,21)
	 THEN umsatz_netto_mo
	 WHEN werbetyp_id IN (10,13,18,29)
	 THEN umsatz_netto_di
         WHEN werbetyp_id IN (9,16,30)
	 THEN umsatz_netto_mi
	 WHEN werbetyp_id IN (14,19)
	 THEN umsatz_netto_do
	 ELSE 0
       END AS umsatz_netto_tag5
      ,CASE
	 WHEN werbetyp_id IN (1,7,8,12,15)
	 THEN umsatz_netto_sa
	 WHEN werbetyp_id IN (17)
	 THEN umsatz_netto_so
	 WHEN werbetyp_id IN (6,11,20,23,24)
	 THEN umsatz_netto_mo
	 WHEN werbetyp_id IN (4,5,21)
	 THEN umsatz_netto_di
	 WHEN werbetyp_id IN (10,13,18,29)
	 THEN umsatz_netto_mi
         WHEN werbetyp_id IN (9,16,30)
	 THEN umsatz_netto_do
	 WHEN werbetyp_id IN (14,19)
	 THEN umsatz_netto_fr
	 ELSE 0
       END AS umsatz_netto_tag6
      ,CASE
	 WHEN werbetyp_id IN (1,7,8,12,15)
	 THEN umsatz_netto_so
	 WHEN werbetyp_id IN (17)
	 THEN umsatz_netto_mo
	 WHEN werbetyp_id IN (6,11,20,23,24)
	 THEN umsatz_netto_di
	 WHEN werbetyp_id IN (4,5,21)
	 THEN umsatz_netto_mi
	 WHEN werbetyp_id IN (10,13,18,29)
	 THEN umsatz_netto_do
         WHEN werbetyp_id IN (9,16,30)
	 THEN umsatz_netto_fr
	 WHEN werbetyp_id IN (14,19)
	 THEN umsatz_netto_sa
	 ELSE 0
       END AS umsatz_netto_tag7
      ,we_menge
      ,COALESCE(min_sicherh_bestand,0) AS min_sicherh_bestand
      ,posten_id
      ,we_menge_ab_vorwoche AS we_menge_zentral
      ,faktor_flaki
      ,COALESCE(mutter_wb_id,art_id) AS mutter_wb_id
      ,wtag_id_start
      ,wtag_id_ende
      ,menge_historie_af
      ,case when anzahl_tage_aktion < anzahl_nullbestand then anzahl_tage_aktion else anzahl_nullbestand end as anzahl_nullbestand
      ,anzahl_tage_aktion
      ,COALESCE(menge_tag1_7bis13h,0)
      ,COALESCE(menge_nur_tag1,0)
      ,COALESCE(lager_prozent,0)
      ,COALESCE(mhd_zeitraum,0)
      ,COALESCE(sollbestand,0)
      ,COALESCE(menge_bestand_soll_max,0)
      ,0 AS werbenachvermarktung_fg
      ,COALESCE(bezugsweg_id,-1)
      ,we_menge_vor_aktion
      ,anzahl_nullbestand_tag1
      ,anzahl_nullbestand_tag1bis3
      ,anzahl_minusbestand
      ,anzahl_minusbestand_tag1
      ,anzahl_minusbestand_tag1bis3
      ,avq_relevant_fg
      ,x2.default_wrg as wrg_id
      ,anzahl_nullbestand_tag2
      ,anzahl_nullbestand_tag3
      ,anzahl_nullbestand_tag4
      ,anzahl_nullbestand_tag5
      ,anzahl_nullbestand_tag6
      ,anzahl_nullbestand_tag7
      ,vk_vor_aktion_brutto
      ,vk_aktion_brutto
      ,vk_kcard_brutto
      ,menge_sa2
      ,current_timestamp
      ,current_timestamp
FROM _ff_we_artbew3_kmo x1
JOIN dbp_data.mandant_1 x2
  ON x1.mandant_id = x2.mandant_id
GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,
         18,19,20,21,22,23,24,25,26,27,28,29,30,31,
         32,33,34,35,36,37,38,39,40,41,42,43,44,45,
         46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62
;

CREATE OR REPLACE VOLATILE TABLE _not_in1_kmo AS (
SELECT *
FROM _werbeartikel_1_kmo
WHERE (kjwo,wup_id,mandant_id,art_id,werbetyp_id) NOT IN (SELECT kjwo,wup_id,mandant_id,art_id,werbetyp_id FROM _ff_we_artbew2_kmo)
);

CREATE OR REPLACE VOLATILE TABLE _ff_we1_kmo_not_in AS (
SELECT a.mandant_id,
       a.kjwo,
	   a.dat_von,
	   a.dat_bis,
	   a.werbetyp_id,
       a.wup_id,
       a.art_id
FROM _not_in1_kmo a
JOIN dbp_data.art_wg_zu_per_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
);

CREATE OR REPLACE VOLATILE TABLE _ff_we2_kmo_not_in AS (
SELECT a.*,
       b.dat,
       b.dat-7 AS dat_2
FROM _ff_we1_kmo_not_in a
JOIN (SELECT a.kjwo,
             a.werbetyp_id,
             b.dat
      FROM _ff_we1_kmo_not_in a
	  JOIN dbp_data.tag_1 b
	    ON b.dat BETWEEN a.dat_von AND a.dat_bis
	  GROUP BY 1,2,3) b
  ON a.kjwo = b.kjwo AND
     a.werbetyp_id = b.werbetyp_id
);

CREATE OR REPLACE VOLATILE TABLE _ff_we3_kmo_not_in AS (
SELECT a.mandant_id,
       a.werbetyp_id,
	   a.dat_von,
	   a.dat_bis,
       a.kjwo,
       a.dat,
       a.wup_id,
       a.art_id,
       COALESCE(b.menge_lagerbew_bme, 0) AS we_menge,
       COALESCE(c.menge_lagerbew_bme, 0) AS we_menge_2
FROM _ff_we2_kmo_not_in a
LEFT JOIN (SELECT b.mandant_id,
                  c.werbetyp_id,
                  b.wup_id,
	              b.art_id,
	              b.dat_buch,
	              SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
           FROM dbp_data.lagerbew_1 a
           JOIN dbp_data.lagerbew_det_1 b
             ON a.mandant_id = b.mandant_id AND
	            a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	            a.dat_buch = b.dat_buch
           JOIN _ff_we2_kmo_not_in c
             ON b.mandant_id = c.mandant_id AND
                b.wup_id = c.wup_id AND
	            b.art_id = c.art_id AND
	            b.dat_buch = c.dat
		   JOIN dbp_data.art_wg_zu_per_1 x
		     ON b.mandant_id = x.mandant_id AND
			    b.art_id = x.art_id AND
				x.arthiertyp_id = 2 AND
				x.dat_bis = '9999-12-31'
           JOIN dbp_data.besch_best_1 c1
             ON b.mandant_id = c1.mandant_id AND
                b.best_beleg_id = c1.best_beleg_id
           JOIN dbp_data.besch_best_det_1 c2
             ON b.mandant_id = c2.mandant_id AND
                b.wup_id = c2.wup_id AND
	            c1.dat_best_beleg = c2.dat_best_beleg  AND
	            b.best_beleg_id = c2.best_beleg_id AND
	            b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	            b.art_id = c2.art_id
           WHERE a.vorgangsart_id IN ('WE','WL') AND
	             -- -dbay-, 25.05.2018
	             -- Nach der Migration der FWW-Verarbeitung greift die Anreicherung des Feldes
	             -- "betrag_einstandspreis" sehr oft ins Leere, sodass wir hier zwingend eine_1
	             -- Aenderung des Ausschlusskriteriums vorsehen und hart die Transitbestandsdaten 
	             -- rausfiltern muessen. Dies erfolgt ueber den Filter auf die Bewergungsarten.
	             -- b.betrag_einstandspreis IS NULL AND
	             b.lager_bewart_id NOT IN ('301', '302', '311', '312', '641', '642', '647', '648') AND
		         CASE
                   WHEN a.mandant_id IN (4) AND
                        c1.bestellart_id IN ('UBPX','UBP','UBP1','NBP','NBBG','UB2','UBE','NBCZ','NBPL','NBSK','NBHR','NBRO','UBGK','UBG1','UBG2','NZP','NZP1','NBMD','UBP0','ZUBZ')
                   THEN 1
                   WHEN a.mandant_id IN (2,3,5,6,7,8) AND
                        c1.bestellart_id IN ('UBPX','UBP','UBP1','NBP','NBBG','UB2','UBE','NBCZ','NBPL','NBSK','NBHR','NBRO','UBGK','UBG1','UBG2','NZP','NZP1','NBMD','UBP0')
                   THEN 1
                   ELSE 0
                 END = 1 AND
				 x.wg_id NOT IN (SELECT wg_id FROM dbp_data.wg_filter_zu_1 WHERE wg_filter_id = 26 AND mandant_id > 1) AND
                 a.mandant_id > 1 AND
				 a.dat_buch BETWEEN (SELECT MIN(dat_2)-7 FROM _ff_we2_kmo_not_in WHERE dat_2 IS NOT NULL) AND (SELECT MAX(dat) FROM _ff_we2_kmo_not_in WHERE dat IS NOT NULL)
           GROUP BY 1,2,3,4,5
		   UNION ALL
		   SELECT b.mandant_id,
                  c.werbetyp_id,
                  b.wup_id,
	              b.art_id,
	              b.dat_buch,
	              SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
           FROM dbp_data.lagerbew_1 a
           JOIN dbp_data.lagerbew_det_1 b
             ON a.mandant_id = b.mandant_id AND
	            a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	            a.dat_buch = b.dat_buch
           JOIN _ff_we2_kmo_not_in c
             ON b.mandant_id = c.mandant_id AND
                b.wup_id = c.wup_id AND
	            b.art_id = c.art_id AND
	            b.dat_buch = c.dat
		   JOIN dbp_data.art_wg_zu_per_1 x
		     ON b.mandant_id = x.mandant_id AND
			    b.art_id = x.art_id AND
				x.arthiertyp_id = 2 AND
				x.dat_bis = '9999-12-31'
           JOIN dbp_data.besch_best_1 c1
             ON b.mandant_id = c1.mandant_id AND
                b.best_beleg_id = c1.best_beleg_id
           JOIN dbp_data.besch_best_det_1 c2
             ON b.mandant_id = c2.mandant_id AND
                b.wup_id = c2.wup_id AND
	            c1.dat_best_beleg = c2.dat_best_beleg  AND
	            b.best_beleg_id = c2.best_beleg_id AND
	            b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	            b.art_id = c2.art_id
           WHERE a.vorgangsart_id IN ('WE','WL') AND
	             -- -dbay-, 25.05.2018
	             -- Nach der Migration der FWW-Verarbeitung greift die Anreicherung des Feldes
	             -- "betrag_einstandspreis" sehr oft ins Leere, sodass wir hier zwingend eine_1
	             -- Aenderung des Ausschlusskriteriums vorsehen und hart die Transitbestandsdaten 
	             -- rausfiltern muessen. Dies erfolgt ueber den Filter auf die Bewergungsarten.
	             -- b.betrag_einstandspreis IS NULL AND
	             b.lager_bewart_id NOT IN ('301', '302', '311', '312', '641', '642', '647', '648') AND
	             x.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu_1 WHERE wg_filter_id = 26 AND mandant_id > 1) AND
                 a.mandant_id > 1 AND
				 a.dat_buch BETWEEN (SELECT MIN(dat_2)-7 FROM _ff_we2_kmo_not_in WHERE dat_2 IS NOT NULL) AND (SELECT MAX(dat) FROM _ff_we2_kmo_not_in WHERE dat IS NOT NULL)
           GROUP BY 1,2,3,4,5) b
  ON a.mandant_id = b.mandant_id AND
     a.wup_id = b.wup_id AND
     a.art_id = b.art_id AND
     a.dat = b.dat_buch  AND
	 a.werbetyp_id = b.werbetyp_id
LEFT JOIN (SELECT b.mandant_id,
                  c.werbetyp_id,
                  b.wup_id,
	              b.art_id,
	              b.dat_buch,
	              SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
           FROM dbp_data.lagerbew_1 a
           JOIN dbp_data.lagerbew_det_1 b
             ON a.mandant_id = b.mandant_id AND
	            a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	            a.dat_buch = b.dat_buch
           JOIN _ff_we2_kmo_not_in c
             ON b.mandant_id = c.mandant_id AND
                b.wup_id = c.wup_id AND
	            b.art_id = c.art_id AND
	            b.dat_buch = c.dat_2
		   JOIN dbp_data.art_wg_zu_per_1 x
		     ON b.mandant_id = x.mandant_id AND
			    b.art_id = x.art_id AND
				x.arthiertyp_id = 2 AND
				x.dat_bis = '9999-12-31'
           JOIN dbp_data.besch_best_1 c1
             ON b.mandant_id = c1.mandant_id AND
                b.best_beleg_id = c1.best_beleg_id
           JOIN dbp_data.besch_best_det_1 c2
             ON b.mandant_id = c2.mandant_id AND
                b.wup_id = c2.wup_id AND
	            c1.dat_best_beleg = c2.dat_best_beleg  AND
	            b.best_beleg_id = c2.best_beleg_id AND
	            b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	            b.art_id = c2.art_id
           WHERE a.vorgangsart_id IN ('WE','WL') AND
	             -- -dbay-, 25.05.2018
	             -- Nach der Migration der FWW-Verarbeitung greift die Anreicherung des Feldes
	             -- "betrag_einstandspreis" sehr oft ins Leere, sodass wir hier zwingend eine_1
	             -- Aenderung des Ausschlusskriteriums vorsehen und hart die Transitbestandsdaten 
	             -- rausfiltern muessen. Dies erfolgt ueber den Filter auf die Bewergungsarten.
	             -- b.betrag_einstandspreis IS NULL AND
	             b.lager_bewart_id NOT IN ('301', '302', '311', '312', '641', '642', '647', '648') AND
		         CASE
                   WHEN a.mandant_id IN (4) AND
                        c1.bestellart_id IN ('UBPX','UBP','UBP1','NBP','NBBG','UB2','UBE','NBCZ','NBPL','NBSK','NBHR','NBRO','UBGK','UBG1','UBG2','NZP','NZP1','NBMD','UBP0','ZUBZ')
                   THEN 1
                   WHEN a.mandant_id IN (2,3,5,6,7,8) AND
                        c1.bestellart_id IN ('UBPX','UBP','UBP1','NBP','NBBG','UB2','UBE','NBCZ','NBPL','NBSK','NBHR','NBRO','UBGK','UBG1','UBG2','NZP','NZP1','NBMD','UBP0')
                   THEN 1
                   ELSE 0
                 END = 1 AND
				 x.wg_id NOT IN (SELECT wg_id FROM dbp_data.wg_filter_zu_1 WHERE wg_filter_id = 26 AND mandant_id > 1) AND
                 a.mandant_id > 1 AND
				 a.dat_buch BETWEEN (SELECT MIN(dat_2)-7 FROM _ff_we2_kmo_not_in WHERE dat_2 IS NOT NULL) AND (SELECT MAX(dat) FROM _ff_we2_kmo_not_in WHERE dat IS NOT NULL)
           GROUP BY 1,2,3,4,5
		   UNION ALL
		   SELECT b.mandant_id,
                  c.werbetyp_id,
                  b.wup_id,
	              b.art_id,
	              b.dat_buch,
	              SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
           FROM dbp_data.lagerbew_1 a
           JOIN dbp_data.lagerbew_det_1 b
             ON a.mandant_id = b.mandant_id AND
	            a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	            a.dat_buch = b.dat_buch
           JOIN _ff_we2_kmo_not_in c
             ON b.mandant_id = c.mandant_id AND
                b.wup_id = c.wup_id AND
	            b.art_id = c.art_id AND
	            b.dat_buch = c.dat_2
		   JOIN dbp_data.art_wg_zu_per_1 x
		     ON b.mandant_id = x.mandant_id AND
			    b.art_id = x.art_id AND
				x.arthiertyp_id = 2 AND
				x.dat_bis = '9999-12-31'
           JOIN dbp_data.besch_best_1 c1
             ON b.mandant_id = c1.mandant_id AND
                b.best_beleg_id = c1.best_beleg_id
           JOIN dbp_data.besch_best_det_1 c2
             ON b.mandant_id = c2.mandant_id AND
                b.wup_id = c2.wup_id AND
	            c1.dat_best_beleg = c2.dat_best_beleg  AND
	            b.best_beleg_id = c2.best_beleg_id AND
	            b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	            b.art_id = c2.art_id
           WHERE a.vorgangsart_id IN ('WE','WL') AND
	             -- -dbay-, 25.05.2018
	             -- Nach der Migration der FWW-Verarbeitung greift die Anreicherung des Feldes
	             -- "betrag_einstandspreis" sehr oft ins Leere, sodass wir hier zwingend eine_1
	             -- Aenderung des Ausschlusskriteriums vorsehen und hart die Transitbestandsdaten 
	             -- rausfiltern muessen. Dies erfolgt ueber den Filter auf die Bewergungsarten.
	             -- b.betrag_einstandspreis IS NULL AND
	             b.lager_bewart_id NOT IN ('301', '302', '311', '312', '641', '642', '647', '648') AND
	             x.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu_1 WHERE wg_filter_id = 26 AND mandant_id > 1) AND
                 a.mandant_id > 1 AND
				 a.dat_buch BETWEEN (SELECT MIN(dat_2)-7 FROM _ff_we2_kmo_not_in WHERE dat_2 IS NOT NULL) AND (SELECT MAX(dat) FROM _ff_we2_kmo_not_in WHERE dat IS NOT NULL)
           GROUP BY 1,2,3,4,5
		   UNION ALL
		   SELECT b.mandant_id,
                  c.werbetyp_id,
                  b.wup_id,
	              b.art_id,
	              b.dat_buch,
	              SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
           FROM dbp_data.lagerbew_1 a
           JOIN dbp_data.lagerbew_det_1 b
             ON a.mandant_id = b.mandant_id AND
	            a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	            a.dat_buch = b.dat_buch
           JOIN _ff_we2_kmo_not_in c
             ON b.mandant_id = c.mandant_id AND
                b.wup_id = c.wup_id AND
	            b.art_id = c.art_id AND
	            b.dat_buch = c.dat_2-7
		   JOIN dbp_data.art_wg_zu_per_1 x
		     ON b.mandant_id = x.mandant_id AND
			    b.art_id = x.art_id AND
				x.arthiertyp_id = 2 AND
				x.dat_bis = '9999-12-31'
           JOIN dbp_data.besch_best_1 c1
             ON b.mandant_id = c1.mandant_id AND
                b.best_beleg_id = c1.best_beleg_id
           JOIN dbp_data.besch_best_det_1 c2
             ON b.mandant_id = c2.mandant_id AND
                b.wup_id = c2.wup_id AND
	            c1.dat_best_beleg = c2.dat_best_beleg  AND
	            b.best_beleg_id = c2.best_beleg_id AND
	            b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	            b.art_id = c2.art_id
           WHERE a.vorgangsart_id IN ('WE','WL') AND
	             -- -dbay-, 25.05.2018
	             -- Nach der Migration der FWW-Verarbeitung greift die Anreicherung des Feldes
	             -- "betrag_einstandspreis" sehr oft ins Leere, sodass wir hier zwingend eine_1
	             -- Aenderung des Ausschlusskriteriums vorsehen und hart die Transitbestandsdaten 
	             -- rausfiltern muessen. Dies erfolgt ueber den Filter auf die Bewergungsarten.
	             -- b.betrag_einstandspreis IS NULL AND
	             b.lager_bewart_id NOT IN ('301', '302', '311', '312', '641', '642', '647', '648') AND
	            (x.mandant_id,x.wg_id) IN (SELECT mandant_id,wg_id FROM dbp_data.wg_filter_zu_1 WHERE wg_filter_id = 30 AND mandant_id > 1) AND
                 a.mandant_id > 1 AND
				 a.dat_buch BETWEEN (SELECT MIN(dat_2)-7 FROM _ff_we2_kmo_not_in WHERE dat_2 IS NOT NULL) AND (SELECT MAX(dat) FROM _ff_we2_kmo_not_in WHERE dat IS NOT NULL)
           GROUP BY 1,2,3,4,5) c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id AND
     a.art_id = c.art_id AND
     a.dat = c.dat_buch+7 AND
	 a.werbetyp_id = c.werbetyp_id
);

CREATE OR REPLACE VOLATILE TABLE _x_ray_kmo_not_in AS (
SELECT a.mandant_id,
       a.wup_id,
	   a.werbetyp_id,
	   b.kopf_art AS art_id,
	   a.dat,
	   a.dat_2
FROM (SELECT mandant_id,
             wup_id,
			 werbetyp_id,
             dat,
             dat_2
	  FROM _ff_we2_kmo_not_in
	  GROUP BY 1,2,3,4,5) a
JOIN (SELECT kopf_art
	  FROM _stpo_kmo
	  WHERE kopf_art NOT IN (SELECT art_id FROM _ff_we_artbew2_kmo)
	  GROUP BY 1) b
  ON 1 = 1
GROUP BY 1,2,3,4,5,6
);

CREATE OR REPLACE VOLATILE TABLE _help_me11_kmo AS (
SELECT mandant_id,
       dat
FROM _x_ray_kmo_not_in
GROUP BY 1,2
);

CREATE OR REPLACE VOLATILE TABLE _help_me22_kmo AS (
SELECT mandant_id,
       dat_2
FROM _x_ray_kmo_not_in
GROUP BY 1,2
);

create or replace volatile table _mseg_package_ekpo_not_in as (
select b.*
FROM dbp_data.lagerbew_1 a
JOIN dbp_data.lagerbew_det_1 b
  ON a.mandant_id = b.mandant_id AND
	 a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	 a.dat_buch = b.dat_buch
JOIN dbp_data.besch_best_1 c1
  ON b.mandant_id = c1.mandant_id AND
     b.best_beleg_id = c1.best_beleg_id
JOIN dbp_data.besch_best_det_1 c2
  ON b.mandant_id = c2.mandant_id AND
     b.wup_id = c2.wup_id AND
	 c1.dat_best_beleg = c2.dat_best_beleg  AND
	 b.best_beleg_id = c2.best_beleg_id AND
	 b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	 b.art_id = c2.art_id
WHERE a.vorgangsart_id IN ('WE','WL') AND
	  b.lager_bewart_id NOT IN ('301', '302', '311', '312', '641', '642', '647', '648') AND
	  CASE
        WHEN a.mandant_id IN (4) AND
             c1.bestellart_id IN ('UBPX','UBP','UBP1','NBP','NBBG','UB2','UBE','NBCZ','NBPL','NBSK','NBHR','NBRO','UBGK','UBG1','UBG2','NZP','NZP1','NBMD','UBP0','ZUBZ')
        THEN 1
        WHEN a.mandant_id IN (2,3,5,6,7,8) AND
             c1.bestellart_id IN ('UBPX','UBP','UBP1','NBP','NBBG','UB2','UBE','NBCZ','NBPL','NBSK','NBHR','NBRO','UBGK','UBG1','UBG2','NZP','NZP1','NBMD','UBP0')
        THEN 1
        ELSE 0
      END = 1 and
      a.dat_buch >= (select min(dat) from (select min(dat) as dat from _help_me11_kmo union SELECT min(dat_2) as dat FROM _help_me22_kmo)) and
      a.mandant_id > 1
);

create or replace volatile table _mseg_package_not_ekpo_not_in as (
select b.*
FROM dbp_data.lagerbew_1 a
JOIN dbp_data.lagerbew_det_1 b
  ON a.mandant_id = b.mandant_id AND
	 a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	 a.dat_buch = b.dat_buch
JOIN dbp_data.besch_best_1 c1
  ON b.mandant_id = c1.mandant_id AND
     b.best_beleg_id = c1.best_beleg_id
JOIN dbp_data.besch_best_det_1 c2
  ON b.mandant_id = c2.mandant_id AND
     b.wup_id = c2.wup_id AND
	 c1.dat_best_beleg = c2.dat_best_beleg  AND
	 b.best_beleg_id = c2.best_beleg_id AND
	 b.best_beleg_pos_id = c2.best_beleg_pos_id AND
	 b.art_id = c2.art_id
WHERE a.vorgangsart_id IN ('WE','WL') AND
	  b.lager_bewart_id NOT IN ('301', '302', '311', '312', '641', '642', '647', '648') AND
      a.dat_buch >= (select min(dat) from (select min(dat) as dat from _help_me11_kmo union SELECT min(dat_2) as dat FROM _help_me22_kmo)) and
      a.mandant_id > 1
);

CREATE OR REPLACE VOLATILE TABLE _x_track1_kmo_not_in AS (
SELECT a.mandant_id,
       c.werbetyp_id,
	   a.lagerbew_beleg_id,
       a.wup_id,
	   a.art_id,
	   a.dat_buch,
	   SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
FROM _mseg_package_ekpo_not_in a
JOIN _x_ray_kmo_not_in c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id AND
	 a.art_id = c.art_id AND
	 a.dat_buch = c.dat
JOIN dbp_data.art_wg_zu_per_1 x
  ON a.mandant_id = x.mandant_id AND
     a.art_id = x.art_id AND
     x.arthiertyp_id = 2 AND
     x.dat_bis = '9999-12-31'
WHERE x.wg_id NOT IN (SELECT wg_id FROM dbp_data.wg_filter_zu_1 WHERE wg_filter_id = 26 AND mandant_id > 1) AND
	 (a.mandant_id,a.dat_buch) IN (SELECT mandant_id,dat FROM _help_me11_kmo)
GROUP BY 1,2,3,4,5,6
UNION ALL
SELECT a.mandant_id,
       c.werbetyp_id,
	   a.lagerbew_beleg_id,
       a.wup_id,
	   a.art_id,
	   a.dat_buch,
	   SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
FROM _mseg_package_not_ekpo_not_in a
JOIN _x_ray_kmo_not_in c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id AND
	 a.art_id = c.art_id AND
	 a.dat_buch = c.dat
JOIN dbp_data.art_wg_zu_per_1 x
  ON a.mandant_id = x.mandant_id AND
     a.art_id = x.art_id AND
     x.arthiertyp_id = 2 AND
     x.dat_bis = '9999-12-31'
WHERE x.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu_1 WHERE wg_filter_id = 26 AND mandant_id > 1) AND
	 (a.mandant_id,a.dat_buch) IN (SELECT mandant_id,dat FROM _help_me11_kmo)
GROUP BY 1,2,3,4,5,6
);

CREATE OR REPLACE VOLATILE TABLE _x_track2_kmo_not_in AS (
SELECT a.mandant_id,
       c.werbetyp_id,
	   a.lagerbew_beleg_id,
       a.wup_id,
	   a.art_id,
	   a.dat_buch,
	   SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
FROM _mseg_package_ekpo_not_in a
JOIN _x_ray_kmo_not_in c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id AND
	 a.art_id = c.art_id AND
	 a.dat_buch = c.dat_2
JOIN dbp_data.art_wg_zu_per_1 x
  ON a.mandant_id = x.mandant_id AND
     a.art_id = x.art_id AND
     x.arthiertyp_id = 2 AND
     x.dat_bis = '9999-12-31'
WHERE x.wg_id NOT IN (SELECT wg_id FROM dbp_data.wg_filter_zu_1 WHERE wg_filter_id = 26 AND mandant_id > 1) AND
	 (a.mandant_id,a.dat_buch) IN (SELECT mandant_id,dat_2 FROM _help_me22_kmo)
GROUP BY 1,2,3,4,5,6
UNION ALL
SELECT a.mandant_id,
       c.werbetyp_id,
	   a.lagerbew_beleg_id,
       a.wup_id,
	   a.art_id,
	   a.dat_buch,
	   SUM(a.menge_lagerbew_bme) AS menge_lagerbew_bme
FROM _mseg_package_not_ekpo_not_in a
JOIN _x_ray_kmo_not_in c
  ON a.mandant_id = c.mandant_id AND
     a.wup_id = c.wup_id AND
	 a.art_id = c.art_id AND
	 a.dat_buch = c.dat_2
JOIN dbp_data.art_wg_zu_per_1 x
  ON a.mandant_id = x.mandant_id AND
     a.art_id = x.art_id AND
     x.arthiertyp_id = 2 AND
     x.dat_bis = '9999-12-31'
WHERE x.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu_1 WHERE wg_filter_id = 26 AND mandant_id > 1) AND
	 (a.mandant_id,a.dat_buch) IN (SELECT mandant_id,dat_2 FROM _help_me22_kmo)
GROUP BY 1,2,3,4,5,6
);

CREATE OR REPLACE VOLATILE TABLE _murks_display_not_in AS (
SELECT c.mandant_id,
       c.werbetyp_id,
       c.lagerbew_beleg_id,
       c.wup_id,
       b.art_id,
       c.dat_buch
FROM dbp_data.stueckliste_1 a
JOIN dbp_data.stueckliste_det_1 b
  ON a.mandant_id = b.mandant_id AND
     a.stueckliste_id = b.stueckliste_id
JOIN (SELECT mandant_id,
             werbetyp_id,
             lagerbew_beleg_id,
             wup_id,
             art_id,
             dat_buch
      FROM _x_track1_kmo_not_in
      GROUP BY 1,2,3,4,5,6
      UNION ALL
      SELECT mandant_id,
             werbetyp_id,
             lagerbew_beleg_id,
             wup_id,
             art_id,
             dat_buch
      FROM _x_track2_kmo_not_in
      GROUP BY 1,2,3,4,5,6) c
  ON a.mandant_id = c.mandant_id AND
     a.art_id = c.art_id
WHERE a.dat_bis = '9999-12-31'
GROUP BY 1,2,3,4,5,6
);

CREATE OR REPLACE VOLATILE TABLE _display_update_kmo_not_in AS (
SELECT b.mandant_id,
       c.werbetyp_id,
       b.wup_id,
       b.art_id,
       b.dat_buch,
       SUM(b.menge_lagerbew_bme) AS menge_lagerbew_bme
FROM dbp_data.lagerbew_1 a
JOIN dbp_data.lagerbew_det_1 b
  ON a.mandant_id = b.mandant_id AND
	 a.lagerbew_beleg_id = b.lagerbew_beleg_id AND
	 a.dat_buch = b.dat_buch
JOIN _murks_display_not_in c
  ON b.mandant_id = c.mandant_id AND
     b.wup_id = c.wup_id AND
	 b.art_id = c.art_id AND
	 b.dat_buch = c.dat_buch
WHERE a.vorgangsart_id IN ('WE','WL') AND  
      -- -dbay-, 25.05.2018
      -- Nach der Migration der FWW-Verarbeitung greift die Anreicherung des Feldes
      -- "betrag_einstandspreis" sehr oft ins Leere, sodass wir hier zwingend eine_1
      -- Aenderung des Ausschlusskriteriums vorsehen und hart die Transitbestandsdaten 
      -- rausfiltern muessen. Dies erfolgt ueber den Filter auf die Bewergungsarten.
      -- b.betrag_einstandspreis IS NULL AND
      b.lager_bewart_id NOT IN ('301', '302', '311', '312', '641', '642', '647', '648') AND
      a.dat_buch >= (SELECT MIN(dat_buch) FROM _murks_display_not_in)
GROUP BY 1,2,3,4,5
);

update _ff_we3_kmo_not_in 

set we_menge = b.menge_lagerbew_bme+_ff_we3_kmo_not_in.we_menge

from (select a.*
      from _display_update_kmo_not_in a
      join (select mandant_id,
                   werbetyp_id,
                   min(dat_von) as dat_von,
                   max(dat_bis) as dat_bis
            from _werbeartikel_1_kmo
            group by 1,2) b
        on a.mandant_id = b.mandant_id and
           a.werbetyp_id = b.werbetyp_id and
           a.dat_buch between b.dat_von and b.dat_bis) b
where _ff_we3_kmo_not_in.mandant_id = b.mandant_id and
      _ff_we3_kmo_not_in.wup_id = b.wup_id and
      _ff_we3_kmo_not_in.art_id = b.art_id and
      _ff_we3_kmo_not_in.werbetyp_id = b.werbetyp_id and
      _ff_we3_kmo_not_in.dat = b.dat_buch
;

update _ff_we3_kmo_not_in 

set we_menge_2 = b.menge_lagerbew_bme+_ff_we3_kmo_not_in.we_menge_2

from (select *
      from _display_update_kmo_not_in) b

where _ff_we3_kmo_not_in.mandant_id = b.mandant_id and
      _ff_we3_kmo_not_in.wup_id = b.wup_id and
      _ff_we3_kmo_not_in.art_id = b.art_id and
      _ff_we3_kmo_not_in.werbetyp_id = b.werbetyp_id and
      _ff_we3_kmo_not_in.dat = b.dat_buch+7
;

CREATE OR REPLACE VOLATILE TABLE _ff_we4_kmo_not_in AS (
SELECT a.kjwo,
       a.werbetyp_id,
	   a.dat_von,
	   a.dat_bis,
       a.wup_id,
       a.mandant_id,
       a.art_id,
       SUM(a.we_menge) AS we_menge,
       SUM(a.we_menge_2) AS we_menge_2,
       SUM(CAST(0 AS DECIMAL(18,3))) AS menge_aktionsstart
FROM _ff_we3_kmo_not_in a
GROUP BY 1,2,3,4,5,6,7
);

CREATE OR REPLACE VOLATILE TABLE _mbst_we1_kmo_not_in AS (
SELECT v.kjwo,
       v.werbetyp_id,
       v.dat_von,
       v.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       SUM(COALESCE(u.menge_lgbest_erp_frei_bme,0)) AS menge_aktionsstart
FROM _ff_we4_kmo_not_in v
JOIN (SELECT mandant_id,
             werbetyp_id,
             wup_id,
             art_id,
             dat_von-1 AS dat_von,
             kjwo
      FROM _werbeartikel_1_kmo
      GROUP BY 1,2,3,4,5,6) w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.werbetyp_id = w.werbetyp_id AND
    (v.kjwo = w.kjwo OR
     v.kjwo = w.kjwo-1)
LEFT JOIN dbp_data.marktbestand_erp_1 u
  ON w.mandant_id = u.mandant_id AND
     w.wup_id = u.wup_id AND
     w.art_id = u.art_id AND
     u.dat = w.dat_von 
GROUP BY 1,2,3,4,5,6,7
);

UPDATE _ff_we4_kmo_not_in 
SET menge_aktionsstart = b.menge_aktionsstart

FROM (SELECT *
      FROM _mbst_we1_kmo_not_in
      WHERE menge_aktionsstart <> 0) b
WHERE _ff_we4_kmo_not_in.mandant_id = b.mandant_id AND
      _ff_we4_kmo_not_in.wup_id = b.wup_id AND
      _ff_we4_kmo_not_in.art_id = b.art_id AND
      _ff_we4_kmo_not_in.kjwo = b.kjwo AND
      _ff_we4_kmo_not_in.werbetyp_id = b.werbetyp_id
;

CREATE OR REPLACE VOLATILE TABLE _ff_mutter_art_kmo_not_in AS (
SELECT a.mandant_id,
       a.art_id,
       COALESCE(a.mutter_wb_id,a.art_id) AS mutter_wb_id
FROM dbp_data.art_1 a
WHERE a.dat_bis = '9999-12-31' AND
     (a.mandant_id,a.art_id) IN (SELECT mandant_id,
	                                art_id
	                         FROM _not_in1_kmo
				 GROUP BY 1,2)
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _test_we_mbst1_kmo_not_in AS (
SELECT v.kjwo,
       v.werbetyp_id,
       v.dat_von,
       v.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       SUM(COALESCE(u.menge_lgbest_erp_frei_bme,0)) AS menge_endbestand
FROM _ff_we4_kmo_not_in v
JOIN (SELECT mandant_id,
             werbetyp_id,
             wup_id,
             art_id,
             dat_bis,
             kjwo
      FROM _werbeartikel_1_kmo
      GROUP BY 1,2,3,4,5,6) w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.werbetyp_id = w.werbetyp_id AND
    (v.kjwo = w.kjwo OR
     v.kjwo = w.kjwo-1)
LEFT JOIN dbp_data.marktbestand_erp_1 u
  ON w.mandant_id = u.mandant_id AND
     w.wup_id = u.wup_id AND
     w.art_id = u.art_id AND
     u.dat = w.dat_bis AND
     u.menge_lgbest_erp_frei_bme >= 0
GROUP BY 1,2,3,4,5,6,7
);

CREATE OR REPLACE VOLATILE TABLE _ff_we5_kmo_not_in AS (
SELECT a.kjwo,
       a.werbetyp_id,
       a.dat_von,
       a.dat_bis,
       a.mandant_id,
       a.wup_id,
       a.art_id,
       SUM(a.we_menge) AS we_menge,
       SUM(a.we_menge_2) AS we_menge_ab_vorwoche,
       SUM(a.menge_aktionsstart) AS menge_aktionsstart,
       SUM(b.menge_endbestand) AS menge_endbestand
FROM _ff_we4_kmo_not_in a
JOIN _test_we_mbst1_kmo_not_in b
  ON a.mandant_id = b.mandant_id AND
     a.kjwo = b.kjwo AND
     a.wup_id = b.wup_id AND
     a.art_id = b.art_id AND
	 a.werbetyp_id = b.werbetyp_id
GROUP BY 1,2,3,4,5,6,7
);

CREATE OR REPLACE VOLATILE TABLE _test_we_mbst2_kmo_not_in AS (
SELECT v.kjwo,
       v.werbetyp_id,
       v.dat_von,
       v.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       SUM(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme = 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000 THEN 1
             ELSE 0
           END) AS anz_tage_null,
       SUM(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme < 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             ELSE 0
           END) AS anz_tage_minus
FROM _ff_we4_kmo_not_in v
JOIN (SELECT a.mandant_id,
             a.werbetyp_id,
             a.wup_id,
             a.art_id,
             a.dat_von,
             a.dat_bis,
             b.dat,
             a.kjwo
      FROM _werbeartikel_1_kmo a
      JOIN dbp_data.tag_1 b
        ON b.dat BETWEEN a.dat_von AND a.dat_bis
      GROUP BY 1,2,3,4,5,6,7,8) w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.werbetyp_id = w.werbetyp_id AND
    (v.kjwo = w.kjwo OR
     v.kjwo = w.kjwo-1)
JOIN dbp_data.art_1 xx
  ON v.mandant_id = xx.mandant_id AND
     v.art_id = xx.art_id
LEFT JOIN dbp_data.marktbestand_erp_1 x
  ON w.mandant_id = x.mandant_id AND
     w.wup_id = x.wup_id AND
     w.art_id = x.art_id AND
     w.dat = x.dat and
     x.dat < current_date
GROUP BY 1,2,3,4,5,6,7
);

CREATE OR REPLACE VOLATILE TABLE _test_we_mbst2a_kmo_not_in AS (
SELECT v.kjwo,
       v.werbetyp_id,
       v.dat_von,
       v.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       MAX(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme = 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000 THEN 1
             ELSE 0
           END) AS anz_null_tag1,
       0 as anz_null_tag2,
       0 as anz_null_tag3,
       0 as anz_null_tag4,
       0 as anz_null_tag5,
       0 as anz_null_tag6,
       0 as anz_null_tag7,
       MAX(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme < 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             ELSE 0
           END) AS anz_minus_tag1
FROM _ff_we4_kmo_not_in v
JOIN (SELECT a.mandant_id,
             a.werbetyp_id,
             a.wup_id,
             a.art_id,
             a.dat_von,
             a.dat_bis,
             b.dat,
             a.kjwo
      FROM _werbeartikel_1_kmo a
      JOIN dbp_data.tag_1 b
        ON b.dat = a.dat_von
      GROUP BY 1,2,3,4,5,6,7,8) w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.werbetyp_id = w.werbetyp_id AND
    (v.kjwo = w.kjwo OR
     v.kjwo = w.kjwo-1)
JOIN dbp_data.art_1 xx
  ON v.mandant_id = xx.mandant_id AND
     v.art_id = xx.art_id
LEFT JOIN dbp_data.marktbestand_erp_1 x
  ON w.mandant_id = x.mandant_id AND
     w.wup_id = x.wup_id AND
     w.art_id = x.art_id AND
     w.dat = x.dat and
     x.dat < current_date
GROUP BY 1,2,3,4,5,6,7
);

-- Anzahl Nullbestand Tag_1 2

update _test_we_mbst2a_kmo_not_in from (select a.mandant_id,
                                    a.wup_id,
                                    a.art_id,
                                    a.dat,
                                    w.dat_von,
                                    w.dat_bis,
                                    w.werbetyp_id,
                                    max(case
                                          when xx.gewart_id  = 'ST' and a.menge_lgbest_erp_frei_bme = 0 then 1
                                          WHEN xx.gewart_id  = 'KG' and a.menge_lgbest_erp_frei_bme between 0.000 and 0.090 then 1
                                          WHEN xx.gewart_id  = 'G'  and a.menge_lgbest_erp_frei_bme between 0.000 and 90.000 then 1
                                          else 0
                                        end) as anz_null_tag2
                             from dbp_data.marktbestand_erp_1 a
                             join (select a.mandant_id,
                                          a.werbetyp_id,
                                          a.wup_id,
                                          a.art_id,
                                          a.dat_von,
                                          a.dat_bis,
                                          b.dat
                                   from _werbeartikel_1_kmo a
                                   join dbp_data.tag_1 b
                                     on b.dat = a.dat_von+1 and
                                        b.dat <= a.dat_bis
                                   group by 1,2,3,4,5,6,7) w
                               on w.mandant_id = a.mandant_id and
                                  w.wup_id = a.wup_id and
                                  w.art_id = a.art_id and
                                  w.dat = a.dat and
                                  a.dat < current_date
                             join dbp_data.art_1 xx
                               on w.mandant_id = xx.mandant_id and
                                  w.art_id = xx.art_id
                             group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag2 = b.anz_null_tag2

where _test_we_mbst2a_kmo_not_in.mandant_id = b.mandant_id and
      _test_we_mbst2a_kmo_not_in.wup_id = b.wup_id and
      _test_we_mbst2a_kmo_not_in.art_id = b.art_id and
      _test_we_mbst2a_kmo_not_in.dat_von = b.dat_von and
      _test_we_mbst2a_kmo_not_in.dat_bis = b.dat_bis and
      _test_we_mbst2a_kmo_not_in.werbetyp_id = b.werbetyp_id
;

-- Anzahl Nullbestand Tag_1 3

update _test_we_mbst2a_kmo_not_in from (select a.mandant_id,
                                    a.wup_id,
                                    a.art_id,
                                    a.dat,
                                    w.dat_von,
                                    w.dat_bis,
                                    w.werbetyp_id,
                                    max(case
                                          when xx.gewart_id  = 'ST' and a.menge_lgbest_erp_frei_bme = 0 then 1
                                          WHEN xx.gewart_id  = 'KG' and a.menge_lgbest_erp_frei_bme between 0.000 and 0.090 then 1
                                          WHEN xx.gewart_id  = 'G'  and a.menge_lgbest_erp_frei_bme between 0.000 and 90.000 then 1
                                          else 0
                                        end) as anz_null_tag3
                             from dbp_data.marktbestand_erp_1 a
                             join (select a.mandant_id,
                                          a.werbetyp_id,
                                          a.wup_id,
                                          a.art_id,
                                          a.dat_von,
                                          a.dat_bis,
                                          b.dat
                                   from _werbeartikel_1_kmo a
                                   join dbp_data.tag_1 b
                                     on b.dat = a.dat_von+2 and
                                        b.dat <= a.dat_bis
                                   group by 1,2,3,4,5,6,7) w
                               on w.mandant_id = a.mandant_id and
                                  w.wup_id = a.wup_id and
                                  w.art_id = a.art_id and
                                  w.dat = a.dat and
                                  a.dat < current_date
                             join dbp_data.art_1 xx
                               on w.mandant_id = xx.mandant_id and
                                  w.art_id = xx.art_id
                             group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag3 = b.anz_null_tag3

where _test_we_mbst2a_kmo_not_in.mandant_id = b.mandant_id and
      _test_we_mbst2a_kmo_not_in.wup_id = b.wup_id and
      _test_we_mbst2a_kmo_not_in.art_id = b.art_id and
      _test_we_mbst2a_kmo_not_in.dat_von = b.dat_von and
      _test_we_mbst2a_kmo_not_in.dat_bis = b.dat_bis and
      _test_we_mbst2a_kmo_not_in.werbetyp_id = b.werbetyp_id
;

-- Anzahl Nullbestand Tag_1 4

update _test_we_mbst2a_kmo_not_in from (select a.mandant_id,
                                    a.wup_id,
                                    a.art_id,
                                    a.dat,
                                    w.dat_von,
                                    w.dat_bis,
                                    w.werbetyp_id,
                                    max(case
                                          when xx.gewart_id  = 'ST' and a.menge_lgbest_erp_frei_bme = 0 then 1
                                          WHEN xx.gewart_id  = 'KG' and a.menge_lgbest_erp_frei_bme between 0.000 and 0.090 then 1
                                          WHEN xx.gewart_id  = 'G'  and a.menge_lgbest_erp_frei_bme between 0.000 and 90.000 then 1
                                          else 0
                                        end) as anz_null_tag4
                             from dbp_data.marktbestand_erp_1 a
                             join (select a.mandant_id,
                                          a.werbetyp_id,
                                          a.wup_id,
                                          a.art_id,
                                          a.dat_von,
                                          a.dat_bis,
                                          b.dat
                                   from _werbeartikel_1_kmo a
                                   join dbp_data.tag_1 b
                                     on b.dat = a.dat_von+3 and
                                        b.dat <= a.dat_bis
                                   group by 1,2,3,4,5,6,7) w
                               on w.mandant_id = a.mandant_id and
                                  w.wup_id = a.wup_id and
                                  w.art_id = a.art_id and
                                  w.dat = a.dat and
                                  a.dat < current_date
                             join dbp_data.art_1 xx
                               on w.mandant_id = xx.mandant_id and
                                  w.art_id = xx.art_id
                             group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag4 = b.anz_null_tag4

where _test_we_mbst2a_kmo_not_in.mandant_id = b.mandant_id and
      _test_we_mbst2a_kmo_not_in.wup_id = b.wup_id and
      _test_we_mbst2a_kmo_not_in.art_id = b.art_id and
      _test_we_mbst2a_kmo_not_in.dat_von = b.dat_von and
      _test_we_mbst2a_kmo_not_in.dat_bis = b.dat_bis and
      _test_we_mbst2a_kmo_not_in.werbetyp_id = b.werbetyp_id
;

-- Anzahl Nullbestand Tag_1 5

update _test_we_mbst2a_kmo_not_in from (select a.mandant_id,
                                    a.wup_id,
                                    a.art_id,
                                    a.dat,
                                    w.dat_von,
                                    w.dat_bis,
                                    w.werbetyp_id,
                                    max(case
                                          when xx.gewart_id  = 'ST' and a.menge_lgbest_erp_frei_bme = 0 then 1
                                          WHEN xx.gewart_id  = 'KG' and a.menge_lgbest_erp_frei_bme between 0.000 and 0.090 then 1
                                          WHEN xx.gewart_id  = 'G'  and a.menge_lgbest_erp_frei_bme between 0.000 and 90.000 then 1
                                          else 0
                                        end) as anz_null_tag5
                             from dbp_data.marktbestand_erp_1 a
                             join (select a.mandant_id,
                                          a.werbetyp_id,
                                          a.wup_id,
                                          a.art_id,
                                          a.dat_von,
                                          a.dat_bis,
                                          b.dat
                                   from _werbeartikel_1_kmo a
                                   join dbp_data.tag_1 b
                                     on b.dat = a.dat_von+4 and
                                        b.dat <= a.dat_bis
                                   group by 1,2,3,4,5,6,7) w
                               on w.mandant_id = a.mandant_id and
                                  w.wup_id = a.wup_id and
                                  w.art_id = a.art_id and
                                  w.dat = a.dat and
                                  a.dat < current_date
                             join dbp_data.art_1 xx
                               on w.mandant_id = xx.mandant_id and
                                  w.art_id = xx.art_id
                             group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag5 = b.anz_null_tag5

where _test_we_mbst2a_kmo_not_in.mandant_id = b.mandant_id and
      _test_we_mbst2a_kmo_not_in.wup_id = b.wup_id and
      _test_we_mbst2a_kmo_not_in.art_id = b.art_id and
      _test_we_mbst2a_kmo_not_in.dat_von = b.dat_von and
      _test_we_mbst2a_kmo_not_in.dat_bis = b.dat_bis and
      _test_we_mbst2a_kmo_not_in.werbetyp_id = b.werbetyp_id
;

-- Anzahl Nullbestand Tag_1 6

update _test_we_mbst2a_kmo_not_in from (select a.mandant_id,
                                    a.wup_id,
                                    a.art_id,
                                    a.dat,
                                    w.dat_von,
                                    w.dat_bis,
                                    w.werbetyp_id,
                                    max(case
                                          when xx.gewart_id  = 'ST' and a.menge_lgbest_erp_frei_bme = 0 then 1
                                          WHEN xx.gewart_id  = 'KG' and a.menge_lgbest_erp_frei_bme between 0.000 and 0.090 then 1
                                          WHEN xx.gewart_id  = 'G'  and a.menge_lgbest_erp_frei_bme between 0.000 and 90.000 then 1
                                          else 0
                                        end) as anz_null_tag6
                             from dbp_data.marktbestand_erp_1 a
                             join (select a.mandant_id,
                                          a.werbetyp_id,
                                          a.wup_id,
                                          a.art_id,
                                          a.dat_von,
                                          a.dat_bis,
                                          b.dat
                                   from _werbeartikel_1_kmo a
                                   join dbp_data.tag_1 b
                                     on b.dat = a.dat_von+5 and
                                        b.dat <= a.dat_bis
                                   group by 1,2,3,4,5,6,7) w
                               on w.mandant_id = a.mandant_id and
                                  w.wup_id = a.wup_id and
                                  w.art_id = a.art_id and
                                  w.dat = a.dat and
                                  a.dat < current_date
                             join dbp_data.art_1 xx
                               on w.mandant_id = xx.mandant_id and
                                  w.art_id = xx.art_id
                             group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag6 = b.anz_null_tag6

where _test_we_mbst2a_kmo_not_in.mandant_id = b.mandant_id and
      _test_we_mbst2a_kmo_not_in.wup_id = b.wup_id and
      _test_we_mbst2a_kmo_not_in.art_id = b.art_id and
      _test_we_mbst2a_kmo_not_in.dat_von = b.dat_von and
      _test_we_mbst2a_kmo_not_in.dat_bis = b.dat_bis and
      _test_we_mbst2a_kmo_not_in.werbetyp_id = b.werbetyp_id
;

-- Anzahl Nullbestand Tag_1 7

update _test_we_mbst2a_kmo_not_in from (select a.mandant_id,
                                    a.wup_id,
                                    a.art_id,
                                    a.dat,
                                    w.dat_von,
                                    w.dat_bis,
                                    w.werbetyp_id,
                                    max(case
                                          when xx.gewart_id  = 'ST' and a.menge_lgbest_erp_frei_bme = 0 then 1
                                          WHEN xx.gewart_id  = 'KG' and a.menge_lgbest_erp_frei_bme between 0.000 and 0.090 then 1
                                          WHEN xx.gewart_id  = 'G'  and a.menge_lgbest_erp_frei_bme between 0.000 and 90.000 then 1
                                          else 0
                                        end) as anz_null_tag7
                             from dbp_data.marktbestand_erp_1 a
                             join (select a.mandant_id,
                                          a.werbetyp_id,
                                          a.wup_id,
                                          a.art_id,
                                          a.dat_von,
                                          a.dat_bis,
                                          b.dat
                                   from _werbeartikel_1_kmo a
                                   join dbp_data.tag_1 b
                                     on b.dat = a.dat_von+6 and
                                        b.dat <= a.dat_bis
                                   group by 1,2,3,4,5,6,7) w
                               on w.mandant_id = a.mandant_id and
                                  w.wup_id = a.wup_id and
                                  w.art_id = a.art_id and
                                  w.dat = a.dat and
                                  a.dat < current_date
                             join dbp_data.art_1 xx
                               on w.mandant_id = xx.mandant_id and
                                  w.art_id = xx.art_id
                             group by 1,2,3,4,5,6,7) b
                                 
set anz_null_tag7 = b.anz_null_tag7

where _test_we_mbst2a_kmo_not_in.mandant_id = b.mandant_id and
      _test_we_mbst2a_kmo_not_in.wup_id = b.wup_id and
      _test_we_mbst2a_kmo_not_in.art_id = b.art_id and
      _test_we_mbst2a_kmo_not_in.dat_von = b.dat_von and
      _test_we_mbst2a_kmo_not_in.dat_bis = b.dat_bis and
      _test_we_mbst2a_kmo_not_in.werbetyp_id = b.werbetyp_id
;

CREATE OR REPLACE VOLATILE TABLE _test_we_mbst2b_kmo_not_in AS (
SELECT v.kjwo,
       v.werbetyp_id,
       v.dat_von,
       v.dat_bis,
       v.wup_id,
       v.mandant_id,
       v.art_id,
       SUM(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme = 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 0.090 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme BETWEEN 0.000 AND 90.000 THEN 1
             ELSE 0
           END) AS anz_null_tag1_bis_tag3,
       SUM(CASE
             WHEN xx.gewart_id  = 'ST' AND x.menge_lgbest_erp_frei_bme < 0 THEN 1
             WHEN xx.gewart_id  = 'KG' AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             WHEN xx.gewart_id  = 'G'  AND x.menge_lgbest_erp_frei_bme < 0.000 THEN 1
             ELSE 0
           END) AS anz_minus_tag1_bis_tag3
FROM _ff_we4_kmo_not_in v
JOIN (SELECT a.mandant_id,
             a.werbetyp_id,
             a.wup_id,
             a.art_id,
             a.dat_von,
             a.dat_bis,
             b.dat,
             a.kjwo
      FROM _werbeartikel_1_kmo a
      JOIN dbp_data.tag_1 b
        ON b.dat BETWEEN a.dat_von AND a.dat_bis AND
           b.dat BETWEEN a.dat_von AND a.dat_von+2
      GROUP BY 1,2,3,4,5,6,7,8) w
  ON v.mandant_id = w.mandant_id AND
     v.wup_id = w.wup_id AND
     v.art_id = w.art_id AND
     v.werbetyp_id = w.werbetyp_id AND
    (v.kjwo = w.kjwo OR
     v.kjwo = w.kjwo-1)
JOIN dbp_data.art_1 xx
  ON v.mandant_id = xx.mandant_id AND
     v.art_id = xx.art_id
LEFT JOIN dbp_data.marktbestand_erp_1 x
  ON w.mandant_id = x.mandant_id AND
     w.wup_id = x.wup_id AND
     w.art_id = x.art_id AND
     w.dat = x.dat and
     x.dat < current_date
GROUP BY 1,2,3,4,5,6,7
);

CREATE OR REPLACE VOLATILE TABLE _ff_we_artbew1_kmo_not_in LIKE _ff_we_artbew1_kmo;
                    
INSERT INTO _ff_we_artbew1_kmo_not_in (kjwo
                                      ,werbetyp_id
                                      ,dat_von
                                      ,dat_bis
                                      ,wup_id
                                      ,mandant_id
                                      ,art_id
                                      ,nb_id
                                      ,posten_id
                                      ,umsatz_netto_mo
                                      ,umsatz_netto_di
                                      ,umsatz_netto_mi
                                      ,umsatz_netto_do
                                      ,umsatz_netto_fr
                                      ,umsatz_netto_sa
                                      ,umsatz_netto_so
                                      ,umsatz_netto_wo
                                      ,menge_mo
                                      ,menge_di
                                      ,menge_mi
                                      ,menge_do
                                      ,menge_fr
                                      ,menge_sa
                                      ,menge_so
                                      ,menge_wo
                                      ,tage_menge_0
                                      ,we_menge
                                      ,menge_aktionsstart
                                      ,we_menge_ab_vorwoche
                                      ,menge_endbestand
                                      ,min_sicherh_bestand
                                      ,faktor_flaki
                                      ,anzahl_nullbestand
                                      ,anzahl_tage_aktion
                                      ,menge_historie_af
                                      ,sollbestand
                                      ,menge_tag1_7bis13h
                                      ,menge_nur_tag1
                                      ,lager_prozent
                                      ,mhd_zeitraum
                                      ,menge_bestand_soll_max
                                      ,bezugsweg_id
                                      ,we_menge_vor_aktion
                                      ,anzahl_nullbestand_tag1
                                      ,anzahl_nullbestand_tag1bis3
                                      ,anzahl_nullbestand_tag2
                                      ,anzahl_nullbestand_tag3
                                      ,anzahl_nullbestand_tag4
                                      ,anzahl_nullbestand_tag5
                                      ,anzahl_nullbestand_tag6
                                      ,anzahl_nullbestand_tag7)
SELECT kjwo
      ,werbetyp_id
      ,dat_von
      ,dat_bis
      ,wup_id
      ,mandant_id
      ,art_id
      ,0 AS nb_id
      ,'' AS posten_id
      ,0 AS umsatz_netto_mo
      ,0 AS umsatz_netto_di
      ,0 AS umsatz_netto_mi
      ,0 AS umsatz_netto_do
      ,0 AS umsatz_netto_fr
      ,0 AS umsatz_netto_sa
      ,0 AS umsatz_netto_so
      ,0 AS umsatz_netto_wo
      ,0 AS menge_mo
      ,0 AS menge_di
      ,0 AS menge_mi
      ,0 AS menge_do
      ,0 AS menge_fr
      ,0 AS menge_sa
      ,0 AS menge_so
      ,0 AS menge_wo
      ,7 AS tage_menge_0
      ,0 AS we_menge
      ,0 AS menge_aktionsstart
      ,0 AS we_menge_ab_vorwoche
      ,0 AS menge_endbestand
      ,0 AS min_sicherh_bestand
      ,1 AS faktor_flaki
      ,0 AS anzahl_nullbestand
      ,0 AS anzahl_tage_aktion
      ,0 AS menge_historie_af
      ,0 AS sollbestand
      ,0 AS menge_tag1_7bis13h
      ,0 AS menge_nur_tag1
      ,0 AS lager_prozent
      ,0 AS mhd_zeitraum
      ,0 AS menge_bestand_soll_max
      ,-1 AS bezugsweg_id
      ,0 AS we_menge_vor_aktion
      ,0 AS anzahl_nullbestand_tag1
      ,0 AS anzahl_nullbestand_tag1bis3
      ,0 AS anzahl_nullbestand_tag2
      ,0 AS anzahl_nullbestand_tag3
      ,0 AS anzahl_nullbestand_tag4
      ,0 AS anzahl_nullbestand_tag5
      ,0 AS anzahl_nullbestand_tag6
      ,0 AS anzahl_nullbestand_tag7
FROM _not_in1_kmo
;

UPDATE _ff_we_artbew1_kmo_not_in
 
SET we_menge = b.we_menge,
    we_menge_ab_vorwoche = b.we_menge_ab_vorwoche,
    we_menge_vor_aktion = b.we_menge_vor_aktion,
    bezugsweg_id = b.bezugsweg_id,
    menge_aktionsstart = b.menge_aktionsstart,
    menge_endbestand = b.menge_endbestand,
    min_sicherh_bestand = b.min_sicherh_bestand,
    sollbestand = b.sollbestand

FROM (SELECT a.kjwo,
             a.werbetyp_id,
             MIN(a.dat_von) AS dat_von,
             MAX(a.dat_bis) AS dat_bis,
             a.mandant_id,
             a.wup_id,
             a.art_id,
             MAX(a.we_menge) AS we_menge,
             MAX(a.we_menge_ab_vorwoche) AS we_menge_ab_vorwoche,
             MAX(a.we_menge_ab_vorwoche) AS we_menge_vor_aktion,
             MAX(a.menge_aktionsstart) AS menge_aktionsstart,
             MAX(a.menge_endbestand) AS menge_endbestand,
             MAX(f.min_sicherh_bestand) AS min_sicherh_bestand,
             MAX(f.sollbestand) AS sollbestand,
             MAX(f.bezugsweg_id) AS bezugsweg_id
      FROM _ff_we5_kmo_not_in a
      LEFT JOIN dbp_data.art_wup_status_per_1 f
        ON a.mandant_id = f.mandant_id AND
           a.wup_id = f.wup_id AND
           a.art_id = f.art_id AND
           f.dat_bis = '9999-12-31'
      GROUP BY 1,2,5,6,7) b

WHERE _ff_we_artbew1_kmo_not_in.mandant_id = b.mandant_id AND
      _ff_we_artbew1_kmo_not_in.wup_id = b.wup_id AND
      _ff_we_artbew1_kmo_not_in.art_id = b.art_id AND
      _ff_we_artbew1_kmo_not_in.kjwo = b.kjwo AND
      _ff_we_artbew1_kmo_not_in.werbetyp_id = b.werbetyp_id
;

UPDATE _ff_we_artbew1_kmo_not_in 

SET mhd_zeitraum = b.mhd_zeitraum,
    lager_prozent = b.lager_prozent

FROM (SELECT a.kjwo,
             a.werbetyp_id,
             MIN(a.dat_von) AS dat_von,
             MAX(a.dat_bis) AS dat_bis,
             a.mandant_id,
             a.wup_id,
             a.art_id,
             MAX(f.mhd_zeitraum) AS mhd_zeitraum,
             MAX(f.lager_prozent) AS lager_prozent
      FROM _ff_we5_kmo_not_in a
      LEFT JOIN dbp_data.art_1 f
        ON a.mandant_id = f.mandant_id AND
           a.art_id = f.art_id
      GROUP BY 1,2,5,6,7) b

WHERE _ff_we_artbew1_kmo_not_in.mandant_id = b.mandant_id AND
      _ff_we_artbew1_kmo_not_in.wup_id = b.wup_id AND
      _ff_we_artbew1_kmo_not_in.art_id = b.art_id AND
      _ff_we_artbew1_kmo_not_in.kjwo = b.kjwo AND
      _ff_we_artbew1_kmo_not_in.werbetyp_id = b.werbetyp_id
;

UPDATE _ff_we_artbew1_kmo_not_in
 
SET menge_bestand_soll_max = b.menge_bestand_soll_max

FROM (SELECT a.kjwo,
             a.werbetyp_id,
             MIN(a.dat_von) AS dat_von,
             MAX(a.dat_bis) AS dat_bis,
             a.mandant_id,
             a.wup_id,
             a.art_id,
             MAX(f.menge_bestand_soll_max) AS menge_bestand_soll_max
      FROM _ff_we5_kmo_not_in a
      LEFT JOIN dbp_data.art_wup_nachschub_per_1 f
        ON a.mandant_id = f.mandant_id AND
           a.wup_id = f.wup_id AND
           a.art_id = f.art_id AND
           f.dat_bis = '9999-12-31'
      GROUP BY 1,2,5,6,7) b

WHERE _ff_we_artbew1_kmo_not_in.mandant_id = b.mandant_id AND
      _ff_we_artbew1_kmo_not_in.wup_id = b.wup_id AND
      _ff_we_artbew1_kmo_not_in.art_id = b.art_id AND
      _ff_we_artbew1_kmo_not_in.kjwo = b.kjwo AND
      _ff_we_artbew1_kmo_not_in.werbetyp_id = b.werbetyp_id
;

UPDATE _ff_we_artbew1_kmo_not_in 

SET anzahl_nullbestand = b.anz_tage_null,
    anzahl_minusbestand = b.anz_tage_minus

FROM (SELECT kjwo,
             werbetyp_id,
             wup_id,
             mandant_id,
             art_id,
             MIN(dat_von) AS dat_von,
             MAX(dat_bis) AS dat_bis,
             MAX(anz_tage_null) AS anz_tage_null,
             MAX(anz_tage_minus) AS anz_tage_minus
      FROM _test_we_mbst2_kmo_not_in
      GROUP BY 1,2,3,4,5) b

WHERE _ff_we_artbew1_kmo_not_in.mandant_id = b.mandant_id AND
      _ff_we_artbew1_kmo_not_in.wup_id = b.wup_id AND
      _ff_we_artbew1_kmo_not_in.art_id = b.art_id AND
      _ff_we_artbew1_kmo_not_in.kjwo = b.kjwo AND
      _ff_we_artbew1_kmo_not_in.werbetyp_id = b.werbetyp_id
;

UPDATE _ff_we_artbew1_kmo_not_in 

SET anzahl_nullbestand_tag1 = b.anz_null_tag1,
    anzahl_minusbestand_tag1 = b.anz_minus_tag1,
    anzahl_nullbestand_tag2 = b.anz_null_tag2,
    anzahl_nullbestand_tag3 = b.anz_null_tag3,
    anzahl_nullbestand_tag4 = b.anz_null_tag4,
    anzahl_nullbestand_tag5 = b.anz_null_tag5,
    anzahl_nullbestand_tag6 = b.anz_null_tag6,
    anzahl_nullbestand_tag7 = b.anz_null_tag7

FROM (SELECT kjwo,
             werbetyp_id,
             wup_id,
             mandant_id,
             art_id,
             MIN(dat_von) AS dat_von,
             MAX(dat_bis) AS dat_bis,
             MAX(anz_null_tag1) AS anz_null_tag1,
             MAX(anz_minus_tag1) AS anz_minus_tag1,
             MAX(anz_null_tag2) AS anz_null_tag2,
             MAX(anz_null_tag3) AS anz_null_tag3,
             MAX(anz_null_tag4) AS anz_null_tag4,
             MAX(anz_null_tag5) AS anz_null_tag5,
             MAX(anz_null_tag6) AS anz_null_tag6,
             MAX(anz_null_tag7) AS anz_null_tag7
      FROM _test_we_mbst2a_kmo_not_in
      GROUP BY 1,2,3,4,5) b

WHERE _ff_we_artbew1_kmo_not_in.mandant_id = b.mandant_id AND
      _ff_we_artbew1_kmo_not_in.wup_id = b.wup_id AND
      _ff_we_artbew1_kmo_not_in.art_id = b.art_id AND
      _ff_we_artbew1_kmo_not_in.kjwo = b.kjwo AND
      _ff_we_artbew1_kmo_not_in.werbetyp_id = b.werbetyp_id
;

UPDATE _ff_we_artbew1_kmo_not_in 

SET anzahl_nullbestand_tag1bis3 = b.anz_null_tag1_bis_tag3,
    anzahl_minusbestand_tag1bis3 = b.anz_minus_tag1_bis_tag3

FROM (SELECT kjwo,
             werbetyp_id,
             wup_id,
             mandant_id,
             art_id,
             MIN(dat_von) AS dat_von,
             MAX(dat_bis) AS dat_bis,
             MAX(anz_null_tag1_bis_tag3) AS anz_null_tag1_bis_tag3,
             MAX(anz_minus_tag1_bis_tag3) AS anz_minus_tag1_bis_tag3
      FROM _test_we_mbst2b_kmo_not_in
      GROUP BY 1,2,3,4,5) b

WHERE _ff_we_artbew1_kmo_not_in.mandant_id = b.mandant_id AND
      _ff_we_artbew1_kmo_not_in.wup_id = b.wup_id AND
      _ff_we_artbew1_kmo_not_in.art_id = b.art_id AND
      _ff_we_artbew1_kmo_not_in.kjwo = b.kjwo AND
      _ff_we_artbew1_kmo_not_in.werbetyp_id = b.werbetyp_id
;

UPDATE _ff_we_artbew1_kmo_not_in

SET menge_historie_af = b.menge_historie_af

FROM (SELECT a.mandant_id,
             a.wup_id,
             a.art_id,
             SUM(d.menge)/42.000 AS menge_historie_af
      FROM _ff_we_artbew1_kmo_not_in a
      JOIN dbp_data.woche_1 b
        ON a.kjwo = b.kjwo
      JOIN dbp_data.woche_kj_kl_1 c
        ON c.akt_wo BETWEEN b.akt_wo-6 AND b.akt_wo-1
      JOIN dbp_data.artbew_wo_sum_1 d
        ON a.mandant_id = d.mandant_id AND
           a.wup_id = d.wup_id AND
           a.art_id = d.art_id AND
           c.kjwo_kl = d.kjwo_kl
      WHERE d.bewart_id = 1001 AND
            d.menge >= 0
      GROUP BY 1,2,3) b

WHERE _ff_we_artbew1_kmo_not_in.mandant_id = b.mandant_id AND
      _ff_we_artbew1_kmo_not_in.wup_id = b.wup_id AND
      _ff_we_artbew1_kmo_not_in.art_id = b.art_id
;

UPDATE _ff_we_artbew1_kmo_not_in

SET anzahl_tage_aktion = b.anz_tage_aktion

FROM (SELECT mandant_id,
             werbetyp_id,
             MAX(anz_tage_aktion) AS anz_tage_aktion
      FROM _werbetyp_tage_kmo
      GROUP BY 1,2) b

WHERE _ff_we_artbew1_kmo_not_in.mandant_id = b.mandant_id AND
      _ff_we_artbew1_kmo_not_in.werbetyp_id = b.werbetyp_id
;

UPDATE _ff_we_artbew1_kmo_not_in SET we_menge_ab_vorwoche = we_menge
;

CREATE OR REPLACE VOLATILE TABLE _ff_we_artbew2_kmo_not_in AS(
SELECT a.*,
       b.wtag_id AS wtag_id_start,
       c.wtag_id AS wtag_id_ende,
       -- 14.09.2016, -dbay-
       -- Zuspielen der Mutter jetzt ueber die eingefrorenen Daten.
       COALESCE(w.mutter_wb_id,d.mutter_wb_id) AS mutter_wb_id,
       w.avq_relevant_fg,
       w.vk_vor_aktion_brutto,
       w.vk_aktion_brutto,
       w.vk_kcard_brutto
FROM _ff_we_artbew1_kmo_not_in a
JOIN dbp_data.tag_1 b
  ON a.dat_von = b.dat
JOIN dbp_data.tag_1 c
  ON a.dat_bis = c.dat
JOIN _werbeartikel_1_kmo w
  ON a.mandant_id = w.mandant_id AND
     a.wup_id = w.wup_id AND
     a.art_id = w.art_id AND
     a.dat_von BETWEEN w.dat_von AND w.dat_bis AND
     a.werbetyp_id = w.werbetyp_id
LEFT JOIN _ff_mutter_art_kmo d
  ON a.mandant_id = d.mandant_id AND
     a.art_id = d.art_id
);

DELETE FROM _ff_we_artbew2_kmo_not_in
WHERE (mandant_id,mutter_wb_id) IN (SELECT akt.mandant_id,
                                           akta.art_id
                                    FROM dbp_data.aktion_1 akt
                                    JOIN dbp_data.aktion_art_wup_zu_1 akta
                                      ON akt.mandant_id = akta.mandant_id AND
                                         akt.aktion_id = akta.aktion_id
                                    JOIN dbp_data.tag_1 x1
                                      ON akt.dat_von = x1.dat
                                    WHERE akta.grund_sperrung IS NULL AND
                                          akt.mandant_id IN (8) AND
                                          charindex('J',akt.aktion_id) > 0 AND
                                          length(trim(akt.aktion_id)) = 9 and
                                          x1.akt_wo = $wkw
                                    GROUP BY 1,2)
;

DELETE FROM dbp_data.werbung_kennzahlen_woche_1
WHERE (kjwo,werbe_typ_id,wup_id,art_id,mandant_id) IN (SELECT kjwo,werbetyp_id,wup_id,art_id,mandant_id FROM _ff_we_artbew2_kmo_not_in) AND
       menge_tag1+menge_tag2+menge_tag3+menge_tag4+menge_tag5+menge_tag6+menge_tag7=0
;

INSERT INTO dbp_data.werbung_kennzahlen_woche_1 (kjwo
                                              ,wup_id
                                              ,nb_id
                                              ,mandant_id
                                              ,art_id
                                              ,werbe_typ_id
                                              ,menge_tag1
                                              ,menge_tag2
                                              ,menge_tag3
                                              ,menge_tag4
                                              ,menge_tag5
                                              ,menge_tag6
                                              ,menge_tag7
                                              ,tage_menge_0       
                                              ,menge_endbestand   
                                              ,menge_aktionsstart 
                                              ,umsatz_netto_tag1    
                                              ,umsatz_netto_tag2  
                                              ,umsatz_netto_tag3  
                                              ,umsatz_netto_tag4  
                                              ,umsatz_netto_tag5
                                              ,umsatz_netto_tag6
                                              ,umsatz_netto_tag7  
                                              ,we_menge           
                                              ,min_sicherh_bestand
                                              ,posten_id
                                              ,we_menge_zentral
                                              ,faktor_flaki
                                              ,mutter_wb_id
                                              ,wtag_id_start
                                              ,wtag_id_ende
                                              ,menge_historie_af
                                              ,anzahl_nullbestand
                                              ,anzahl_tage_aktion
                                              ,menge_tag1_7bis13h
                                              ,menge_nur_tag1
                                              ,lager_prozent
                                              ,mhd_zeitraum
                                              ,sollbestand
                                              ,menge_bestand_soll_max
                                              ,werbenachvermarktung_fg
                                              ,art_mutter_bezugsweg_id
                                              ,we_menge_vor_aktion
                                              ,anzahl_nullbestand_tag1
                                              ,anzahl_nullbestand_tag1bis3
                                              ,anzahl_minusbestand
                                              ,anzahl_minusbestand_tag1
                                              ,anzahl_minusbestand_tag1bis3
                                              ,avq_relevant_fg
                                              ,wrg_id
                                              ,anzahl_nullbestand_tag2
                                              ,anzahl_nullbestand_tag3
                                              ,anzahl_nullbestand_tag4
                                              ,anzahl_nullbestand_tag5
                                              ,anzahl_nullbestand_tag6
                                              ,anzahl_nullbestand_tag7
                                              ,vk_vor_aktion_brutto
                                              ,vk_aktion_brutto
                                              ,vk_kcard_brutto
                                              ,menge_sa
                                              ,td_insert
                                              ,td_update)
SELECT kjwo               
      ,wup_id             
      ,nb_id              
      ,x1.mandant_id
      ,art_id
      ,werbetyp_id AS werbe_typ_id
      ,CASE
         WHEN werbetyp_id IN (1,7,8,12,15)
         THEN menge_mo
         WHEN werbetyp_id IN (17)
         THEN menge_di
         WHEN werbetyp_id IN (6,11,20,23,24)
         THEN menge_mi
         WHEN werbetyp_id IN (4,5,21)
         THEN menge_do
         WHEN werbetyp_id IN (10,13,18,29)
         THEN menge_fr
         WHEN werbetyp_id IN (9,30)
         THEN menge_sa
         WHEN werbetyp_id IN (14,19)
         THEN menge_so
         ELSE 0
       END AS menge_tag1
      ,CASE
         WHEN werbetyp_id IN (1,7,8,12,15)
         THEN menge_di
	 WHEN werbetyp_id IN (17)
         THEN menge_mi
         WHEN werbetyp_id IN (6,11,20,23,24)
         THEN menge_do
	 WHEN werbetyp_id IN (4,5,21)
         THEN menge_fr
         WHEN werbetyp_id IN (10,13,18,29)
         THEN menge_sa
         WHEN werbetyp_id IN (9,30)
         THEN menge_so
         WHEN werbetyp_id IN (14,19)
         THEN menge_mo
         ELSE 0
       END AS menge_tag2
      ,CASE
         WHEN werbetyp_id IN (1,7,8,12,15)
         THEN menge_mi
         WHEN werbetyp_id IN (17)
         THEN menge_do
         WHEN werbetyp_id IN (6,11,20,23,24)
         THEN menge_fr
         WHEN werbetyp_id IN (4,5,21)
         THEN menge_sa
         WHEN werbetyp_id IN (10,13,18,29)
         THEN menge_so
         WHEN werbetyp_id IN (9,30)
         THEN menge_mo
         WHEN werbetyp_id IN (14,19)
         THEN menge_di
         ELSE 0
       END AS menge_tag3
      ,CASE
         WHEN werbetyp_id IN (1,7,8,12,15)
         THEN menge_do
         WHEN werbetyp_id IN (17)
         THEN menge_fr
         WHEN werbetyp_id IN (6,11,20,23,24)
         THEN menge_sa
         WHEN werbetyp_id IN (4,5,21)
         THEN menge_so
         WHEN werbetyp_id IN (10,13,18,29)
         THEN menge_mo
         WHEN werbetyp_id IN (9,30)
         THEN menge_di
         WHEN werbetyp_id IN (14,19)
         THEN menge_mi
         ELSE 0
       END AS menge_tag4
      ,CASE
         WHEN werbetyp_id IN (1,7,8,12,15)
         THEN menge_fr
         WHEN werbetyp_id IN (17)
         THEN menge_sa
         WHEN werbetyp_id IN (6,11,20,23,24)
         THEN menge_so
         WHEN werbetyp_id IN (4,5,21)
         THEN menge_mo
         WHEN werbetyp_id IN (10,13,18,29)
         THEN menge_di
         WHEN werbetyp_id IN (9,30)
         THEN menge_mi
         WHEN werbetyp_id IN (14,19)
         THEN menge_do
         ELSE 0
       END AS menge_tag5
      ,CASE
         WHEN werbetyp_id IN (1,7,8,12,15)
         THEN menge_sa
         WHEN werbetyp_id IN (17)
         THEN menge_so
         WHEN werbetyp_id IN (6,11,20,23,24)
         THEN menge_mo
         WHEN werbetyp_id IN (4,5,21)
         THEN menge_di
         WHEN werbetyp_id IN (10,13,18,29)
         THEN menge_mi
         WHEN werbetyp_id IN (9,30)
         THEN menge_do
         WHEN werbetyp_id IN (14,19)
         THEN menge_fr
         ELSE 0
       END AS menge_tag6
      ,CASE
         WHEN werbetyp_id IN (1,7,8,12,15)
         THEN menge_so
         WHEN werbetyp_id IN (17)
         THEN menge_mo
         WHEN werbetyp_id IN (6,11,20,23,24)
         THEN menge_di
         WHEN werbetyp_id IN (4,5,21)
         THEN menge_mi
         WHEN werbetyp_id IN (10,13,18,29)
         THEN menge_do
         WHEN werbetyp_id IN (9,30)
         THEN menge_fr
         WHEN werbetyp_id IN (14,19)
         THEN menge_sa
         ELSE 0
       END AS menge_tag7
      ,tage_menge_0       
      ,menge_endbestand   
      ,menge_aktionsstart 
      ,CASE
	 WHEN werbetyp_id IN (1,7,8,12,15)
	 THEN umsatz_netto_mo
	 WHEN werbetyp_id IN (17)
	 THEN umsatz_netto_di
	 WHEN werbetyp_id IN (6,11,20,23,24)
	 THEN umsatz_netto_mi
	 WHEN werbetyp_id IN (4,5,21)
	 THEN umsatz_netto_do
	 WHEN werbetyp_id IN (10,13,18,29)
	 THEN umsatz_netto_fr
         WHEN werbetyp_id IN (9,30)
	 THEN umsatz_netto_sa
	 WHEN werbetyp_id IN (14,19)
	 THEN umsatz_netto_so
	 ELSE 0
       END AS umsatz_netto_tag1
      ,CASE
	 WHEN werbetyp_id IN (1,7,8,12,15)
	 THEN umsatz_netto_di
	 WHEN werbetyp_id IN (17)
	 THEN umsatz_netto_mi
	 WHEN werbetyp_id IN (6,11,20,23,24)
	 THEN umsatz_netto_do
	 WHEN werbetyp_id IN (4,5,21)
	 THEN umsatz_netto_fr
	 WHEN werbetyp_id IN (10,13,18,29)
	 THEN umsatz_netto_sa
         WHEN werbetyp_id IN (9,30)
	 THEN umsatz_netto_so
	 WHEN werbetyp_id IN (14,19)
	 THEN umsatz_netto_mo
	 ELSE 0
       END AS umsatz_netto_tag2
      ,CASE
	 WHEN werbetyp_id IN (1,7,8,12,15)
	 THEN umsatz_netto_mi
	 WHEN werbetyp_id IN (17)
	 THEN umsatz_netto_do
	 WHEN werbetyp_id IN (6,11,20,23,24)
	 THEN umsatz_netto_fr
	 WHEN werbetyp_id IN (4,5,21)
	 THEN umsatz_netto_sa
	 WHEN werbetyp_id IN (10,13,18,29)
	 THEN umsatz_netto_so
         WHEN werbetyp_id IN (9,30)
	 THEN umsatz_netto_mo
	 WHEN werbetyp_id IN (14,19)
	 THEN umsatz_netto_di
	 ELSE 0
       END AS umsatz_netto_tag3
      ,CASE
	 WHEN werbetyp_id IN (1,7,8,12,15)
	 THEN umsatz_netto_do
	 WHEN werbetyp_id IN (17)
	 THEN umsatz_netto_fr
	 WHEN werbetyp_id IN (6,11,20,23,24)
	 THEN umsatz_netto_sa
	 WHEN werbetyp_id IN (4,5,21)
	 THEN umsatz_netto_so
	 WHEN werbetyp_id IN (10,13,18,29)
	 THEN umsatz_netto_mo
         WHEN werbetyp_id IN (9,30)
	 THEN umsatz_netto_di
	 WHEN werbetyp_id IN (14,19)
	 THEN umsatz_netto_mi
	 ELSE 0
       END AS umsatz_netto_tag4
      ,CASE
	 WHEN werbetyp_id IN (1,7,8,12,15)
	 THEN umsatz_netto_fr
	 WHEN werbetyp_id IN (17)
	 THEN umsatz_netto_sa
	 WHEN werbetyp_id IN (6,11,20,23,24)
	 THEN umsatz_netto_so
	 WHEN werbetyp_id IN (4,5,21)
	 THEN umsatz_netto_mo
	 WHEN werbetyp_id IN (10,13,18,29)
	 THEN umsatz_netto_di
         WHEN werbetyp_id IN (9,30)
	 THEN umsatz_netto_mi
	 WHEN werbetyp_id IN (14,19)
	 THEN umsatz_netto_do
	 ELSE 0
       END AS umsatz_netto_tag5
      ,CASE
	 WHEN werbetyp_id IN (1,7,8,12,15)
	 THEN umsatz_netto_sa
	 WHEN werbetyp_id IN (17)
	 THEN umsatz_netto_so
	 WHEN werbetyp_id IN (6,11,20,23,24)
	 THEN umsatz_netto_mo
	 WHEN werbetyp_id IN (4,5,21)
	 THEN umsatz_netto_di
	 WHEN werbetyp_id IN (10,13,18,29)
	 THEN umsatz_netto_mi
         WHEN werbetyp_id IN (9,30)
	 THEN umsatz_netto_do
	 WHEN werbetyp_id IN (14,19)
	 THEN umsatz_netto_fr
	 ELSE 0
       END AS umsatz_netto_tag6
      ,CASE
	 WHEN werbetyp_id IN (1,7,8,12,15)
	 THEN umsatz_netto_so
	 WHEN werbetyp_id IN (17)
	 THEN umsatz_netto_mo
	 WHEN werbetyp_id IN (6,11,20,23,24)
	 THEN umsatz_netto_di
	 WHEN werbetyp_id IN (4,5,21)
	 THEN umsatz_netto_mi
	 WHEN werbetyp_id IN (10,13,18,29)
	 THEN umsatz_netto_do
         WHEN werbetyp_id IN (9,30)
	 THEN umsatz_netto_fr
	 WHEN werbetyp_id IN (14,19)
	 THEN umsatz_netto_sa
	 ELSE 0
       END AS umsatz_netto_tag7
      ,we_menge
      ,COALESCE(min_sicherh_bestand,0) AS min_sicherh_bestand
      ,posten_id
      ,we_menge_ab_vorwoche AS we_menge_zentral
      ,faktor_flaki
      ,COALESCE(mutter_wb_id,art_id) AS mutter_wb_id
      ,wtag_id_start
      ,wtag_id_ende
      ,menge_historie_af
      ,case when anzahl_tage_aktion < anzahl_nullbestand then anzahl_tage_aktion else anzahl_nullbestand end as anzahl_nullbestand
      ,anzahl_tage_aktion
      ,COALESCE(menge_tag1_7bis13h,0)
      ,COALESCE(menge_nur_tag1,0)
      ,COALESCE(lager_prozent,0)
      ,COALESCE(mhd_zeitraum,0)
      ,COALESCE(sollbestand,0)
      ,COALESCE(menge_bestand_soll_max,0)
      ,0 AS werbenachvermarktung_fg
      ,COALESCE(bezugsweg_id,-1)
      ,we_menge_vor_aktion
      ,anzahl_nullbestand_tag1
      ,anzahl_nullbestand_tag1bis3
      ,COALESCE(anzahl_minusbestand,0)
      ,COALESCE(anzahl_minusbestand_tag1,0)
      ,COALESCE(anzahl_minusbestand_tag1bis3,0)
      ,avq_relevant_fg
      ,x2.default_wrg as wrg_id
      ,COALESCE(anzahl_nullbestand_tag2,0)
      ,COALESCE(anzahl_nullbestand_tag3,0)
      ,COALESCE(anzahl_nullbestand_tag4,0)
      ,COALESCE(anzahl_nullbestand_tag5,0)
      ,COALESCE(anzahl_nullbestand_tag6,0)
      ,COALESCE(anzahl_nullbestand_tag7,0)
      ,vk_vor_aktion_brutto
      ,vk_aktion_brutto
      ,vk_kcard_brutto
      ,COALESCE(menge_sa,0)
      ,current_timestamp
      ,current_timestamp
FROM _ff_we_artbew2_kmo_not_in x1
JOIN dbp_data.mandant_1 x2
  ON x1.mandant_id = x2.mandant_id
;

CREATE OR REPLACE VOLATILE TABLE _preis_mutter_kmo AS (
SELECT a.mandant_id,
       a.kjwo,
       a.wup_id,
       a.werbe_typ_id,
       a.mutter_wb_id,
       x.vk_brutto AS preis
FROM dbp_data.werbung_kennzahlen_woche_1 a
JOIN _werbeartikel_1_kmo x
  ON a.kjwo = x.kjwo AND
     a.werbe_typ_id = x.werbetyp_id AND
     a.mandant_id = x.mandant_id AND
     a.wup_id = x.wup_id AND
     a.mutter_wb_id = x.art_id
JOIN dbp_data.art_wg_zu_per_1 b
  ON a.mandant_id = b.mandant_id AND
     a.mutter_wb_id = b.art_id AND
     b.dat_bis = '9999-12-31' AND
     b.arthiertyp_id = 2
WHERE a.mutter_wb_id = a.art_id AND
      b.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu_1 WHERE wg_filter_id = 44 AND mandant_id > 1) AND
      a.kjwo IN (SELECT kjwo FROM dbp_data.tag_1 WHERE akt_wo = $wkw) AND
      preis <> 0
);

CREATE OR REPLACE VOLATILE TABLE _preis_kind_kmo AS (
SELECT a.mandant_id,
       a.kjwo,
       a.werbe_typ_id,
       a.wup_id,
       a.art_id,
       a.mutter_wb_id,
       x.vk_brutto AS preis_kind,
       b.preis AS preis_mutter,
       CAST(COALESCE(ROUND(preis_mutter/NULLIFZERO(preis_kind),2),1) AS DECIMAL(9,3)) AS faktor
FROM dbp_data.werbung_kennzahlen_woche_1 a
JOIN _werbeartikel_1_kmo x
  ON a.kjwo = x.kjwo AND
     a.werbe_typ_id = x.werbetyp_id AND
     a.mandant_id = x.mandant_id AND
     a.wup_id = x.wup_id AND
     a.art_id = x.art_id
JOIN _preis_mutter_kmo b
  ON a.mandant_id = b.mandant_id AND
     a.mutter_wb_id = b.mutter_wb_id AND
     a.wup_id = b.wup_id AND
     a.kjwo = b.kjwo AND
     a.werbe_typ_id = b.werbe_typ_id
);

UPDATE dbp_data.werbung_kennzahlen_woche_1 

SET faktor_flaki = b.faktor

FROM (SELECT mandant_id,
             kjwo,
             werbe_typ_id,
             wup_id,
             art_id,
             mutter_wb_id,
             MAX(preis_kind) AS preis_kind,
             MAX(preis_mutter) AS preis_mutter,
             MAX(faktor) AS faktor
      FROM _preis_kind_kmo
      GROUP BY 1,2,3,4,5,6) b

WHERE dbp_data.werbung_kennzahlen_woche.mandant_id = b.mandant_id AND
      dbp_data.werbung_kennzahlen_woche.wup_id = b.wup_id AND
      dbp_data.werbung_kennzahlen_woche.kjwo = b.kjwo AND
      dbp_data.werbung_kennzahlen_woche.art_id = b.art_id AND
      dbp_data.werbung_kennzahlen_woche.mutter_wb_id = b.mutter_wb_id AND
      dbp_data.werbung_kennzahlen_woche.werbe_typ_id = b.werbe_typ_id
;

UPDATE dbp_data.werbung_kennzahlen_woche_1 SET faktor_flaki = 1
WHERE faktor_flaki = 0
;

DELETE FROM dbp_data.werbung_kennzahlen_woche_1
WHERE (mandant_id,art_id) IN (SELECT mandant_id,kopf_art FROM _stpo_kmo) AND
       menge_tag1+menge_tag2+menge_tag3+menge_tag4+menge_tag5+menge_tag6+menge_tag7 = 0 AND
	   kjwo IN (SELECT kjwo FROM dbp_data.tag_1 WHERE akt_wo = $wkw)
;

CREATE OR REPLACE VOLATILE TABLE _upd_werbung AS (
SELECT a.kjwo,
       a.mandant_id,
       a.art_id,
       MIN(b.posten_id) AS posten_id_neu
FROM dbp_data.werbung_kennzahlen_woche_1 a
JOIN dbp_data.art_1 b
  ON a.mandant_id = b.mandant_id AND
     -- 14.09.2016, -dbay-
     -- Zuspielen des Postenkennzeichens jetzt auf Mutterebene!!!
     -- a.art_id = b.art_id AND (alt)
     a.mutter_wb_id = b.art_id AND 
     b.dat_bis = '9999-12-31'
WHERE a.mandant_id IN (2,3,4,5,6,7,8) AND
      kjwo IN (SELECT kjwo FROM dbp_data.tag_1 WHERE akt_wo = $wkw)
GROUP BY 1,2,3
);

UPDATE dbp_data.werbung_kennzahlen_woche_1 

SET posten_id = b.posten_id_neu

FROM (SELECT *
      FROM _upd_werbung) b

WHERE dbp_data.werbung_kennzahlen_woche.mandant_id = b.mandant_id AND
      dbp_data.werbung_kennzahlen_woche.art_id = b.art_id AND
      dbp_data.werbung_kennzahlen_woche.kjwo = b.kjwo
;

CREATE OR REPLACE VOLATILE TABLE _we_upd_candidates_kmo AS (
SELECT a.kjwo,
       a.werbe_typ_id,
       a.mandant_id,
       a.wup_id,
       a.art_id,
       a.mutter_wb_id,
       SUM(a.we_menge_zentral) AS we_menge_zentral,
       SUM(a.menge_tag1+a.menge_tag2+a.menge_tag3+a.menge_tag4+
       a.menge_tag5+a.menge_tag6+a.menge_tag7) AS menge_
FROM dbp_data.werbung_kennzahlen_woche_1 a
JOIN dbp_data.art_wg_zu_per_1 b
  ON a.mandant_id = b.mandant_id AND
     a.art_id = b.art_id AND
     b.arthiertyp_id = 2 AND
     b.dat_bis = '9999-12-31'
WHERE b.wg_id IN (SELECT wg_id FROM dbp_data.wg_filter_zu_1 WHERE wg_filter_id = 44 AND mandant_id > 1) AND
      a.mandant_id IN (2,3,4,5,6,7,8) AND
      a.kjwo IN (SELECT kjwo FROM dbp_data.tag_1 WHERE akt_wo = $wkw)
GROUP BY 1,2,3,4,5,6
HAVING SUM(we_menge_zentral) = 0 AND
       menge_ <> 0
);

CREATE OR REPLACE VOLATILE TABLE _ff_mutter_art_we_upd_kmo AS (
SELECT a.mandant_id,
       a.art_id,
       COALESCE(a.mutter_wb_id,a.art_id) AS mutter_wb_id
FROM dbp_data.art_1 a
WHERE a.dat_bis = '9999-12-31' AND
      a.mandant_id IN (2,3,4,5,6,7,8)
GROUP BY 1,2,3
);

CREATE OR REPLACE VOLATILE TABLE _singles_kmo AS (
SELECT mutter_wb_id
FROM _ff_mutter_art_we_upd_kmo
GROUP BY 1
HAVING COUNT(*) = 1
);

DELETE FROM _we_upd_candidates_kmo
WHERE (mutter_wb_id) IN (SELECT mutter_wb_id FROM _singles_kmo)
;

CREATE OR REPLACE VOLATILE TABLE _multiples_kmo AS (
SELECT mutter_wb_id,
       COUNT(*) AS anzahl
FROM _ff_mutter_art_we_upd_kmo
GROUP BY 1
HAVING COUNT(*) > 1
);

DELETE FROM _we_upd_candidates_kmo
WHERE (mandant_id,kjwo,werbe_typ_id,mutter_wb_id) IN (SELECT a.mandant_id,
                                                             a.kjwo,
                                                             a.werbe_typ_id,
                                                             a.mutter_wb_id
                                                      FROM dbp_data.werbung_kennzahlen_woche_1 a
                                                      JOIN _multiples_kmo b
                                                        ON a.mutter_wb_id = b.mutter_wb_id
                                                      WHERE a.mandant_id IN (2,3,4,5,6,7,8) AND
                                                            a.kjwo IN (SELECT kjwo FROM dbp_data.tag_1 WHERE akt_wo = $wkw)
                                                      GROUP BY 1,2,3,4
                                                      HAVING SUM(a.we_menge_zentral) = 0)
;

UPDATE dbp_data.werbung_kennzahlen_woche_1 

SET we_menge_zentral = 0.001

FROM (SELECT *
      FROM _we_upd_candidates_kmo) b

WHERE dbp_data.werbung_kennzahlen_woche.kjwo = b.kjwo AND
      dbp_data.werbung_kennzahlen_woche.werbe_typ_id = b.werbe_typ_id AND
      dbp_data.werbung_kennzahlen_woche.mandant_id = b.mandant_id AND
      dbp_data.werbung_kennzahlen_woche.wup_id = b.wup_id AND
      dbp_data.werbung_kennzahlen_woche.art_id = b.art_id AND
      dbp_data.werbung_kennzahlen_woche.we_menge_zentral = 0
;

delete from dbp_data.werbung_kennzahlen_woche_1
where (mandant_id,art_id) in (select mandant_id,art_id from dbp_etl_process.avq_obsolete_artikel_1)
;

update dbp_data.werbung_kennzahlen_woche_1 set tage_menge_0 = 1
where werbe_typ_id = 22 and
      mandant_id = 4 and
      tage_menge_0 = 7
;

DELETE FROM dbp_data.avq_aktualisierung_1
WHERE (mandant_id,kjwo) IN (SELECT mandant_id,kjwo FROM _werbeartikel_1_kmo)
;

INSERT INTO dbp_data.avq_aktualisierung_1 (mandant_id,
                                         kjwo,
                                         dat_letzte_aktualisierung)
SELECT mandant_id,
       kjwo,
       CURRENT_TIMESTAMP(0)
FROM _werbeartikel_1_kmo
GROUP BY 1,2,3
;
