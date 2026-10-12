CREATE OR REPLACE VIEW DBP_MSI_VIEW_BIS.MV_QUARTAL_GJ
-- 18.08.2016 twie: SPEC0008548 neue Lookupview
-- 12.09.2016 twie: SPEC0008548 neues Bez. feld
-- 14.11.2016 twie: SPEC0016203 Buchungsschluss für Quartal ermitteln sowie letzter Tag des Quartals
(
gjqu
,akt_gjqu
,akt_gjqu_komplett
,gj, akt_gj
,akt_gj_komplett
,gjqu_bez
,gjqu_kbez
,gjqu_bez2
,dat_buchungs_schluss
,max_dat
)
AS
   SELECT v01.gjqu,
   v01.akt_gjqu,
   v01.akt_gjqu_komplett,
   v01.gj,
   v01.akt_gj,
   v01.akt_gj_komplett,
   TRIM(v01.gj) || ' - Q'  || CAST(MOD(v01.gjqu, 100) AS CHAR(2)) AS gjqu_bez,
   'Q'  || CAST(MOD(v01.gjqu, 100) AS CHAR(2)) AS gjqu_kbez,
   CAST(MOD(v01.gjqu, 100) AS CHAR(1)) || '. Quartal' AS gjqu_bez2,
   v02.dat_buchungs_schluss,
   v02.max_dat

   FROM dbp_view.v_quartal_gj v01

   --Buchungsschluss auf Quartalsebene ermitteln
   --ein Geschäftsquartal wird erst freigegeben, wenn alle Monate des zugehörigen  Geschäftsqartals freigegeben sind
   --Also für GQ 1 müssen die Monate März, April, Mai abgeschlossen sein, das ist dann bspw. am 17. Juni (Buchungsschluss Mai)
   --Für bestimmte Kennzahlen ist Quartal am letzten Tag des Quartals abgeschlossen, also GQ 1 am 31. Mai. Für diese Logik max_dat
   JOIN
   (
   SELECT
   v11.gjqu,
   MAX(v12.dat_buchungs_schluss) AS dat_buchungs_schluss,
   MAX(v11.max_dat) AS max_dat
   FROM dbp_view.v_monat v11
   LEFT JOIN dbp_view.v_l_buchungsstatus_ker  v12
   ON v11.kjmo = v12.kj_ker_mo_id
   GROUP BY 1
   )v02
   ON v01.gjqu = v02.gjqu
;