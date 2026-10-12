/* AW check 2021-05-10*/
DROP TABLE IF EXISTS DBP_ETL.vis_bon_wup_bedienung_tmp_2;

CREATE TABLE DBP_ETL.vis_bon_wup_bedienung_tmp_2  (
  mandant_id                  BYTEINT,
  wup_id                      INTEGER,
  nb_id                       SMALLINT,
  dat                         DATE,
  wrg_id                      CHAR(3) COLLATE 'en-ci',
  gj                          SMALLINT,
  akt_gj                      SMALLINT,
  kjmo                        INTEGER,
  akt_mo                      SMALLINT,
  kjwo                        INTEGER,
  akt_wo                      SMALLINT,
  wtag_id                     BYTEINT,
  akt_tag                     SMALLINT,
  anz_kunde_bed_wurst         SMALLINT,
  anz_kunde_bed_wurst_wvj     SMALLINT,
  anz_kunde_bed_kaese         SMALLINT,
  anz_kunde_bed_kaese_wvj     SMALLINT,
  anz_kunde_bed_fleisch       SMALLINT,
  anz_kunde_bed_fleisch_wvj   SMALLINT,
  anz_kunde_bed_gefluegel     SMALLINT,
  anz_kunde_bed_gefluegel_wvj SMALLINT,
  anz_kunde_bed_fisch         SMALLINT,
  anz_kunde_bed_fisch_wvj     SMALLINT,
  anz_kunde_bed_feink         SMALLINT,
  anz_kunde_bed_feink_wvj     SMALLINT
)
;

INSERT INTO DBP_ETL.vis_bon_wup_bedienung_tmp_2
(
   mandant_id
  ,wup_id
  ,nb_id
  ,dat
  ,wrg_id
  ,gj
  ,akt_gj
  ,kjmo
  ,akt_mo
  ,kjwo
  ,akt_wo
  ,wtag_id
  ,akt_tag
  ,anz_kunde_bed_wurst
  ,anz_kunde_bed_wurst_wvj
  ,anz_kunde_bed_kaese
  ,anz_kunde_bed_kaese_wvj
  ,anz_kunde_bed_fleisch
  ,anz_kunde_bed_fleisch_wvj
  ,anz_kunde_bed_gefluegel
  ,anz_kunde_bed_gefluegel_wvj
  ,anz_kunde_bed_fisch
  ,anz_kunde_bed_fisch_wvj
  ,anz_kunde_bed_feink
  ,anz_kunde_bed_feink_wvj
)
SELECT
   d.mandant_id
  ,d.wup_id
  ,d.nb_id
  ,d.dat
  ,COALESCE(m.default_wrg,'') AS wrg_id
  ,d.gj
  ,d.akt_gj
  ,d.kjmo
  ,d.akt_mo
  ,d.kjwo
  ,d.akt_wo
  ,d.wtag_id
  ,d.akt_tag
  ,SUM(COALESCE(w.anz_kunde * akt_gj_fg, 0)) AS anz_kunde_wurst
  ,SUM(COALESCE(w.anz_kunde * vj_wt_1_fg, 0)) AS anz_kunde_wurst_wvj

  ,SUM(COALESCE(k.anz_kunde * akt_gj_fg, 0)) AS anz_kunde_kaese
  ,SUM(COALESCE(k.anz_kunde * vj_wt_1_fg, 0)) AS anz_kunde_kaese_wvj

  ,SUM(COALESCE(f.anz_kunde * akt_gj_fg, 0)) AS anz_kunde_fleisch
  ,SUM(COALESCE(f.anz_kunde * vj_wt_1_fg, 0)) AS anz_kunde_fleisch_wvj

  ,SUM(COALESCE(g.anz_kunde * akt_gj_fg, 0)) AS anz_kunde_gefluegel
  ,SUM(COALESCE(g.anz_kunde * vj_wt_1_fg, 0)) AS anz_kunde_gefluegel_wvj

  ,SUM(COALESCE(s.anz_kunde * akt_gj_fg, 0)) AS anz_kunde_fisch
  ,SUM(COALESCE(s.anz_kunde * vj_wt_1_fg, 0)) AS anz_kunde_fisch_wvj

  ,SUM(COALESCE(e.anz_kunde * akt_gj_fg, 0)) AS anz_kunde_feink
  ,SUM(COALESCE(e.anz_kunde * vj_wt_1_fg, 0)) AS anz_kunde_feink_wvj
FROM DBP_ETL.dat_vj_vergleich_2 d

INNER JOIN DBP_DATA.mandant_2 m
ON d.mandant_id = m.mandant_id

--Wurst
LEFT OUTER JOIN DBP_DATA.wupcal_bedienkonzept_zu_2 w
ON d.mandant_id=w.mandant_id
  AND d.wup_id=w.wup_id
  AND d.join_dat=w.dat
  AND w.bedienkonzept_id = 1

-- Kaese
LEFT OUTER JOIN DBP_DATA.wupcal_bedienkonzept_zu_2 k
ON d.mandant_id = k.mandant_id
  AND d.wup_id = k.wup_id
  AND d.join_dat = k.dat
  AND k.bedienkonzept_id = 2

-- Fleisch
LEFT OUTER JOIN DBP_DATA.wupcal_bedienkonzept_zu_2 f
ON d.mandant_id = f.mandant_id
  AND d.wup_id = f.wup_id
  AND d.join_dat = f.dat
  AND f.bedienkonzept_id = 3

-- Gefluegel
LEFT OUTER JOIN DBP_DATA.wupcal_bedienkonzept_zu_2 g
ON d.mandant_id = g.mandant_id
  AND d.wup_id = g.wup_id
  AND d.join_dat = g.dat
  AND g.bedienkonzept_id = 4

-- Fisch
LEFT OUTER JOIN DBP_DATA.wupcal_bedienkonzept_zu_2 s
ON d.mandant_id = s.mandant_id
  AND d.wup_id = s.wup_id
  AND d.join_dat = s.dat
  AND s.bedienkonzept_id = 5

-- Feinkost
LEFT OUTER JOIN DBP_DATA.wupcal_bedienkonzept_zu_2 e
ON d.mandant_id = e.mandant_id
  AND d.wup_id = e.wup_id
  AND d.join_dat = e.dat
  AND e.bedienkonzept_id = 6

-- mindestens ein Bedienkonzept muss vorhanden sein.
WHERE COALESCE
      (
         w.mandant_id
        ,k.mandant_id
        ,f.mandant_id
        ,g.mandant_id
        ,s.mandant_id
        ,e.mandant_id
      )
      IS NOT NULL

GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12,13
;

UPDATE DBP_ETL.vis_bon_wup_bedienung_tmp_2

SET wup_id = wup_id_

FROM
(
  SELECT
     t1.mandant_id as mandant_id_
    ,t1.nb_id AS nb_id_
    ,t2.wup_id AS wup_id_
    ,t1.wup_id AS wup_id_alt_
  FROM DBP_DATA.wup_2 t1_2

  INNER JOIN DBP_DATA.wup_2 t2
  ON t2.wup_id_alt = t1.wup_id
    AND t2.nb_id = t1.nb_id
    AND t2.mandant_id = t1.mandant_id
    AND t2.dat_von <= CURRENT_DATE
) x1
 WHERE mandant_id = mandant_id_
  AND nb_id = nb_id_
  AND wup_id = wup_id_alt_
;

