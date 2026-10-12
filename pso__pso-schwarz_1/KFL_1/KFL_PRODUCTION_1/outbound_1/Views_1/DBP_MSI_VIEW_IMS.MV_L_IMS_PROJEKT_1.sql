CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_ims_projekt_1 (mandant_id, in_projekt_id, in_projekt_id_char,
projekt_ext_id, in_projekt_bez, projekt_typ_id, standort_id, in_budget_typ_id, dat_massnahme_ende) AS SELECT V01.mandant_id
 ,
 V01.in_projekt_id,
  CASE
  WHEN V01.ims_projekt_typ_id = 'P' AND v02.statistisch_fg = 1
  THEN v02.psp_id_char
  ELSE V01.in_projekt_id_char
  END AS in_projekt_id_char,
 V01.projekt_ext_id,
 V01.in_projekt_bez,
 V01.ims_projekt_typ_id AS projekt_typ_id,
 V01.standort_id,
 COALESCE(V01.in_budget_typ_id, '-1') AS in_budget_typ_id,
 COALESCE(V01.dat_massnahme_ende, DATE '2010-01-01') AS dat_massnahme_ende
FROM kfl_production_dbp_view.v_in_projekt_1 AS V01
 LEFT JOIN (SELECT in_projekt_id,
   mandant_id,
   MAX(statistisch_fg) AS statistisch_fg,
   MAX(psp_id_char) AS psp_id_char
  FROM kfl_production_dbp_view.v_in_psp_element_1
  GROUP BY mandant_id,
   in_projekt_id) AS v02 ON V01.in_projekt_id = v02.in_projekt_id AND V01.mandant_id = v02.mandant_id
WHERE V01.krk_id <> 'DE02'
 OR V01.mandant_id <> 1;