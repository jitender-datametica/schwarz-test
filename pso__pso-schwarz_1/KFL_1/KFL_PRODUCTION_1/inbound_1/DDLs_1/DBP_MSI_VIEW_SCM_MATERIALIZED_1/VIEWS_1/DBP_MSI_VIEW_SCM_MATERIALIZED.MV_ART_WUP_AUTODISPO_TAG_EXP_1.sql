create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ART_WUP_AUTODISPO_TAG_EXP_1(
	MANDT,
	COUNTRY_1,
	LOC,
	LOC_CLUSTER,
	PROD,
	PROD_CLUSTER,
	DIF_TYPE,
	TSTFR,
	TSTTO,
	DIF_VALUE,
	FUNCTION,
	DIF_DESC
) as
-- export view for iDoc generation (to be placed in an interim dossier for XLS export until backend is done)
-- 2020-09-03, AP0068964, nwag2310, Ersterstellung
-- 2020-11-04, AP0068964, nwag2310, Changed to EXP columns
SELECT
abs(m.mandant_sap_id) as  MANDT,
case when m.mandant_kbez = 'D' then 'DE' else m.mandant_kbez end as COUNTRY_1,
dif.kunde_id as LOC,
' ' as LOC_CLUSTER --wird leer geliefert da wir sowieso immer auf markt/artikel_1/tag_1 runtergehen
,
a.kl_art_id as ""PROD"",
' ' as PROD_CLUSTER --wird leer geliefert da wir sowieso immer auf markt/artikel_1/tag_1 runtergehen
,
case when dt.dif_typ_id= 1 and dif_mult_exp <> 1 then 'Multiplicative'
 when dt.dif_typ_id= 2 and coalesce(dif_add_exp,0) <> 0 then 'Additive'
 when dt.dif_typ_id= 3 and coalesce(dif_abs_exp,0) <> 0 then 'Absolute' end as DIF_TYPE,
dif.dat as TSTFR,
dif.dat as TSTTO,
CAST(case when dt.dif_typ_id= 1  then ( dif_mult_exp * 100 ) - 100
 when dt.dif_typ_id= 2  then dif_add_exp
 when dt.dif_typ_id= 3  then dif_abs_exp end AS NUMBER(38,5)) as DIF_VALUE,
'I' as ""FUNCTION"",
CAST( case when dt.dif_typ_id= 1 and anz_dif_mult_exp = 1 then dif_komm_mult
 when dt.dif_typ_id= 2  and anz_dif_add_exp = 1 then dif_komm_add
 when dt.dif_typ_id= 3 and anz_dif_abs_exp = 1  then dif_komm_abs else 'Mehrere DIFs -DWH-' end as VARCHAR(255)) as DIF_DESC
FROM DBP_MSI_VIEW_SCM_MATERIALIZED.mv_art_wup_autodispo_tag_dif_bme_1 dif
join dbp_view.v_l_dif_typ_1 dt on 1=1
-- big exception to use other MV in this MV because encaspulation resolve-logic makes more sense!
join
dbp_view.v_art_1 a
on dif.art_id=a.art_id
and dif.mandant_id=a.mandant_id
join dbp_view.v_mandant_1 m
on dif.mandant_id=m.mandant_id
where  /* nur gesperrte und noch nicht exportierte einträge  --> impl. by _exp */
DIF_TYPE is not null
and dif.dat between CURRENT_DATE -180 and CURRENT_DATE +101;