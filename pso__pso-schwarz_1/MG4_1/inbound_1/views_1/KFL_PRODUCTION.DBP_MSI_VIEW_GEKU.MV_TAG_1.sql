create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_TAG_1(
	DAT,
	KJMO,
	KJMO_VJ,
	WTAG_ID,
	KJWO,
	KJWO_VJ,
	GJWO,
	GJWO_VJ,
	WO_DAT_VON,
	WO_DAT_BIS,
	GJMO,
	GJMO_VJ,
	KJQU,
	GJQU,
	KJ,
	GJ,
	KJTAG_ID,
	GJTAG_ID,
	KJWO_KL,
	KJWO_KL_DAT_VON,
	KJWO_KL_DAT_BIS,
	GJWO_KL,
	GJWO_KL_DAT_VON,
	GJWO_KL_DAT_BIS,
	DAT_VJ,
	AKT_TAG,
	AKT_MO,
	AKT_MO_KOMPLETT,
	AKT_WO,
	AKT_WO_KOMPLETT,
	AKT_GJWO_KL,
	AKT_GJWO_KL_KOMPLETT,
	AKT_KJWO_KL,
	AKT_KJWO_KL_KOMPLETT,
	AKT_GJQU,
	AKT_GJQU_KOMPLETT,
	AKT_KJQU,
	AKT_KJQU_KOMPLETT,
	AKT_GJ,
	AKT_GJ_KOMPLETT,
	AKT_KJ,
	AKT_KJ_KOMPLETT,
	MO_GJ,
	MO_KJ,
	DAT_VVJ,
	AKT_QU,
	DAT_VM
) as
-- 01.02.2016 twie: kjwo_kl_vj, gjwo_kl_vj entfernt

   SELECT
   dat
   , kjmo
   , kjmo_vj
   , wtag_id
   , kjwo
   , kjwo_vj
   , gjwo
   , gjwo_vj
   , wo_dat_von
   , wo_dat_bis
   , gjmo
   , gjmo_vj
   , kjqu
   , gjqu
   , kj
   , gj
   , kjtag_id
   , gjtag_id
   , kjwo_kl
   , kjwo_kl_dat_von
   , kjwo_kl_dat_bis
   , gjwo_kl
   , gjwo_kl_dat_von
   , gjwo_kl_dat_bis
   , dat_vj
   , akt_tag
   , akt_mo
   , akt_mo_komplett
   , akt_wo
   , akt_wo_komplett
   , akt_gjwo_kl
   , akt_gjwo_kl_komplett
   , akt_kjwo_kl
   , akt_kjwo_kl_komplett
   , akt_gjqu
   , akt_gjqu_komplett
   , akt_kjqu
   , akt_kjqu_komplett
   , akt_gj
   , akt_gj_komplett
   , akt_kj
   , akt_kj_komplett
   , mo_gj
   , mo_kj
   , dat_vj-364
   , TRUNC(akt_mo/3)
   , ADD_MONTHS(dat,-1)
   FROM dbp_view.v_tag_1;