CREATE OR REPLACE VIEW dbp_msi_view_ios.mv_bvv_projekt_tage_einzeln_2
AS
SELECT
ALLES.projekt_id
,  ALLES.projekt_nr
,  ALLES.CPR_BAUABNAHME
,  ALLES.BAUBEGINN
,  ALLES.CPR_BAUBEG_KAELTE
,  ALLES.KBE_FS_VP_VERABSCHIEDET
,  ALLES.STILLE_EROEFFNUNG
,  ALLES.BEGINN_EINRICHTUNG
, ALLES.dat_termin_gj


FROM
(
select
a12.projekt_id
,a12.projekt_nr
, max(CASE WHEN a11.cpr_suchfeld_id = 'CPR_BAUABNAHME'                     THEN a11.dat_termin ELSE NULL END)  as CPR_BAUABNAHME
, max(CASE WHEN a11.cpr_suchfeld_id = 'BAUBEGINN'                                      THEN a11.dat_termin ELSE NULL END) as BAUBEGINN
, max(CASE WHEN a11.cpr_suchfeld_id = 'CPR_BAUBEG_KAELTE'                 THEN a11.dat_termin ELSE NULL END) as CPR_BAUBEG_KAELTE

, max(CASE WHEN a11.cpr_suchfeld_id = 'KBE_FS_VP_VERABSCHIEDET'                 THEN a11.dat_termin ELSE NULL END) as KBE_FS_VP_VERABSCHIEDET
, max(CASE WHEN a11.cpr_suchfeld_id = 'STILLE_EROEFFNUNG'                 THEN a11.dat_termin ELSE NULL END) as STILLE_EROEFFNUNG
, max(CASE WHEN a11.cpr_suchfeld_id = 'BEGINN_EINRICHTUNG'                 THEN a11.dat_termin ELSE NULL END) as BEGINN_EINRICHTUNG
, max(a11.dat_termin_gj) AS dat_termin_gj

from  dbp_msi_view_ios.mv_cpr_cl_punkt_2 a11
join  dbp_msi_view_ios.mv_cpr_phase_2  a12
on  (a11.projekt_phase_id = a12.projekt_phase_id)
group by
a12.projekt_id
,a12.projekt_nr
) ALLES;
