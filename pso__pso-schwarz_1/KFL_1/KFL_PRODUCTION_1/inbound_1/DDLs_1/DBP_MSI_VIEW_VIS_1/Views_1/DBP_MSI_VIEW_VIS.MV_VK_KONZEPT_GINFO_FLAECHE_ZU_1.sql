CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_VK_KONZEPT_GINFO_FLAECHE_ZU_1 as
   -- ZUORDNUNG : Verkaufskonzept zu G-Info Flaeche
   -- Befuellung Tabelle ueber INIT-Skript
   -- Join ueber Fakt-Tabelle (Gueltigkeit), Abteilung aus flaeche_typ, VKF-Flaeche auf Pseudo-Abteilung 0
   -- 2012KW46 : Initial (nur DE)

   SELECT
   v01.mandant_id, CASE
   WHEN SUBSTR( v01.ginfo_flaeche_typ_id, 1, 5) = 'VKF-A' THEN SUBSTRING(v01.ginfo_flaeche_typ_id, 7, 1)
   WHEN v01.ginfo_flaeche_typ_id = 'VKF' AND v01.ginfo_flaeche_id IN ('02.01','02.10','02.08') THEN 0 -- Mapping Verkaufsfläche
   WHEN v01.ginfo_flaeche_typ_id = 'BBF' AND v01.ginfo_flaeche_id IN ('PPL', 'PPE', 'PPB') THEN -9 -- ohne Anzahl Parkplätze
   ELSE -3 -- Alle anderen Flächen
   END::SMALLINT AS abt_id, COALESCE(v02.vk_konzept_id, -1) AS vk_konzept_id, v01.ginfo_flaeche_typ_id, v01.ginfo_flaeche_id
   FROM
   (
   SELECT DISTINCT
   mandant_id, ginfo_flaeche_typ_id, ginfo_flaeche_id
   FROM dbp_view.v_ginfo_flaeche_per_1
   WHERE dat_bis = '9999-12-31'
   )  v01
   LEFT JOIN dbp_msi_v_view.v_vk_konzept_ginfo_flaeche_zu_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.ginfo_flaeche_id = v02.ginfo_flaeche_id;