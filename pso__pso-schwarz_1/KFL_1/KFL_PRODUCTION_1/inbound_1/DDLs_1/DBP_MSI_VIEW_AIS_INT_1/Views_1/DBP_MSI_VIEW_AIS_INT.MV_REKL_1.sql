CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_INT.MV_REKL_1
(
 dat
,art_id
,ean_kasse
,mandant_id
,wup_id
,nb_id
,reklamationsgrund_id
,Rekl_VK_Brutto
,Rekl_VK_netto
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
  --AP0221989/SPEC0258672 Erweiterung um Spalte ean_kasse / sschuecke 16.08.2024
   CASE WHEN v01.ean_kasse IS NOT NULL THEN v01.ean_kasse ELSE 0 END AS ean_kasse,
   v01.mandant_id,
   v01.wup_id,
   v01.nb_id,
   v01.reklamationsgrund_id,
   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   CASE WHEN v2.wrg_typ_id = 0 AND v2.berichtskurs_typ_id = 0 THEN v01.VK_Brutto_re * v04.umrechnungskurs
        WHEN v2.wrg_typ_id = 0 AND v2.berichtskurs_typ_id = 1 THEN v01.VK_Brutto_re * v05.umrechnungskurs
        ELSE v01.VK_Brutto_re END AS Rekl_VK_Brutto,
   ((Rekl_VK_Brutto * 100) / (100 + v03.mwst)) AS Rekl_VK_netto,
   v01.VK_Menge_re AS Rekl_VK_Menge,
   v01.gp_id,
   v01.mhd,
   v01.los_charge,
   v02.mwst_id,
   v03.mwst,
   v01.art_id_ref,
   v01.kunden_text
   FROM dbp_view.v_rekl_1 v01
   INNER JOIN dbp_view.v_art_1 v02
   ON v02.art_id=v01.art_id 
   AND v02.mandant_id=v01.mandant_id

   INNER JOIN dbp_view.v_mwst_per_1 v03
   ON v02.mwst_id=v03.mwst_id AND
   v02.mandant_id=v03.mandant_id

   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v2
  
   -- JOIN aktueller Berichtskurs
   JOIN dbp_view.v_kurs_1 v04
   ON v04.dat_bis = '9999-12-31'
   AND v01.wrg_id = v04.von_wrg_id
   AND v04.kurstyp_id = 3
   AND v04.nach_wrg_id ='EUR'

   -- JOIN historischer Berichtskurs
   JOIN dbp_view.v_kurs_1 v05
   ON v01.dat BETWEEN v05.dat_von AND v05.dat_bis
   AND v01.wrg_id = v05.von_wrg_id
   AND v05.kurstyp_id = 3
   AND v05.nach_wrg_id ='EUR'

  WHERE  v01.dat BETWEEN v03.dat_von AND v03.dat_bis
   -- Bonstornos (1) werden nicht berücksichtigt
  AND v01.bon_storno_fg = 0;