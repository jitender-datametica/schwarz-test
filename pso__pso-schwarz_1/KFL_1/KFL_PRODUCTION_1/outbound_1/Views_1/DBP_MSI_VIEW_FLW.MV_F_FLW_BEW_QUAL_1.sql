
CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_flw_bew_qual_1 (mandant_id, best_beleg_id, werk_id, in_lief_id
, dat_lief_wunsch, flw_beleg_typ_id, beleg_gruppe_id, zeit_differenz, ds_verspaetung, anz_best_beleg_ok) AS SELECT V01.mandant_id
 ,
 V01.best_beleg_id,
 V01.werk_id,
 V02.flw_lief_id AS in_lief_id,
 V03.dat_lief_wunsch,
 V01.flw_beleg_typ_id,
 V01.beleg_gruppe_id,
 TIMESTAMP_DIFF(V03.datzeit_lief_wunsch, V01.datzeit_erstellung, DAY) AS zeit_differenz,
 TIMESTAMP_DIFF(
  V03.datzeit_lief_wunsch,
  V01.datzeit_erstellung,
  SECOND
) AS ds_verspaetung,
 COUNT(V01.best_beleg_id) AS anz_best_beleg_ok
FROM kfl_production_dbp_view.v_flw_bew_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_flw_besch_best_1 AS V02 ON V01.best_beleg_id = V02.best_beleg_id AND V01.mandant_id
   = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_flw_lief_einteilung_1 AS V03 ON V01.best_beleg_id = V03.best_beleg_id AND V01.best_beleg_pos_id
     = V03.best_beleg_pos_id AND V01.mandant_id = V03.mandant_id
 INNER JOIN kfl_production_dbp_view.v_flw_qual_meldung_1 AS V04 ON V01.best_beleg_id = V04.best_beleg_id AND V01.mandant_id
    = V04.mandant_id
 INNER JOIN kfl_production_dbp_view.v_flw_qual_meldung_det_1 AS V05 ON V04.qual_meldung_id = V05.qual_meldung_id AND V04.mandant_id
    = V05.mandant_id
 INNER JOIN kfl_production_dbp_view.v_flw_l_fehlgrund_1 AS V06 ON V05.fehlgrund_id = V06.fehlgrund_id AND V05.mandant_id =
   V06.mandant_id
 INNER JOIN kfl_production_dbp_view.v_flw_pruefkatalog_code_spr_zu_1 AS V07 ON V05.codegruppe_id = V07.codegruppe_id AND
     V05.katalogart_id = V07.katalogart_id AND V05.mandant_id = V07.mandant_id AND V05.pruefcode_id = V07.pruefcode_id
WHERE V06.fehlgrund_bez = 'I'
 AND V07.katalogart_id = '9'
 AND V07.pruefcode_id = '01'
 AND TRIM(V07.codegruppe_id) LIKE 'Z_1'
 AND V01.datzeit_erstellung <> CAST('1900-01-01 00:00:00' AS DATETIME)
 AND V02.einkaufsorganisation_id IN (5000, 5013, 5014)
GROUP BY V01.mandant_id,
 V01.best_beleg_id,
 V01.werk_id,
 in_lief_id,
 V03.dat_lief_wunsch,
 V01.flw_beleg_typ_id,
 V01.beleg_gruppe_id,
 V01.datzeit_erstellung,
 V03.datzeit_lief_wunsch;
