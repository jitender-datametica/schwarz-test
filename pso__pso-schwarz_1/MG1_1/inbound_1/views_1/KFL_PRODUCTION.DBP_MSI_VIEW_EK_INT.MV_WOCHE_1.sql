create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_WOCHE_1(
	KJWO,
	KJ,
	WO_KJ,
	AKT_WO,
	AKT_WO_KOMPLETT,
	WO_DAT_VON,
	WO_DAT_BIS,
	KJWO_VJ,
	KJ_VJ,
	WO_VJ,
	WO_VON_BIS,
	WO_VON,
	WO_DAT_MO,
	KW_IST_VJ
) as
   SELECT
   kjwo, 
   kjwo / 100 ::INTEGER   AS kj, 
   MOD(kjwo, 100 ::INTEGER) AS wo_kj,
   akt_wo, 
   akt_wo_komplett, 
   wo_dat_von, 
   wo_dat_bis,
   kjwo_vj AS kjwo_vj, 
   kjwo_vj / 100 ::INTEGER   AS kj_vj, 
   MOD(kjwo_vj, 100 ::INTEGER) AS wo_vj, 
   LPAD(MOD(kjwo, 100), 2, '0') || ' (' || to_varchar(wo_dat_von,'DD.MM.') || '-' || to_varchar(wo_dat_bis, 'DD.MM.') || ')' ::VARCHAR(20) AS wo_von_bis, 
   LPAD(MOD(kjwo, 100), 2, '0')  || ' (' || to_varchar(wo_dat_von, 'DD.MM.') || ')' ::VARCHAR(20) AS wo_von, 
   Cast(SUBSTRING(wo_dat_von, 1, 8) ||'01' AS VARCHAR) AS wo_dat_mo, 
   LPAD(wo_kj, 2, '0')  || ' | ' || LPAD(wo_vj, 2, '0')  ::VARCHAR(20) AS kw_ist_vj

/* SPEC0249727 Umstellung auf VTA (vorher mv_woche_vvt_1) / sschuecke 23.05.2024 */
   FROM dbp_view.v_woche_1

   /*JOIN
   (
   SELECT kjwo AS kjwo_vj, wo_dat_von + 364 AS wo_dat_von_vj
   FROM dbp_msi_view_ek_int.mv_woche_vvt_1
   WHERE akt_wo BETWEEN -623 AND 0
   ) v02
   ON v01.wo_dat_von = v02.wo_dat_von_vj*/

   WHERE akt_wo BETWEEN -571 AND 55;