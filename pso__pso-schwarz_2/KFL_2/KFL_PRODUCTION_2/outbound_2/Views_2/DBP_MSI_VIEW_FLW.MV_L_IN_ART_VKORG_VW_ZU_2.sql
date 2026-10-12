-- 13.05.2019 pjan: AP0043250, SPEC0054321 including flw_verkaufsorganisation_id DE09
 -- 26.10.2011 system_id entfernt

-- , system_id
 -- 20.08.2014 TWIE: Umstellung von Industrie auf eigene FLW Tabellen

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_art_vkorg_vw_zu_2 (mandant_id, in_verkaufsorganisation_id,
in_art_id, in_vw_id, art_status_id, verk_menge_einh_id, werk_id, umrech_faktor_bme) AS
-- Zuordnung Werk zu VK_2-Org und VW
 -- fuer Umrechnung von VKME in BME
 SELECT V01.mandant_id,
 V01.flw_verkaufsorganisation_id AS in_verkaufsorganisation_id,
 V01.flw_art_id AS in_art_id,
 V01.flw_vw_id AS in_vw_id,
 V01.art_status_id,
 V01.verk_menge_einh_id,
 V02.werk_id,
 ROUND(CAST(V03.umrech_faktor AS BIGNUMERIC), 5) AS umrech_faktor_bme
FROM kfl_production_dbp_view.v_flw_art_vkorg_vw_zu_2 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_vkorg_vw_werk_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.flw_verkaufsorganisation_id
       = V02.flw_verkaufsorganisation_id AND V01.flw_vw_id = V02.flw_vw_id -- Fleischwerk VKORG
 AND V02.flw_verkaufsorganisation_id
     IN ('DE03', 'DE04', 'DE07', 'DE08', 'DE09', 'CZ03') AND -- Filialen DE+CZ
 V01.flw_vw_id = 10
 LEFT JOIN kfl_production_dbp_view.v_flw_art_umrech_faktor_per_2 AS V03 ON V01.flw_art_id = V03.flw_art_id AND V01.mandant_id
     = V03.mandant_id -- Umrechnungsfaktor VKME in BME
 AND V01.verk_menge_einh_id = V03.altnv_menge_einh_id;