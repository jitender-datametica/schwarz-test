  /* AW check 2021-05-10*/
DROP TABLE IF EXISTS DBP_ETL.vis_personal_wup_tmp_2
;

DROP TABLE IF EXISTS DBP_ETL.vis_personal_wup_tmp1_2
;

CREATE TABLE DBP_ETL.vis_personal_wup_tmp_2  (
      mandant_id                 BYTEINT NOT NULL,
      nb_id                      BYTEINT NOT NULL,
      wup_id                     INTEGER NOT NULL,
      gj                         SMALLINT NOT NULL,
      kjmo                       INTEGER NOT NULL,
      pers_std                   DECIMAL(18,2) NOT NULL,
      pers_std_kvj               DECIMAL(18,2) NOT NULL,
      pers_std_plan              DECIMAL(18,2) NOT NULL,
      abwesenheit_tage           DECIMAL(18,2) NOT NULL,
      anz_tage                   DECIMAL(18,2) NOT NULL,
      abwesenheit_tage_kvj       DECIMAL(18,2) NOT NULL,
      anz_tage_kvj               DECIMAL(18,2) NOT NULL,
      pers_austritte             DECIMAL(18,2) NOT NULL,
      pers_anz                   DECIMAL(18,2) NOT NULL,
      pers_austritte_kvj         DECIMAL(18,2) NOT NULL,
      pers_anz_kvj               DECIMAL(18,2) NOT NULL
)
;

CREATE TABLE DBP_ETL.vis_personal_wup_tmp1_2  (
      mandant_id                 BYTEINT NOT NULL,
      nb_id                      BYTEINT NOT NULL,
      wup_id                     INTEGER NOT NULL,
      gj                         SMALLINT NOT NULL,
      kjmo                       INTEGER NOT NULL,
      pers_std                   DECIMAL(18,2) NOT NULL,
      pers_std_kvj               DECIMAL(18,2) NOT NULL,
      pers_std_plan              DECIMAL(18,2) NOT NULL,
      abwesenheit_tage           DECIMAL(18,2) NOT NULL,
      anz_tage                   DECIMAL(18,2) NOT NULL,
      abwesenheit_tage_kvj       DECIMAL(18,2) NOT NULL,
      anz_tage_kvj               DECIMAL(18,2) NOT NULL,
      pers_austritte             DECIMAL(18,2) NOT NULL,
      pers_anz                   DECIMAL(18,2) NOT NULL,
      pers_austritte_kvj         DECIMAL(18,2) NOT NULL,
      pers_anz_kvj               DECIMAL(18,2) NOT NULL
)
;

INSERT INTO DBP_ETL.vis_personal_wup_tmp_2
(
mandant_id
,nb_id
,wup_id
,gj
,kjmo 
,pers_std
,pers_std_kvj
,pers_std_plan
,abwesenheit_tage
,anz_tage
,abwesenheit_tage_kvj
,anz_tage_kvj
,pers_austritte
,pers_anz
,pers_austritte_kvj
,pers_anz_kvj
)
SELECT DISTINCT
dt1.mandant_id
,dt1.nb_id
,dt1.wup_id
,dt1.gj
,dt1.kjmo
,coalesce(max(ps3.stunden_ist),0) as pers_std
,coalesce(max(ps4.stunden_ist),0) as pers_std_kvj
,coalesce(max(ps3.stunden_plan),0) as pers_std_plan
,0
,0
,0
,0
,0
,0
,0
,0
FROM
(
SELECT 
ps1.mandant_id
,ps1.nb_id
,ps1.wup_id
,m.gj
,m.kjmo

FROM DBP_ETL_PROCESS.personalstd_2 ps1

INNER JOIN DBP_ETL.vis_mandant_2 vm
ON vm.mandant_id = ps1.mandant_id

INNER JOIN DBP_DATA.monat_2 m
ON m.kjmo = ps1.kjmo

WHERE (m.akt_gj IN (0,-1,-2) OR (m.akt_gj IN (1) AND MOD(m.kjmo,100) IN (1,2,3,4,5,6,7,8,9,10,11,12)))

UNION

SELECT 
ps2.mandant_id
,ps2.nb_id
,ps2.wup_id
,m.gj
,m.kjmo

FROM DBP_ETL_PROCESS.personalstd_2 ps2

INNER JOIN DBP_ETL.vis_mandant_2 vm
ON vm.mandant_id = ps2.mandant_id

INNER JOIN DBP_DATA.monat_2 m
ON m.kjmo = ps2.kjmo +100
WHERE (m.akt_gj IN (0) OR (m.akt_gj IN (1) AND MOD(m.kjmo,100) IN (1,2,3,4,5,6,7,8,9,10,11,12)))
) dt1

LEFT OUTER JOIN DBP_ETL_PROCESS.personalstd_2 ps3
ON ps3.kjmo = dt1.kjmo
AND ps3.mandant_id = dt1.mandant_id
AND ps3.wup_id = dt1.wup_id
AND ps3.nb_id = dt1.nb_id

LEFT OUTER JOIN DBP_ETL_PROCESS.personalstd_2 ps4
ON ps4.kjmo = dt1.kjmo - 100
AND ps4.mandant_id = dt1.mandant_id
AND ps4.wup_id = dt1.wup_id
AND ps4.nb_id = dt1.nb_id

GROUP BY 1,2,3,4,5;

