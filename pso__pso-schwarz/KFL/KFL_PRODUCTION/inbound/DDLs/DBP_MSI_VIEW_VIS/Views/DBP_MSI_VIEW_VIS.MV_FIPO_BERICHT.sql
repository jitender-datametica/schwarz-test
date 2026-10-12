CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_FIPO_BERICHT
AS

   SELECT
   v01.fipo_bericht_id, v01.fipo_pruef_modul_id, CASE
   WHEN v02.mandant_id = 1 AND fipo_pruef_modul_id = 21300 THEN  1 --GfK
   ELSE 0
   END AS gfk_flag, CASE
   WHEN gfk_flag = 1 THEN  v01.dat_fipo_bericht - date_part(dayofweek, v01.dat_fipo_bericht) + 9
   --Die day_of_week-Formel gilt bei Wochenstart am Montag. Bei Wochenstart am Sonntag muss statt "+8" die Konstante "+2" gesetzt werden
   ELSE v01.dat_fipo_bericht
   END dat_fipo_bericht, 
   CASE WHEN gfk_flag = 1  THEN CAST(CAST('00:00:00' AS CHAR(8)) AS TIME(0))
   ELSE CAST(TO_VARCHAR(v01.zeit_fipo_bericht,'HH24:MI:SS') AS TIME(0))
   END AS zeit_fipo_bericht,
   v01.mobil_erfasst_fg, v01.nicht_auswerten_fg, v01.fipo_person_id, v01.dat_bis, v02.mandant_id, 
   CASE  WHEN gfk_flag = 1 THEN v04.wup_id 
      ELSE v02.wup_id
   END AS wup_id, 
   COALESCE (v03.hausleiter_sperr_fg, 0) AS hausleiter_sperr_fg, COALESCE (v03.vkl_sperr_fg, 0) AS vkl_sperr_fg, COALESCE (v03.gf_gbl_vertrieb_sperr_fg, 0) AS gf_gbl_vertrieb_sperr_fg, CASE
   WHEN gfk_flag = 1 THEN  v01.dat_versorgung - date_part(dayofweek,v01.dat_versorgung) + 8
   --Die day_of_week-Formel gilt bei Wochenstart am Montag. Bei Wochenstart am Sonntag muss statt "+8" die Konstante "+2" gesetzt werden
   ELSE v01.dat_versorgung
   END dat_versorgung

   FROM dbp_view.v_fipo_bericht v01
   INNER JOIN dbp_view.v_wup v02
      ON v01.fipo_pruef_objekt_id = v02.fipo_pruef_objekt_id
   LEFT OUTER JOIN dbp_msi_v_view.v_wup_denorm v03
      ON v02.wup_id = v03.wup_id
         AND v02.mandant_id = v03.mandant_id
   LEFT OUTER JOIN dbp_view.v_wup v04
      ON v04.vs_id = v02.vs_id 
         AND v04.mandant_id = v02.mandant_id 
         AND v04.wup_id IN (2,22,28,43,46,124) 
         AND v04.mandant_id = 1

   -- ungültige ausfiltern
   WHERE v01.nicht_auswerten_fg = 0
   AND v01.dat_bis >= CURRENT_DATE;