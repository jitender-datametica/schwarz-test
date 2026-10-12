CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_psp_element (mandant_id, psp_id, psp_id_char, psp_bez,
in_projekt_id, in_projekt_id_char, projekt_typ_id, in_massnahme_typ_id, buchungskreis_id, dat_erfasst,
plan_aktivierungs_quote, gewerk_id) AS SELECT V02.mandant_id,
 V02.psp_id,
 V02.psp_id_char,
 V02.psp_bez,
 V02.in_projekt_id,
 V01.in_projekt_id_char,
 V01.ims_projekt_typ_id AS projekt_typ_id,
  CASE
  WHEN V01.ims_projekt_typ_id = 'A'
  THEN '17'
  WHEN V01.ims_projekt_typ_id = 'I' AND V02.psp_id > 0
  THEN '16'
  WHEN V01.ims_projekt_typ_id = 'I' AND V02.psp_id < 0
  THEN '15'
  ELSE COALESCE(V01.in_massnahme_typ_id, '-1')
  END AS in_massnahme_typ_id,
 COALESCE(V02.buchungskreis_id, - 1) AS buchungskreis_id,
 COALESCE(V02.dat_erfasst, PARSE_DATE('%F', '1900-01-01')) AS dat_erfasst,
 COALESCE(V02.plan_aktivierungs_quote, 1) AS plan_aktivierungs_quote,
 COALESCE(V02.gewerk_id, - 1) AS gewerk_id
FROM kfl_production_dbp_view.v_in_projekt AS V01
 INNER JOIN kfl_production_dbp_view.v_in_psp_element AS V02 ON V01.in_projekt_id = V02.in_projekt_id AND V01.mandant_id
   = V02.mandant_id
WHERE V02.krk_id <> 'DE02'
 OR V02.mandant_id <> 1;