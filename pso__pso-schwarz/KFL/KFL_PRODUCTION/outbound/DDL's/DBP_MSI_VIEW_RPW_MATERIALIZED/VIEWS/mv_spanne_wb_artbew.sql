-- 20.07.2020 dsim: SPEC0064436 Artbew view has been created

-- 09.03.2023 twie: SPEC0064436 Sonderlogik vom 01.03.2023 entfernt, Tabelle enthält nicht die benötigten Daten

-- 12.04.2023 twie: SPEC0064436 andere Vorzeichenlogik in RPW gewünscht, deshalb bei allen Kennzahlen das Vorzeichen gedreht (* -1)

-- 20.04.2021 sanadze: AP0047531 Erstellung der View auf Snowflake

-- 01.03.2023 twie: SPEC0064436 ek_netto wird in der MV_SPANNE_WB_LBD für Bewart 317-320 ausgefiltert, dafür hier als extra Feld hinzugenommen

-- 14.06.2021 richternic: verdichtet Belastungsart_id aufnehmen

-- 08.02.2023 twie: SPEC0064436 ek_netto darf nicht durch menge geteilt werden, Gruppierung korrigiert

-- 30.06.2021 richternic: Anpassungen Brutto VK

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw_materialized.mv_spanne_wb_artbew (rcv_id, mandant_id, system_id,
bewart_id, nb_id, art_id, dat, mwst, belastungsart_id, belastungsart_vd_id, menge, ek_netto, vk_netto, vk_brutto) AS
-- Belastungsart_id verdichtet (fuer das richtige Mapping mit der Lookup)
 -- Menge (Hybridbericht)

-- Betrag ek netto (Hybridbericht)
 -- Betrag VK Netto (Hybridbericht)
 -- Betrag VK Brutto (Hybritbericht)
 SELECT AB.wup_id
  AS rcv_id,
 AB.mandant_id,
 7 AS system_id,
 AB.bewart_id,
 AB.nb_id,
 AB.art_id,
 AB.dat,
 MP.mwst,
 CAST(CASE
   WHEN AB.umsatz_netto >= 0
   THEN 251
   ELSE 252
   END AS STRING) AS belastungsart_id,
 -- Belastungsart_id für Umsatz soll als 251 und Retouren 252 angegegeben werden
 4 AS belastungsart_vd_id,
 SUM(AB.menge * -1) AS menge,
 SUM(AB.ek_netto * -1) AS ek_netto,
 SUM(AB.umsatz_netto * -1) AS vk_netto,
 SUM(AB.umsatz_netto * (1 + MP.mwst / 100) * -1) AS vk_brutto
FROM kfl_production_dbp_view.v_artbew AS AB
 INNER JOIN kfl_production_dbp_view.v_mwst_per AS MP ON AB.mwst_id = MP.mwst_id AND AB.mandant_id = MP.mandant_id AND AB
   .dat BETWEEN MP.dat_von AND MP.dat_bis
WHERE AB.mandant_id = 1
GROUP BY rcv_id,
 AB.mandant_id,
 system_id,
 AB.bewart_id,
 AB.nb_id,
 AB.art_id,
 AB.dat,
 MP.mwst,
 belastungsart_id,
 belastungsart_vd_id;