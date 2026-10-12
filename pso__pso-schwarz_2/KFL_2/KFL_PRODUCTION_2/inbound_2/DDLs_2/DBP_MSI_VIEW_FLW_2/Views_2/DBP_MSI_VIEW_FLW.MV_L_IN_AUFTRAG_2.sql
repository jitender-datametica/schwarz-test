CREATE OR REPLACE VIEW DBP_MSI_VIEW_FLW.MV_L_IN_AUFTRAG_2
-- 26.10.2011 system_id entfernt
-- 22.10.2012 Filter auf mandant_id in (1,2)
-- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen
-- 01.10.2019 TWIE: SPEC0045510 Auftragsart FL04 ergaenzt
-- 13.12.2019 TWIE: NSR1136156 auftrag_id -1 mit auftragsart_id -1 war doppelt aus Trenn- und Mischauftrag, deshalb bei Mischauftrag im Filter die -1 entfernt

(
mandant_id
--, system_id
, auftrag_id
, auftragsart_id
, auftrag_bez
, dat_start
)
AS
   SELECT
   v01.mandant_id, v01.auftrag_id, v01.auftragsart_id, v03.art_bez AS auftrag_bez, v02.dat_start

   FROM dbp_view.v_flw_auftrag_2 v01-- AUFK

   JOIN dbp_view.v_flw_auftrag_pps_2 v02--AFKO

   ON v01.mandant_id = v02.mandant_id
   AND v01.auftrag_id = v02.auftrag_id
   LEFT OUTER JOIN dbp_view.v_flw_art_spr_zu_2 v03-- MARM_2 fuer MPA Texte

   ON v01.mandant_id = v03.mandant_id
   AND v02.flw_art_id = v03.flw_art_id

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v04
   ON v03.spr_id = v04.spr_id

   WHERE v01.auftragsart_id IN ('FL02','FL04')
   AND v01.mandant_id IN (1,2)

   UNION ALL

   --TRENN Auftraege
   SELECT
   v01.mandant_id, v01.auftrag_id, v02.auftragsart_id, v03.auftrag_bez AS auftrag_bez, v01.dat_start

   FROM dbp_view.v_flw_auftrag_pps_2 v01--AFKO statt COKO

   JOIN dbp_view.v_flw_auftrag_2 v02-- AUFK

   ON v01.mandant_id = v02.mandant_id
   AND v01.auftrag_id = v02.auftrag_id

   JOIN dbp_view.v_flw_trenn_auftrag_2 v03-- COKO fuer TPA Texte

   ON v01.mandant_id = v03.mandant_id
   AND v01.auftrag_id = v03.auftrag_id

   WHERE v02.auftragsart_id IN ('ZPP1','-1')
   AND v01.mandant_id IN (1,2);