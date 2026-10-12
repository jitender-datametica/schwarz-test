--[OK] statement is translated correctly (syntax and type checks are fine)
CREATE TABLE DBP_ETL.wup_monat_tmp_2  (      
      mandant_id                 BYTEINT,
      wup_id                     INTEGER,
      nb_id                      BYTEINT,      
      gj                         SMALLINT,
      kjmo                       INTEGER NOT NULL,
      gjmo                       INTEGER NOT NULL,
      akt_gj                     SMALLINT,
      akt_mo                     SMALLINT,
      mo_kj                      BYTEINT,
      umsatz_wrg                 CHAR(3)     
     )
;



/*
#------------------------------------------------------------------------------
# 7) aus GJ werden GJ -2 DS für alle WUP_2's erzeugt. Auf Markt/WUP_2 Ebene.
#----------------------------------------------------------------------------
*/


INSERT INTO DBP_ETL.wup_monat_tmp_2
(
mandant_id
, wup_id
, nb_id
, umsatz_wrg
, gj
, kjmo
, gjmo
, akt_gj
, akt_mo
, mo_kj
)
SELECT
w.mandant_id
, w.wup_id
, w.nb_id
, ma.default_wrg AS umsatz_wrg
, mo.gj
, mo.kjmo
, mo.gjmo
, coalesce(mo.akt_gj,m2.akt_gj) AS akt_gj
, COALESCE(mo.akt_mo,m2.akt_mo) AS akt_mo
, COALESCE(mo.mo_kj,m2.mo_kj) AS mo_kj
FROM DBP_DATA.wup_2 w

INNER JOIN DBP_DATA.mandant_2 ma
ON w.mandant_id = ma.mandant_id

CROSS JOIN
( SELECT  coalesce(akt_gj_mo.gj, floor(periode.kj_ker_mo_id/100)) gj  -- floor required for SF
, coalesce(akt_gj_mo.kjmo, periode.kj_ker_mo_id) kjmo
, coalesce(akt_gj_mo.gjmo, periode.kj_ker_mo_id) gjmo
, akt_gj_mo.akt_gj
, akt_gj_mo.akt_mo
, akt_gj_mo.mo_kj
FROM
(SELECT kj_ker_mo_id from
DBP_DATA.ker_mo_periode_zu_2
WHERE krk_id = 'DE01' group by 1)  periode
FULL OUTER JOIN
DBP_DATA.monat_2 akt_gj_mo
on akt_gj_mo.kjmo = periode.kj_ker_mo_id
WHERE 
coalesce(akt_gj_mo.gj, floor(periode.kj_ker_mo_id/100)) BETWEEN EXTRACT(YEAR FROM CURRENT_DATE) -2 AND EXTRACT(YEAR FROM CURRENT_DATE) -- floor required for SF
group by 1,2,3,4,5,6) mo
LEFT JOIN DBP_DATA.monat_2 m2
ON m2.kjmo = mo.kjmo-1
WHERE w.nb_id IN (-2,-1,0,2,7)
and w.dat_eroeffnung is not null

;

/*
#------------------------------------------------------------------------------
# 8) Alle fehlenden DS in der Kostenrechnung_2 werden mit Umsatz = 0 befuellt
#----------------------------------------------------------------------------
*/

INSERT INTO DBP_ETL.kostenrechnung_tmp_2
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
, umsatz_wrg      
, ums_n_ker                  
, ums_n_ker_plan             
, rohertrag                  
, rohertrag_plan             
, pk_ker                     
, pk_ker_plan    
, pk_ohne                     
, pk_ohne_plan       
)
SELECT
 wup_mo_tmp.kjmo
,wup_mo_tmp.gjmo
,wup_mo_tmp.gj
,wup_mo_tmp.akt_gj
,wup_mo_tmp.akt_mo
,wup_mo_tmp.mo_kj
,wup_mo_tmp.wup_id
,wup_mo_tmp.nb_id
,wup_mo_tmp.mandant_id
,wup_mo_tmp.umsatz_wrg
,0 AS ums_n_ker
,0 AS ums_n_ker_plan
,0 AS rohertrag
,0 AS rohertrag_plan
,0 AS pk_ker
,0 AS pk_ker_plan   
,0 AS pk_ohne
,0 AS pk_ohne_plan  
FROM DBP_ETL.wup_monat_tmp_2 wup_mo_tmp
WHERE
NOT EXISTS
(
SELECT *  
FROM DBP_ETL.kostenrechnung_tmp_2 kos_tmp
  WHERE wup_mo_tmp.mandant_id   = kos_tmp.mandant_id
        AND wup_mo_tmp.wup_id   = kos_tmp.wup_id
        AND wup_mo_tmp.nb_id    = kos_tmp.nb_id
        AND wup_mo_tmp.kjmo     = kos_tmp.kjmo  
)
;

