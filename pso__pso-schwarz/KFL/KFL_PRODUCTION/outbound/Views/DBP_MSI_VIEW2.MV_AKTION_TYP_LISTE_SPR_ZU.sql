CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_aktion_typ_liste_spr_zu (mandant_id, aktion_typ_liste_id,
aktion_typ_liste_bez) AS SELECT mandant_id,
 aktion_typ_liste_id,
 aktion_typ_liste_bez
FROM kfl_production_dbp_view.v_aktion_typ_liste_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22;