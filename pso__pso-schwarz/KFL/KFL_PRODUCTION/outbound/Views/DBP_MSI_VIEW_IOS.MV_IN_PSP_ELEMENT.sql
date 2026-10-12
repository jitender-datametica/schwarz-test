CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ios.mv_in_psp_element (mandant_id, psp_id, psp_id_char, psp_bez,
dat_abschluss, satus_psp, systemstatus_id, psp_end_nr, ims_projekt_typ_id, in_projekt_id, in_projekt_id_char,
psp_projekt, projekt_nr, projekt_id, in_massnahme_typ_id, dat_massnahme_ende) AS SELECT IPSP.mandant_id,
 IPSP.psp_id,
 IPSP.psp_id_char,
 IPSP.psp_bez,
 COALESCE(IPSP.dat_abschluss, DATE('1900-01-01')) AS dat_abschluss,
 IPSP.dat_abschluss AS satus_psp,
 IPST.systemstatus_id,
 ROUND(CAST(SUBSTR(IPSP.psp_id_char, LENGTH(IPSP.psp_id_char), 1) AS BIGNUMERIC), 0) AS psp_end_nr,
 IPRO.ims_projekt_typ_id,
 IPRO.in_projekt_id,
 IPRO.in_projekt_id_char,
 IPRO.in_projekt_id_char AS psp_projekt,
 IPRO.projekt_ext_id AS projekt_nr,
 CPRO.projekt_id,
 IPRO.in_massnahme_typ_id,
 IPRO.dat_massnahme_ende
FROM kfl_production_dbp_view.v_in_psp_element AS IPSP
 INNER JOIN kfl_production_dbp_view.v_in_projekt AS IPRO ON IPSP.mandant_id = IPRO.mandant_id AND IPSP.in_projekt_id =
   IPRO.in_projekt_id
 LEFT JOIN kfl_production_dbp_view.v_cpr_projekt_per AS CPRO ON IPRO.projekt_ext_id = CPRO.cpr_ext_id AND CPRO.dat_bis =
   DATE '9999-12-31'
 LEFT JOIN kfl_production_dbp_view.v_ims_psp_ele_sysstat_zu AS IPST ON IPSP.psp_id = IPST.psp_id AND IPSP.mandant_id =
   IPST.mandant_id
WHERE IPSP.statistisch_fg = 1;