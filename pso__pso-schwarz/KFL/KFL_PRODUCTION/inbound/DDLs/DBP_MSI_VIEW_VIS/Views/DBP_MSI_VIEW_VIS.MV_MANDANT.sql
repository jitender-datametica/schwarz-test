create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_MANDANT(
	MANDANT_ID,
	MANDANT_SORT_ID,
	MANDANT_BEZ,
	MANDANT_BEZ_CZ,
	MANDANT_BEZ_SK,
	MANDANT_BEZ_HR,
	MANDANT_BEZ_PL,
	MANDANT_BEZ_RO,
	MANDANT_BEZ_BG,
	MANDANT_ISO,
	DEFAULT_WRG,
	MANDANT_KBEZ,
	MANDANT_BEZ_OLD,
	MANDANT_NAT_BEZ,
	MANDANT_NAT_BEZ_CZ,
	MANDANT_NAT_BEZ_SK,
	MANDANT_NAT_BEZ_HR,
	MANDANT_NAT_BEZ_PL,
	MANDANT_NAT_BEZ_RO,
	MANDANT_NAT_BEZ_BG
) as 
/* LOOKUP Land (Mandant) 
 2011KW28 Review 
 2013KW28 Where-Bedingung entfernt (Performance) 
 2020-09-25 ssch0611 : added land_iso 
 2022-03-08 ssch0611 : review Translations 
*/ 
SELECT 
 mandant_id 
,mandant_sort_id 
/* translations */
,CASE WHEN mandant_id = 2 THEN 'Tschechien'
      WHEN mandant_id = 7 THEN 'Rumänien'  ELSE mandant_bez END::VARCHAR(40) AS mandant_bez 
,CASE WHEN mandant_id = 2 THEN 'Česko' 
      WHEN mandant_id = 5 THEN 'Slovensko' ELSE mandant_bez END::VARCHAR(40) AS mandant_bez_cz 
,CASE WHEN mandant_id = 5 THEN 'Slovensko' 
      WHEN mandant_id = 2 THEN 'Česko'     ELSE mandant_bez END::VARCHAR(40) AS mandant_bez_sk 
,CASE WHEN mandant_id = 6 THEN 'Hrvatska'  ELSE mandant_bez END::VARCHAR(40) AS mandant_bez_hr 
,CASE WHEN mandant_id = 3 THEN 'Polska'    ELSE mandant_bez END::VARCHAR(40) AS mandant_bez_pl 
,CASE WHEN mandant_id = 4 THEN 'Moldova' 
      WHEN mandant_id = 7 THEN 'România'   ELSE mandant_bez END::VARCHAR(40) AS mandant_bez_ro 
,CASE WHEN mandant_id = 8 THEN 'България'  ELSE mandant_bez END::VARCHAR(40) AS mandant_bez_bg 
,CASE WHEN mandant_id = 1 THEN 'DE'        ELSE mandant_kbez END::VARCHAR(2) AS mandant_iso 
,default_wrg 
,mandant_kbez 
,mandant_bez AS mandant_bez_old 
/* columns temporary needed */
,CASE WHEN mandant_id = 2 THEN 'Tschechien'
      WHEN mandant_id = 7 THEN 'Rumänien'  ELSE mandant_bez END::VARCHAR(40) AS mandant_nat_bez 
,CASE WHEN mandant_id = 2 THEN 'Česko'     
      WHEN mandant_id = 5 THEN 'Slovensko' ELSE mandant_bez END::VARCHAR(40) AS mandant_nat_bez_cz 
,CASE WHEN mandant_id = 5 THEN 'Slovensko' 
      WHEN mandant_id = 2 THEN 'Česko'     ELSE mandant_bez END::VARCHAR(40) AS mandant_nat_bez_sk 
,CASE WHEN mandant_id = 6 THEN 'Hrvatska'  ELSE mandant_bez END::VARCHAR(40) AS mandant_nat_bez_hr 
,CASE WHEN mandant_id = 3 THEN 'Polska'    ELSE mandant_bez END::VARCHAR(40) AS mandant_nat_bez_pl 
,CASE WHEN mandant_id = 4 THEN 'Moldova' 
      WHEN mandant_id = 7 THEN 'România'   ELSE mandant_bez END::VARCHAR(40) AS mandant_nat_bez_ro 
,CASE WHEN mandant_id = 8 THEN 'България'  ELSE mandant_bez END::VARCHAR(40) AS mandant_nat_bez_bg 
FROM dbp_view.v_mandant;
