create or replace view DBP_MSI_VIEW3_MATERIALIZED.MV_PROTOKOLL_AENDERUNG_LAGERNUMMER_1(
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	LAGERNUMMER_ID,
	REFERENZNUMMER,
	DAT_TOUR,
	ERSTER_DATE_BASIS_LN,
	ERSTER_ZEITSTEMPEL_BASIS_LN,
	LETZTER_DATE_BASIS_LN,
	LETZTER_ZEITSTEMPEL_BASIS_LN
) as

--2022-11-30, AP0150311_SPEC0174516, dknop, , separating from bsf part

SELECT 
  v01.wup_id
 ,v01.nb_id
 ,v01.mandant_id
 ,v01.lagernummer_id
 ,CAST(CASE WHEN v01.referenznummer='' THEN '-1' ELSE v01.referenznummer END AS NUMBER(18,0)) AS referenznummer
 ,v02.dat_tour
 ,MIN(DATE(v01.dat_aenderung)) AS erster_date_basis_ln
 ,MIN(v01.datzeit_aenderung_UTC) AS erster_zeitstempel_basis_ln
 ,MAX(DATE(v01.dat_aenderung)) AS letzter_date_basis_ln
 ,MAX(v01.datzeit_aenderung_UTC) AS letzter_zeitstempel_basis_ln                 
FROM dbp_view.v_protokoll_aenderung_bsf_1 v01

  
 LEFT JOIN dbp_view.v_tour_1 v02 ON CAST(CASE WHEN v01.referenznummer='' THEN '-1' ELSE v01.referenznummer END AS NUMBER(18,0)) = v02.tour_id
                              AND v01.mandant_id=v02.mandant_id
                              AND v01.wup_id=v02.wup_id
                              
                              
                              
                              
--where CAST(CASE WHEN v01.referenznummer='' THEN '-1' ELSE v01.referenznummer END AS NUMBER(18,0)) ='40955396'
    GROUP BY
  v01.wup_id
 ,v01.nb_id
 ,v01.mandant_id
 ,v01.lagernummer_id
 ,v01.referenznummer
 ,v02.dat_tour;