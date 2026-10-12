CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ART_WUP_MAX_WE_WA_1 AS
-- 20220331 richternic: SPEC0150052 initiale Anlage_1
-- 20230215 dknop: INC6092100 coalesce for max_dat_we, max_dat_wa
-- 20231122 nwag: feature/AP0194246_SPEC0225986_Optimierung_SCM
SELECT
  marc.MANDANT_ID
  ,marc.WUP_ID
  ,marc.NB_ID
  ,marc.ART_ID
  ,COALESCE(MAX(CASE WHEN mkpf.VORGANGSART_ID = 'WE' THEN mseg.dat_buch END),'1900-01-01') AS max_dat_we
  ,CASE WHEN max_dat_we='1900-01-01' THEN  '> 18 Monate' ELSE to_varchar(max_dat_we, 'dd.mm.yyyy') END AS max_dat_we_bez
  ,COALESCE(MAX(CASE WHEN mkpf.VORGANGSART_ID  = 'WL' THEN mseg.dat_buch END),'1900-01-01') AS max_dat_wa
  ,CASE WHEN max_dat_wa='1900-01-01' THEN  '> 18 Monate' ELSE to_varchar(max_dat_wa, 'dd.mm.yyyy') END AS max_dat_wa_bez
--auch artikel_1 ohne we/wa in den letzten 18 monaten sollen hochkommen, daher MARC_1 als basis:
FROM dbp_view.v_art_wup_status_per_1 marc_1
LEFT JOIN dbp_view.v_lagerbew_det_1 mseg 
ON marc.mandant_id = mseg.mandant_id
  AND marc.WUP_ID = mseg.WUP_ID
  AND marc.ART_ID = mseg.ART_ID
  AND mseg.dat_buch BETWEEN marc.dat_von AND marc.dat_bis
  AND mseg.dat_buch >= CURRENT_DATE - 540 AND mseg.dat_buch <= CURRENT_DATE --nur letzte 18 monate
LEFT JOIN dbp_view.v_lagerbew_1 mkpf 
ON mkpf.mandant_id = mseg.mandant_id
    AND mkpf.lagerbew_beleg_id = mseg.lagerbew_beleg_id
    AND mkpf.KJ = mseg.KJ

WHERE marc.dat_bis >= CURRENT_DATE - 540

GROUP BY marc.MANDANT_ID
,marc.WUP_ID
,marc.NB_ID
,marc.ART_ID;