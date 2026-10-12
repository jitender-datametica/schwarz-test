CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_REKL_1
(
dat
,art_id
,mandant_id
,wup_id
,nb_id
,reklamationsgrund_id
,Rekl_VK_Brutto
,Rekl_VK_Menge
,gp_id
,mhd
,los_charge
,mwst_id
,mwst
,art_id_ref
,kunden_text
)
AS
   SELECT
  v01.dat,
   v01.art_id,
   v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.reklamationsgrund_id,
   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   CASE WHEN v2.wrg_typ_id = 0 AND v2.berichtskurs_typ_id = 0 THEN v01.VK_Brutto_re * v3.umrechnungskurs
        WHEN v2.wrg_typ_id = 0 AND v2.berichtskurs_typ_id = 1 THEN v01.VK_Brutto_re * v4.umrechnungskurs
        ELSE v01.VK_Brutto_re END AS VK_Brutto_re,
   v01.VK_Menge_re,
   v01.gp_id,
   v01.mhd,
   v01.los_charge,
   v02.mwst_id,
   v03.mwst,
   v01.art_id_ref,
   v01.kunden_text
   FROM dbp_view.v_rekl_1 v01
   INNER JOIN dbp_view.v_art_1 v02
   ON
   v02.art_id=v01.art_id AND
   v02.mandant_id=v01.mandant_id
   INNER JOIN dbp_view.v_mwst_per_1 v03
   ON v02.mwst_id=v03.mwst_id AND
   v02.mandant_id=v03.mandant_id

   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v2
  
 -- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs_1 v3
   ON v3.dat_bis = '9999-12-31'
   AND v01.wrg_id = v3.von_wrg_id
   AND v3.kurstyp_id = 3
   AND v3.nach_wrg_id ='EUR'

-- JOIN historischer Berichtskurs
   JOIN dbp_view.v_kurs_1 v4
   ON v01.dat BETWEEN v4.dat_von AND v4.dat_bis
   AND v01.wrg_id = v4.von_wrg_id
   AND v4.kurstyp_id = 3
   AND v4.nach_wrg_id ='EUR'

  WHERE v01.mandant_id <> 1
  AND v01.dat BETWEEN v03.dat_von AND v03.dat_bis
   -- Bonstornos (1) werden nicht berücksichtigt
  AND v01.bon_storno_fg = 0;