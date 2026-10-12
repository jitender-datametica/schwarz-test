CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_ofentyp (mandant_id, ofen_typ_id, anz_backblech) AS SELECT mandant_id
 ,
 ofen_typ_id,
 anz_backblech
FROM kfl_production_dbp_data.l_ofentyp;