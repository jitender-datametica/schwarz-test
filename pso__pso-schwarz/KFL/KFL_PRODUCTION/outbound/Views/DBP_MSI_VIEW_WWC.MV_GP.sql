CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_gp (lifnr, mandant_id, mandant_kbez, dat_von, agb_id, dat_bis
, iso_id, eigenverpackung_id, eigenmarke, audit, audit_dat, anlieferung, gp_name, strasse, plz, ort, land_id, hgp_id,
zek_id, lieferzeit, ampel_flg, einkaufsorganisation_id, region_id) AS SELECT V01.gp_id AS lifnr,
 V01.mandant_id,
 V02.mandant_kbez,
 V01.dat_von,
 V01.agb_id,
 V01.dat_bis,
 V01.iso_id,
 V01.eigenverpackung_id,
 V01.eigenmarke_id AS eigenmarke,
 V01.audit_id AS audit,
 V01.audit_dat,
 V01.anlieferung_id AS anlieferung,
 V01.gp_name,
 V01.gp_strasse AS strasse,
 V01.gp_plz AS plz,
 V01.gp_ort AS ort,
 V01.land_id,
  CASE
  WHEN V01.hgp_id = - 1
  THEN V01.gp_id
  ELSE V01.hgp_id
  END AS hgp_id,
 V01.zek_id,
 V01.lieferzeit,
 1 AS ampel_flg,
 V01.einkaufsorganisation_id,
 V03.region_id
FROM kfl_production_dbp_view.v_gp AS V01
 INNER JOIN kfl_production_dbp_view.v_mandant AS V02 ON V01.mandant_id = V02.mandant_id
 INNER JOIN kfl_production_dbp_view.v_region AS V03 ON V01.mandant_id = V03.mandant_id AND V01.land_id = V03.land_id AND
    V01.region_id = V03.region_id AND V01.gp_id NOT BETWEEN 10000 AND 999999;