CREATE OR REPLACE VIEW dbp_msi_view_ios.mv_bvv_projekt_tage
as

SELECT

v01.projekt_id
,  v01.projekt_nr
,  v01.CPR_BAUABNAHME
,  v01.BAUBEGINN
,  v01.CPR_BAUBEG_KAELTE
,  v01.KBE_FS_VP_VERABSCHIEDET
,  v01.STILLE_EROEFFNUNG
,  v01.BEGINN_EINRICHTUNG
,  v01.dat_termin_gj

, MAX( v01.CPR_BAUABNAHME  - v01.BAUBEGINN)  AS massnahme_gesamt
, MAX( v01.BAUBEGINN  - v01.KBE_FS_VP_VERABSCHIEDET)  AS tage_baubeginn_minus_vs_verabschiedet
, MAX( v01.dat_termin_gj  - v01.BAUBEGINN)  AS tage_letzter_Tag_im_akt_gj_minus_baubeginn
, MAX( v01.dat_termin_gj  - v01.KBE_FS_VP_VERABSCHIEDET)  AS tage_letzter_Tag_im_akt_gj_minus_vs_verabschiedet
, MAX( v01.dat_termin_gj  - v01.CPR_BAUBEG_KAELTE)  AS tage_letzter_Tag_im_akt_gj_minus_beginn_kaelte
, MAX( v01.dat_termin_gj  - v01.BEGINN_EINRICHTUNG)  AS tage_letzter_Tag_im_akt_gj_minus_beginn_einrichtung
, MAX( v01.dat_termin_gj  - v01.CPR_BAUABNAHME)  AS tage_letzter_Tag_im_akt_gj_minus_bauabnahme
, MAX( v01.STILLE_EROEFFNUNG  - v01.CPR_BAUBEG_KAELTE)  AS tage_stille_eoe_minus_beginn_kaelte
, MAX( v01.STILLE_EROEFFNUNG  - v01.BEGINN_EINRICHTUNG)  AS tage_stille_eoe_minus_beginn_einrichtung
, MAX( v01.STILLE_EROEFFNUNG  - v01.CPR_BAUABNAHME)  AS tage_stille_eoe_minus_bauabnahme

, MAX( CURRENT_DATE()  - v01.CPR_BAUBEG_KAELTE)  AS tage_date_minus_beginn_kaelte
, MAX( CURRENT_DATE()  - v01.BEGINN_EINRICHTUNG)  AS tage_date_minus_beginn_einrichtung
, MAX( CURRENT_DATE()  - v01.KBE_FS_VP_VERABSCHIEDET)  AS tage_date_minus_vs_verabschiedet
, MAX( CURRENT_DATE()  - v01.BAUBEGINN)  AS tage_date_minus_baubeginn
, MAX( CURRENT_DATE()  - v01.CPR_BAUABNAHME)  AS tage_date_minus_bauabnahme

, CASE WHEN CURRENT_DATE() > v01.STILLE_EROEFFNUNG THEN tage_stille_eoe_minus_beginn_kaelte
ELSE tage_date_minus_beginn_kaelte END AS tage_seit_baubeginn_kuehlung_kaelte

, CASE WHEN CURRENT_DATE() > v01.STILLE_EROEFFNUNG THEN tage_stille_eoe_minus_beginn_einrichtung
ELSE tage_date_minus_beginn_einrichtung END AS tage_seit_baubeginn_einrichtung

, CASE WHEN CURRENT_DATE() > v01.STILLE_EROEFFNUNG THEN tage_stille_eoe_minus_beginn_einrichtung
ELSE tage_date_minus_beginn_einrichtung END AS tage_seit_baubeginn_it

, CASE WHEN CURRENT_DATE() > v01.CPR_BAUABNAHME THEN massnahme_gesamt
ELSE tage_date_minus_bauabnahme END AS tage_seit_baubeginn_baunebenkosten_35

, CASE WHEN CURRENT_DATE() > v01.BAUBEGINN THEN tage_baubeginn_minus_vs_verabschiedet
ELSE tage_letzter_Tag_im_akt_gj_minus_baubeginn END AS tage_seit_baubeginn_baunebenkosten_65

, CASE WHEN CURRENT_DATE() > v01.CPR_BAUABNAHME THEN massnahme_gesamt
ELSE tage_letzter_Tag_im_akt_gj_minus_baubeginn END AS tage_seit_baubeginn_baukosten

, CASE WHEN v01.dat_termin_gj > v01.STILLE_EROEFFNUNG THEN tage_stille_eoe_minus_beginn_kaelte
ELSE tage_letzter_Tag_im_akt_gj_minus_beginn_kaelte END AS tage_bis_fertigstellung_kaelte

, CASE WHEN v01.dat_termin_gj > v01.STILLE_EROEFFNUNG THEN tage_stille_eoe_minus_beginn_einrichtung
ELSE tage_letzter_Tag_im_akt_gj_minus_beginn_einrichtung END AS tage_bis_fertigstellung_einrichtung

, CASE WHEN v01.dat_termin_gj > v01.STILLE_EROEFFNUNG THEN tage_stille_eoe_minus_beginn_einrichtung
ELSE tage_letzter_Tag_im_akt_gj_minus_beginn_einrichtung END AS tage_bis_fertigstellung_it

, CASE WHEN v01.dat_termin_gj > v01.CPR_BAUABNAHME THEN massnahme_gesamt
ELSE tage_letzter_Tag_im_akt_gj_minus_beginn_einrichtung END AS tage_bis_fertigstellung_35

, CASE WHEN v01.dat_termin_gj > v01.CPR_BAUABNAHME THEN tage_baubeginn_minus_vs_verabschiedet
ELSE tage_letzter_Tag_im_akt_gj_minus_vs_verabschiedet END AS tage_bis_fertigstellung_65

, CASE WHEN v01.dat_termin_gj > v01.BAUBEGINN THEN massnahme_gesamt
ELSE tage_letzter_Tag_im_akt_gj_minus_baubeginn END AS tage_bis_baukosten

from  dbp_msi_view_ios.mv_bvv_projekt_tage_einzeln v01

group BY 1,2,3,4,5,6,7,8,9;
