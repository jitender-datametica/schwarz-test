
CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_WERBEWOCHE_KL_VJ
-- AP0011863, SPEC0024396, 14.06.2017, initial
-- speziell für Vorjahresmapping. Tagesebene wird ausgruppiert, damit eine reine/eindeutige Zuordnung von Woche zu Woche VJ besteht
-- Im Fakturabericht kann Anwender nur Werbewoche als Ebene auswählen. Daher direkte Transformation über Werbewoche erforderlich
(
mandant_id
,akt_kjwo_ww
,kjwo_ww

,kjwo_ww_vj
,dat_von_vj
,dat_bis_vj
)
AS
SELECT mandant_id
,akt_kjwo_ww
,kjwo_ww

,kjwo_ww_vj
,dat_von_vj
,dat_bis_vj

FROM ( -- t2
SELECT t1.mandant_id
,t1.akt_kjwo_ww
,t1.kjwo_ww

,v03.kjwo_ww AS kjwo_ww_vj
,MIN(v03.dat) OVER (PARTITION BY v03.mandant_id, v03.kjwo_ww) AS dat_von_vj
,MAX(v03.dat) OVER (PARTITION BY v03.mandant_id, v03.kjwo_ww) AS dat_bis_vj
FROM ( -- t1
SELECT v01.mandant_id
,v01.akt_kjwo_ww
,v01.kjwo_ww
,v02.dat_vj
FROM dbp_view.v_werbewoche_kl v01
INNER JOIN dbp_view.v_tag v02
ON v01.dat = v02.dat
) t1
INNER JOIN dbp_view.v_werbewoche_kl v03
ON t1.mandant_id = v03.mandant_id
AND t1.dat_vj = v03.dat
) t2
GROUP BY mandant_id
,akt_kjwo_ww
,kjwo_ww

,kjwo_ww_vj
,dat_von_vj
,dat_bis_vj
;
