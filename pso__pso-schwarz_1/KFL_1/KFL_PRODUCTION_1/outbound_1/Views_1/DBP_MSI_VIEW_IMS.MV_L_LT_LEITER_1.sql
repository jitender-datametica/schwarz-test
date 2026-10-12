CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ims.mv_l_lt_leiter_1 AS SELECT ma_id AS it_lt_leiter_id,
   ma_vorname || ' ' || ma_name AS ma_name,
 ma_ldap
FROM kfl_production_dbp_view.v_ma_spr_zu_1 AS V01
WHERE mandant_id = 1
 AND spr_id = 22
 AND ma_id IN (SELECT ma_id
   FROM kfl_production_dbp_view.v_it_projekt_ma_zu_1 AS V01
   WHERE mandant_id = 1
    AND ma_funktion_id = 'CLLTKIS');