CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_wup_techn_platz_2 AS SELECT wp.mandant_id,
 wp.nb_id,
 wp.wup_id,
 tpl.techn_platz_id,
 COALESCE(tpl2.baujahr, 9999) AS baujahr,
 COALESCE(tpl2.ginfo_bauform_id, - 1) AS ginfo_bauform_id,
 tpl2.anz_kassen
FROM (SELECT mandant_id,
   nb_id,
   wup_id
  FROM kfl_production_dbp_view.v_wup_2) AS wp
 LEFT JOIN (SELECT mandant_id,
   techn_platz_id,
   wup_id
  FROM kfl_production_dbp_view.v_techn_platz_per_2
  WHERE techn_platz_ebene_id = 2
   AND dat_bis = DATE '9999-12-31') AS tpl ON wp.mandant_id = tpl.mandant_id AND wp.wup_id = tpl.wup_id
 LEFT JOIN (SELECT mandant_id,
   techn_platz_id,
   baujahr,
   ginfo_markt_typ,
   ginfo_bauform_id,
   anz_kassen
  FROM kfl_production_dbp_view.v_techn_platz_ebene_2_per_2 AS S01
  WHERE dat_bis = DATE '9999-12-31') AS tpl2 ON tpl.techn_platz_id = tpl2.techn_platz_id;