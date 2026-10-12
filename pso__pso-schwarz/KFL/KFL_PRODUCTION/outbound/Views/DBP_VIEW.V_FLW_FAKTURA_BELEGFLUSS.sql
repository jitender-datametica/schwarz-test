CREATE OR REPLACE VIEW kfl_production_dbp_view.v_flw_faktura_belegfluss AS SELECT mandant_id,
 lief_beleg_id,
 lief_beleg_pos_id,
 folge_beleg_id,
 folge_beleg_pos_id,
 folge_beleg_typ_id,
 lief_beleg_typ_id,
 td_insert,
 td_update
FROM kfl_production_dbp_data.flw_faktura_belegfluss;