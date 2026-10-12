CREATE OR REPLACE DYNAMIC TABLE DBP_MSI_VIEW2.MV_STERNCHEN_LOGIK_KREISTYP
(
	ART_ID,
	TYP_OST_BASIS,
	TYP_OST_GROSS,
	TYP_SUED_OST,
	TYP_SUED_WEST,
	TYP_WEST,
	TYP_NORD,
	MANDANT_ID
) TARGET_LAG = '1 HOUR, 30 MINUTES' REFRESH_MODE = FULL INITIALIZE = ON_CREATE WAREHOUSE = WH_KFL_%%environmentAbbreviation%%_DYNAMIC_TABLE_AIS_DE
AS
SELECT
t1.art_id, 
MAX(typ_ost_basis), 
MAX (typ_ost_gross), 
MAX (typ_sued_ost), 
MAX (typ_sued_west), 
MAX (typ_west), 
MAX (typ_nord), 
t1.mandant_id

FROM
   (
   SELECT
   v01.art_id, 
   CAST(CASE v01.kreistyp_gruppe_id WHEN 'O' THEN v02.sternchen_id ELSE ' ' END  AS CHAR(2)) AS typ_ost_basis, 
   CAST(CASE v01.kreistyp_gruppe_id WHEN 'Q' THEN v02.sternchen_id ELSE ' ' END  AS CHAR(2)) AS typ_ost_gross, 
   CAST(CASE v01.kreistyp_gruppe_id WHEN 'G' THEN v02.sternchen_id ELSE ' ' END  AS CHAR(2)) AS typ_sued_ost, 
   CAST(CASE v01.kreistyp_gruppe_id WHEN 'M' THEN v02.sternchen_id ELSE ' ' END AS CHAR(2)) AS typ_sued_west, 
   CAST(CASE v01.kreistyp_gruppe_id WHEN 'W' THEN v02.sternchen_id ELSE ' ' END AS CHAR(2)) AS typ_west, 
   CAST(CASE v01.kreistyp_gruppe_id WHEN 'N' THEN v02.sternchen_id ELSE ' ' END  AS CHAR(2)) AS typ_nord, 
   v01.mandant_id
   
   FROM dbp_view.v_sternchen_logik_kreis v01
   INNER JOIN dbp_view.v_l_sternchen v02
   ON    v01.list_durchg_fg    = v02.list_durchg_fg
   AND v01.bezugsweg1_fg  = v02.bezugsweg1_fg
   AND v01.bezugsweg4_fg  = v02.bezugsweg4_fg
   AND v01.kdis0_fg            = v02.kdis0_fg
   AND v01.kdis1_fg            = v02.kdis1_fg
   AND v01.mandant_id        = v02.mandant_id
   WHERE v01.mandant_id = 1) t1
   GROUP BY
   t1.art_id,
   t1.mandant_id;
