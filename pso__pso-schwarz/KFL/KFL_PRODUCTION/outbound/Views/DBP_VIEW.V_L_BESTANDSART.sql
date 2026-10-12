CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_bestandsart AS SELECT mandant_id,
 lagernummer_id,
 bestandsart_id,
 bestandsart_grp_id_ausl,
 bestandsart_grp_id_einl,
 verfuegbarkeitsgruppe_id,
 lokunabh_bestandsart_id,
 bestandsart_rolle_id,
 td_update,
 td_insert
FROM kfl_production_dbp_data.l_bestandsart;