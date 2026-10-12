CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_GF_KUNDE_ZU
-- 22.06.2011 AL fuehrende 0 bei Kundennummer analog zu Kundenlookup entfernt
-- 26.10.2011 system_id entfernt
-- 30.01.2012 Join auf in_kunde via wup_id angepasst
-- 02.10.2013 twie: Erweitert um mandant_id 2
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
vkl_id
, gf_id
, vkl_name
, mandant_id
, in_kunde_id
, kunde_nr
, kunde_name
)
AS
   SELECT
   v01.vkl_id, v01.gf_id, v01.vkl_name, v01.mandant_id, v03.flw_kunde_id AS in_kunde_id, 
   COLLATE(LTRIM(COLLATE(v03.kunde_nr,''),'0'), 'en-ci') AS kunde_nr,
   v03.kunde_name

   FROM dbp_view.v_vkl v01

   JOIN dbp_view.v_wup v02
   ON v01.vkl_id = v02.vkl_id
   AND v01.mandant_id = v02.mandant_id
   LEFT OUTER JOIN dbp_view.v_flw_kunde v03
   ON v03.wup_id = v02.wup_id
   AND v03.mandant_id = v02.mandant_id

   WHERE v01.mandant_id IN (1,2);