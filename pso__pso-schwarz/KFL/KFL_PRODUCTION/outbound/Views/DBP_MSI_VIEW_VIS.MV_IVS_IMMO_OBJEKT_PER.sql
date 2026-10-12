-- Basis: Statusinformationen und Umgliederungsdatum

-- 2012KW25 : Initial von IVS nach VIS übernommen, ohne Währungsumrechnung
 -- Dummy Objekt 0

-- 2013KW10 Erweiterung Kurs/Waehrungsumrechnung
 -- Ermittlung der relevanten Objekt-Version bei Umgliederung

-- 2013KW02 : Transkription
 -- STAMMDATEN Immobilie (immo_objekt)
 -- Akt. Datenstand : Gueltigkeitsdatum 31.12.9999

CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_ivs_immo_objekt_per AS SELECT IO.mandant_id,
 IO.immo_objekt_id,
 IO.dat_von,
 IO.dat_bis,
 IO.objekt_groesse,
 IO.konzessionaer_groesse,
 kfl_production_dbp_process.transcriptc(IO.objekt_ort) AS objekt_ort,
 kfl_production_dbp_process.transcriptc(IO.objekt_strasse) AS objekt_strasse,
 IO.objekt_plz,
 kfl_production_dbp_process.transcriptc(IO.objekt_name) AS objekt_name,
 IO.dat_1bereich_oeffnung,
 IO.dat_objekt_oeffnung,
 IO.objektart_id,
 NULLIF(IO.objektart_datum_von, DATE '1900-01-01') AS objektart_datum_von,
 NULLIF(IO.objektart_datum_bis, DATE '9999-12-31') AS objektart_datum_bis,
  IO.eigenmiete_pro_qm * KURS.kurs AS eigenmiete_pro_qm,
  IO.eigenmiete_pro_monat * KURS.kurs AS eigenmiete_pro_monat,
 KURS.wrg_id,
 IO.immo_objekt_obj_id,
 IO.immo_objekt_bez,
 IO.immo_objekt_nr,
 IO.buchungskreis_id,
 kfl_production_dbp_process.transcriptc(CASE
   WHEN STRPOS(IO.objekt_name, 'Partnerobjekt') > 0
   THEN TRIM(SUBSTR(IO.objekt_name, 1, STRPOS(IO.objekt_name, 'Partnerobjekt') - 1))
   ELSE IO.objekt_name
   END) AS objekt_name_grp
FROM kfl_production_dbp_view.v_ivs_immo_objekt_per AS IO
 INNER JOIN kfl_production_dbp_msi_view_vis.mv_ivs_mandant_wrg_kurs_zu_per AS KURS ON IO.mandant_id = KURS.mandant_id
WHERE IO.dat_bis = DATE '9999-12-31'
 AND (IO.mandant_id, IO.immo_objekt_id) NOT IN (SELECT (mandant_id, immo_objekt_id)
   FROM kfl_production_dbp_view.v_ivs_immo_objekt_per
   WHERE dat_bis = DATE '9999-12-31'
    AND (/* Daten der Umgliederung in der Zukunft */ dat_umgl > CURRENT_DATE OR
         /* mindestens ein Satz vorhanden mit Umgliederung in der Vergangenheit */ status_umgl = 'UMGL' AND dat_umgl
        IS NULL AND (mandant_id, ref_immo_objekt_id) IN (SELECT (mandant_id, ref_immo_objekt_id)
         FROM kfl_production_dbp_view.v_ivs_immo_objekt_per
         WHERE dat_umgl <= CURRENT_DATE
          AND dat_bis = DATE '9999-12-31')))
UNION ALL
SELECT mandant_id,
 'IW----------0' AS dm__operand1,
 CAST('1900-01-01' AS DATE) AS dm__operand2,
 CAST('9999-12-31' AS DATE) AS dm__operand3,
 0 AS dm__operand4,
 0 AS dm__operand5,
 '' AS dm__operand6,
 '' AS dm__operand7,
 '' AS dm__operand8,
 'ohne Zuordnung' AS dm__operand9,
 CAST('1900-01-01' AS DATE) AS dm__operand10,
 CAST('1900-01-01' AS DATE) AS dm__operand11,
 '3' AS dm__operand12,
 CAST('1900-01-01' AS DATE) AS dm__operand13,
 CAST('9999-12-31' AS DATE) AS dm__operand14,
 0.00 AS dm__operand15,
 0.00 AS dm__operand16,
 wrg_id,
 'IW----------0' AS dm__operand18,
 0 AS dm__operand19,
 '' AS dm__operand20,
 0 AS dm__operand21,
 'ohne Zuordnung' AS dm__operand22
FROM kfl_production_dbp_msi_view_vis.mv_ivs_mandant_wrg_kurs_zu_per AS KURS;


