CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wug_spr_zu (arthiertyp_id
OPTIONS(description='Artikel - Hierarchie - Typ - ID: kennzeichnet, ob es sich um eine Hierarchie mit zwei- oder dreistelligen Warengruppen  handelt'),
mandant_id OPTIONS(description='Mandant im DWH'), wg_id OPTIONS(description='ID der Warengruppe'), spr_id
OPTIONS(description='ID der Sprache'), wug_id OPTIONS(description='ID der Warenuntergruppe'), wug_bez
OPTIONS(description='Warenuntergruppe - Bezeichnung aus SAP Retail.')) AS SELECT arthiertyp_id,
 mandant_id,
 wg_id,
 spr_id,
 wug_id,
 wug_bez
FROM kfl_production_dbp_data.wug_spr_zu;