CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_l_in_lieferant_grp (lieferantlv2_id, lieferantlv2_bez,
lieferantentyp) AS SELECT V01.werk_id_flw AS lieferantlv2_id,
 MAX(CASE
   WHEN V01.werk_id_flw <> - 1
   THEN V02.werk_name
   ELSE 'Extern'
   END) AS lieferantlv2_bez,
 MAX(CASE
   WHEN V01.werk_id_flw <> - 1
   THEN 'Intern'
   ELSE 'Extern'
   END) AS lieferantentyp
FROM kfl_production_dbp_view.v_flw_lieferant AS V01
 LEFT JOIN kfl_production_dbp_view.v_flw_werk AS V02 ON V01.werk_id_flw = V02.werk_id AND V01.mandant_id_werk = V02.mandant_id
   
 INNER JOIN kfl_production_dbp_view.v_flw_lieferant_ekorg_zu AS DT2 ON V01.mandant_id = DT2.mandant_id AND V01.flw_lief_id
    = DT2.flw_lief_id
WHERE DT2.einkaufsorganisation_id IN (5000, 5013, 5014)
GROUP BY lieferantlv2_id;