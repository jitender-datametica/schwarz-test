CREATE OR REPLACE VIEW kfl_production_dbp_data_center.tv_gfk_maerkte_2 AS SELECT W.mandant_id,
 W.fipo_pruef_objekt_id,
 W.wup_id,
 COALESCE(W.wup_name_e, W.wup_name_v) AS wup_name,
 W.wup_str,
 W.wup_plz,
 W.wup_standort,
 M.mandant_bez
FROM kfl_production_dbp_view.v_wup_2 AS W
 INNER JOIN kfl_production_dbp_view.v_mandant_2 AS M ON W.mandant_id = M.mandant_id
WHERE W.fipo_pruef_objekt_id <> - 1
 AND W.nb_id = 0
 AND CURRENT_DATE BETWEEN W.dat_von AND W.dat_bis;