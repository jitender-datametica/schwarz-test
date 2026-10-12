CREATE OR REPLACE VIEW DBP_MSI_VIEW_WWC.MV_WERBEWOCHE_KL_1
-- AP0011863, SPEC0024396, 14.06.2017, initial
-- INC0234537, Falsche Daten in Fakturabericht, 08.05.2018, srom0404, Einschränkung in Prompt Filter verlagert
-- diese View wird auch als Lookup/Verbindung bei VJ Metriken verwendet. Werte können daher ausser Range liegen, wenn Werbewochen ausgewählt werden, die länger als ein Jahr zurück liegen
-- NSR0307992, 28.08.2018, srom0404, Elementprompt Werbewoche im Fakturabericht
(
mandant_id
,dat
,akt_kjwo_ww
,kjwo_ww
,mandant_kjwo_ww
,dat_von
,dat_bis
)
AS
   SELECT v01.mandant_id, v01.dat, v01.akt_kjwo_ww, v01.kjwo_ww, TRIM(CAST(v01.mandant_id AS CHAR(3)))||'_'||CAST(v01.kjwo_ww AS CHAR(6)) AS mandant_kjwo_ww, MIN(v01.dat) OVER (PARTITION BY v01.mandant_id, v01.kjwo_ww) AS dat_von, MAX(v01.dat) OVER (PARTITION BY v01.mandant_id, v01.kjwo_ww) AS dat_bis
   FROM dbp_view.v_werbewoche_kl_1 v01
--WHERE v01.akt_kjwo_ww BETWEEN -104 AND 1
;