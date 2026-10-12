CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_ART_WUP_ZU_PER_2
/*SPEC0049888 kdis zu kdis_kz hinzugefÃ¼gt 05.02.2019 dhoe0404*/
(
art_id
, bezugsweg_id
, dat_bis
, dat_von
, listung_id
, mandant_id
, nb_id
, vk_brutto
, wup_id
, kdis_kz
, kdis_aenderung_dat
)
AS
   SELECT
   v01.art_id
  ,v01.bezugsweg_id
  ,v01.dat_bis
  ,v01.dat_von
  ,v01.listung_id
  ,v01.mandant_id
  ,v01.nb_id
  -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
  -- EUR akt. Berichtskurs
  ,CASE WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 0 THEN CAST(v01.vk_brutto * v03.umrechnungskurs AS NUMBER(38,4))
  -- EUR hist. Berichtskurs
        WHEN v02.wrg_typ_id = 0 AND v02.berichtskurs_typ_id = 1 THEN CAST(v01.vk_brutto * v04.umrechnungskurs AS NUMBER(38,4))
  -- Landeswährung
        ELSE v01.vk_brutto END AS vk_brutto
  ,v01.wup_id
  ,CASE
   WHEN kdis = 0 OR kdis IS NULL THEN ' ' 
   ELSE 'K' END kdis_kz
  ,CURRENT_DATE AS kdis_aenderung_dat

   FROM dbp_view.v_art_wup_zu_per_2 v01

   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_2 v02
  
  /* JOIN dbp_view.v_kurs_2 v03
   ON CURRENT_DATE BETWEEN v03.dat_von AND v03.dat_bis
   AND v01.wrg_id = v03.von_wrg_id
   AND v03.kurstyp_id = 9
   AND v03.nach_wrg_id ='EUR'*/

      -- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs_2 v03
   ON v03.dat_bis = '9999-12-31'
   AND v01.wrg_id = v03.von_wrg_id
   AND v03.kurstyp_id = 3
   AND v03.nach_wrg_id ='EUR'

   -- JOIN historischer Berichtskurs
   JOIN dbp_view.v_kurs_2 v04
   ON v01.dat_von >= v04.dat_von 
   AND v01.dat_bis <= v04.dat_bis
   AND v01.wrg_id = v04.von_wrg_id
   AND v04.kurstyp_id = 3
   AND v04.nach_wrg_id ='EUR'

   WHERE v01.dat_bis = '9999-12-31'
   AND v01.nb_id <> 99;