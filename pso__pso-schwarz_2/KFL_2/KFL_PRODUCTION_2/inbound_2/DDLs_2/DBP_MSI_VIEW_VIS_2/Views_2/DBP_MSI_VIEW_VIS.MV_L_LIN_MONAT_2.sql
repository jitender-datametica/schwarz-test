CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_L_LIN_MONAT_2
-- 20151006 srom: Anpassung auf akt_mo_komplett (RITM0152517)
-- 20170410 srom: Anforderung per Mail von A. Wolter  'BETWEEN -11 AND 0' auf ' BETWEEN -11 AND 1' ändern
(
mo_kj
,kj
,kjmo
,kj_kurz
,mo_kbez
,mo_bez
,mo_kj_bez
,dat_von
,kjmo_order
,kjmo_vormonat
,akt_mo_komplett
)
AS
   SELECT
   mo_kj, kj, kjmo, kj_kurz, mo_kbez, mo_bez, mo_kj_bez, dat_von, RANK() OVER (ORDER BY kjmo DESC NULLS LAST) AS kjmo_order, kjmo_vormonat, akt_mo_komplett

   FROM
   (
   SELECT v01.mo_kj, v01.kj, v01.kjmo, SUBSTR(CAST(v01.kj AS CHAR(4)),3,2) AS kj_kurz, SUBSTR(v02.mo_bez,1,3)||'.' AS mo_kbez, v02.mo_bez, mo_kbez||' '||kj_kurz AS mo_kj_bez, min_dat AS dat_von, MAX(v01.kjmo) OVER (ORDER BY v01.kjmo ROWS BETWEEN 1 PRECEDING AND 1 PRECEDING) AS kjmo_vormonat, v01.akt_mo_komplett
   FROM dbp_view.v_monat_2 v01
   INNER JOIN dbp_view.v_monat_spr_zu_2 v02
   ON v01.mo_kj = v02.mo_id
   WHERE v02.spr_id = 22
   ) dt1
   -- WHERE dt1.akt_mo BETWEEN -12 AND -1
   WHERE dt1.akt_mo_komplett BETWEEN -11 AND 1;