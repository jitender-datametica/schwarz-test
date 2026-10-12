CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_vis_monat_shr_wup_funktgr AS SELECT mandant_id,
 wup_id,
 nb_id,
 kjmo,
 shr_ma_funktion_gruppe_id,
 kopf_gesamt,
 kopf_eintritte,
 kopf_austritte,
 kopf_teilzeit,
 kopf_austritte_bereinigt,
 stunden_vertrag
FROM kfl_production_dbp_msi_data.vis_monat_shr_wup_funktgr;