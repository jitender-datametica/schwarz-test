CREATE OR REPLACE VIEW kfl_production_dbp_view.v_rabatt_typ_spr_zu (mandant_id OPTIONS(description='Mandant im DWH'),
spr_id OPTIONS(description='ID der Sprache'), rabatt_typ_id
OPTIONS(description='ID des Rabatt Typs. Gibt die Art des gewährten Rabattes an, bspw. Normalpreis (1), Rabattpreis (2), Absoluter Rabatt (3). etc.'),
rabatt_typ_bez OPTIONS(description='Sprachabhängige Bezeichnung des Rabatttyps.'))
OPTIONS(DESCRIPTION = `TABELLE FÜR SPRACHABHÄNGIGE BEZEICHNUNGEN DES RABATTTYPS`) AS SELECT mandant_id,
 spr_id,
 rabatt_typ_id,
 rabatt_typ_bez
FROM kfl_production_dbp_data.rabatt_typ_spr_zu;