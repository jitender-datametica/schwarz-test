create or replace view KFL_PRODUCTION.DBP_ETL.MV_LISTUNG_MARKT_TAG(
	MANDANT_ID,
	WG_ID,
	ART_ID,
	DAT,
	KJWO,
	WUP_ID,
	ABSATZ,
	ABSATZ_SA,
	ABSATZ_AF,
	ANZ_TAGE_MIT_ABSATZ,
	ANZ_TAGE_MIT_ABSATZ_SA,
	ANZ_TAGE_MIT_ABSATZ_AF
) as (
SELECT v01.mandant_id
      ,v03.wg_id
      ,v01.art_id
      ,v01.dat
      ,v02.kjwo
      ,v01.wup_id
      ,ZEROIFNULL(SUM(v01.menge)) AS absatz
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1002 THEN v01.menge end)) AS absatz_sa
      ,ZEROIFNULL(SUM(CASE WHEN v01.bewart_id = 1001 THEN v01.menge end)) AS absatz_af
      ,ZEROIFNULL(COUNT(DISTINCT v02.dat)) AS anz_tage_mit_absatz
      ,ZEROIFNULL(COUNT(DISTINCT CASE WHEN v01.bewart_id = 1002 THEN v02.dat end)) AS anz_tage_mit_absatz_sa
      ,ZEROIFNULL(COUNT(DISTINCT CASE WHEN v01.bewart_id = 1001 THEN v02.dat end)) AS anz_tage_mit_absatz_af
FROM dbp_view.v_artbew v01
JOIN dbp_view.v_tag v02
  ON v01.dat = v02.dat
JOIN dbp_view.v_art_wg_zu_per v03
  ON v03.art_id = v01.art_id AND 
     v01.mandant_id = v03.mandant_id
JOIN dbp_view.v_wup v04
  ON v01.wup_id = v04.wup_id AND 
     v01.nb_id = v04.nb_id AND 
     v01.mandant_id = v04.mandant_id
WHERE v01.mandant_id = 1 AND 
      v03.arthiertyp_id = 2 AND 
      v03.dat_bis = '9999-12-31'
GROUP BY 1,2,3,4,5,6
);