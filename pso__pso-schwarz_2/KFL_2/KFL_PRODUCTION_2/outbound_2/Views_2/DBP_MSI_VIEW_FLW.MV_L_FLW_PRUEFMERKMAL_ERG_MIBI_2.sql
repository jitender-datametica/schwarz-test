CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_flw_pruefmerkmal_erg_mibi_2 (prueflos_id, mandant_id,
satzstatus_id, gkz_fehlerklasse_id, entero_fehlerklasse_id, gkz_katalogart_id, entero_katalogart_id, gkz_codegruppe_id,
entero_codegruppe_id, gkz_pruefcode_id, entero_pruefcode_id, we_dat, mibi_erfass_dat, gkz_original_input,
entero_original_input) AS SELECT prueflos_id,
 mandant_id,
 MAX(satzstatus_id) AS satzstatus_id,
 MAX(CASE
   WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 10
   THEN fehlerklasse_id
   ELSE NULL
   END) AS gkz_fehlerklasse_id,
 MAX(CASE
   WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 40
   THEN fehlerklasse_id
   ELSE NULL
   END) AS entero_fehlerklasse_id,
 MAX(CASE
   WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 10
   THEN katalogart_id
   ELSE NULL
   END) AS gkz_katalogart_id,
 MAX(CASE
   WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 40
   THEN katalogart_id
   ELSE NULL
   END) AS entero_katalogart_id,
 MAX(CASE
   WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 10
   THEN codegruppe_id
   ELSE NULL
   END) AS gkz_codegruppe_id,
 MAX(CASE
   WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 40
   THEN codegruppe_id
   ELSE NULL
   END) AS entero_codegruppe_id,
 MAX(CASE
   WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 10
   THEN pruefcode_id
   ELSE NULL
   END) AS gkz_pruefcode_id,
 MAX(CASE
   WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 40
   THEN pruefcode_id
   ELSE NULL
   END) AS entero_pruefcode_id,
 MAX(CASE
   WHEN knoten_lfd_nr = 1
   THEN dat_pruef_von
   ELSE NULL
   END) AS we_dat,
 MAX(CASE
   WHEN knoten_lfd_nr = 2
   THEN dat_pruef_von
   ELSE NULL
   END) AS mibi_erfass_dat,
 COALESCE(MAX(CASE
    WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 20 AND original_input <> '0'
    THEN original_input
    ELSE NULL
    END), MAX(CASE
    WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 30 AND original_input <> '0'
    THEN original_input
    ELSE NULL
    END)) AS gkz_original_input,
 COALESCE(MAX(CASE
    WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 50 AND original_input <> '0'
    THEN original_input
    ELSE NULL
    END), MAX(CASE
    WHEN knoten_lfd_nr = 2 AND merkmal_lfd_nr = 60 AND original_input <> '0'
    THEN original_input
    ELSE NULL
    END)) AS entero_original_input
FROM kfl_production_dbp_view.v_flw_pruefmerkmal_ergebnis_2
GROUP BY prueflos_id,
 mandant_id;