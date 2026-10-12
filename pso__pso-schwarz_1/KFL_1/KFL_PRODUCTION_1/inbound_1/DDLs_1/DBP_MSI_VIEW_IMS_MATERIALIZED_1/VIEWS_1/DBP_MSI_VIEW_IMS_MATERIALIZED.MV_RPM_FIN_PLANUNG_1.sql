create or replace view DBP_MSI_VIEW_IMS_MATERIALIZED.MV_RPM_FIN_PLANUNG_1(
	DAT_VON,
	RPM_HIERARCHIE_ID,
	FIN_KAT_HIERARCHIE_ID,
	FIN_KATEGORIE_ID,
	FIN_KAT_VERSION_ID,
	FIN_KAT_VERSION_DAT,
	FIN_GRUPPE_HIERARCHIE_ID,
	FIN_GRUPPE_ID,
	RPM_PLANTYP_ID,
	FIN_GRUPPE_VERSION_ID,
	FIN_GRUPPE_VERSION_DAT,
	DAT_START,
	MAXKP_FG,
	BETRAG
) as



   SELECT
   v01.dat_von,
   v01.rpm_hierarchie_id,
   v01.fin_kat_hierarchie_id,
   v01.fin_kategorie_id,
   fin_kat_version_id,
   v01.fin_kat_version_dat,
   v01.fin_gruppe_hierarchie_id,
   v01.fin_gruppe_id,
   v01.rpm_plantyp_id,
   v01.fin_gruppe_version_id,
   v01.fin_gruppe_version_dat,
   v01.dat_start,
   maxkp_fg,
   CAST(
    CASE
    WHEN v200.wrg_typ_id  = 1
    THEN COALESCE( v01.betrag   ,0)
    WHEN  v200.wrg_typ_id  = 0
    THEN COALESCE(v01.betrag   ,0) * umrechnungskurs
    END
    AS DECIMAL(18,4) ) AS betrag

  FROM DBP_MSI_VIEW_IMS_MATERIALIZED.TBL_MV_RPM_FIN_PLANUNG_1 v01
   
  
  CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v200;