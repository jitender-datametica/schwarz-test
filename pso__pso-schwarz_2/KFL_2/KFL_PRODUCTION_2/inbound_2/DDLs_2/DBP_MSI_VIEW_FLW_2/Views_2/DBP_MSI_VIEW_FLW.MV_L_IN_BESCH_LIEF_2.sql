CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_BESCH_LIEF_2
-- 26.10.2011 system_id entfernt
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
(
lief_beleg_id
,mandant_id
--  ,system_id
,werk_id
,in_kunde_id
,kunde_nr
,kunde_name
,lief_typ_id
,dat_beleg
,dat_erfasst
,dat_lief_soll
,in_verkaufsorganisation_id
)
AS
   SELECT
   v01.lief_beleg_id, v01.mandant_id, v01.werk_id, v01.flw_kunde_id AS in_kunde_id, 
   COALESCE(COLLATE(LTRIM(COLLATE(v02.kunde_nr,''),'0'), 'en-ci'),'nicht in Lookup') AS kunde_nr, 
    COALESCE(v02.kunde_name,'nicht in Lookup') AS kunde_name, 
   v01.lief_typ_id, 
   v01.dat_beleg, 
   v01.dat_erfasst, 
   v01.dat_lief_soll, 
   v01.flw_verkaufsorganisation_id AS in_verkaufsorganisation_id
   FROM dbp_view.v_flw_besch_lief_2 v01
   LEFT JOIN dbp_view.v_flw_kunde_2 v02
   ON v01.mandant_id = v02.mandant_id
   AND v01.flw_kunde_id = v02.flw_kunde_id;