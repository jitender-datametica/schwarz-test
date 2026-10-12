CREATE OR REPLACE VIEW kfl_production_dbp_view.v_vis_puk_monat_kommentar_1 AS SELECT mandant_id,
 kjmo,
 kennzahl_id,
 puk_typ_id,
 puk_id,
 puk_parent_id,
 ursache_kjmo,
 massnahme_kjmo,
 zeit_aktualisierung
FROM kfl_production_dbp_data.vis_puk_monat_kommentar_1;