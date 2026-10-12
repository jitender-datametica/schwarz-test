CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wup_plan_kjmo_owg_2 (wup_id
OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum'), nb_id
OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'), mandant_id
OPTIONS(description='Mandant_2 im DWH'), kjmo OPTIONS(description='Monat_2 eines Kalenderjahres, Format JJJJMM'), hwg_id
OPTIONS(description='ID der Hauptwarengruppe'), wrg_id
OPTIONS(description='Kurzbezeichnung der Währung, z.Bsp. CZK, EUR'), umsatz_netto_plan
OPTIONS(description='geplanter Nettoumsatz / Umsatzplanwert'), abschriften_netto_operativ_plan
OPTIONS(description='Abschriftenplanwert für operative Abschriften. Total- + Preisabschriften'),
betrag_vk_netto_inventur_diff_plan
OPTIONS(description='Von der VT Landesorganisation geplante Inventurdifferenz-Werte im definierten Inventur_2-Zeitraum'))
OPTIONS(DESCRIPTION = `VIS - PLANWERTE PRO MARKT / MANDANT_2 / MONAT_2 / HAUPWARENGRUPPE (HWG)`) AS SELECT wup_id,
 nb_id,
 mandant_id,
 kjmo,
 hwg_id,
 wrg_id,
 umsatz_netto_plan,
 abschriften_netto_operativ_plan,
 betrag_vk_netto_inventur_diff_plan
FROM kfl_production_dbp_data.wup_plan_kjmo_owg_2;