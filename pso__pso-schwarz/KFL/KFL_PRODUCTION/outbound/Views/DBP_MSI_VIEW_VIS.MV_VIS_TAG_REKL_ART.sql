CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_vis_tag_rekl_art (mandant_id, nb_id, wup_id, dat, art_id,
reklamationsgrund_id, kasse_nr, bon_nr, start_bon_zeile, gp_id, mhd, los_charge, art_id_ref, kunden_text, bon_storno_fg
, mit_ware_fg, wrg_id, betrag, vk_menge_re, vk_menge_kuga, vk_brutto_re, vk_netto_re, vk_mwst_re, anz_pos) AS SELECT
 REKL.mandant_id,
 REKL.nb_id,
 WUP.aktuell_wup_id AS wup_id,
 REKL.dat,
 REKL.art_id,
 REKL.reklamationsgrund_id,
 REKL.kasse_nr,
 REKL.bon_nr,
 REKL.start_bon_zeile,
 REKL.gp_id,
 REKL.mhd,
 REKL.los_charge,
 REKL.art_id_ref,
 REKL.kunden_text,
 REKL.bon_storno_fg,
 REKL.mit_ware_fg,
 krs.nach_wrg_id AS wrg_id,
 MAX(CASE WHEN REKL.reklamationsgrund_id IN (91, 92, 93) THEN CASE
		WHEN REKL.mandant_id = 1 AND REKL.wrg_id='EUR' THEN  2.50
		WHEN REKL.mandant_id = 5 AND REKL.wrg_id='EUR' THEN  2.00
		WHEN REKL.mandant_id = 2 AND REKL.wrg_id='CZK' THEN 50.00 
		WHEN REKL.mandant_id = 3 AND REKL.wrg_id='PLN' THEN  5.00
		WHEN REKL.mandant_id = 7 AND REKL.wrg_id='RON' THEN 10.00
		WHEN REKL.mandant_id = 4 AND REKL.wrg_id='MDL' THEN 50.00 
		WHEN REKL.mandant_id = 6 AND REKL.wrg_id='EUR' AND REKL.dat > '2022-12-31' THEN  2.00 
		WHEN REKL.mandant_id = 6 AND REKL.wrg_id='EUR' AND REKL.dat < '2023-01-01' THEN  1.33 
		WHEN REKL.mandant_id = 8 AND REKL.wrg_id='EUR' AND REKL.dat > '2025-12-31' THEN  1.50 
		WHEN REKL.mandant_id = 8 AND REKL.wrg_id='EUR' AND REKL.dat < '2026-01-01' THEN  1.53 
		ELSE 1.00 END 
	ELSE 1 END) AS betrag,
 SUM(REKL.vk_menge_re) AS vk_menge_re,
  SUM(REKL.vk_brutto_re) / MAX(CASE WHEN REKL.reklamationsgrund_id IN (91, 92, 93) THEN CASE
		WHEN REKL.mandant_id = 1 AND REKL.wrg_id='EUR' THEN  2.50
		WHEN REKL.mandant_id = 5 AND REKL.wrg_id='EUR' THEN  2.00
		WHEN REKL.mandant_id = 2 AND REKL.wrg_id='CZK' THEN 50.00 
		WHEN REKL.mandant_id = 3 AND REKL.wrg_id='PLN' THEN  5.00
		WHEN REKL.mandant_id = 7 AND REKL.wrg_id='RON' THEN 10.00
		WHEN REKL.mandant_id = 4 AND REKL.wrg_id='MDL' THEN 50.00 
		WHEN REKL.mandant_id = 6 AND REKL.wrg_id='EUR' AND REKL.dat > '2022-12-31' THEN  2.00 
		WHEN REKL.mandant_id = 6 AND REKL.wrg_id='EUR' AND REKL.dat < '2023-01-01' THEN  1.33 
		WHEN REKL.mandant_id = 8 AND REKL.wrg_id='EUR' AND REKL.dat > '2025-12-31' THEN  1.50 
		WHEN REKL.mandant_id = 8 AND REKL.wrg_id='EUR' AND REKL.dat < '2026-01-01' THEN  1.53 
		ELSE 1.00 END 
	ELSE 1 END) AS vk_menge_kuga,
 SUM(REKL.vk_brutto_re * krs.umrechnungskurs) AS vk_brutto_re,
 SUM(REKL.vk_brutto_re / (1.00 + MWSTP.mwst / 100.00) * krs.umrechnungskurs) AS vk_netto_re,
  SUM(REKL.vk_brutto_re * krs.umrechnungskurs) - SUM(REKL.vk_brutto_re / (1.00 + MWSTP.mwst / 100.00) * krs.umrechnungskurs
    ) AS vk_mwst_re,
 COUNT(DISTINCT REKL.pos_nr) AS anz_pos
FROM kfl_production_dbp_view.v_rekl AS REKL
 INNER JOIN kfl_production_dbp_view.v_art_per AS ARTP ON REKL.art_id = ARTP.art_id AND REKL.mandant_id = ARTP.mandant_id
     AND REKL.dat BETWEEN ARTP.dat_von AND ARTP.dat_bis
 INNER JOIN kfl_production_dbp_view.v_mwst_per AS MWSTP ON ARTP.mwst_id = MWSTP.mwst_id AND ARTP.mandant_id = MWSTP.mandant_id
     AND REKL.dat BETWEEN MWSTP.dat_von AND MWSTP.dat_bis
 INNER JOIN (SELECT von_wrg_id,
    nach_wrg_id,
    umrechnungskurs
   FROM kfl_production_dbp_data.kurs AS KRS1
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT')
   UNION ALL
   SELECT von_wrg_id,
    von_wrg_id AS von_wrg_id0,
    1.0000
   FROM kfl_production_dbp_data.kurs AS KRS2
   WHERE kurstyp_id = 3
    AND dat_bis = DATE '9999-12-31'
    AND von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')) AS krs ON REKL.wrg_id = krs.von_wrg_id
 INNER JOIN kfl_production_dbp_view.v_wup AS WUP ON REKL.mandant_id = WUP.mandant_id AND REKL.wup_id = WUP.wup_id
WHERE REKL.bon_storno_fg = 0
GROUP BY REKL.mandant_id,
 REKL.nb_id,
 wup_id,
 REKL.dat,
 REKL.art_id,
 REKL.reklamationsgrund_id,
 REKL.kasse_nr,
 REKL.bon_nr,
 REKL.start_bon_zeile,
 REKL.gp_id,
 REKL.mhd,
 REKL.los_charge,
 REKL.art_id_ref,
 REKL.kunden_text,
 REKL.bon_storno_fg,
 REKL.mit_ware_fg,
 wrg_id
HAVING vk_menge_re <> 0;