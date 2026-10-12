CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_art_gruppe_art_zu_2 (mandant_id, art_id, umrech_faktor,
art_gruppe_id, art_gruppe_bez, art_gruppe_bereich, art_gruppe_bemerkung, art_gruppe_kategorie, dat_anlage, dat_aenderung
) AS SELECT V01.mandant_id,
 V01.art_id,
 COALESCE(V02.umrech_faktor, 0) AS umrech_faktor,
 COALESCE(V02.art_gruppe_id, - 1) AS art_gruppe_id,
 COALESCE(V03.art_gruppe_bez, 'Nicht in Artikelgruppierung') AS art_gruppe_bez,
 COALESCE(V03.art_gruppe_bereich, 'Nicht in Artikelgruppierung') AS art_gruppe_bereich,
 COALESCE(V03.art_gruppe_bemerkung, 'Nicht in Artikelgruppierung') AS art_gruppe_bemerkung,
 COALESCE(V03.art_gruppe_kategorie, 'Nicht in Artikelgruppierung') AS art_gruppe_kategorie,
 COALESCE(V03.dat_anlage, DATE '1900-01-01') AS dat_anlage,
 COALESCE(V03.dat_aenderung, DATE '1900-01-01') AS dat_aenderung
FROM kfl_production_dbp_data.art_2 AS V01
 LEFT JOIN kfl_production_dbp_data.art_gruppe_art_zu_2 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.art_id = V02.art_id
   
 LEFT JOIN kfl_production_dbp_data.art_gruppe_2 AS V03 ON V02.art_gruppe_id = V03.art_gruppe_id
WHERE V01.mandant_id = 1;