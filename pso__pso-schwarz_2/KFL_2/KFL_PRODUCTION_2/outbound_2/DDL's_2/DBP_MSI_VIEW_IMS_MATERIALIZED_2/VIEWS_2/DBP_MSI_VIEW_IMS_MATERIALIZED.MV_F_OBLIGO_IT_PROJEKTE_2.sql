CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims_materialized.mv_f_obligo_it_projekte_2 (mandant_id, it_psp_id,
it_psp_id_char, it_plan_ebene_id, in_art_id, gj, buchungsperiode_id, buchungskreis_id, dat_buch, dat_beleg, ref_beleg_id
, ref_beleg_pos_id, krk_id, in_lief_id, it_projekte_obligo, kostenart_id, anlage_id, anlage_sub_id,
anlage_buchungskreis_id, berichts_position_it_id, berichts_position_it_rwi_id, sparte_id, dat_von, dat_bis,
kostenstelle_id, bestell_text, betrag_plan, bedarf_nr) AS SELECT V01.mandant_id,
 V01.it_psp_id,
 V01.it_psp_id_char,
 V01.it_plan_ebene_id,
 V01.in_art_id,
 V01.gj,
 V01.buchungsperiode_id,
 V01.buchungskreis_id,
 V01.dat_buch,
 V01.dat_beleg,
 V01.ref_beleg_id,
 V01.ref_beleg_pos_id,
 V01.krk_id,
 V01.in_lief_id,
  CASE
  WHEN V400.wrg_typ_id = 1
  THEN V01.betrag
  ELSE V01.betrag * V500.umrechnungskurs
  END AS it_projekte_obligo,
 V01.kostenart_id,
 V01.anlage_id,
 V01.anlage_sub_id,
 V01.anlage_buchungskreis_id,
 V01.berichts_position_it_id,
 V01.berichts_position_it_rwi_id,
 V01.sparte_id,
 V01.dat_von,
 V01.dat_bis,
 V01.kostenstelle_id,
 V01.bestell_text,
 V01.betrag_plan,
 V01.bedarf_nr
FROM kfl_production_dbp_msi_view_ims_materialized.tbl_mv_f_obligo_it_projekte_2 AS V01
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_wrg_typ_zu_2 AS V200 ON TRUE
 INNER JOIN kfl_production_dbp_msi.akt_msi_user_kurstyp_zu_2 AS V300 ON TRUE
 INNER JOIN kfl_production_dbp_view.v_mandant_wrg_typ_zu_2 AS V400 ON V01.mandant_id = V400.mandant_id AND V200.wrg_typ_id
    = V400.wrg_typ_id
 INNER JOIN kfl_production_dbp_view.v_kurs_2 AS V500 ON V300.kurstyp_id = V500.kurstyp_id AND V01.wrg_id = V500.von_wrg_id
     AND CURRENT_DATE BETWEEN V500.dat_von AND V500.dat_bis
QUALIFY V500.nach_wrg_id = 'EUR' AND (RANK() OVER (PARTITION BY V01.mandant_id, V01.krk_id, V01.obligo_version_id, V01.obligo_wrg_typ_id
       , V01.ref_beleg_id, V01.ref_beleg_pos_id, V01.ref_belegart_id, V01.ref_termin_pos_id, V01.ref_kontierung_id, V01
       .ref_objektart_id, V01.dat_bis ORDER BY V01.dat_von IS NULL, V01.dat_von)) = 1;