CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_TAG_RO
-- 13.06.2014 twie: kurze Wochentagsbez ausgeben
-- 18.04.2016 srom0404, Feld gjwo_kl_vj lt. Mail von M.Sarbak (19.01.2016) ausgebaut
-- 02.08.2017 AP0011863, SPEC0026312, srom04040, dat_vj_date für Transformation auf Vorjahr Datum
-- 23.08.2018 AP0031942, Umsatzplanung, Erweiterung der Einschränkung auf 3 Jahre in die Zukunft
-- 08.01.2019 NSR0505888, srom0404, Anforderung seitens H. Weber, von akt_kj BETWEEN -2 AND 3 auf akt_gj BETWEEN -2 AND 3 umzustellen
-- 01.04.2020 NSR0505888, srom0404, telefonische Anforderung Fachbereich, anpassen akt_gj BETWEEN -4 AND 3 (vorher BETWEEN -2 AND 3)
(
dat
,kjmo
,kjmo_vj
,wtag_id
,kjwo
,kjwo_vj
,gjwo
,gjwo_vj
,wo_dat_von
,wo_dat_bis
,gjmo
,gjmo_vj
,kjqu
,gjqu
,kj
,gj
,kjtag_id
,gjtag_id
,kjwo_kl
--,kjwo_kl_vj
,kjwo_kl_dat_von
,kjwo_kl_dat_bis
,gjwo_kl
--,gjwo_kl_vj
,gjwo_kl_dat_von
,gjwo_kl_dat_bis
,dat_vj
,akt_tag
,akt_mo
,akt_mo_komplett
,akt_wo
,akt_wo_komplett
,akt_gjwo_kl
,akt_gjwo_kl_komplett
,akt_kjwo_kl
,akt_kjwo_kl_komplett
,akt_gjqu
,akt_gjqu_komplett
,akt_kjqu
,akt_kjqu_komplett
,akt_gj
,akt_gj_komplett
,akt_kj
,akt_kj_komplett
,mo_gj
,mo_kj
,dat_vvj
,akt_qu
,dat_vm
,wtag_bez
,wtag_kbez
,dat_vj_date
)
AS
   SELECT
   v01.dat,
   v01.kjmo,
   v01.kjmo_vj,
   v01.wtag_id,
   v01.kjwo,
   v01.kjwo_vj,
   v01.gjwo,
   v01.gjwo_vj,
   v01.wo_dat_von,
   v01.wo_dat_bis,
   v01.gjmo,
   v01.gjmo_vj,
   v01.kjqu,
   v01.gjqu,
   v01.kj,
   v01.gj,
   v01.kjtag_id,
   v01.gjtag_id,
   v01.kjwo_kl,
   --v01.kjwo_kl_vj,
   v01.kjwo_kl_dat_von,
   v01.kjwo_kl_dat_bis,
   v01.gjwo_kl,
   --v01.gjwo_kl_vj,
   v01.gjwo_kl_dat_von,
   v01.gjwo_kl_dat_bis,
   v01.dat_vj,
   v01.akt_tag,
   v01.akt_mo,
   v01.akt_mo_komplett,
   v01.akt_wo,
   v01.akt_wo_komplett,
   v01.akt_gjwo_kl,
   v01.akt_gjwo_kl_komplett,
   v01.akt_kjwo_kl,
   v01.akt_kjwo_kl_komplett,
   v01.akt_gjqu,
   v01.akt_gjqu_komplett,
   v01.akt_kjqu,
   v01.akt_kjqu_komplett,
   v01.akt_gj,
   v01.akt_gj_komplett,
   v01.akt_kj,
   v01.akt_kj_komplett,
   v01.mo_gj,
   v01.mo_kj,
   v01.dat_vj-364, TRUNC(
   v01.akt_mo/3),
   Add_Months(v01.dat, -1),
   v02.wtag_bez,
   Trim(SUBSTRING(v02.wtag_bez, 1, 2))::VARCHAR(20) AS wtag_kbez,
   Add_Months(v01.dat,-12) AS dat_vj_date
   FROM dbp_view.v_tag v01
   INNER JOIN dbp_view.v_wtag_spr_zu v02
   ON v01.wtag_id = v02.wtag_id
   WHERE v01.akt_gj BETWEEN -4 AND 3
     AND v02.spr_id = 95;