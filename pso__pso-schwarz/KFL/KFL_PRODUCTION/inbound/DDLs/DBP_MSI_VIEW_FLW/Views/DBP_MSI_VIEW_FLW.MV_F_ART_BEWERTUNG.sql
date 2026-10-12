  CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_ART_BEWERTUNG
-- 26.10.2011 system_id entfernt
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen

(
mandant_id
--, system_id
, werk_id
, werk_nr
, werk_name
, bewertungskreis_id
, in_art_id
, preis_steuer_kz
, gld
, standard_preis
, preis_faktor
, dat_von
, dat_bis
, umrech_faktor
, artikelwert_bme
, artikelwert_kg
, wrg_id
, dat
)
AS
   SELECT
    v01.mandant_id
    --, system_id--
    , v01.werk_id
    , v01.werk_nr
    , v01.werk_name
    , v01.bewertungskreis_id
    , v01.in_art_id
    , v01.preis_steuer_kz
    , v01.gld
    , v01.standard_preis
    , v01.preis_faktor
    , v01.dat_von
    , v01.dat_bis
    , v01.umrech_faktor
   ,CASE
   WHEN v01.preis_steuer_kz = 'V'AND v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(((v01.gld / v01.preis_faktor)),0)
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.preis_steuer_kz = 'V'AND v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 1
   THEN ( COALESCE(((v01.gld / v01.preis_faktor)),0) / v500.umrechnungskurs)
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.preis_steuer_kz = 'V'AND v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(((v01.gld / v01.preis_faktor)),0) * v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.preis_steuer_kz = 'V'AND v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 1
   THEN COALESCE(((v01.gld / v01.preis_faktor)),0)
   -- Standardpreis
   -- Landesbeleg in Euro wird in Euro angezeigt
   WHEN v01.preis_steuer_kz = 'S'AND v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(((v01.standard_preis / v01.preis_faktor)),0)
   -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
   WHEN v01.preis_steuer_kz = 'S'AND v01.wrg_id <> v01.default_wrg AND v200.wrg_typ_id = 1
   THEN ( COALESCE(((v01.standard_preis / v01.preis_faktor)),0) / v500.umrechnungskurs)
   -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
   WHEN v01.preis_steuer_kz = 'S'AND v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 0
   THEN COALESCE(((v01.standard_preis / v01.preis_faktor)),0) * v500.umrechnungskurs
   -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
   WHEN v01.preis_steuer_kz = 'S'AND v01.wrg_id = v01.default_wrg AND v200.wrg_typ_id = 1
   THEN COALESCE(((v01.standard_preis / v01.preis_faktor)),0)
   END AS artikelwert_bme
   , CASE
   WHEN v01.basismenge_einh_id = 'KG' THEN artikelwert_bme
   WHEN v01.basismenge_einh_id = 'ST' THEN ( artikelwert_bme / v01.umrech_faktor)
   END AS artikelwert_kg
   ,v400.wrg_id
   ,v01.dat


   -- Ermittlung der Zuordnung werk_id zu wup_id, zur Aufloesung fuer bewertungskreis_id aus in_art_bewertungkreis_per
   FROM
   DBP_MSI_VIEW_FLW.TBL_MV_F_ART_BEWERTUNG v01

    CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu v200
    CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu v300

    JOIN dbp_view.v_mandant_wrg_typ_zu v400
    ON v01.mandant_id = v400.mandant_id
    AND v200.wrg_typ_id = v400.wrg_typ_id
    LEFT OUTER JOIN dbp_view.v_kurs v500
    ON V300.kurstyp_id = v500.kurstyp_id
    AND v400.wrg_id = v500.von_wrg_id
    AND v500.nach_wrg_id ='EUR'
    AND v01.dat BETWEEN v500.dat_von AND v500.dat_bis

   WHERE v01.mandant_id IN (1,2);