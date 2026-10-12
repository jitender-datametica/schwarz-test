create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_UDF_PROGNOSE_1(
	MANDANT_ID,
	WUP_ID,
	NB_ID,
	ART_ID,
	DAT,
	DAT_PROGNOSELAUF,
	MENGE_PROGNOSE_UDF_SA,
	MENGE_PROGNOSE_UDF_AA,
	MENGE_PROGNOSE_UDF,
	MENGE_PROGNOSE_UDF_GESTEUERT
) as

SELECT
p.mandant_id,
p.wup_id,
p.nb_id,
p.art_id,
p.dat,
p.dat_prognoselauf,
menge_prognose_sa as menge_prognose_udf_sa,
menge_prognose_af as menge_prognose_udf_aa,
CASE
WHEN menge_prognose_sa IS NULL AND menge_prognose_af IS NULL THEN NULL
ELSE  Coalesce(menge_prognose_sa,0)+Coalesce(menge_prognose_af,0) END AS menge_prognose_udf,
menge_prognose_gesteuert as menge_prognose_udf_gesteuert
FROM dbp_view.v_udf_prognose_1 p
WHERE diagnose_id = '';