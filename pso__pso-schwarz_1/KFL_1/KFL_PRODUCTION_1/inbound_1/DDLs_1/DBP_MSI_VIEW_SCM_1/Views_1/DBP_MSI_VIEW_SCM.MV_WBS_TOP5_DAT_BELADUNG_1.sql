create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_WBS_TOP5_DAT_BELADUNG_1(
	DAT_BELADUNG
) as
--2026-05-14, dknop, initial, for wbs iCubes filter

  SELECT dat_beladung
  FROM (
    SELECT dat_beladung,
           ROW_NUMBER() OVER (ORDER BY dat_beladung DESC) rn
    FROM   dbp_view.v_wbs_werbeaenderungen_1
    GROUP BY dat_beladung
  )
  WHERE rn <= 5;
