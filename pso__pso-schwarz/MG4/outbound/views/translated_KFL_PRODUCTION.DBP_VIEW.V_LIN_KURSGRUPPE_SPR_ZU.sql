CREATE OR REPLACE VIEW kfl_production_dbp_view.v_lin_kursgruppe_spr_zu (lin_kursgruppe_id, spr_id, mandant_id,
lin_kursgruppe_bez, td_update, td_insert) AS SELECT lin_kursgruppe_id,
 spr_id,
 mandant_id,
 lin_kursgruppe_bez,
 td_update,
 td_insert
FROM kfl_production_dbp_data.lin_kursgruppe_spr_zu;