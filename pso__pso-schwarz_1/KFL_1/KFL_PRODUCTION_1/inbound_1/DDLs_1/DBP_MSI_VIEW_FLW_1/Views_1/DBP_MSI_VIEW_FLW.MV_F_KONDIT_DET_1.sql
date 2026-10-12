CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_F_KONDIT_DET_1 
-- 26.10.2011 system_id entfernt
-- 31.01.2012 twie: preisliste_typ_id und in_vw_id eingefuegt
-- Filterung auf BSP und ABGN entfernt (jetzt im Frontend) dafuer betrag_kondition durchgereicht
-- 14.08.2013 twie: Retailartikel mit ausgeben
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
   mandant_id,
   kondition_id,
   konditionsart_id,
   in_art_id,
   dat_bis,
   dat_von,
   dat,
   betrag_kondition,
   betrag_kondition_bme,
   flag_landeswrg,
   wrg_id,
   preisliste_typ_id,
   in_vw_id,
   art_id
) AS
      SELECT
         v01.mandant_id,
         v01.kondition_id,
         v01.konditionsart_id,
         v01.in_art_id,
         v01.dat_bis,
         v01.dat_von,
         v01.dat,
         CAST(
            CASE
               WHEN v01.wrg_id_org <> v01.default_wrg
               AND v200.wrg_typ_id = 0 THEN COALESCE(v01.betrag_kondition, 0) -- Landesbeleg in Euro wird in Landeswaehrung angezeigt
               WHEN v01.wrg_id_org <> v01.default_wrg
               AND v200.wrg_typ_id = 1 THEN (
                  COALESCE(v01.betrag_kondition, 0) / v500.umrechnungskurs
               ) -- Landesbeleg in Landeswaehrung wird in Euro angezeigt
               WHEN v01.wrg_id_org = v01.default_wrg
               AND v200.wrg_typ_id = 0 THEN COALESCE(v01.betrag_kondition, 0) * v500.umrechnungskurs -- Landesbeleg in Landeswaehrung wird in Landeswaehrung angezeigt
               WHEN v01.wrg_id_org = v01.default_wrg
               AND v200.wrg_typ_id = 1 THEN COALESCE(v01.betrag_kondition, 0)
            END AS DECIMAL(18, 6)
         ) AS betrag_kondition_konzwrg,
         CAST(
            betrag_kondition_konzwrg * CAST(v01.umrech_faktor AS FLOAT) AS FLOAT
         ) AS betrag_kondition_konzwrg_bme,
         CASE
            WHEN v01.wrg_id_org = v01.default_wrg THEN 1
            ELSE 0
         END AS flag_landeswrg,
         v400.wrg_id AS wrg_id,
         preisliste_typ_id,
         in_vw_id,
         art_id
      FROM
         DBP_MSI_VIEW_FLW.TBL_MV_F_KONDIT_DET_1 v01
         CROSS JOIN dbp_msi.akt_msi_user_wrg_typ_zu_1 v200
         CROSS JOIN dbp_msi.akt_msi_user_kurstyp_zu_1 v300
         JOIN dbp_view.v_mandant_wrg_typ_zu_1 v400 ON v01.mandant_id = v400.mandant_id
         AND v200.wrg_typ_id = v400.wrg_typ_id
         LEFT OUTER JOIN dbp_view.v_kurs_1 v500 ON v300.kurstyp_id = v500.kurstyp_id
         AND wrg_id_org = v500.von_wrg_id
         AND v500.nach_wrg_id = 'EUR'
         AND v01.dat_von BETWEEN v500.dat_von
         AND v500.dat_bis
;