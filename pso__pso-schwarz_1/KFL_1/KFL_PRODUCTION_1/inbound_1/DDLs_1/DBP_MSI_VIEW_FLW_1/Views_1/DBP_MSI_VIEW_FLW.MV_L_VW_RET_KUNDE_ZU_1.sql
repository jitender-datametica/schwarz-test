CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_VW_RET_KUNDE_ZU_1
-- 26.10.2011 system_id entfernt
-- 30.01.2012 Join auf in_kunde_1 via wup_id angepasst
-- 02.10.2013 twie: Erweitert um mandant_id 2
-- 05.08.2014 twie: Filter erweitert um vw_id 10 fuer CZ
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
--28.09.2016 twie: SPEC0015193 Vertriebswegsumstellung DE von 1,2,3 auf 6
(
vw_id
, vw_ret_bez
, mandant_id
, vwvt_bez
, in_kunde_id
, kunde_nr
, kunde_name
)
AS
   SELECT
   v01.vw_id, 
   v01.vw_bez AS vw_ret_bez, 
   v01.mandant_id, 
   v01.vwvt_bez, 
   v03.flw_kunde_id AS in_kunde_id, 
   COLLATE(LTRIM(COLLATE(v03.kunde_nr,''),'0'), 'en-ci') AS kunde_nr,
   v03.kunde_name

   FROM dbp_view.v_l_vw_1 v01

   JOIN dbp_view.v_wup_1 v02
   ON v01.vw_id = v02.vw_id AND v01.mandant_id = v02.mandant_id
   LEFT OUTER JOIN dbp_view.v_flw_kunde_1 v03
   ON v03.wup_id = v02.wup_id
   AND v03.mandant_id = v02.mandant_id

   WHERE v01.mandant_id IN (1,2)
   AND v01.vwart_id=1
   AND v01.vw_id IN (6,10);