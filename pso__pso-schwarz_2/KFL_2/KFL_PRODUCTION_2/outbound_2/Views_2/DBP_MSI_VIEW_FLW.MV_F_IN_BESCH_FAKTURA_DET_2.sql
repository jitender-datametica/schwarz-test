CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_in_besch_faktura_det_2 AS SELECT V01.faktura_beleg_id,
 V01.faktura_beleg_pos_id,
 V01.mandant_id,
 V01.werk_id,
 V01.lief_pos_typ_id,
 V01.in_art_id,
 V01.vorlage_beleg_id,
 V01.menge_faktura_vkme_tmp AS menge_faktura_vkme,
 V01.menge_faktura_lme_tmp AS menge_faktura_lme,
 V01.verk_menge_faktura_einh_id,
 V01.gewicht_netto,
 V01.dat_preisfindung,
 V01.dat_leist_erstellung,
 V400.wrg_id,
  CAST(CASE
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V01.wert_ek_netto
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
    THEN V01.wert_ek_netto / V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V01.wert_ek_netto * V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
    THEN V01.wert_ek_netto
    ELSE 0
    END AS NUMERIC) * V01.vorzeichen_preise AS wert_ek_netto,
  CAST(CASE
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V01.zwsum_2_betrag
    WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
    THEN V01.zwsum_2_betrag / V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
    THEN V01.zwsum_2_betrag * V500.umrechnungskurs
    WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
    THEN V01.zwsum_2_betrag
    ELSE 0
    END AS NUMERIC) * V01.vorzeichen_preise AS vkpn_gesamt,
  CAST(CASE
    WHEN V200.wrg_typ_id = 0
    THEN V01.vk_brutto * V500.umrechnungskurs
    WHEN V200.wrg_typ_id = 1
    THEN V01.vk_brutto
    ELSE NULL
    END AS NUMERIC) * V01.vorzeichen_preise AS npb,
   CAST(CASE
     WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
     THEN V01.zwsum_2_betrag
     WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
     THEN V01.zwsum_2_betrag / V500.umrechnungskurs
     WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
     THEN V01.zwsum_2_betrag * V500.umrechnungskurs
     WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
     THEN V01.zwsum_2_betrag
     ELSE 0
     END AS NUMERIC) * V01.vorzeichen_preise / CASE
   WHEN V01.menge_faktura_lme = 0
   THEN NULL
   ELSE V01.menge_faktura_lme
   END AS vkpn,
   CAST(CASE
     WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 0
     THEN V01.zwsum_2_betrag
     WHEN V01.wrg_id <> V01.default_wrg AND V200.wrg_typ_id = 1
     THEN V01.zwsum_2_betrag / V500.umrechnungskurs
     WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 0
     THEN V01.zwsum_2_betrag * V500.umrechnungskurs
     WHEN V01.wrg_id = V01.default_wrg AND V200.wrg_typ_id = 1
     THEN V01.zwsum_2_betrag
     ELSE 0
     END AS NUMERIC) * V01.vorzeichen_preise * (1 + V01.mwst / 100) AS vkpb_gesamt,
   CAST(CASE
     WHEN V200.wrg_typ_id = 0
     THEN V01.vk_brutto * V500.umrechnungskurs
     WHEN V200.wrg_typ_id = 1
     THEN V01.vk_brutto
     ELSE NULL
     END AS NUMERIC) * V01.vorzeichen_preise / (1 + V01.mwst / 100) AS npn,
 CAST(CAST(CASE
       WHEN V200.wrg_typ_id = 0
       THEN V01.vk_brutto * V500.umrechnungskurs
       WHEN V200.wrg_typ_id = 1
       THEN V01.vk_brutto
       ELSE NULL
       END AS NUMERIC) * V01.vorzeichen_preise / (1 + V01.mwst / 100) / CAST(CASE
     WHEN V01.basismenge_einh_id = 'KG'
     THEN 1
     WHEN V01.basismenge_einh_id = 'ST'
     THEN V01.umrech_faktor
     ELSE NULL
     END AS NUMERIC) AS NUMERIC) AS npn_kg,
    CAST(CAST(CASE
          WHEN V200.wrg_typ_id = 0
          THEN V01.vk_brutto * V500.umrechnungskurs
          WHEN V200.wrg_typ_id = 1
          THEN V01.vk_brutto
          ELSE NULL
          END AS NUMERIC) * V01.vorzeichen_preise / (1 + V01.mwst / 100) / CAST(CASE
        WHEN V01.basismenge_einh_id = 'KG'
        THEN 1
        WHEN V01.basismenge_einh_id = 'ST'
        THEN V01.umrech_faktor
        ELSE NULL
        END AS NUMERIC) AS NUMERIC) * V01.gewicht_netto_v02 * V01.zaehler / V01.nenner AS npn_gesamt
FROM kfl_production_dbp_msi_view_flw.tbl_mv_f_in_besch_faktura_det_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_2 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 LEFT JOIN kfl_production_dbp_view.v_kurs_2 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.default_wrg = V500.von_wrg_id
      AND V500.nach_wrg_id = 'EUR' AND V01.dat_preisfindung BETWEEN V500.dat_von AND V500.dat_bis;