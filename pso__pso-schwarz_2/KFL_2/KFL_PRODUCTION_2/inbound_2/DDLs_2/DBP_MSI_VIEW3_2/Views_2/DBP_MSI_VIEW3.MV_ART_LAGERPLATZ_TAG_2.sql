CREATE OR REPLACE VIEW DBP_MSI_VIEW3.MV_ART_LAGERPLATZ_TAG_2
(
art_id
, mandant_id
, system_id
, wup_id
, nb_id
, lagernummer_id
, lagertyp_id
, lagerplatz_id
, dat
, lagerplatz_loesch_kz
, mlgt_fg
, bestand_kz
, bestand_kz_11
, bestand_kz_22
, bestand_kz_33
, bestand_kz_44
, bestand_kz_1
, bestand_kz_2
, bestand_kz_3
, bestand_kz_4
, bestand_kz_5
, bestand_kz_6
, bestand_kz_7
, bestand_kz_8
, bestand_kz_9
, bestand_kz_10
, bestand_kz_99
, bestand_kz_12
, bestand_kz_13
, bestand_kz_14
, bestand_kz_15
, bestand_kz_16
, bestand_kz_17
, bestand_kz_18
)
AS
-- AP0105952, SPEC0140328, bestand_kz_15
-- AP0105952, SPEC0140328, bestand_kz_16, bestand_kz_17, bestand_kz_18
   SELECT
  art_id, mandant_id, system_id, wup_id, nb_id, lagernummer_id, lagertyp_id, lagerplatz_id, dat, 
  lagerplatz_loesch_kz, mlgt_fg, bestand_kz, 
  
  CASE WHEN bestand_kz = 11 THEN 1 ELSE 0 END AS bestand_kz_11  /* Belegte virtuelle Lagerplätze für Griffzonen mit Bestand */, 
  CASE WHEN bestand_kz = 22 THEN 1 ELSE 0 END AS bestand_kz_22  /* Belegte virtuelle Lagerplätze für Griffzonen ohne Bestand */, 
  CASE WHEN bestand_kz = 33 THEN 1 ELSE 0 END AS bestand_kz_33  /* Freie virtuelle Lagerplätze für Griffzonen */, 
  CASE WHEN bestand_kz = 44 THEN 1 ELSE 0 END AS bestand_kz_44  /* Gesperrte virtuelle Lagerplätze für Griffzonen */, 
 
  
  CASE WHEN bestand_kz = 1 THEN 1 ELSE 0 END + bestand_kz_11 AS bestand_kz_1  
  /* Belegte Lagerplätze für Griffzonen mit Bestand inkl. virtuelle Griffzonen*/, 
  CASE WHEN bestand_kz = 2 THEN 1 ELSE 0 END + bestand_kz_22 AS bestand_kz_2  /* Belegte Lagerplätze für Griffzonen ohne Bestand inkl. virtuelle Griffzonen*/, 
  CASE WHEN bestand_kz = 3 THEN 1 ELSE 0 END + bestand_kz_33 AS bestand_kz_3  /* Freie Lagerplätze für Griffzonen inkl. virtuelle Griffzonen*/, 
  CASE WHEN bestand_kz = 4 THEN 1 ELSE 0 END + bestand_kz_44 AS bestand_kz_4  /* Gesperrte Lagerplätze für Griffzonen inkl. virtuelle Griffzonen*/, 
  CASE WHEN bestand_kz = 5 THEN 1 ELSE 0 END AS bestand_kz_5  /* Belegte Lagerplätze für Reserve / Hochregal mit Bestand */, 
  CASE WHEN bestand_kz = 6 THEN 1 ELSE 0 END AS bestand_kz_6  /* Freie Lagerplätze für Reserve / Hochregal mit Bestand */, 
  CASE WHEN bestand_kz = 7 THEN 1 ELSE 0 END AS bestand_kz_7  /* Gesperrte Lagerplätze für Reserve / Hochregal */, 
  anzahl_quant AS bestand_kz_8  /* Blocklager */, 
  bestand_kz_1 + bestand_kz_2 + bestand_kz_3 + bestand_kz_4 AS bestand_kz_9  /* Lagerplätze für Griffzonen Gesamt*/, 
  bestand_kz_5 + bestand_kz_6 + bestand_kz_7 AS bestand_kz_10, 
  bestand_kz_11 + bestand_kz_22 + bestand_kz_33 + bestand_kz_44 AS bestand_kz_99  /* Virtuelle Lagerplätze für Griffzonen Gesamt*/, 
  CASE WHEN bestand_kz = 12 THEN 1 ELSE 0 END + CASE WHEN lagertyp_id = 'RH1' THEN bestand_kz_5 ELSE 0 END AS bestand_kz_12 /* Belegte Lagerplätze für AKL mit Bestand; RH1 auch in 5 enthalten*/, 
  CASE WHEN bestand_kz = 13 THEN 1 ELSE 0 END + CASE WHEN lagertyp_id = 'RH1' THEN bestand_kz_6 ELSE 0 END AS bestand_kz_13 /* Freie Lagerplätze für AKL; RH1 auch in 5 enthalten*/, 
  bestand_kz_12 + bestand_kz_13 AS bestand_kz_14 /* Lagerplätze für AKL Gesamt*/,
  
  CASE WHEN bestand_kz = 15 THEN 1 ELSE 0 END AS bestand_kz_15,
  CASE WHEN bestand_kz = 16 THEN 1 ELSE 0 END AS bestand_kz_16,
  CASE WHEN bestand_kz = 17 THEN 1 ELSE 0 END AS bestand_kz_17,
  CASE WHEN bestand_kz = 18 THEN 1 ELSE 0 END AS bestand_kz_18 

   FROM dbp_view.v_art_lagerplatz_tag_2
   WHERE EXTRACT(YEAR FROM dat) >= YEAR(CURRENT_TIMESTAMP) - 2;