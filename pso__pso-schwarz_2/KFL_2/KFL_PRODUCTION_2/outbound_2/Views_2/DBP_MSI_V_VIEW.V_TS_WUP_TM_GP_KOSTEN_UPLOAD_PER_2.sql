CREATE OR REPLACE VIEW kfl_production_dbp_msi_v_view.v_ts_wup_tm_gp_kosten_upload_per_2 (mandant_id
OPTIONS(description='Mandant_2 im DWH'), system_id
OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_gp_id
OPTIONS(description='ID des Geschäftspartners. Aus plkd.nr  (hier: Spedition)'), tms_gp_typ_cd
OPTIONS(description='Geschäftspartnertyp. L- Lager, S - Spediteur, 0(null) - Markt(Kunde)     (hier: nur Speditionen)'),
wup_id OPTIONS(description='Mutter Wup_2 ID wird verwendet für Beziehung Lager zu Verteilzentrum  (hier: nur Werk)'),
nb_id OPTIONS(description='Im bisherigen System die 4 Stelle der Marktnummer die Nebenbetriebskennziffer'),
kosten_upload_fg
OPTIONS(description='Flag: für Touren die von einer gg. Spedition aus einem gg. VZ gefahren werden, werden Daten in der Tabelle transportation_unit_kosten_upload erwartet'),
dat_bis OPTIONS(description='Gültig bis'), dat_von OPTIONS(description='Gültig von'))
OPTIONS(DESCRIPTION = `TRANSACTION SERVICES TABLE - USER CAN MAINTAIN WHEN TO EXPECT A RECORD IN UPLOAD TABLE (DBP_DATA.TRANSPORTATION_UNIT_KOSTEN_2)  FOR A GIVEN TDL/DC COMBINATION`)
AS SELECT mandant_id,
 system_id,
 tms_gp_id,
 tms_gp_typ_cd,
 wup_id,
 nb_id,
 kosten_upload_fg,
 dat_bis,
 dat_von
FROM kfl_production_dbp_msi_data.ts_wup_tm_gp_kosten_upload_per_2;