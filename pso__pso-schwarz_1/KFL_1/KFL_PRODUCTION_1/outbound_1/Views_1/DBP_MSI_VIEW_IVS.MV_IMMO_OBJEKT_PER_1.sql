CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_immo_objekt_per_1 AS SELECT IO.mandant_id,
 IO.immo_objekt_id,
 IO.dat_von,
 IO.dat_bis,
 IO.objekt_groesse,
 IO.konzessionaer_groesse,
 IO.objekt_plz,
 kfl_production_dbp_process.transcriptc(IO.objekt_ort) AS objekt_ort,
 kfl_production_dbp_process.transcriptc(IO.objekt_strasse) AS objekt_strasse,
 kfl_production_dbp_process.transcriptc(IO.objekt_name) AS objekt_name,
 IO.dat_1bereich_oeffnung,
 IO.dat_objekt_oeffnung,
 wp.dat_eroeffnung,
 COALESCE(IO.dat_objekt_oeffnung, wp.dat_eroeffnung) AS dat_eroeffnung_geplant,
 IO.objektart_id,
 NULLIF(IO.objektart_datum_von, DATE('1900-01-01')) AS objektart_datum_von,
 NULLIF(IO.objektart_datum_bis, DATE('9999-12-31')) AS objektart_datum_bis,
 IO.dat_umgl,
 IO.status_umgl,
  IO.eigenmiete_pro_qm * KURS.kurs_1 AS eigenmiete_pro_qm,
  IO.eigenmiete_pro_monat * KURS.kurs_1 AS eigenmiete_pro_monat,
 KURS.wrg_id,
 KURS.wrg_typ_id,
 IO.immo_objekt_obj_id,
 IO.ref_immo_objekt_id,
 IO.immo_objekt_nr,
 IO.buchungskreis_id,
 IO.immo_objekt_bez,
 kfl_production_dbp_process.transcriptc(CASE
   WHEN INSTR(IO.objekt_name, 'PAOB') > 0
   THEN TRIM(SUBSTR(IO.objekt_name, 1, INSTR(IO.objekt_name, 'PAOB') - 1))
   WHEN INSTR(IO.objekt_name, ',PAOB') > 0
   THEN TRIM(SUBSTR(IO.objekt_name, 1, INSTR(IO.objekt_name, ',PAOB') - 1))
   WHEN INSTR(IO.objekt_name, 'UMGL') > 0
   THEN TRIM(SUBSTR(IO.objekt_name, 1, INSTR(IO.objekt_name, 'UMGL') - 1))
   WHEN INSTR(IO.objekt_name, ',UMGL') > 0
   THEN TRIM(SUBSTR(IO.objekt_name, 1, INSTR(IO.objekt_name, ',UMGL') - 1))
   WHEN INSTR(IO.objekt_name, 'Partnerobjekt') > 0
   THEN TRIM(SUBSTR(IO.objekt_name, 1, INSTR(IO.objekt_name, 'Partnerobjekt') - 1))
   ELSE IO.objekt_name
   END) AS objekt_name_grp
FROM kfl_production_dbp_view.v_ivs_immo_objekt_per_1 AS IO
 INNER JOIN kfl_production_dbp_msi_view_ivs.mv_mandant_wrg_kurs_zu_per_1 AS KURS_1 ON IO.mandant_id = KURS.mandant_id AND
   CURRENT_DATE BETWEEN KURS.kurs_dat_von AND KURS.kurs_dat_bis
 LEFT JOIN (SELECT mandant_id,
   wup_id,
   dat_eroeffnung
  FROM kfl_production_dbp_view.v_wup_1
  WHERE nb_id = 0
   AND dat_eroeffnung BETWEEN DATE('1900-01-02') AND (DATE('2090-12-30'))) AS wp ON IO.mandant_id = wp.mandant_id AND IO
   .immo_objekt_bez = wp.wup_id
WHERE IO.dat_bis = DATE('9999-12-31')
 AND (IO.mandant_id, IO.immo_objekt_id) NOT IN (SELECT (mandant_id, immo_objekt_id)
   FROM kfl_production_dbp_view.v_ivs_immo_objekt_per_1
   WHERE dat_bis = DATE('9999-12-31')
    AND (dat_umgl > CURRENT_DATE OR status_umgl = 'UMGL' AND dat_umgl IS NULL AND (mandant_id, ref_immo_objekt_id) IN (SELECT
           (mandant_id, ref_immo_objekt_id)
         FROM kfl_production_dbp_view.v_ivs_immo_objekt_per_1
         WHERE dat_umgl <= CURRENT_DATE
          AND dat_bis = DATE('9999-12-31'))))
UNION ALL
SELECT mandant_id,
 'IW----------0' AS dm__operand1,
 DATE('1900-01-01') AS dm__operand2,
 DATE('9999-12-31') AS dm__operand3,
 0 AS dm__operand4,
 0 AS dm__operand5,
 '' AS dm__operand6,
 '' AS dm__operand7,
 '' AS dm__operand8,
 'ohne Zuordnung' AS dm__operand9,
 DATE('1900-01-01') AS dm__operand10,
 DATE('1900-01-01') AS dm__operand11,
 DATE('1900-01-01') AS dm__operand12,
 DATE('1900-01-01') AS dm__operand13,
 '3' AS dm__operand14,
 DATE('1900-01-01') AS dm__operand15,
 DATE('9999-12-31') AS dm__operand16,
 DATE(NULL) AS dm__operand17,
 SUBSTR(NULL, 1, 10) AS dm__operand18,
 0.00 AS dm__operand19,
 0.00 AS dm__operand20,
 wrg_id,
 wrg_typ_id,
 'IW----------0' AS dm__operand23,
 'IW----------0' AS dm__operand24,
 '' AS dm__operand25,
 0 AS dm__operand26,
 0 AS dm__operand27,
 'ohne Zuordnung' AS dm__operand28
FROM kfl_production_dbp_view.v_mandant_wrg_typ_zu_1;
