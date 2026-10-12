CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_as_food_denorm_1 (art_id, mandant_id, nb_id, wup_id, wrg_id,
as_dat_auslistung, as_dat_aend, as_dat_final, as_final_erl_kz, as_final_status_id, as_menge_startbestand,
as_menge_endbestand, as_erl_fg, as_erl_kz, as_phase_status, kjwo, as_menge_totalabschrift, as_menge_preisabschrift,
as_menge_absatz, as_preisabschrift_netto, as_totalabschrift_netto, as_umsatz_netto, as_phase_id, as_phase_wo,
as_phase_menge_endbestand, as_phase_vk_brutto, as_phase_vk_netto, as_menge_endbestand_det) AS SELECT ASD.art_id,
 ASD.mandant_id,
 ASD.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 krs.nach_wrg_id AS wrg_id,
 ASD.dat_auslistung AS as_dat_auslistung,
 ASF.dat_aend AS as_dat_aend,
 ASD.dat_final AS as_dat_final,
 ASD.erl_kz AS as_final_erl_kz,
 ASD.as_final_status_id,
  CASE
  WHEN ASD.kjwo = (MIN(ASD.kjwo) OVER (PARTITION BY CAST(ASD.art_id AS STRING), CAST(ASD.mandant_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING)
       , krs.nach_wrg_id, ASD.dat_auslistung RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
  THEN ASF.menge_startbestand
  ELSE NULL
  END AS as_menge_startbestand,
  CASE
  WHEN ASD.kjwo = (MAX(ASD.kjwo) OVER (PARTITION BY CAST(ASD.art_id AS STRING), CAST(ASD.mandant_id AS STRING), CAST(WUP.aktuell_wup_id AS STRING)
       , krs.nach_wrg_id, ASD.dat_auslistung RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))
  THEN ASF.menge_endbestand
  ELSE NULL
  END AS as_menge_endbestand,
 ASF.erl_fg AS as_erl_fg,
 ASF.erl_kz AS as_erl_kz,
 ASF.phase_status AS as_phase_status,
 ASD.kjwo,
 ASD.menge_totalabschrift AS as_menge_totalabschrift,
 ASD.menge_preisabschrift AS as_menge_preisabschrift,
 ASD.menge_absatz AS as_menge_absatz,
  ASD.betrag_preisabschrift_netto * krs.umrechnungskurs AS as_preisabschrift_netto,
  ASD.betrag_totalabschrift_netto * krs.umrechnungskurs AS as_totalabschrift_netto,
  ASD.umsatz_netto * krs.umrechnungskurs AS as_umsatz_netto,
 ASD.phase_id AS as_phase_id,
 ASD.phase_wo AS as_phase_wo,
 ASD.menge_endbestand_phase AS as_phase_menge_endbestand,
  ASD.phase_vk_brutto * krs.umrechnungskurs AS as_phase_vk_brutto,
  ASD.phase_vk_netto * krs.umrechnungskurs AS as_phase_vk_netto,
 ASD.menge_endbestand AS as_menge_endbestand_det
FROM kfl_production_dbp_data.as_food_det_1 AS ASD
 INNER JOIN kfl_production_dbp_data.as_food_1 AS ASF_1 ON ASD.mandant_id = ASF.mandant_id AND ASD.wup_id = ASF.wup_id AND
    ASD.art_id = ASF.art_id AND ASD.dat_auslistung = ASF.dat_auslistung
 INNER JOIN kfl_production_dbp_data.wup_1 AS WUP_1 ON ASD.mandant_id = WUP.mandant_id AND ASD.wup_id = WUP.wup_id
 INNER JOIN kfl_production_dbp_data.woche_1 AS ZEIT_1 ON ASD.kjwo = ZEIT.kjwo
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs_1 AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS von_wrg_id0,
    1.0000
   FROM kfl_production_dbp_data.kurs_1 AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON ASD.wrg_id = krs.von_wrg_id;