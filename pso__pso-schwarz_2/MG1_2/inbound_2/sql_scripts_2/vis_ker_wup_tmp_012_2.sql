/*
#------------------------------------------------------------------------------
#10) Tmp-Tabelle fuer ker anlegen. 
#----------------------------------------------------------------------------
*/
--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.vis_ker_monat_wup_tmp_2  (
      kjmo                        INTEGER NOT NULL,
      gjmo                        INTEGER NOT NULL,
      gj                          SMALLINT,
      akt_gj                      SMALLINT,
      akt_mo                      SMALLINT,
      mo_kj                       BYTEINT,
      wup_id                      INTEGER,
      nb_id                       BYTEINT,
      mandant_id                  BYTEINT,
      ums_n_ker                   DECIMAL(18,2),
      ums_n_ker_kvj               DECIMAL(18,2),
      ums_n_ker_kvvj              DECIMAL(18,2),
      ums_n_ker_kvvvj             DECIMAL(18,2),
      ums_n_ker_plan              DECIMAL(18,2),
      ums_n_ker_plan_kvj          DECIMAL(18,2),
      rohertrag                   DECIMAL(18,2),
      rohertrag_kvj               DECIMAL(18,2),
      rohertrag_kvvj              DECIMAL(18,2),
      rohertrag_kvvvj             DECIMAL(18,2),
      rohertrag_plan              DECIMAL(18,2),
      rohertrag_plan_kvj          DECIMAL(18,2),
      pk_ker                      DECIMAL(18,2),
      pk_ker_kvj                  DECIMAL(18,2),
      pk_ker_kvvj                 DECIMAL(18,2),
      pk_ker_kvvvj                DECIMAL(18,2),
      pk_ker_plan                 DECIMAL(18,2),
      pk_ker_plan_kvj             DECIMAL(18,2),
	  pk_ohne                     DECIMAL(18,2),
      pk_ohne_kvj                 DECIMAL(18,2),
      pk_ohne_kvvj                DECIMAL(18,2),
      pk_ohne_kvvvj               DECIMAL(18,2),
      pk_ohne_plan                DECIMAL(18,2),
      pk_ohne_plan_kvj            DECIMAL(18,2),
      umsatz_wrg                  CHAR(3)
)
;
/*
#------------------------------------------------------------------------------
#11) Tmp-Tabelle für ker mit Aggregiertdaten auf Wup_2/Monat_2 Ebene laden.
#----------------------------------------------------------------------------
*/

INSERT INTO DBP_ETL.vis_ker_monat_wup_tmp_2
(
kjmo
, gjmo
, gj
, akt_gj
, akt_mo
, mo_kj
, wup_id
, nb_id
, mandant_id
, ums_n_ker
, ums_n_ker_kvj
, ums_n_ker_kvvj
, ums_n_ker_kvvvj
, ums_n_ker_plan
, ums_n_ker_plan_kvj
, rohertrag
, rohertrag_kvj
, rohertrag_kvvj
, rohertrag_kvvvj
, rohertrag_plan
, rohertrag_plan_kvj
, pk_ker
, pk_ker_kvj
, pk_ker_kvvj
, pk_ker_kvvvj
, pk_ker_plan
, pk_ker_plan_kvj
, pk_ohne
, pk_ohne_kvj
, pk_ohne_kvvj
, pk_ohne_kvvvj
, pk_ohne_plan
, pk_ohne_plan_kvj
, umsatz_wrg
)
SELECT
dt2.kjmo
, dt2.gjmo
, floor(dt2.gjmo/100)  -- floor required for SF
, dt2.akt_gj 
, dt2.akt_mo 
, dt2.mo_kj
, dt2.wup_id
, dt2.nb_id
, dt2.mandant_id
, dt2.ums_n_ker
, dt2.ums_n_ker_kvj
, dt2.ums_n_ker_kvvj
, dt2.ums_n_ker_kvvvj
, dt2.ums_n_ker_plan
, dt2.ums_n_ker_plan_kvj
, CASE WHEN bk.akt_buchungs_schluss <= 0 OR MOD(dt2.kjmo ,100) = 13 THEN dt2.rohertrag ELSE 0 END rohertrag
, dt2.rohertrag_kvj
, dt2.rohertrag_kvvj
, dt2.rohertrag_kvvvj
, dt2.rohertrag_plan
, dt2.rohertrag_plan_kvj
, CASE WHEN bk.akt_buchungs_schluss <= 0 OR MOD(dt2.kjmo ,100) = 13 THEN dt2.pk_ker -- Buchungsschluss
        WHEN bk.akt_fruehinfo2 = 0 THEN dt2.pk_ker        -- Frühinfo 2 (KMO & DE)
        ELSE 0 -- XLS Werte separat
  END pk_ker
, dt2.pk_ker_kvj
, dt2.pk_ker_kvvj
, dt2.pk_ker_kvvvj
, dt2.pk_ker_plan
, dt2.pk_ker_plan_kvj
, CASE WHEN bk.akt_buchungs_schluss <= 0 OR MOD(dt2.kjmo ,100) = 13 THEN dt2.pk_ohne -- Buchungsschluss
       WHEN bk.akt_fruehinfo2 = 0 THEN dt2.pk_ohne        -- Frühinfo 2 (KMO & DE)
  ELSE 0 -- XLS Werte separat
  END pk_ohne
, dt2.pk_ohne_kvj
, dt2.pk_ohne_kvvj
, dt2.pk_ohne_kvvvj
, dt2.pk_ohne_plan
, dt2.pk_ohne_plan_kvj
, dt2.umsatz_wrg
FROM
(
SELECT
dt1.kjmo
, dt1.gjmo
, dt1.akt_gj
, dt1.akt_mo
, dt1.mo_kj
, dt1.wup_id
, dt1.nb_id
, dt1.mandant_id
, dt1.umsatz_wrg
, dt1.ums_n_ker
, dt1.ums_n_ker_kvj
, dt1.ums_n_ker_kvvj
, dt1.ums_n_ker_kvvvj
, dt1.ums_n_ker_plan
, dt1.ums_n_ker_plan_kvj
, dt1.rohertrag
, dt1.rohertrag_kvj
, dt1.rohertrag_kvvj
, dt1.rohertrag_kvvvj
, dt1.rohertrag_plan
, dt1.rohertrag_plan_kvj
, dt1.pk_ker
, dt1.pk_ker_kvj
, dt1.pk_ker_kvvj
, dt1.pk_ker_kvvvj
, dt1.pk_ker_plan
, dt1.pk_ker_plan_kvj
, dt1.pk_ohne
, dt1.pk_ohne_kvj
, dt1.pk_ohne_kvvj
, dt1.pk_ohne_kvvvj
, dt1.pk_ohne_plan
, dt1.pk_ohne_plan_kvj
FROM
(
SELECT
MAX(coalesce(ma.kjmo,t1.kjmo)) AS kjmo
, MAX(coalesce(ma.gjmo,t1.gjmo)) AS gjmo
, MAX(coalesce(ma.akt_gj,t1.akt_gj)) AS akt_gj
, MAX(coalesce(ma.akt_mo,t1.akt_mo)) AS akt_mo
, MAX(coalesce(ma.mo_kj,t1.mo_kj)) AS mo_kj
, t1.wup_id
, t1.nb_id
, t1.mandant_id
, t1.umsatz_wrg
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_     THEN t1.ums_n_ker      ELSE 0 END)AS ums_n_ker
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 1 THEN t1.ums_n_ker      ELSE 0 END)AS ums_n_ker_kvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 2 THEN t1.ums_n_ker      ELSE 0 END)AS ums_n_ker_kvvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 3 THEN t1.ums_n_ker      ELSE 0 END)AS ums_n_ker_kvvvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_     THEN t1.ums_n_ker_plan ELSE 0 END)AS ums_n_ker_plan
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 1 THEN t1.ums_n_ker_plan ELSE 0 END)AS ums_n_ker_plan_kvj

, SUM(CASE WHEN t1.gj   = cgj.akt_gj_     THEN t1.rohertrag      ELSE 0  END)AS rohertrag
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 1 THEN t1.rohertrag      ELSE 0  END)AS rohertrag_kvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 2 THEN t1.rohertrag      ELSE 0  END)AS rohertrag_kvvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 3 THEN t1.rohertrag      ELSE 0  END)AS rohertrag_kvvvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_     THEN t1.rohertrag_plan ELSE 0  END)AS rohertrag_plan
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 1 THEN t1.rohertrag_plan ELSE 0  END)AS rohertrag_plan_kvj

, SUM(CASE WHEN t1.gj   = cgj.akt_gj_     THEN t1.pk_ker       ELSE 0    END)AS pk_ker
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 1 THEN t1.pk_ker       ELSE 0    END)AS pk_ker_kvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 2 THEN t1.pk_ker       ELSE 0    END)AS pk_ker_kvvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 3 THEN t1.pk_ker       ELSE 0    END)AS pk_ker_kvvvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_     THEN t1.pk_ker_plan  ELSE 0    END)AS pk_ker_plan
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 1 THEN t1.pk_ker_plan  ELSE 0    END)AS pk_ker_plan_kvj

, SUM(CASE WHEN t1.gj   = cgj.akt_gj_     THEN t1.pk_ohne      ELSE 0    END)AS pk_ohne
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 1 THEN t1.pk_ohne      ELSE 0    END)AS pk_ohne_kvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 2 THEN t1.pk_ohne      ELSE 0    END)AS pk_ohne_kvvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 3 THEN t1.pk_ohne      ELSE 0    END)AS pk_ohne_kvvvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_     THEN t1.pk_ohne_plan ELSE 0    END)AS pk_ohne_plan
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 1 THEN t1.pk_ohne_plan ELSE 0    END)AS pk_ohne_plan_kvj

FROM DBP_ETL.kostenrechnung_tmp_2 t1_2

INNER JOIN
-- das aktuelle Geschäftsjahr
(
SELECT gj akt_gj_
FROM DBP_DATA.tag_2
WHERE akt_tag = 0
) cgj
-- nur Daten aus dem aktuellen Jahr und den Jahren davor
ON t1.gj <= cgj.akt_gj_

LEFT OUTER JOIN DBP_DATA.monat_2 ma
ON cgj.akt_gj_ = ma.gj
AND  MOD(t1.kjmo,100) = MOD(ma.kjmo,100)
GROUP BY
t1.wup_id
, t1.nb_id
, t1.mandant_id
, t1.umsatz_wrg
, MOD(t1.gjmo,100)
) dt1
)dt2

LEFT JOIN DBP_DATA.l_buchungsstatus_ker_2 bk
ON bk.kj_ker_mo_id = dt2.kjmo

;

/*
#------------------------------------------------------------------------------
#12) Die Daten für das Vorjahr werden eingefügt.
#----------------------------------------------------------------------------
*/


INSERT INTO DBP_ETL.vis_ker_monat_wup_tmp_2
(
kjmo
, gjmo
, gj
, akt_gj
, akt_mo
, mo_kj
, wup_id
, nb_id
, mandant_id
, ums_n_ker
, ums_n_ker_kvj
, ums_n_ker_kvvj
, ums_n_ker_kvvvj
, ums_n_ker_plan
, ums_n_ker_plan_kvj
, rohertrag
, rohertrag_kvj
, rohertrag_kvvj
, rohertrag_kvvvj
, rohertrag_plan
, rohertrag_plan_kvj
, pk_ker
, pk_ker_kvj
, pk_ker_kvvj
, pk_ker_kvvvj
, pk_ker_plan
, pk_ker_plan_kvj
, pk_ohne
, pk_ohne_kvj
, pk_ohne_kvvj
, pk_ohne_kvvvj
, pk_ohne_plan
, pk_ohne_plan_kvj
, umsatz_wrg
)
SELECT
dt2.kjmo
, dt2.gjmo
, floor(dt2.gjmo/100) -- floor required for SF
, dt2.akt_gj 
, dt2.akt_mo 
, dt2.mo_kj
, dt2.wup_id
, dt2.nb_id
, dt2.mandant_id
, dt2.ums_n_ker
, dt2.ums_n_ker_kvj
, dt2.ums_n_ker_kvvj
, dt2.ums_n_ker_kvvvj
, dt2.ums_n_ker_plan
, dt2.ums_n_ker_plan_kvj
, CASE WHEN bk.akt_buchungs_schluss <= 0 OR MOD(dt2.kjmo,100) = 13 THEN dt2.rohertrag ELSE 0 END rohertrag
, dt2.rohertrag_kvj
, dt2.rohertrag_kvvj
, dt2.rohertrag_kvvvj
, dt2.rohertrag_plan
, dt2.rohertrag_plan_kvj
, CASE WHEN bk.akt_buchungs_schluss <= 0 OR MOD(dt2.kjmo,100) = 13 THEN dt2.pk_ker -- Buchungsschluss
        WHEN bk.akt_fruehinfo2 = 0 THEN dt2.pk_ker        -- Frühinfo 2 (KMO & DE)
        ELSE 0 -- XLS Werte separat
  END pk_ker
, dt2.pk_ker_kvj
, dt2.pk_ker_kvvj
, dt2.pk_ker_kvvvj
, dt2.pk_ker_plan
, dt2.pk_ker_plan_kvj
, CASE WHEN bk.akt_buchungs_schluss <= 0 OR MOD(dt2.kjmo,100) = 13 THEN dt2.pk_ohne -- Buchungsschluss
       WHEN bk.akt_fruehinfo2 = 0 THEN dt2.pk_ohne        -- Frühinfo 2 (KMO & DE)
  ELSE 0 -- XLS Werte separat
  END pk_ohne
, dt2.pk_ohne_kvj
, dt2.pk_ohne_kvvj
, dt2.pk_ohne_kvvvj
, dt2.pk_ohne_plan
, dt2.pk_ohne_plan_kvj
, dt2.umsatz_wrg
FROM
(
SELECT
dt1.kjmo
, dt1.gjmo
, dt1.akt_gj
, dt1.akt_mo
, dt1.mo_kj
, dt1.wup_id
, dt1.nb_id
, dt1.mandant_id
, dt1.umsatz_wrg
, dt1.ums_n_ker
, dt1.ums_n_ker_kvj
, dt1.ums_n_ker_kvvj
, dt1.ums_n_ker_kvvvj
, dt1.ums_n_ker_plan
, dt1.ums_n_ker_plan_kvj
, dt1.rohertrag
, dt1.rohertrag_kvj
, dt1.rohertrag_kvvj
, dt1.rohertrag_kvvvj
, dt1.rohertrag_plan
, dt1.rohertrag_plan_kvj
, dt1.pk_ker
, dt1.pk_ker_kvj
, dt1.pk_ker_kvvj
, dt1.pk_ker_kvvvj
, dt1.pk_ker_plan
, dt1.pk_ker_plan_kvj
, dt1.pk_ohne
, dt1.pk_ohne_kvj
, dt1.pk_ohne_kvvj
, dt1.pk_ohne_kvvvj
, dt1.pk_ohne_plan
, dt1.pk_ohne_plan_kvj
FROM
(
SELECT
MAX(coalesce(ma.kjmo,t1.kjmo)) AS kjmo
, MAX(coalesce(ma.gjmo,t1.gjmo)) AS gjmo
, MAX(coalesce(ma.akt_gj,t1.akt_gj)) AS akt_gj
, MAX(coalesce(ma.akt_mo,t1.akt_mo)) AS akt_mo
, MAX(coalesce(ma.mo_kj,t1.mo_kj)) AS mo_kj
, t1.wup_id
, t1.nb_id
, t1.mandant_id
, t1.umsatz_wrg
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_     THEN t1.ums_n_ker      ELSE 0 END)AS ums_n_ker
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 1 THEN t1.ums_n_ker      ELSE 0 END)AS ums_n_ker_kvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 2 THEN t1.ums_n_ker      ELSE 0 END)AS ums_n_ker_kvvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 3 THEN t1.ums_n_ker      ELSE 0 END)AS ums_n_ker_kvvvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_     THEN t1.ums_n_ker_plan ELSE 0 END)AS ums_n_ker_plan
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 1 THEN t1.ums_n_ker_plan ELSE 0 END)AS ums_n_ker_plan_kvj

, SUM(CASE WHEN t1.gj   = cgj.akt_gj_     THEN t1.rohertrag      ELSE 0  END)AS rohertrag
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 1 THEN t1.rohertrag      ELSE 0  END)AS rohertrag_kvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 2 THEN t1.rohertrag      ELSE 0  END)AS rohertrag_kvvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 3 THEN t1.rohertrag      ELSE 0  END)AS rohertrag_kvvvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_     THEN t1.rohertrag_plan ELSE 0  END)AS rohertrag_plan
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 1 THEN t1.rohertrag_plan ELSE 0  END)AS rohertrag_plan_kvj

, SUM(CASE WHEN t1.gj   = cgj.akt_gj_     THEN t1.pk_ker       ELSE 0    END)AS pk_ker
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 1 THEN t1.pk_ker       ELSE 0    END)AS pk_ker_kvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 2 THEN t1.pk_ker       ELSE 0    END)AS pk_ker_kvvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 3 THEN t1.pk_ker       ELSE 0    END)AS pk_ker_kvvvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_     THEN t1.pk_ker_plan  ELSE 0    END)AS pk_ker_plan
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 1 THEN t1.pk_ker_plan  ELSE 0    END)AS pk_ker_plan_kvj

, SUM(CASE WHEN t1.gj   = cgj.akt_gj_     THEN t1.pk_ohne      ELSE 0    END)AS pk_ohne
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 1 THEN t1.pk_ohne      ELSE 0    END)AS pk_ohne_kvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 2 THEN t1.pk_ohne      ELSE 0    END)AS pk_ohne_kvvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 3 THEN t1.pk_ohne      ELSE 0    END)AS pk_ohne_kvvvj
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_     THEN t1.pk_ohne_plan ELSE 0    END)AS pk_ohne_plan
, SUM(CASE WHEN t1.gj   = cgj.akt_gj_ - 1 THEN t1.pk_ohne_plan ELSE 0    END)AS pk_ohne_plan_kvj

FROM DBP_ETL.kostenrechnung_tmp_2 t1_2

INNER JOIN
-- das aktuelle Geschäftsjahr
(
SELECT gj akt_gj_
FROM DBP_DATA.tag_2
WHERE akt_gj = 1
GROUP BY 1
) cgj
-- nur Daten aus dem aktuellen Jahr und den Jahren davor
ON t1.gj <= cgj.akt_gj_

LEFT OUTER JOIN DBP_DATA.monat_2 ma
ON cgj.akt_gj_ = ma.gj
AND MOD(t1.kjmo,100) = MOD(ma.kjmo,100)
GROUP BY
t1.wup_id
, t1.nb_id
, t1.mandant_id
, t1.umsatz_wrg
,MOD(t1.gjmo,100)
) dt1
)dt2

LEFT JOIN DBP_DATA.l_buchungsstatus_ker_2 bk
ON bk.kj_ker_mo_id = dt2.kjmo

WHERE dt2.kjmo NOT IN (SELECT kjmo FROM DBP_ETL.vis_ker_monat_wup_tmp_2) AND
      dt2.kjmo IN (SELECT kjmo FROM DBP_DATA.monat_2 WHERE akt_gj IN (1) AND MOD(kjmo,100) IN (3,4,5,6))

;

/*
#------------------------------------------------------------------------------
#13) Die Daten für das Vorvorjahr werden eingefügt.
#----------------------------------------------------------------------------
*/


INSERT INTO DBP_ETL.vis_ker_monat_wup_tmp_2 

(
  kjmo                       
, gjmo                       
, gj
, akt_gj
, akt_mo
, mo_kj                       
, wup_id                     
, nb_id                      
, mandant_id                 
, ums_n_ker                  
, ums_n_ker_kvj               
, ums_n_ker_kvvj              
, ums_n_ker_plan             
, rohertrag                  
, rohertrag_kvj               
, rohertrag_kvvj              
, rohertrag_plan             
, pk_ker                     
, pk_ker_kvj                  
, pk_ker_kvvj                 
, pk_ker_plan                
, pk_ohne                     
, pk_ohne_kvj                  
, pk_ohne_kvvj                 
, pk_ohne_plan  
, umsatz_wrg
)
SELECT
  kjmo - 100                       
, gjmo - 100                      
, gj   - 1
, akt_gj - 1
, akt_mo -12
, mo_kj                        
, wup_id                     
, nb_id                      
, mandant_id                 
, ums_n_ker_kvj               AS ums_n_ker                  
, ums_n_ker_kvvj              AS ums_n_ker_kvj               
, ums_n_ker_kvvvj             AS ums_n_ker_kvvj               
, ums_n_ker_plan_kvj          AS ums_n_ker_plan             
,CASE WHEN bk.akt_buchungs_schluss <= 0 OR MOD(kjmo,100) = 13 THEN rohertrag_kvj ELSE 0 
END AS rohertrag
--, rohertrag_kvj               AS rohertrag               
, rohertrag_kvvj              AS rohertrag_kvj               
, rohertrag_kvvvj             AS rohertrag_kvvj               
, rohertrag_plan_kvj          AS rohertrag_plan             
,CASE WHEN bk.akt_buchungs_schluss <= 0 OR MOD(kjmo,100) = 13 THEN pk_ker_kvj -- Buchungsschluss
WHEN bk.akt_fruehinfo2 = 0 THEN pk_ker_kvj        -- Frühinfo 2 (KMO & DE)
END AS pk_ker                     
--, pk_ker_kvj                  AS pk_ker 
, pk_ker_kvvj                 AS pk_ker_kvj                
, pk_ker_kvvvj                AS pk_ker_kvvj                  
, pk_ker_plan_kvj             AS pk_ker_plan
,CASE WHEN bk.akt_buchungs_schluss <= 0 OR MOD(kjmo,100) = 13 THEN pk_ohne_kvj -- Buchungsschluss
WHEN bk.akt_fruehinfo2 = 0 THEN pk_ohne_kvj        -- Frühinfo 2 (KMO & DE)
END AS pk_ohne                     
--, pk_ohne_kvj                  AS pk_ohne
, pk_ohne_kvvj                 AS pk_ohne_kvj                
, pk_ohne_kvvvj                AS pk_ohne_kvvj                  
, pk_ohne_plan_kvj             AS pk_ohne_plan                                
, umsatz_wrg
FROM DBP_ETL.vis_ker_monat_wup_tmp_2  ker

LEFT JOIN DBP_DATA.l_buchungsstatus_ker_2 bk
ON bk.kj_ker_mo_id = ker.kjmo-100

WHERE ker.kjmo NOT IN (SELECT kjmo FROM DBP_DATA.monat_2 WHERE akt_gj IN (1) AND MOD(kjmo,100) IN (3,4,5,6))

;

INSERT INTO dbp_etl.vis_ker_monat_wup_tmp_2 

(
  kjmo                       
, gjmo                       
, gj
, akt_gj
, akt_mo
, mo_kj                       
, wup_id                     
, nb_id                      
, mandant_id                 
, ums_n_ker                  
, ums_n_ker_kvj                                        
, rohertrag                  
, rohertrag_kvj                      
, pk_ker                     
, pk_ker_kvj                              
, pk_ohne                     
, pk_ohne_kvj                   
, umsatz_wrg
)
SELECT
  kjmo - 200                       
, gjmo - 200                      
, gj   - 2
, akt_gj - 2
, akt_mo - 24
, mo_kj                        
, wup_id                     
, nb_id                      
, mandant_id                 
, ums_n_ker_kvvj               AS ums_n_ker                  
, ums_n_ker_kvvvj              AS ums_n_ker_kvj    
,CASE WHEN bk.akt_buchungs_schluss <= 0 OR MOD(kjmo,100) = 13 THEN rohertrag_kvvj ELSE 0 
END AS rohertrag
--, rohertrag_kvj               AS rohertrag               
, rohertrag_kvvvj              AS rohertrag_kvj                        
,CASE WHEN bk.akt_buchungs_schluss <= 0 OR MOD(kjmo,100) = 13 THEN pk_ker_kvvj -- Buchungsschluss
WHEN bk.akt_fruehinfo2 = 0 THEN pk_ker_kvvj        -- Frühinfo 2 (KMO & DE)
END AS pk_ker                     
--, pk_ker_kvj                  AS pk_ker 
, pk_ker_kvvvj                 AS pk_ker_kvj                
,CASE WHEN bk.akt_buchungs_schluss <= 0 OR MOD(kjmo,100) = 13 THEN pk_ohne_kvvj -- Buchungsschluss
WHEN bk.akt_fruehinfo2 = 0 THEN pk_ohne_kvvj        -- Frühinfo 2 (KMO & DE)
END AS pk_ohne                     
--, pk_ohne_kvj                  AS pk_ohne
, pk_ohne_kvvvj                 AS pk_ohne_kvj                                               
, umsatz_wrg
FROM dbp_etl.vis_ker_monat_wup_tmp_2  ker

LEFT JOIN dbp_data.l_buchungsstatus_ker_2 bk
ON bk.kj_ker_mo_id = ker.kjmo-100
WHERE ker.kjmo NOT IN (SELECT kjmo FROM dbp_data.monat_2 WHERE akt_gj IN (1) AND MOD(kjmo,100) IN (3,4,5,6))

;

/*
#------------------------------------------------------------------------------
#14) Alle DS mit wrg_id <>'EUR' werden in EUR umgerechnen und eingefuegt.
#----------------------------------------------------------------------------
*/


--[OK] statement is translated correctly (syntax and type checks are fine)
INSERT INTO DBP_ETL.vis_ker_monat_wup_tmp_2 

(
  kjmo                       
, gjmo                       
, gj
, akt_gj
, akt_mo
, mo_kj                       
, wup_id                     
, nb_id                      
, mandant_id                 
, ums_n_ker                  
, ums_n_ker_plan             
, ums_n_ker_kvj               
, ums_n_ker_kvvj              
, rohertrag                  
, rohertrag_plan             
, rohertrag_kvj               
, rohertrag_kvvj              
, pk_ker                     
, pk_ker_plan                
, pk_ker_kvj                  
, pk_ker_kvvj   
, pk_ohne                     
, pk_ohne_plan                
, pk_ohne_kvj                  
, pk_ohne_kvvj                 
, umsatz_wrg
)
SELECT
  a.kjmo                       
, a.gjmo                       
, a.gj
, a.akt_gj  
, a.akt_mo  
, a.mo_kj                          
, a.wup_id                     
, a.nb_id                      
, a.mandant_id                 
, a.ums_n_ker                   * k.umrechnungskurs
, a.ums_n_ker_plan              * k.umrechnungskurs
, a.ums_n_ker_kvj                * k.umrechnungskurs
, a.ums_n_ker_kvvj               * k.umrechnungskurs
, a.rohertrag                   * k.umrechnungskurs
, a.rohertrag_plan              * k.umrechnungskurs
, a.rohertrag_kvj                * k.umrechnungskurs
, a.rohertrag_kvvj               * k.umrechnungskurs
, a.pk_ker                      * k.umrechnungskurs
, a.pk_ker_plan                 * k.umrechnungskurs
, a.pk_ker_kvj                   * k.umrechnungskurs
, a.pk_ker_kvvj                  * k.umrechnungskurs
, a.pk_ohne                      * k.umrechnungskurs
, a.pk_ohne_plan                 * k.umrechnungskurs
, a.pk_ohne_kvj                   * k.umrechnungskurs
, a.pk_ohne_kvvj                  * k.umrechnungskurs
, k.nach_wrg_id AS umsatz_wrg
FROM DBP_ETL.vis_ker_monat_wup_tmp_2 a

INNER JOIN DBP_DATA.kurs_2 k
ON k.von_wrg_id = a.umsatz_wrg 
AND k.dat_bis = to_date('9999-12-31','YYYY-MM_2-DD')
AND k.nach_wrg_id = 'EUR'
AND k.kurstyp_id = 3

WHERE a.umsatz_wrg <> 'EUR';




UPDATE DBP_ETL.vis_ker_monat_wup_tmp_2  

SET akt_gj = x.akt_gj, akt_mo = x.akt_mo, mo_kj = x.mo_kj
FROM (
SELECT

a.gjmo AS gjmo_ 
,MAX(b.akt_gj) AS akt_gj
,MAX(b.akt_mo) AS akt_mo
,MAX(b.mo_kj) AS mo_kj
FROM DBP_ETL.vis_ker_monat_wup_tmp_2 a
LEFT JOIN DBP_DATA.monat_2 b
ON b.gjmo = a.gjmo -1
WHERE  MOD(a.gjmo,100)= 13
GROUP BY 1
)x WHERE  MOD(gjmo,100) = 13 AND gjmo = gjmo_;


/*
#------------------------------------------------------------------------------
#15) Rohertrag Fruehinfo 2
#----------------------------------------------------------------------------
*/


INSERT INTO DBP_ETL.vis_ker_monat_wup_tmp_2 
(
 kjmo                       
, gjmo                       
, gj
, akt_gj
, akt_mo
, mo_kj                       
, wup_id                     
, nb_id                      
, mandant_id                 
, ums_n_ker                  
, ums_n_ker_plan             
, ums_n_ker_kvj               
, ums_n_ker_kvvj              
, rohertrag                  
, rohertrag_plan             
, rohertrag_kvj               
, rohertrag_kvvj              
, pk_ker                     
, pk_ker_plan                
, pk_ker_kvj                  
, pk_ker_kvvj
, pk_ohne                     
, pk_ohne_plan                
, pk_ohne_kvj                  
, pk_ohne_kvvj                
, umsatz_wrg
) SELECT 
m.kjmo AS kjmo
,m.gjmo AS gjmo
,m.gj AS gj
,m.akt_gj AS akt_gj
,m.akt_mo  AS akt_mo
,m.mo_kj AS mo_kj
,re.wup_id AS wup_id
,re.nb_id AS nb_id
,re.mandant_id AS mandant_id
,0
,0
,0
,0
,re.rohertrag_ist AS rohertrag
,0
,0
,0
,0
,0
,0
,0
,0
,0
,0
,0
,'EUR' AS umsatz_wgr
FROM 
DBP_ETL_PROCESS.rohertrag_man_2 re_2

INNER JOIN DBP_ETL.vis_mandant_2 ma
ON ma.mandant_id = re.mandant_id

INNER JOIN DBP_DATA.l_buchungsstatus_ker_2 bk
ON bk.kj_ker_mo_id = re.kjmo

INNER JOIN DBP_DATA.monat_2 m
on m.kjmo = re.kjmo

WHERE bk.akt_fruehinfo2 = 0 and bk.akt_buchungs_schluss = 1
;

/*
#------------------------------------------------------------------------------
#16) Personalkosten_2 DE Fruehinfo 1
#----------------------------------------------------------------------------
*/
INSERT INTO DBP_ETL.vis_ker_monat_wup_tmp_2 
(
 kjmo 
, gjmo
, gj
, akt_gj
, akt_mo
, mo_kj
, wup_id
, nb_id
, mandant_id                 
, ums_n_ker                  
, ums_n_ker_plan             
, ums_n_ker_kvj               
, ums_n_ker_kvvj              
, rohertrag                  
, rohertrag_plan             
, rohertrag_kvj               
, rohertrag_kvvj              
, pk_ker                     
, pk_ker_plan                
, pk_ker_kvj                  
, pk_ker_kvvj     
, pk_ohne                     
, pk_ohne_plan                
, pk_ohne_kvj                  
, pk_ohne_kvvj              
, umsatz_wrg
) SELECT 
m.kjmo AS kjmo
,m.gjmo AS gjmo
,m.gj AS gj
,m.akt_gj AS akt_gj
,m.akt_mo  AS akt_mo
,m.mo_kj AS mo_kj
,pk.wup_id AS wup_id
,pk.nb_id AS nb_id
,pk.mandant_id AS mandant_id
,0
,0
,0
,0
,0
,0
,0
,0
,COALESCE(pk.kosten_ist,0) AS pk_ker
,0
,0
,0
,COALESCE(pk1.kosten_ist,0) AS pk_ohne
,0
,0
,0
,'EUR' AS umsatz_wgr
FROM
DBP_ETL_PROCESS.personalkosten_2 pk 

LEFT JOIN DBP_ETL_PROCESS.personalkosten_2 pk1
ON pk.mandant_id = pk1.mandant_id
AND pk.nb_id = pk1.nb_id
AND pk.wup_id = pk1.wup_id
AND pk.kjmo = pk1.kjmo
AND pk1.abgr_fg = 0

INNER JOIN DBP_ETL.vis_mandant_2 ma
ON ma.mandant_id = pk.mandant_id

INNER JOIN DBP_DATA.l_buchungsstatus_ker_2 bk
ON bk.kj_ker_mo_id = pk.kjmo

INNER JOIN DBP_DATA.monat_2 m
ON m.kjmo = pk.kjmo

WHERE bk.akt_fruehinfo1 >= 0 AND bk.akt_buchungs_schluss = 1 AND pk.mandant_id = 1 AND pk.abgr_fg = 1 AND
      -- dbay, 18.05.2016
      --
      -- Da wir die Fruehinfo 2 uebernehmen, duerfen hier nicht etwaige Einser noch mitgezogen werden!
      -- Muessen rausgefiltert werden, sonst gibt's Dopplungen!
     (m.kjmo,m.gjmo,m.gj,m.akt_gj,m.akt_mo,m.mo_kj,pk.wup_id,pk.nb_id,pk.mandant_id) NOT IN (SELECT kjmo,gjmo,gj,akt_gj,akt_mo,mo_kj,wup_id,nb_id,mandant_id FROM DBP_ETL.vis_ker_monat_wup_tmp_2)
;

/*
#------------------------------------------------------------------------------
# 17) Wup_2 Merging WUP_ID_ALT durch WUP_ID
#----------------------------------------------------------------------------
*/

UPDATE DBP_ETL.vis_ker_monat_wup_tmp_2


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
 AND t2.dat_von <= CURRENT_DATE) x1
 WHERE mandant_id = mandant_id_
AND nb_id = nb_id_
AND wup_id = wup_id_alt_
;

