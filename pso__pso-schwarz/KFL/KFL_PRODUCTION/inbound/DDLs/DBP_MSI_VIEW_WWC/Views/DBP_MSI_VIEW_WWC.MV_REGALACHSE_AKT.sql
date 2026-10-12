CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_REGALACHSE_AKT
-- AP0032822, SPEC0041631 - 20.11.2108, mkub1811 neue View
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
   v01.aktiv_fg, v01.art_id, v01.display_art_id, CAST(
   CASE WHEN v01.wrg_id <> v100.default_wrg AND v200.wrg_typ_id  = 0
   THEN COALESCE( v01.ek_mep ,0)
   -- Landesbeleg in Euro wird in Landeswährung angezeigt
   WHEN v01.wrg_id <> v100.default_wrg AND v200.wrg_typ_id  = 1
   THEN TRUNC( COALESCE(v01.ek_mep ,0) / v400.umrechnungskurs)
   -- Landesbeleg in Landeswährung wird in Euro angezeigt
   WHEN v01.wrg_id = v100.default_wrg AND v200.wrg_typ_id  = 0
   THEN COALESCE(v01.ek_mep ,0) * v400.umrechnungskurs
   -- Landesbeleg in Landeswährung wird in Landeswährung angezeigt
   WHEN v01.wrg_id = v100.default_wrg AND v200.wrg_typ_id  = 1
   THEN COALESCE(v01.ek_mep ,0)
   END
   AS DECIMAL(18,6))
   AS ek_mep, v01.fachboden_nr, v01.fachboden_pos, v01.fbb_nr, v01.kapazitaet, v01.kapazitaet_faktor, v01.kapazitaet_menge_einh_id, v01.mandant_id, v01.nb_id, v01.regional_kz, v01.soll_ist_kz, CAST(
   CASE WHEN v01.wrg_id <> v100.default_wrg AND v200.wrg_typ_id  = 0
   THEN COALESCE(v01.vk_brutto ,0)
   -- Landesbeleg in Euro wird in Landeswährung angezeigt
   WHEN v01.wrg_id <> v100.default_wrg AND v200.wrg_typ_id  = 1
   THEN TRUNC( COALESCE(v01.vk_brutto ,0) / v400.umrechnungskurs)
   -- Landesbeleg in Landeswährung wird in Euro angezeigt
   WHEN v01.wrg_id = v100.default_wrg AND v200.wrg_typ_id  = 0
   THEN COALESCE(v01.vk_brutto ,0) * v400.umrechnungskurs
   -- Landesbeleg in Landeswährung wird in Landeswährung angezeigt
   WHEN v01.wrg_id = v100.default_wrg AND v200.wrg_typ_id  = 1
   THEN COALESCE(v01.vk_brutto ,0)
   END
   AS DECIMAL(18,6))
   AS vk_brutto_umrechnung, COALESCE(v01.mwst ,0) AS mwst, (TRUNC(vk_brutto_umrechnung / (100.000 + mwst))) * 100  AS vk_netto, v01.wup_id, regalachse_flaeche

   FROM dbp_view.v_regalachse_akt v01

   JOIN dbp_view.v_mandant v100
   ON v01.mandant_id = v100.mandant_id
   CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200

   JOIN dbp_view.v_kurs AS v400
   ON v01.wrg_id = v400.von_wrg_id
   AND v400.dat_bis = '9999-12-31'
   AND v400.kurstyp_id = 9
   AND v400.nach_wrg_id = 'EUR';