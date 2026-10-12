CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ivs.mv_immo_objekt_miet_region_zu AS SELECT Z.mandant_id,
 Z.immo_objekt_id,
 COALESCE(O.objekt_plz, '-1') AS objekt_plz,
 Z.miet_region_id,
 Z.bl_id AS miet_bundesland_id
FROM kfl_production_dbp_view.v_ivs_immo_obj_miet_region_zu AS Z
 INNER JOIN kfl_production_dbp_view.v_ivs_immo_objekt_per AS O ON Z.mandant_id = O.mandant_id AND Z.immo_objekt_id = O.immo_objekt_id
     AND O.dat_bis = DATE '9999-12-31';