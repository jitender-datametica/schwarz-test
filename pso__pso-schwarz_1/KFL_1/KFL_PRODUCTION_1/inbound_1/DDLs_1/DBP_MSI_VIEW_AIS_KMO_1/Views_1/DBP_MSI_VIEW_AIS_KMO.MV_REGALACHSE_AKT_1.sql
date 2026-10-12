CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_REGALACHSE_AKT_1
(
  aktiv_fg
, art_id
, display_art_id
, ek_mep
, fachboden_nr
, fachboden_pos
, fbb_nr
, kapazitaet
, kapazitaet_faktor
, kapazitaet_menge_einh_id
, mandant_id
, nb_id
, regional_kz
, soll_ist_kz
, vk_brutto_umrechnung
, mwst
, vk_netto
, wup_id
, regalachse_flaeche
)
AS
   SELECT
   v01.aktiv_fg,
   v01.art_id,
   v01.display_art_id,
   /*CAST(
   CASE WHEN v01.wrg_id <> v100.default_wrg AND v200.wrg_typ_id  = 0 THEN COALESCE( v01.ek_mep ,0)
  -- Landesbeleg in Euro wird in Landeswährung angezeigt
        WHEN v01.wrg_id <> v100.default_wrg AND v200.wrg_typ_id  = 1 THEN COALESCE(v01.ek_mep ,0) / v400.umrechnungskurs
   -- Landesbeleg in Landeswährung wird in Euro angezeigt
        WHEN v01.wrg_id = v100.default_wrg AND v200.wrg_typ_id  = 0  THEN COALESCE(v01.ek_mep ,0) * v400.umrechnungskurs
   -- Landesbeleg in Landeswährung wird in Landeswährung angezeigt
        WHEN v01.wrg_id = v100.default_wrg AND v200.wrg_typ_id  = 1  THEN COALESCE(v01.ek_mep ,0)
        END AS DECIMAL(18,6)) AS ek_mep,*/

   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   CAST(
   CASE WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN COALESCE( v01.ek_mep ,0) * v01.umrechnungskurs_0
        WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN COALESCE( v01.ek_mep ,0) * v01.umrechnungskurs_1
        ELSE COALESCE(v01.ek_mep ,0) END AS DECIMAL(18,6)) AS ek_mep,
   v01.fachboden_nr,
   v01.fachboden_pos,
   v01.fbb_nr,
   v01.kapazitaet,
   v01.kapazitaet_faktor,
   v01.kapazitaet_menge_einh_id,
   v01.mandant_id,
   v01.nb_id,
   v01.regional_kz,
   v01.soll_ist_kz,
  /*CAST(
   CASE WHEN v01.wrg_id <> v100.default_wrg AND v200.wrg_typ_id  = 0 THEN COALESCE(v01.vk_brutto ,0)
  -- Landesbeleg in Euro wird in Landeswährung angezeigt
        WHEN v01.wrg_id <> v100.default_wrg AND v200.wrg_typ_id  = 1 THEN COALESCE(v01.vk_brutto ,0) / v400.umrechnungskurs
   -- Landesbeleg in Landeswährung wird in Euro angezeigt
        WHEN v01.wrg_id = v100.default_wrg AND v200.wrg_typ_id  = 0  THEN COALESCE(v01.vk_brutto ,0) * v400.umrechnungskurs
   -- Landesbeleg in Landeswährung wird in Landeswährung angezeigt
        WHEN v01.wrg_id = v100.default_wrg AND v200.wrg_typ_id  = 1  THEN COALESCE(v01.vk_brutto ,0)
        END AS DECIMAL(18,6)) AS vk_brutto_umrechnung,*/
   
   -- AP0202325/SPEC0286323 Erweiterung Tages-und Berichtskurs / sschuecke 10.01.2025
   CAST(
   CASE WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 0 THEN COALESCE(v01.vk_brutto ,0) *v01.umrechnungskurs_0
        WHEN v200.wrg_typ_id  = 0 AND v200.berichtskurs_typ_id = 1 THEN COALESCE(v01.vk_brutto ,0) *v01.umrechnungskurs_1
        ELSE COALESCE(v01.vk_brutto ,0) END AS DECIMAL(18,6)) AS vk_brutto_umrechnung,
   mwst,
   (vk_brutto_umrechnung / (100.000 + mwst)) * 100  AS vk_netto,
   v01.wup_id,
   regalachse_flaeche

  FROM DBP_MSI_VIEW_AIS_KMO.TBL_MV_REGALACHSE_AKT_1 v01

   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v200;