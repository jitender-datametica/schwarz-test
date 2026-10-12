CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_GINFO_FLAECHE
AS
   -- LOOKUP : G-Info-Flaechen
   -- Join ueber Fakt-Tabelle (Gueltigkeit) ohne Schluessel Techn. Platz.
   -- Abteilung aus flaeche_typ, VKF-Flaeche auf Pseudo-Abteilung 0
   -- 2012KW46 : Initial

   SELECT
   s01.mandant_id, s01.flaeche_quelle_id -- NOT USED
   , s01.ginfo_flaeche_typ_id, s01.ginfo_flaeche_id, CASE
   WHEN SUBSTR( s01.ginfo_flaeche_typ_id, 1, 5) = 'VKF-A' THEN SUBSTRING(s01.ginfo_flaeche_typ_id, 7, 1)
   WHEN s01.ginfo_flaeche_typ_id = 'VKF' AND s01.ginfo_flaeche_id IN ('02.01','02.10','02.08') THEN 0
   ELSE -9
   END::SMALLINT AS abt_id
   FROM
   ( -- Lookup
   SELECT DISTINCT
   mandant_id, flaeche_quelle_id, ginfo_flaeche_typ_id, ginfo_flaeche_id
   FROM dbp_view.v_l_ginfo_flaeche
   )  s01
   JOIN
   ( -- Fakt
   SELECT DISTINCT
   mandant_id, ginfo_flaeche_typ_id, ginfo_flaeche_id
   FROM dbp_view.v_ginfo_flaeche_per
   WHERE dat_bis = '9999-12-31'
   )  s02
   ON s01.mandant_id = s02.mandant_id
   AND s01.ginfo_flaeche_id = s02.ginfo_flaeche_id
   AND s01.ginfo_flaeche_typ_id = s02.ginfo_flaeche_typ_id;