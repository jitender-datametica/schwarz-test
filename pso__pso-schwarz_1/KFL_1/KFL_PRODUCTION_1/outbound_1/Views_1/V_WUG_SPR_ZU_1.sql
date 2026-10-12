CREATE OR REPLACE VIEW kfl_production_dbp_view.v_wug_spr_zu_1 (arthiertyp_id
OPTIONS(description='ARTIKEL_1 - HIERARCHIE - TYP - ID: KENNZEICHNET, OB ES SICH UM EINE_1 HIERARCHIE MIT ZWEI- ODER DREISTELLIGEN WARENGRUPPEN  HANDELT'),
mandant_id OPTIONS(description='MANDANT_1 IM DWH'), wg_id OPTIONS(description='ID DER WARENGRUPPE'), spr_id
OPTIONS(description='ID DER SPRACHE'), wug_id OPTIONS(description='ID DER WARENUNTERGRUPPE'), wug_bez
OPTIONS(description='WARENUNTERGRUPPE - BEZEICHNUNG AUS SAP RETAIL.')) AS SELECT arthiertyp_id,
 mandant_id,
 wg_id,
 spr_id,
 wug_id,
 wug_bez
FROM kfl_production_dbp_data.wug_spr_zu_1;