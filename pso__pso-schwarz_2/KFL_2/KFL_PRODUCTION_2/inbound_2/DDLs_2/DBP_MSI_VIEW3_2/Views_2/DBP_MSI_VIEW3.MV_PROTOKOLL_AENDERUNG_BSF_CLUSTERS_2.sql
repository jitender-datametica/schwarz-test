CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_PROTOKOLL_AENDERUNG_BSF_CLUSTERS_2(
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	LAGERNUMMER_ID,
	BEREITSTELLUNGSFLAECHE,
	REFERENZNUMMER,
	DAT_TOUR,
	ERSTER_DATE_BASIS_BSF,
	ERSTER_ZEITSTEMPEL_BASIS_BSF,
	LETZTER_DATE_BASIS_BSF,
	LETZTER_ZEITSTEMPEL_BASIS_BSF,
	ERSTER_DATE_BASIS_TOUR,
	ERSTER_ZEITSTEMPEL_BASIS_TOUR,
	LETZTER_DATE_BASIS_TOUR,
	LETZTER_ZEITSTEMPEL_BASIS_TOUR,
	CLUSTER_ID,
	CLUSTER_ELEMENT_ID
) AS
-- 2022-12-16, dknop, AP0150311_SPEC0174516, initial, copy of MV_PROTOKOLL_AENDERUNG_BSF_2 but with clusters
WITH all_tour ( 
  wup_id
 ,nb_id
 ,mandant_id
 ,referenznummer
 ,erster_date_basis_Tour   
 ,erster_zeitstempel_basis_Tour
 ,letzter_date_basis_Tour
 ,letzter_zeitstempel_basis_Tour 
  ) 
AS
(
SELECT 
  v01.wup_id
 ,v01.nb_id
 ,v01.mandant_id
 ,CASE WHEN v01.referenznummer='' THEN '-1' ELSE v01.referenznummer END AS referenznummer
 ,MIN(DATE(v01.dat_aenderung)) AS erster_zeitstempel_basis_Tour
 ,MIN(datzeit_aenderung_UTC) AS erster_date_basis_Tour   
 ,MAX(DATE(v01.dat_aenderung)) AS letzter_date_basis_Tour
 ,MAX(datzeit_aenderung_UTC) AS letzter_zeitstempel_basis_Tour                 
FROM dbp_view.v_protokoll_aenderung_bsf_2 v01
  GROUP BY
  v01.wup_id
 ,v01.nb_id
 ,v01.mandant_id
 ,v01.referenznummer
   ),
      
all_BSF ( 
  wup_id
 ,nb_id
 ,mandant_id
 ,lagernummer_id
 ,bereitstellungsflaeche
 ,referenznummer
 ,erster_date_basis_BSF
 ,erster_zeitstempel_basis_BSF
 ,letzter_date_basis_BSF
 ,letzter_zeitstempel_basis_BSF
   ) 
AS
(
SELECT 
  v01.wup_id
 ,v01.nb_id
 ,v01.mandant_id
 ,v01.lagernummer_id
 ,v01.bereitstellungsflaeche
 ,CASE WHEN v01.referenznummer='' THEN '-1' ELSE v01.referenznummer END AS referenznummer
 ,MIN(DATE(v01.dat_aenderung)) AS erster_date_basis_BSF
 ,MIN(v01.datzeit_aenderung_UTC) AS erster_zeitstempel_basis_BSF
 ,MAX(DATE(v01.dat_aenderung)) AS letzter_date_basis_BSF
 ,MAX(v01.datzeit_aenderung_UTC) AS letzter_zeitstempel_basis_BSF                 
FROM dbp_view.v_protokoll_aenderung_bsf_2 v01
    GROUP BY
  v01.wup_id
 ,v01.nb_id
 ,v01.mandant_id
 ,v01.lagernummer_id
 ,v01.bereitstellungsflaeche
 ,v01.referenznummer
   )
 
SELECT
  t01.wup_id
 ,t01.nb_id
 ,t01.mandant_id
 ,t01.lagernummer_id
 ,t01.bereitstellungsflaeche
 ,CAST(t01.referenznummer AS NUMBER(18,0)) AS referenznummer
 ,v02.dat_tour
 ,t01.erster_date_basis_BSF
 ,TO_TIMESTAMP(t01.erster_zeitstempel_basis_BSF) AS erster_zeitstempel_basis_BSF
 ,t01.letzter_date_basis_BSF
 ,TO_TIMESTAMP(t01.letzter_zeitstempel_basis_BSF) AS letzter_zeitstempel_basis_BSF
 
 
 ,t02.erster_date_basis_Tour
 ,TO_TIMESTAMP(t02.erster_zeitstempel_basis_Tour) AS erster_zeitstempel_basis_Tour
 ,t02.letzter_date_basis_Tour
 ,TO_TIMESTAMP(t02.letzter_zeitstempel_basis_Tour) AS letzter_zeitstempel_basis_Tour

,v3.cluster_id
,v3.cluster_element_id
 
 FROM all_BSF t01
 LEFT JOIN all_tour t02 ON t01.referenznummer=t02.referenznummer AND t01.wup_id=t02.wup_id
 LEFT JOIN dbp_view.v_tour_2 v02 ON CAST(t01.referenznummer AS NUMBER(18,0))=v02.tour_id
                              AND t01.mandant_id=v02.mandant_id
                              AND t01.wup_id=v02.wup_id
LEFT JOIN dbp_msi_data.ts_scm_cluster_2 v3
ON CAST (( CAST (letzter_zeitstempel_basis_bsf AS DATE) - CAST(erster_zeitstempel_basis_bsf AS DATE))*86400 AS INTEGER)
+ (CAST (EXTRACT (HOUR FROM CAST(letzter_zeitstempel_basis_bsf AS TIMESTAMP))AS INTEGER)- CAST(EXTRACT(HOUR FROM CAST (erster_zeitstempel_basis_bsf AS TIMESTAMP)) AS INTEGER ))*3600
+ (CAST (EXTRACT(MINUTE FROM CAST(letzter_zeitstempel_basis_bsf AS TIMESTAMP))AS INTEGER)- CAST(EXTRACT(MINUTE FROM CAST (erster_zeitstempel_basis_bsf  AS TIMESTAMP)) AS INTEGER ))*60
+ (CAST (EXTRACT(SECOND FROM CAST(letzter_zeitstempel_basis_bsf AS TIMESTAMP))AS INTEGER)- CAST(EXTRACT(SECOND FROM CAST (erster_zeitstempel_basis_bsf  AS TIMESTAMP)) AS INTEGER )) BETWEEN wert_von AND wert_bis
AND cluster_id IN (2,3)

--where CAST(t01.referenznummer AS NUMBER(18,0))=26499514 
                        
                             ;