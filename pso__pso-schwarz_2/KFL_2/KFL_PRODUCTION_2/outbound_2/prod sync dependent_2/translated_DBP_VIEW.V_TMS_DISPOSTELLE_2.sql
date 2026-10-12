CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tms_dispostelle_2 (mandant_id OPTIONS(description='Mandant_2 im DWH'),
system_id OPTIONS(description='Spezifiziert das Quellsystem, aus dem die Daten kommen.'), tms_dispostelle_id
OPTIONS(description='ID des Dispostelles. Auspldispst.dst_id'), tms_dispostelle_name
OPTIONS(description='Dispostelle Name'), lagernummer_id OPTIONS(description='Lagernummer der Dispostelle'),
bestand_tms_gp_id
OPTIONS(description='TMS Geschäftspartner-ID des Verteilzeintrums, auf dessen Bestand die Dispostelle Auswirkung hat.'),
bestand_tms_gp_typ_cd
OPTIONS(description='TMS Geschäftspartnertyp-Code des Verteilzeintrums, auf dessen Bestand die Dispostelle Auswirkung hat.'))
AS SELECT mandant_id,
 system_id,
 tms_dispostelle_id,
 tms_dispostelle_name,
 lagernummer_id,
 bestand_tms_gp_id,
 bestand_tms_gp_typ_cd
FROM kfl_production_dbp_data.tms_dispostelle_2;