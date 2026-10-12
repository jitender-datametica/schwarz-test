CREATE OR REPLACE VIEW kfl_production_dbp_view.v_l_rabatt_typ_1 (mandant_id OPTIONS(description='Mandant_1 im DWH'),
rabatt_typ_id
OPTIONS(description='ID des Rabatt Typs. Gibt die Art_1 des gewährten Rabattes an, bspw. Normalpreis (1), Rabattpreis (2), Absoluter Rabatt (3). etc.'))
OPTIONS(DESCRIPTION = `LOOKUPTABELLE DER MÖGLICHEN ARTEN DES GEWÄHRTEN RABATTES.`) AS SELECT mandant_id,
 rabatt_typ_id
FROM kfl_production_dbp_data.l_rabatt_typ_1;