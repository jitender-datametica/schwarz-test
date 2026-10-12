-- 29.07.2019 twie: SPEC0059158  Tag_2 des Tickets ermitteln, damit Gutschein_2 unabhängig davon

-- 17.07.2019 twie: SPEC0059158  CRM Gutschein_2

-- 07.08.2019 twie: SPEC0060329 Securitykennzeichen definieren, 1 wie KDC

-- 09.05.2024 twie: SPEC0247600 Gutscheine mit -1 und NULL ausschließen, sind fachlich nicht relevant

-- 18.10.2023 twie: SPEC0213119 mandant_id hinzu für CROSS JOIN auf kostenstelle_id

-- 12.10.2022 twie: SPEC0167837 sek_kz von 1 auf 3 geändert

-- 03.01.2022 twie: NSR3432488 dat_start als Datum gecastet

-- 02.05.2024 twie: SPEC0247600 neue Datumsfelder aus Vorgang

CREATE OR REPLACE VIEW dbp_msi_view_geku.mv_crm_f_gutschein_2 (crm_gutschein_id, crm_vorgang_id, crm_gutschein_grund_id,
gutschein_nummer, kostenstelle_id, mandant_id, gutschein_wert, dat_start, dat_ende, dat_start_processing,
dat_end_processing, sec_kz) AS SELECT v01.crm_gutschein_id,
 v01.crm_vorgang_id,
 v01.crm_gutschein_grund_id,
 v01.gutschein_nummer,
 v01.kostenstelle_id,
 v01.mandant_id,
 v01.gutschein_wert,
 DATE(v02.dat_start) AS dat_start,
 DATE(v02.dat_ende) AS dat_ende,
 DATE(v02.dat_start_processing) AS dat_start_processing,
 DATE(v02.dat_end_processing) AS dat_end_processing,
 3 AS sec_kz
FROM kfl_production_dbp_view.v_crm_gutschein_2 AS v01
 INNER JOIN kfl_production_dbp_view.v_crm_vorgang_2 AS v02 ON v01.crm_vorgang_id = v02.crm_vorgang_id
WHERE CAST(v01.gutschein_nummer AS FLOAT64) <> - 1;