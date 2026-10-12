CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_KUNDE_1
-- 26.10.2011 system_id entfernt
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 20.02.2017 TTEZ1905: SPEC0018113: Hinzufuegen von Kreistyp_gruppe_id wegen Hierarchie Markt-(mv_l_wup_1)-Kunde-(mv_l_in_kunde_1)-Kreistyp_gruppe
-- 24.01.2019  NAKU:  SPEC0039809 neue Felder hinzugefuegt
(
in_kunde_id
,mandant_id
--  ,system_id
,kunde_nr
,kunde_name
,kreistyp_gruppe_id
,frueh_spaet_kz
,kunde_land
,kunde_plz
,kunde_ort
)
AS
   SELECT
   
   v01.flw_kunde_id AS in_kunde_id, 
   v01.mandant_id, 
  
   
   COLLATE(LTRIM(COLLATE(v01.kunde_nr,''),'0'), 'en-ci') AS kunde_nr,
   
   v01.kunde_name, 
   
   
   COALESCE(v03.kreistyp_gruppe_id, '-1')  AS kreistyp_gruppe_id, v01.frueh_spaet_kz, v01.kunde_land, v01.kunde_plz, v01.kunde_ort
   FROM dbp_view.v_flw_kunde_1 v01
   INNER JOIN dbp_view.v_flw_kunde_vkorg_vw_zu_1 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.flw_kunde_id = v02.flw_kunde_id
   LEFT OUTER JOIN dbp_view.v_wup_1 v03
   ON v01.mandant_id = v03.mandant_id
   AND v01.wup_id = v03.wup_id

   WHERE v02.flw_vw_id IN (10,20,25)

   GROUP BY 1,2,3,4,5,6,7,8,9;