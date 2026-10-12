create or replace view DBP_ETL.MV_LISTUNG_MARKT_KW_KMO_2(
	MANDANT_ID,
	WG_ID,
	ART_ID,
	WUP_ID,
	NB_ID,
	KREISTYP_GRUPPE_ID,
	KJWO,
	ABSATZ,
	ABSATZ_SA,
	ABSATZ_AF,
	ANZ_WO_MIT_ABSATZ,
	ANZ_WO_MIT_ABSATZ_SA,
	ANZ_WO_MIT_ABSATZ_AF
) as
SELECT v01.mandant_id
      ,v01.wg_id
      ,v01.art_id
      ,v01.wup_id
      ,v01.nb_id
      ,v04.kreistyp_gruppe_id
      ,v01.kjwo
      ,ZeroIfNull(Sum(v01.menge)) AS absatz
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1002 THEN v01.menge end)) AS absatz_sa
      ,ZeroIfNull(Sum(CASE WHEN v01.bewart_id = 1001 THEN v01.menge end)) AS absatz_af
      ,ZeroIfNull(Count(DISTINCT v01.kjwo)) AS anzahl_wochen_mit_absatz
      ,ZeroIfNull(Count(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v01.kjwo end)) AS anzahl_wochen_mit_absatz_sa
      ,ZeroIfNull(Count(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v01.kjwo end)) AS anzahl_wochen_mit_absatz_af
FROM dbp_etl.bf_artbew_wg_art_wo_sum_kmo_2 v01
JOIN dbp_data.art_wg_zu_per_2 v03
  ON v03.art_id = v01.art_id AND 
     v01.mandant_id = v03.mandant_id
JOIN dbp_data.wup_2 v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
	 v01.mandant_id = v04.mandant_id
WHERE v01.mandant_id > 1 AND 
      v03.arthiertyp_id = 2 AND 
	  v03.dat_bis = '9999-12-31'
GROUP BY 1,2,3,4,5,6,7;