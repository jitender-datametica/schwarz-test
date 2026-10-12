CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_BESCH_PARTNER_2
-- 26.10.2011 system_id entfernt
-- 19.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
faktura_beleg_id
, mandant_id
--, system_id
, in_kunde_id
, kunde_nr
, kunde_name
)
AS
   SELECT
   v01.faktura_beleg_id, v01.mandant_id, v01.flw_kunde_id AS in_kunde_id,  COALESCE(COLLATE(LTRIM(COLLATE(v02.kunde_nr,''),'0'), 'en-ci') ,'kein Lookup vorhanden') AS kunde_nr, COALESCE(v02.kunde_name,'kein Lookup vorhanden') AS kunde_name
  
   FROM dbp_view.v_flw_besch_partner_2 v01

   JOIN dbp_view.v_flw_kunde_2 v02
   ON v01.mandant_id  = v02.mandant_id
   AND v01.flw_kunde_id = v02.flw_kunde_id

   WHERE v01.partner_verwendung_id = 'WE';