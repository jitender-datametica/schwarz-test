CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.tbl_mv_f_obligo_1 AS SELECT V01.mandant_id,
 V01.psp_id,
 V03.ims_projekt_typ_id AS projekt_typ_id,
 V01.gj,
 V01.buchungsperiode_id,
 COALESCE(V01.buchungskreis_id, - 1) AS buchungskreis_id,
 V01.dat_buch,
 V01.dat_beleg,
 V01.ref_beleg_id,
 V01.ref_beleg_pos_id,
 V01.krk_id,
 COALESCE(V01.in_lief_id, - 1) AS in_lief_id,
 V01.auftrag_id,
 LTRIM(COLLATE(V01.kostenart_id, ''), '0') AS kostenart_id,
 COALESCE(V01.anlage_id, '') AS anlage_id,
 COALESCE(V01.anlage_sub_id, 0) AS anlage_sub_id,
 CAST(CASE
   WHEN V01.anlage_id IS NULL
   THEN CAST(- 1 AS BIGNUMERIC)
   ELSE V01.buchungskreis_id
   END AS BIGNUMERIC) AS anlage_buchungskreis_id,
 V01.berichts_position_it_id,
 V01.berichts_position_invest_id,
  CASE
  WHEN V01.sparte_id IN (4, 6, 8)
  THEN 5
  ELSE V01.sparte_id
  END AS sparte_id,
 COALESCE(V01.in_art_id, - 1) AS in_art_id,
 V01.obligo_version_id,
 V01.obligo_wrg_typ_id,
 V01.dat_von,
 V01.dat_bis,
 COALESCE(V01.kostenstelle_id, '') AS kostenstelle_id,
 V01.bestell_text,
 V01.betrag_plan,
 V01.bedarf_nr,
 V01.wrg_id,
 V01.betrag
FROM kfl_production_dbp_view.v_obligo_per_1 AS V01
 INNER JOIN kfl_production_dbp_view.v_in_psp_element_1 AS V02 ON V01.psp_id = V02.psp_id AND V01.mandant_id = V02.mandant_id
   
 INNER JOIN kfl_production_dbp_view.v_in_projekt_1 AS V03 ON V02.in_projekt_id = V03.in_projekt_id AND V02.mandant_id =
   V03.mandant_id
 INNER JOIN kfl_production_dbp_view.v_mandant_1 AS V100 ON V01.mandant_id = V100.mandant_id
WHERE (V01.krk_id <> 'DE02' OR V01.mandant_id <> 1)
 AND V01.psp_id <> - 1
 AND TRIM(COLLATE(V01.kostenart_id, ''), '0') NOT IN ('912000', '979002', 'H912000', 'H979002');