     CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_BESTELLDATEN
-- 26.10.2011 system_id entfernt
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen

(
mandant_id
--, system_id
, lief_beleg_id
, lief_typ_id
, dat_lief_soll
, lief_beleg_pos_id
, werk_id
, in_art_id
, in_art_nr
, basismenge_einh_id
, verk_menge_einh_id
, nettogew
, dat_mat_bereitstllg
, dat_produktion
, in_kunde_id
, verkaufs_beleg_id
, verkaufs_beleg_pos_id
, menge_auftrag_vme_kum
, menge_bes_bme_kum
, menge_bes_bme_kum_kg
, stueckliste_id
, stueckliste_pos_id
, stueckliste_typ_id
, menge_basis
, komponentenmenge
, komponentenmenge_einh_id
, stueckliste_pos_typ_id
, in_art_id_sek
, in_art_nr_sek
, art_bez_sek
)
AS
   SELECT
   v01.mandant_id, 
   v01.lief_beleg_id, 
   v01.lief_typ_id, 
   v01.dat_lief_soll, 
   v01.lief_beleg_pos_id, 
   v01.werk_id, 
   v01.in_art_id AS in_art_id, 
   v01.in_art_nr AS in_art_nr, 
   v01.basismenge_einh_id, 
   v01.verk_menge_einh_id, 
   v01.nettogew, 
   v01.dat_mat_bereitstllg, 
   v01.dat_produktion, 
   v01.in_kunde_id AS in_kunde_id, 
   v01.verkaufs_beleg_id, 
   v01.verkaufs_beleg_pos_id, 
   v01.menge_auftrag_vme_kum, 
   v01.menge_bes_bme_kum, 
   v01.menge_bes_bme_kum_kg, 
   v07.stueckliste_id, 
   v07.stueckliste_pos_id, 
   v07.stueckliste_typ_id, 
   v07.menge_basis, 
   v07.komponentenmenge, 
   v07.komponentenmenge_einh_id, 
   v07.stueckliste_pos_typ_id, 
   v07.flw_art_id_sek AS in_art_id_sek, 
   v07.flw_art_nr_sek AS in_art_nr_sek, 
   v07.art_bez_sek

   
   FROM
   DBP_MSI_VIEW_FLW.TBL_MV_F_BESTELLDATEN v01

   
   LEFT OUTER JOIN
   (
   SELECT
   v05.mandant_id, v05.stueckliste_id, v05.werk_id, v05.flw_art_id AS flw_art_id_primaer, v05.menge_basis, 
   v06.stueckliste_pos_id, v06.stueckliste_typ_id, v06.komponentenmenge, v06.komponentenmenge_einh_id, 
   v06.stueckliste_pos_typ_id, v06.flw_art_id AS flw_art_id_sek, v08.flw_art_nr AS flw_art_nr_sek, v09.art_bez AS art_bez_sek

   -- MASTSTKO
   FROM
   dbp_view.v_flw_stueckliste v05
   -- STPO
   JOIN
   dbp_view.v_flw_stueckliste_det v06
   ON v05.mandant_id = v06.mandant_id
   AND v05.stueckliste_id = v06.stueckliste_id
   AND v05.stueckliste_typ_id = v06.stueckliste_typ_id
   LEFT OUTER JOIN dbp_view.v_flw_art v08
   ON v06.mandant_id = v08.mandant_id
   AND v06.flw_art_id = v08.flw_art_id

   JOIN dbp_view.v_flw_art_spr_zu v09
   ON v08.mandant_id = v09.mandant_id
   AND v08.flw_art_id = v09.flw_art_id

   JOIN dbp_msi.akt_msi_user_spr_zu v10
   ON v09.spr_id = v10.spr_id

   WHERE v06.stueckliste_pos_typ_id IN ('G','X')
   AND v06.komponentenmenge > 0.001
   ) v07
   

   WHERE v01.mandant_id IN (1,2);