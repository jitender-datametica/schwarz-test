CREATE OR REPLACE VIEW kfl_production_dbp_view.v_ruecksendung_typ_spr_zu_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), ruecksendung_typ_kz OPTIONS(description='Code für die Art_2 der Rücksendung.'),
spr_id OPTIONS(description='Sprache im DWH'), ruecksendung_typ_bez
OPTIONS(description='Bezeichnung der Retourenart eines von der Filiale zurückgegebenen Artikels in unterschiedlichen Sprachen.'))
OPTIONS(DESCRIPTION = `SPRACHABHÄNGIGE BEZEICHNUNG DES RÜCKSENDUNGSTYPEN`) AS SELECT mandant_id,
 ruecksendung_typ_kz,
 spr_id,
 ruecksendung_typ_bez
FROM kfl_production_dbp_data.ruecksendung_typ_spr_zu_2;