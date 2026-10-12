create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_KURS(
	DAT_BIS,
	DAT_VON,
	KURSTYP_ID,
	NACH_WRG_ID,
	UMRECHNUNGSKURS,
	VON_WRG_ID
) as
--20220804: AP0132142 SPEC0154921, richternic, Fuer die Waehrungsauswahl  
   SELECT
   dat_bis,
   dat_von,
   kurstyp_id,
   nach_wrg_id,
   umrechnungskurs,
   von_wrg_id
   FROM dbp_view.v_kurs
   WHERE dat_bis = '9999-12-31' AND kurstyp_id=3;
