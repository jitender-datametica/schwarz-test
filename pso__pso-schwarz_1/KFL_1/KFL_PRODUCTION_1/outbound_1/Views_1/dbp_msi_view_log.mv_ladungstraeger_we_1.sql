CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_ladungstraeger_we_1 (mandant_id, transportation_unit_id,
kj_transportation_unit, dat_erstellung, beleg_id, gp_id, lagerort_id, lagernummer_id, ladungstraeger_status_id, art_guid
, art_id, artikelsortiment_id, anz_ladungstraeger_defekt, anz_ladungstraeger, anz_ladungstraeger_tausch,
anz_ladungstraeger_defekt_tausch, wg_id) AS SELECT TCL.mandant_id,
 TCL.transportation_unit_id,
 TCL.kj_transportation_unit,
 DATE(TCL.datzeit_erstellung) AS dat_erstellung,
 TCL.beleg_id,
 BL.gp_id,
 bld.lagerort_id,
 tu.lagernummer_id,
 TCL.ladungstraeger_status_id,
 TCL.art_guid,
 ART_GUID0.art_id,
 A_SORT.artikelsortiment_id,
 TCL.anz_ladungstraeger_defekt,
 TCL.anz_ladungstraeger,
 TCL.anz_ladungstraeger_tausch,
 TCL.anz_ladungstraeger_defekt_tausch,
 WG.wg_id
FROM kfl_production_dbp_view.v_transportation_unit_carrier_log_1 AS TCL
 INNER JOIN kfl_production_dbp_view.v_besch_lief_1 AS BL ON TCL.beleg_id = BL.lief_beleg_id AND TCL.mandant_id = BL.mandant_id
     AND ABS(BL.kj - TCL.kj_transportation_unit) <= 1
 INNER JOIN (SELECT mandant_id,
   lief_beleg_id,
   kj,
   dat_lief_soll,
   MIN(lagerort_id) AS lagerort_id
  FROM kfl_production_dbp_view.v_besch_lief_det_1
  GROUP BY mandant_id,
   lief_beleg_id,
   kj,
   dat_lief_soll) AS bld ON BL.mandant_id = bld.mandant_id AND BL.lief_beleg_id = bld.lief_beleg_id AND BL.kj = bld.kj
  AND BL.dat_lief_soll = bld.dat_lief_soll
 INNER JOIN kfl_production_dbp_view.v_art_guid_zu_1 AS ART_GUID0 ON TCL.art_guid = ART_GUID0.art_guid AND TCL.mandant_id =
   ART_GUID0.mandant_id
 LEFT JOIN kfl_production_dbp_view.v_fremd_lagerort_artikelsortiment_zu_1 AS A_SORT ON bld.lagerort_id = A_SORT.fremd_lagerort_id
    AND bld.mandant_id = A_SORT.mandant_id
 LEFT JOIN (SELECT mandant_id,
   beleg_id,
   transportation_unit_id,
   kj_transportation_unit,
   lagernummer_id,
   ROW_NUMBER() OVER (PARTITION BY CAST(mandant_id AS STRING), CAST(beleg_id AS STRING) ORDER BY datzeit_aenderung
      IS NULL DESC, datzeit_aenderung DESC, beleg_pos_id IS NULL, beleg_pos_id) AS relevant
  FROM kfl_production_dbp_view.v_transportation_unit_hu_lief_zu_1) AS tu ON BL.mandant_id = tu.mandant_id AND BL.lief_beleg_id
      = tu.beleg_id AND TCL.kj_transportation_unit = tu.kj_transportation_unit AND tu.relevant = 1
 LEFT JOIN kfl_production_dbp_view.v_art_wg_zu_per_1 AS WG ON ART_GUID0.art_id = WG.art_id AND TCL.mandant_id = WG.mandant_id
      AND DATE(TCL.datzeit_erstellung) BETWEEN WG.dat_von AND WG.dat_bis AND WG.arthiertyp_id = 2
WHERE TCL.kj_transportation_unit >= EXTRACT(YEAR FROM CURRENT_DATE) - 2;