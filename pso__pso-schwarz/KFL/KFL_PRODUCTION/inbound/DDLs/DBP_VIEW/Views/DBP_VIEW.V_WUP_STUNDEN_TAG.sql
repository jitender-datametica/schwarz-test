create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_VIEW.V_WUP_STUNDEN_TAG(
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	DAT,
	STUNDEN_MARKT,
	STUNDEN_SONSTIGE,
	STUNDEN_PLAN,
	STUNDEN_CO5_SONSTIGE,
	UMS_NETTO_PLAN,
	UMS_NETTO_PLAN_MAN,
	WRG_ID,
	STUNDEN_SONSTIGE_PLAN,
	STUNDEN_CO1_IKS,
	STUNDEN_CO2_EA,
	STUNDEN_CO3_ANUE,
	STUNDEN_CO4_REINIGUNG,
	STUNDEN_PLAN_PEP,
	STUNDEN_PLAN_MELDESCHLUSS_PLUS1,
	UMS_NETTO_PLAN_MAN_MELDESCHLUSS_PLUS2,
	STUNDEN_CO_IST,
	STUNDEN_CO_PLAN,
	STUNDEN_PLAN_MELDESCHLUSS_PLUS2,
	UMS_NETTO_PLAN_MAN_MELDESCHLUSS_PLUS1,
	STUNDEN_CO_PLAN_PLUS1,
	STUNDEN_CO_PLAN_PLUS2,
	STUNDEN_SONSTIGE_PLAN_PLUS1,
	STUNDEN_SONSTIGE_PLAN_PLUS2,
	STUNDEN_PLAN_SSM,
	STUNDEN_VERSETZUNG
) as
WITH CTE AS (
SELECT
IFNULL(b.wup_id, a.wup_id) AS wup_id
,IFNULL(b.nb_id, a.nb_id) AS nb_id
,IFNULL(b.mandant_id, a.mandant_id) AS mandant_id
,IFNULL(b.dat, a.dat) AS dat
,b.stunden_markt
,a.stunden_sonstige
,a.stunden_plan
,b.stunden_co5_sonstige
,b.ums_netto_plan
,a.ums_netto_plan_man
,IFNULL(b.wrg_id, a.wrg_id) AS wrg_id
,a.stunden_sonstige_plan
,b.stunden_co1_iks
,b.stunden_co2_ea
,b.stunden_co3_anue
,b.stunden_co4_reinigung
,b.stunden_plan_pep
,b.stunden_plan_meldeschluss_plus1
,b.ums_netto_plan_man_meldeschluss_plus2
,b.stunden_co_ist
,b.stunden_co_plan
,b.stunden_plan_meldeschluss_plus2
,b.ums_netto_plan_man_meldeschluss_plus1
,b.stunden_co_plan_plus1
,b.stunden_co_plan_plus2
,b.stunden_sonstige_plan_plus1
,b.stunden_sonstige_plan_plus2
,b.stunden_plan_ssm
,a.stunden_versetzung
FROM dbp_data.wup_stunden_tag b
FULL OUTER JOIN dbp_view.V_WUP_STUNDEN_TAG_union_land a
ON b.wup_id = a.wup_id
    AND b.nb_id = a.nb_id
    AND b.mandant_id = a.mandant_id
    AND b.dat = a.dat
    AND b.wrg_id = a.wrg_id )
SELECT * FROM CTE;
