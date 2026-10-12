create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_AIS_INT.MV_EIGENMARKE_AGG_SPR_ZU_1(
	MANDANT_ID,
	EIGENMARKE_AGG,
	EIGENMARKE_AGG_BEZ,
	EIGENMARKE_AGG_BEZ_DE,
	EIGENMARKE_AGG_BEZ_CZ,
	EIGENMARKE_AGG_BEZ_SK,
	EIGENMARKE_AGG_BEZ_HR,
	EIGENMARKE_AGG_BEZ_PL,
	EIGENMARKE_AGG_BEZ_RO,
	EIGENMARKE_AGG_BEZ_BG
) as
 SELECT
 mandant_id
,CASE WHEN v01.eigenmarke_id !='' THEN 1 ELSE 2 END AS eigenmarke_agg
,CASE WHEN eigenmarke_agg = 1 THEN 'KL-Marke'  ELSE 'nicht KL-Marke' END AS eigenmarke_agg_bez
,CASE WHEN eigenmarke_agg = 1 THEN 'KL-Marke'  ELSE 'nicht KL-Marke' END AS eigenmarke_agg_bez_de
,CASE WHEN eigenmarke_agg = 1 THEN 'KL-Značka' ELSE 'žádný KL-Značka' END AS eigenmarke_agg_bez_cz
,CASE WHEN eigenmarke_agg = 1 THEN 'KL-Značka' ELSE 'nie KL-Značka' END AS eigenmarke_agg_bez_sk
,CASE WHEN eigenmarke_agg = 1 THEN 'KL-Marka'  ELSE 'Ne KL-Marka' END AS eigenmarke_agg_bez_hr
,CASE WHEN eigenmarke_agg = 1 THEN 'Marka KL'  ELSE 'nie Marka' END AS eigenmarke_agg_bez_pl
,CASE WHEN eigenmarke_agg = 1 THEN 'Marc_1ă KL'  ELSE 'nu Marc_1ă KL' END AS eigenmarke_agg_bez_ro
,CASE WHEN eigenmarke_agg = 1 THEN 'KFL-Марка' ELSE 'не KFL-Марка' END AS eigenmarke_agg_bez_bg          
FROM DBP_DATA.ARTKZ_EIGENMARKE_1  v01
GROUP BY 1,2,3;
